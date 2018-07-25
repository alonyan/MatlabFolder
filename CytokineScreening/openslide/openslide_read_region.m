function [im] = openslide_read_region(openslidePointer,xPos,yPos,width,height,varargin)
% OPENSLIDE_READ_REGION Reads a region according to specified coordinates and with specified size
%
% [im] = openslide_read_region(openslidePointer,xPos,yPos,width,height)
%
% INPUT ARGUMENTS
% openslidePointer          - Pointer to slide to read from, obtained from
%                             OPENSLIDE_OPEN
% xPos                      - Pixel position, with first position as 0
% yPos                      - Pixel position, with first position as 0
% width                     - Widht of region to read in pixels
% height                    - Height of region to read in pixels
%
% OPTIONAL INPUT ARGUMENTS
% 'level'                   - Image level to read, 0 refers to original
%                             level
%
% OUTPUT
% im                        - Read image

% Copyright (c) 2013 Daniel Forsberg
% daniel.forsberg@liu.se
%
% This program is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
%
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with this program.  If not, see <http://www.gnu.org/licenses/>.

%% Default parameters
level = 0;

% Overwrites default parameter
for k=1:2:length(varargin)
    eval([varargin{k},'=varargin{',int2str(k+1),'};']);
end


% Check if openslide library is opened
if ~libisloaded('openslidelib')
    error('openslide:openslide_read_region',...
        'Make sure to load the openslide library first\n')
end

% Check that specified level is available
numberOfLevels = calllib('openslidelib','openslide_get_level_count',...
    openslidePointer);
if level >= numberOfLevels
    error('openslide:openslide_read_region',...
        'Specified level is not available in the current slide\n')
end

% Check that it is possible to read the specified region
widthLevel = 0;
heightLevel = 0;
[~, widthLevel, heightLevel] = calllib('openslidelib',...
    'openslide_get_level_dimensions',openslidePointer,level,widthLevel,heightLevel);

if xPos + width - 1 >= widthLevel
    error('openslide:openslide_read_region',...
        'Specified x-pos and width yields an invalid end position\n')
end
if yPos + height - 1 >= heightLevel
    error('openslide:openslide_read_region',...
        'Specified y-pos and height yields an invalid end position\n')
end

% Adjust position according to downsampling factor of desired level
downsamplingFactor = calllib('openslidelib',...
    'openslide_get_level_downsample',openslidePointer,level);
xPos = xPos * downsamplingFactor;
yPos = yPos * downsamplingFactor;
    
% Read region
data = uint32(zeros(width*height,1));
region = libpointer('uint32Ptr',data);
[~, region] = calllib('openslidelib','openslide_read_region',openslidePointer,region,int64(xPos),int64(yPos),int32(level),int64(width),int64(height));
RGBA = typecast(region,'uint8');
im = uint8(zeros(width,height,3));
im(:,:,1) = reshape(RGBA(3:4:end),width,height);
im(:,:,2) = reshape(RGBA(2:4:end),width,height);
im(:,:,3) = reshape(RGBA(1:4:end),width,height);

% Permute image to make sure it is according to standard MATLAB format
im = permute(im,[2 1 3]);
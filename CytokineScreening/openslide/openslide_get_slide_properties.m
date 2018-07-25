function [mppX, mppY, width, height, numberOfLevels, ...
    downsampleFactors, objectivePower] = ...
    openslide_get_slide_properties(openslidePointer)
% OPENSLIDE_GET_SLIDE_PROPERTIES Reads some basics properties of the slide
%
% [mppX, mppY, width, height, numberOfLevels, ...
%     downsampleFactors, objectivePower] = ...
%     openslide_get_slide_properties(openslidePointer)
%
% INPUT ARGUMENTS
% openslidePointer          - Pointer to the slide to read properties from
%
% OPTIONAL INPUT ARGUMENTS
% N/A
%
% OUTPUT
% mppX                      - Resolution, microns per pixel
% mppY                      - Resolution, microns per pixel
% width                     - Size in pixels
% height                    - Size in pixels
% numberOfLevels            - Number of levels available
% downsampleFactors         - Downsample factors of the levels available
% objectivePower            - Magnification factor for level 0

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

%%

% Check if openslide library is opened
if ~libisloaded('openslidelib')
    error('openslide:openslide_read_region',...
        'Make sure to load the openslide library first\n')
end

% Read microns per pixel along x-axis
mppX = str2double(calllib('openslidelib','openslide_get_property_value',...
    openslidePointer,'openslide.mpp-x'));

% Read microns per pixel along y-axis
mppY = str2double(calllib('openslidelib','openslide_get_property_value',...
    openslidePointer,'openslide.mpp-y'));

% Read size of slide
width = 0;
height = 0;
[~, width, height] = calllib('openslidelib',...
    'openslide_get_level0_dimensions',openslidePointer,width,height);

% Read number of zoom levels
numberOfLevels = calllib('openslidelib','openslide_get_level_count',...
    openslidePointer);

% Read downsample factors for each available zoom level
downsampleFactors = zeros(numberOfLevels,1);
for level = 0 : numberOfLevels - 1
    downsampleFactors(level+1) = calllib('openslidelib',...
        'openslide_get_level_downsample',openslidePointer,level);
end

% Read zoom level of level 0
objectivePower = str2double(calllib('openslidelib',...
    'openslide_get_property_value',...
    openslidePointer,'openslide.objective-power'));
function nucimg = model2nuclei(model,param)
%MODEL2NUCLEI Generate nuclear edge from a model.
%   NUCIMG = MODEL2NUCLEI(MODEL) returns the nuclear edge image generated
%   from the generative model MODEL.   

%   14-Jan-2007 Initial write T. Zhao
%   10-Feb-2012 Separated synthesizing of nuclei shape and cell shape model 
%   Copyright (c) 2012 Murphy Lab
%   Carnegie Mellon University
%
%   This program is free software; you can redistribute it and/or modify
%   it under the terms of the GNU General Public License as published
%   by the Free Software Foundation; either version 2 of the License,
%   or (at your option) any later version.
%   
%   This program is distributed in the hope that it will be useful, but
%   WITHOUT ANY WARRANTY; without even the implied warranty of
%   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
%   General Public License for more details.
%   
%   You should have received a copy of the GNU General Public License
%   along with this program; if not, write to the Free Software
%   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
%   02110-1301, USA.
%   
%   For additional information visit http://murphylab.web.cmu.edu or
%   send email to murphy@cmu.edu


if nargin < 1
    error('1 or 2 arguments are required');
end

if ~exist('param','var')
    param = struct([]);
end

param = ml_initparam(param,struct('imageSize',[1024 1024]));

shape = ml_genshape(model.nuclearShapeModel);
% nucpts = ml_mxp2crd(shape);

%Get the center and orientation of the nucleus
%tz- 02-Apr-2007
%[center,mangle] = ml_edgecenter(nucpts);
%tz--

%Convert the contour to a solid object
nucbody = ml_findobjs(imfill(ml_mxp2img(shape),'hole'));
nucbody = nucbody{1};

%The cell code base on the synthesized nucleus
%This is necessary for further steps
cellcode = struct([]);
cellcode=ml_parsecell(cellcode,nucbody,nucbody,1, ...
    param.imageSize,...
    {'da','nuchitpts','nucdist','nuccenter','nucmangle',...
    'nucellhitpts','celldist'},0);

%tz- 02-Apr-2007
%     {'da','nucarea','nuccenter','nucmangle','nuchitpts',...
%     'nuccontour','nucellhitpts','nucdist','nucelldist','nucecc',...
%     'cellarea','cellcenter','cellmangle','cellcontour',...
%     'cellhitpts','celldist','cellecc'},0);
%tz--

nucBoundary = ml_showpts_2d(curve1,'ln',1);
offset = round((param.imageSize-cellBoxsize)/2)-cellBoundbox(1,:);

nucBoundary = ml_addrow(nucBoundary,offset);
nucimg = ml_obj2img(nucBoundary,param.imageSize);

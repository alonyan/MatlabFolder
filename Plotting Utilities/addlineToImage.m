function [bw, axH] = addlineToImage(varargin)
if length(varargin)  > 0,
    axH = varargin{1};
else 
    axH = gca;
end;

if length(varargin) >  1,
    pixValue = varargin{2};
else 
    pixValue = 1;
end;

% get image
tempAx = gca;
axes(axH);

Him  = get(axH, 'Children' );
if ~strcmp(get(Him, 'Type'), 'image'),
    error('Wrong type of axes (not an image)!')
end;

bw = get(Him, 'CData');

title('draw a polyline and double-click to terminate')
Hpoly = impoly(axH, 'Closed', false);
api = iptgetapi(Hpoly);
pos = api.getPosition();
[X, Y, C] = contour2pixcoord(pos, size(bw));
bw(C) = pixValue; 

imagesc(bw); 
axis image;
figure(gcf);
axes(tempAx);
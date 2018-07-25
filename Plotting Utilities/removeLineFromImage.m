function [bw, axH] = removeLineFromImage(varargin)
if length(varargin)  > 0,
    axH = varargin{1};
else 
    axH = gca;
end;

if length(varargin) >  1,
    pixValue = varargin{2};
else 
    pixValue = 0;
end;

% get image
tempAx = gca;
axes(axH);

Him  = get(axH, 'Children' );
if ~strcmp(get(Him, 'Type'), 'image'),
    error('Wrong type of axes (not an image)!')
end;

bw = get(Him, 'CData');

title('draw a rectangle over the area you want to remove')
Hrect = imrect(axH, []);
api = iptgetapi(Hrect);
pos = api.getPosition();
api.delete();


bw(round(pos(2):(pos(2)+pos(4))), round(pos(1):(pos(1)+pos(3)))) = pixValue; 

%imagesc(bw); 
%axis image;
%figure(gcf);
%axes(tempAx);
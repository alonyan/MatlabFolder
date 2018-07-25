img = tiffread('/Users/Alonyan/Downloads/Composite-2.tif');

%% floatize, normalize, denoise nuclei
Red = double(img(1).data);
Red = Red./max(Red(:));
Red = imadjust(Red);
Green = double(img(2).data);
Green = Green./max(Green(:));
Green = imadjust(Green);
Blue = double(img(3).data);
Blue = Blue./max(Blue(:));
Blue = imopen(awtDenoising(Blue),strel('disk',1));
Blue = imadjust(Blue);

imagesc(cat(3,Red,Green,Blue));
shg
%% pick mask
h = impoly;
position = h.getPosition;  
%% get mask
figure;
[maskX,maskY] = meshgrid(1:size(Red,2),1:size(Red,1));
mask = inpolygon(maskX, maskY, position(:,1), position(:,2) );
imagesc(mask)
%% mask images
mask = double(mask);
Red = mask.*Red;
Green = mask.*Green;
Blue = mask.*Blue;
%% show masked image
RGB = cat(3,Red,Green,Blue);
figure(123)
set(gcf,'Position',[10 100 size(nucMask,2)*5 size(nucMask,1)*5])
axes('position',[0,0,1,1])
imagesc(RGB);shg

      set(figure(123), 'PaperPositionMode','auto','color','w')
      print(figure(123),'-dpng','RGBGrant','-r300');%
%% Pick nuclear masks:
imagesc(Blue);shg

% pick mask 1
h1 = impoly;
position = h1.getPosition;  
% get mask 1
mask1 = double(inpolygon(maskX, maskY, position(:,1), position(:,2)));
% pick mask 1
h2 = impoly;
position = h2.getPosition;  
% get mask 1
mask2 = double(inpolygon(maskX, maskY, position(:,1), position(:,2)));
nucMask = 1*mask1+2.*mask2;
%%
figure(123)
set(gcf,'Position',[10 100 size(nucMask,2)*5 size(nucMask,1)*5])
axes('position',[0,0,1,1])

imagesc(nucMask);shg

%% Pick Cell mask:
imagesc(Green);shg

% pick mask 1
h1 = impoly;
position = h1.getPosition;  
% get mask 1
cellMask = double(inpolygon(maskX, maskY, position(:,1), position(:,2)));
%%
figure()
imagesc(cellMask);shg

%% Pick Boundary mask:
imagesc(cat(3,Red,Green,Blue));shg

[cx,cy,~] = improfile;
borderMask = zeros(size(Red));
for i=1:length(cx)
    borderMask(round(cy(i)),round(cx(i)))=1;
end

%%
figure()
imagesc(borderMask);shg

%% All masks together
figure(345)
set(gcf,'Position',[10 100 size(nucMask,2)*5 size(nucMask,1)*5])
axes('position',[0,0,1,1])
imagesc(cat(3,0.5*cellMask+0.5*borderMask,0.5*cellMask+0.5*mask1,0.5*cellMask+0.5*mask2));shg

      set(figure(345), 'PaperPositionMode','auto','color','w')
      print(figure(345),'-dpng','MasksGrant','-r300');%
%% Run segmentation thing

XY = FindCellPoly(RGB, nucMask==1,borderMask,cellMask,100,'Present')

%%
      set(figure(1), 'PaperPositionMode','auto','color','w')
      print(figure(1),'-dpng','Segment1','-r300');%
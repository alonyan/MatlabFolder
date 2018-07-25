function [L, voronoiCells] = SegmentCells(filepath, varargin)

%% Open nuclear image

%filepath = '/Users/Alonyan/GoogleDrive/School/Applications and conferences/MBL2017/data/HeLa12415-1.png'

cellSizeEst = ParseInputs('EstSize', 6, varargin);

img = double(imread(filepath));
img = img./max(img(:));
img = padarray(img,[1 1],0);
GMimg = GradMag_v1(img); %use DAPI for segmentation

d = fspecial('gaussian',6*cellSizeEst,cellSizeEst);
se = strel('disk', ceil(cellSizeEst/2));
%% First, find unit cells
voronoiCells = ParseInputs('voronoiCells', [], varargin);
%Smoothen
if ~isstruct(voronoiCells)
    imgSmooth = imfilter(img,d,'replicate');
    %imagesc(imgSmooth);shg
    % Threshold
    img_hmax = imhmax(imgSmooth,0.01); %threshold
    RegionMax = imregionalmax(img_hmax);
    RegionMax = imerode(imdilate(RegionMax,se),se);%clean up regional max
    I = imgSmooth;
    I(RegionMax) = 1;%ceil regional maximum
    % find smooth objects
    imgBW = bwconvhull(im2bw(I,2*graythresh(img)),'objects'); %find individual objects using convhull

    % Watershed
    %distance transform finds the distance to the next white pixel. within a
    %region of imgBW it will be 0. grow until it's closer to the next cell.
    D = bwdist(imgBW);
    %Watershed will find the /\ lines between these regions.
    DL = watershed(D); %find watershed basins
    RegionBounds = DL == 0; %the region bounds are==0;voronoi cells
    voronoiCells.imgBW = imgBW;
    voronoiCells.RegionBounds = RegionBounds;
end

imgBW = voronoiCells.imgBW;
RegionBounds = voronoiCells.RegionBounds;

%RegionBounds will define the large boundaries for all channels 
%% Now, within every region, impose artificial maxes at the border and max, then watershed again inside to find the outline
gradmag2 = imimposemin(GMimg, imgBW | RegionBounds);
gradmag2 = imhmax(gradmag2,0.01);

L = watershed(gradmag2);

Mask = L==0;
ToSee2 = img;
ToSee2(Mask|imgBW)=1;
figure();
imagesc(ToSee2); shg




end

function [L, voronoiCells] = SegmentCellsImg_v2(img, varargin)

%% Open nuclear image

%filepath = '/Users/Alonyan/GoogleDrive/School/Applications and conferences/MBL2017/data/HeLa12415-1.png'

cellSizeEst = ParseInputs('EstSize', 5, varargin);

se = strel('disk', round(cellSizeEst));
%FFimg = squeeze(awt2Dlite(img1,7));
%img = sum(FFimg(:,:,3:end-1),3);

GMimg = abs(GradMag_v1((img))); 



%% First, find unit cells
voronoiCells = ParseInputs('voronoiCells', [], varargin);
hThresh = ParseInputs('hthresh', 0.001, varargin);
gmThresh = ParseInputs('gmthresh', 0.5, varargin);
maskflag = ParseInputs('maskflag', true, varargin);

if ~isstruct(voronoiCells)&&isempty(voronoiCells)
    
    % Threshold
    if maskflag
        mask = img>adaptthresh(img,'NeighborhoodSize', 401, 'Statistic','gaussian');
        se = strel('disk', 1);
        mask = imopen(mask,se);    
        se = strel('disk', round(cellSizeEst));
        mask = imclose(mask,se);
    else
        mask = ones(size(img));
    end

    %Smoothen
    imgSmooth = imgaussfilt(img.*mask,round(cellSizeEst));
    img_hmax = imhmax(imgSmooth,hThresh); %threshold
   
    %Find regional max and merge close ones
    RegionMax = imregionalmax(img_hmax);
    se = strel('disk', ceil(cellSizeEst/2));
    RegionMax = imerode(imdilate(RegionMax,se),se);%clean up regional max
    imgBW = imdilate(RegionMax,se);

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
GMimg = abs(GradMag_v1(log(img)));

gradmag2 = imimposemin(GMimg, imgBW | RegionBounds);

L = watershed(gradmag2);


A = regionprops(L,'Area');
A = [A.Area];
indBG = find(A>100000);
if any(indBG)
    for i=1:numel(indBG)
        L(L==indBG(i))=0;
    end
end

L = bwlabel(bwconvhull(L,'objects'));
end

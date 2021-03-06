
channelNames;
partNameList;
tic;
options = struct('level', 1,'waitbar',0);
Channels = cell(numel(partNameList),1);
for i=1:numel(partNameList);
I = loadBigDataViewerFormat(['/RazorScopeData/RazorScopeSets/Jen/CorneaHSV/HSVSpread_p65V_2018Aug17/acq_1/' partNameList{1}],options);
I = squeeze(single(I)/2^12);
Channels{i} = I;
end
%Ilog = (log(log(squeeze(single(I)))));
%I = Ilog/(log(log(2^12)));

I = Channels{find(strcmp(channelNames,'DeepBlue'))};
% This is, unfortunately, too slow for now. We should do a mex
% implementation
awtI = awt3DRemBG(I,4);
I = padarray(awtI,[1 1 1],0);

imgG = imgaussian3(I,[4,1]);
imgGRegMax = imregionalmax(imgG);


%indPeaks = find(imgGRegMax);
%[X1,Y1,Z1]=ind2sub(size(imgGRegMax),indPeaks);
%vor = voronoin([X1,Y1,Z1]);

%
[xx,yy,zz] = ndgrid(-4:4);
nhood = sqrt(xx.^2 + yy.^2+zz.^2) <= 4.0;
ExpandedPeaks = imdilate(imgGRegMax,nhood);

%
somePix = I(ExpandedPeaks);
[h,x]=hist(log(somePix),100);
ThreshVal = exp(triangleThresh(h,x));
%ThreshVal = exp(meanThresh(log(somePix)));

nuclearSeeds = ExpandedPeaks.*(imgG>ThreshVal);

% L = bwlabeln(nuclearSeeds);
% [xx,yy,zz] = ndgrid(-8:8);
% nhood = sqrt(xx.^2 + yy.^2+zz.^2) <= 8.0;
% L = imdilate(L,nhood);

distNC = bwdist(nuclearSeeds);
L = pseudowatershed3D(distNC);
[Gx,Gy,Gz] = gradient(single(L));
cellBoxes = (Gx.^2+Gy.^2+Gz.^2)~=0;

%imgG = imgaussian3(I,[1 1]);
[Gx,Gy,Gz] = gradient(imgG);
gradmagI = sqrt(Gx.^2+Gy.^2+Gz.^2).*(L>0);

tic; imImp = imimposemin(gradmagI,nuclearSeeds | cellBoxes,6);toc
imImp(imImp==-inf)=-1000;
tic; gradmagI(nuclearSeeds | cellBoxes)=0;toc
L = watershed3D(imImp);

nuclearSeedsSignal = I.*nuclearSeeds;
%





CC = bwconncomp(nuclearSeeds);
toc

S = regionprops(CC,nuclearSeedsSignal,'MeanIntensity','Centroid','Area');
% filter CC keep only cells with volume in some range
Areas = cat(1, S.Area);
Intensities = cat(1, S.MeanIntensity);
Centroids = cat(1,S.Centroid);
%remove specks
J = Areas>=120;
Areas = Areas(J);
Intensities = Intensities(J);
Centroids = Centroids(J,:);
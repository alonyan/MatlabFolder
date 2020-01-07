
%index of nuclear channel
indChNuc = find(strcmp(block1.channelNames,block1.NuclearChannel));


searchRadius=35;

%find 5 nearest neighbors in block2 of points in block1
[n,d]=knnsearch(block2.Centroids,block1.Centroids,'k',5);

%find the mean distance
d=median(d,2);

%find indexes of centroids in block1 that have close neighbors in block 2.
indD = find(d<=searchRadius);
%find the indexes of those neighbors and calculate their mean intensity
a = n(indD,:);
a = mat2cell(a,ones(size(a,1),1),size(a,2));
medianIntensityB = cellfun(@(x) mean(block2.Intensities{indChNuc}(x)), a);

%intensity of matched points in block1
IntensityA = block1.Intensities{indChNuc}(indD);

block1.useInMerge(indD(IntensityA<=medianIntensityB)) = false;

%repeat for other direction
%find 5 nearest neighbors in block2 of points in block1
[n,d]=knnsearch(block1.Centroids,block2.Centroids,'k',5);

%find the mean distance
d=median(d,2);

%find indexes of centroids in block1 that have close neighbors in block 2.
indD = find(d<=searchRadius);
%find the indexes of those neighbors and calculate their mean intensity
a = n(indD,:);
a = mat2cell(a,ones(size(a,1),1),size(a,2));
medianIntensityB = cellfun(@(x) mean(block1.Intensities{indChNuc}(x)), a);

%intensity of matched points in block1
IntensityA = block2.Intensities{indChNuc}(indD);

block2.useInMerge(indD(IntensityA<=medianIntensityB)) = false;

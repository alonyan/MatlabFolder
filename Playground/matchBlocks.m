function matchBlocks(block1,block2)
    searchRadius=40;
    Dists = createDistanceMatrix(block1.Centroids, block2.Centroids);
    costMat = Dists;
    
    costMat(Dists>searchRadius) = 0;
    costMat = sparse(double(costMat));
    [Links12, ~] = lap(costMat,[],[],1);


    Link12Mat =repmat(Links12(1:length(block1.Centroids(:,1))),1,length(block2.Centroids(:,1)));
    LinkMat1 = meshgrid(1:length(block2.Centroids(:,1)), 1:length(block1.Centroids(:,1)));
    Link12Mat = LinkMat1==Link12Mat;
    clear LinkMat1 costMat;
    [ind1, ind2]=find(Link12Mat);
    
    block1.useInMerge(ind1(block1.localEntropyScore(ind1) < block2.localEntropyScore(ind2)))=false;
    block2.useInMerge(ind1(block1.localEntropyScore(ind1) >= block2.localEntropyScore(ind2)))=false;

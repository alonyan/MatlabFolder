profile on
i=1;
SPIMTPi = R.SPIMTimepoints{i};
SPIMTPip1 = R.SPIMTimepoints{i+1};

TrackChannel = 'Red';
TrackChInd = find(strcmp(SPIMTPi.channelNames,TrackChannel));

ND = SPIMTPi.num;
NA = SPIMTPip1.num;
CentsD = SPIMTPi.Centroids;
CentsA = SPIMTPip1.Centroids;
IntD = SPIMTPi.Intensities{TrackChInd};
IntA = SPIMTPip1.Intensities{TrackChInd};

searchRadius = 35;
maxAmpRatio = 6;
epsilon = 10^-4;%prevent cost==0
%preallocate for speed
indx1 = zeros(1,25*ND);
indx2 = zeros(1,25*ND);
costMat = zeros(1,25*ND);
counter = 1;

[ids , dist] = rangesearch(CentsA,CentsD,searchRadius);

indx1 = arrayfun(@(x) repmat(x,1,numel(ids{x})), 1:numel(ids),'UniformOutput', false);
indx1 = cat(2,indx1{:});
indx2 = cat(2,ids{:});
Dists = cat(2,dist{:});
ampRatio = max(IntD(indx1),IntA(indx2))./min(IntD(indx1),IntA(indx2));

cost1 = Dists.*(log2(ampRatio')+epsilon);
% 
% %%
% 
% 
%             for ind1 = 1:ND
% 
%                     %dR = createDistanceMatrix(CentsD(ind1,:),CentsA);
%                     %ind2 = find(dR<=searchRadius);
%                     ind2 = ids{ind1};
%                     dR = dist{ind1};
%                     for i=1:numel(ind2)
%                         
%                         ampRatio = max(IntD(ind1),IntA(ind2(i)))./min(IntD(ind1),IntA(ind2(i)));                      
%                         indx1(counter)=ind1;
%                         indx2(counter)=ind2(i);
%                         cost1 = dR(i).*(log2(ampRatio)+epsilon);
%                         costMat(counter)=cost1;
%                         counter = counter+1;
%                         %add more lines if we run out of space
%                         if counter==numel(costMat)
%                             indx1 = [indx1 zeros(1,5*ND)];
%                             indx2 = [indx2 zeros(1,5*ND)];
%                             costMat = [costMat zeros(1,5*ND)];       
%                         end
%                     end                   
%                 ind1
%             end
%             %clean up zeros
%             costMat(indx1==0)=[];
%             indx2(indx1==0)=[];
%             indx1(indx1==0)=[];

            profile viewer
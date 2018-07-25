function IM = MakeImage_v3(Ain,Chan,n, overlapFracX, overlapFracY)
% 
% p.i0 is the expected displacement between the images in the line
% p.di - the expected uncertainty in positions
% p.j0
% p.dj
% have yet to take care of vertical drift

A = Ain(:,:,:,Chan);

clear L1;
sizeA = size(Ain);
for i =1:(sizeA(3)/n),
    L1{i} = CombineImageLine_v3(Ain(:,:,(n*(i-1)+1):n*(i),:),Chan, overlapFracX);
    tform = affine2d([sqrt(1-((size(L1{i},1)-512)/size(L1{i},2))^2) -(size(L1{i},1)-512)/size(L1{i},2) 0; (size(L1{i},1)-512)/size(L1{i},2) sqrt(1-((size(L1{i},1)-512)/size(L1{i},2))^2) 0; 0 0 1]);
    L1warp{i} = imwarp(L1{i}, tform);
    skipL1 = round((size(L1warp{i},1)-512)/2)+5;
    L1warp{i} = L1warp{i}(skipL1+1:end-skipL1,:,:);
end;




IM = L1warp{1};


dI = 0;
dJ = 0;

for i =1:(sizeA(3)/n-1),
    [di, dj] = Combine2Images_v1(L1warp{i}(:, :, Chan), L1warp{i+1}(:, :, Chan), overlapFracY)
    dI = dI+di;
    dJ = dJ+dj;
    
%     if (overlapJ<0)||,
%         warning('overlap < 0'),
%     elseif (overlapJ > size(A, 2)),
%         warning('overlap > image dimensions'),
%     end;
%L(dI:dI+511,dJ:dJ+511,:) = A(:,:,2,:);
sizeA = size(L1warp{i+1});

if dI+1<=0

        IM(1:(dI+sizeA(1)), dJ+1:dJ+sizeA(2),:,:) = L1warp{i+1}(1-dI:sizeA(2),:,:);

elseif dJ+1<=0

        IM(dI+1:(dI+sizeA(1)), 1:dJ+sizeA(2),:,:) = L1warp{i+1}(:,1-dJ:sizeA(2),:);

elseif (dI+1<=0)&&(dJ+1<=0)
                   
        IM(1:(dI+sizeA(1)), 1:dJ+sizeA(2),:,:) = L1warp{i+1}(1-dI:sizeA(2),1-dJ:sizeA(2),:);

else
        IM(dI+1:(dI+sizeA(1)),dJ+1:(dJ+sizeA(2)),:) = L1warp{i+1}(:,:,:);
end;


end;



overlapFrac = [0.1,1]

[dI, dJ] = Combine2Images_v1(A(:,:,1,3), A(:,:,11,3), overlapFrac,'show')

%%
L = A(:, :, 1,:);

L(dI:dI+511,dJ:dJ+511,:) = A(:,:,2,:);

imagesc(L(:,:,1))
%%

L = CombineImageLine_v3(A(:,:,1:10,:),4, [1, 0.1]);

%%
n=10
overlapFracX = [1,0.1]
%%
clear L1;
for i =1:10,
    i
    L1{i} = CombineImageLine_v3(A(:,:,(n*(i-1)+1):n*(i),:),4, overlapFracX);
end;


%%
i=2

tform = affine2d([sqrt(1-((size(L1{i},1)-512)/size(L1{i},2))^2) -(size(L1{i},1)-512)/size(L1{i},2) 0; (size(L1{i},1)-512)/size(L1{i},2) sqrt(1-((size(L1{i},1)-512)/size(L1{i},2))^2) 0; 0 0 1])
L1warp{i} = imwarp(L1{i}, tform);
%%
[dI,dJ] = Combine2Images_v1(L1warp{1}(28:end-27,:,3),L1warp{2}(28:end-27,:,3),[0.1,1],'show')


%%
Im = MakeImage_v3(A,4,10, [1, 0.1], [0.1, 1])
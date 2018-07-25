function IM = MakeImage_v4(Ain,Chan,n, overlapFracX, overlapFracY)
% 
% Ain - array of single tiles
% Chan - Channel number to use for allignment usually BF but you can play with it
% n -  pictures  nxn tiles, if you want other shapes, can be added I
% guess...
% overlapX:[1, fracoverlapx]  example: [1, 0.1] Sorry if these are not very
% elegant. Feel free to fix
% overlapY:[fracoverlapy, 1]  example: [0.1, 1]

A = Ain(:,:,:,Chan);

clear L1;
sizeA = size(Ain);
for i =1:(sizeA(3)/n),
    L1{i} = CombineImageLine_v3(Ain(:,:,(n*(i-1)+1):n*(i),:),Chan, overlapFracX);
end;




IM = L1{1};


dI = 0;
dJ = 0;

for i =1:(sizeA(3)/n-1),
    [di, dj] = Combine2Images_v1(A(:, :, 1+n*(i-1)), A(:, :, 1+n*(i)), overlapFracY)

    dI = dI+di;
    dJ = dJ+dj;
    skipL1 = min(size(L1{i},1),size(L1{i+1},1))-size(A,1)
  %  skipL1 = 27
%     if (overlapJ<0)||,
%         warning('overlap < 0'),
%     elseif (overlapJ > size(A, 2)),
%         warning('overlap > image dimensions'),
%     end;
%L(dI:dI+511,dJ:dJ+511,:) = A(:,:,2,:);
sizeA = size(L1{i+1});

if (dI+1<=0)&&(dJ+1<=0)
                   
        IM(1:(dI+sizeA(1)), 1:dJ+sizeA(2),:,:) = L1{i+1}(1-dI:sizeA(2),1-dJ:sizeA(2),:);

elseif dI+1<=0

        IM(1:(dI+sizeA(1)), dJ+1:dJ+sizeA(2),:,:) = L1{i+1}(1-dI:sizeA(2),:,:);

elseif dJ+1<=0
        IM(dI+skipL1+1:(dI+sizeA(1)), 1:dJ+sizeA(2),:,:) = L1{i+1}(skipL1+1:end,1-dJ:sizeA(2),:);
else
        IM(dI+skipL1+1:(dI+sizeA(1)),dJ+1:(dJ+sizeA(2)),:) = L1{i+1}(skipL1+1:end,:,:);
end;


end;


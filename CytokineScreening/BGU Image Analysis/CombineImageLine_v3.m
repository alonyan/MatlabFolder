function L = CombineImageLine_v3(Ain ,Chan, overlapFrac, varargin)
% assume Ain is M X N X n matrix where n is the number of images in the line
% Chan - Channel number to use for allignment usually BF but you can play with it
% overlapFrac:[1, fracoverlapx]  example: [1, 0.1] Sorry if these are not very
% elegant. Feel free to fix

A = Ain(:,:,:,Chan);
sizeA = size(A);


L{1} = Ain(:, :, 1,:);
dI = 0;
dJ = 0;

if ndims(A)>2
for i =1:(sizeA(3)-1),
    if strcmp(varargin,'show')
            [di, dj] = Combine2Images_v1(A(:, :, i), A(:, :, i+1), overlapFrac,'show');
    else
            [di, dj] = Combine2Images_v1(A(:, :, i), A(:, :, i+1), overlapFrac);
    end
%di=3;
%dj=473;
    dI = dI+di
    dJ = dJ+dj
    
%     if (overlapJ<0)||,
%         warning('overlap < 0'),
%     elseif (overlapJ > size(A, 2)),
%         warning('overlap > image dimensions'),
%     end;
%L(dI:dI+511,dJ:dJ+511,:) = A(:,:,2,:);

if dI+1<=0

        L{1}(1:(dI+sizeA(2)), dJ+1:dJ+sizeA(1),:,:) = Ain(1-dI:sizeA(2),:, i+1,:);

elseif dJ+1<=0

        L{1}(dI+1:(dI+sizeA(2)), 1:dJ+sizeA(1),:,:) = Ain(:,1-dJ:sizeA(1), i+1,:);

elseif (dI+1<=0)&&(dJ+1<=0)
                   
        L{1}(1:(dI+sizeA(2)), 1:dJ+sizeA(1),:,:) = Ain(1-dI:sizeA(2),1-dJ:sizeA(1), i+1,:);

else
        L{1}(dI+1:(dI+sizeA(2)),dJ+1:(dJ+sizeA(1)),:) = Ain(:,:, i+1,:);
end;
end;


end;
L = squeeze(L{1});




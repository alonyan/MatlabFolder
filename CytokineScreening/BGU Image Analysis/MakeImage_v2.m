function IM = MakeImage_v2(Ain,Chan, p, n)
% 
% p.i0 is the expected displacement between the images in the line
% p.di - the expected uncertainty in positions
% p.j0
% p.dj
% have yet to take care of vertical drift

A = Ain(:,:,:,Chan);
A = double(A);
sizeA = size(A);

pv.i0=p.i0;
pv.di =p.di;
pv.j0=0;
pv.dj = p.dj;

L = CombineImageLine_v3(Ain(:,:,1:n,:),Chan, p.j0, p.dj);


dI = 0;
dJ = 0;

%IM = zeros(size(L{1},2));
IM(1:size(L{1},1),:,:) = L{1};

for i =1:(sizeA(3)/n-1),
    i
    L{1+i} = CombineImageLine_v2(Ain(:, :, (n*i+1):n*(i+1),:),Chan, p.j0, p.dj);
    
    [C, P(i)] = match2images_v2(L{i}(:,:,Chan),L{1+i}(:,:,Chan), pv,'correlation');
    
    dI = dI + P(i).i;
    dJ = dJ + P(i).j
    
    overlapI = size(IM, 1) - dI;
    overlapJ = size(IM, 2) - dJ;
    %overlapI = 25
    if (overlapI<0),
        warning('overlap < 0'),
    elseif (overlapI > size(L{i+1}, 1)),
        warning('overlap > image dimensions'),
    end;
    
    cutI = round(overlapI/2);
        cutJ = round(overlapJ/2);

    IM((size(IM,1)-cutI):(size(IM,1)+size(L{i+1}, 1)-overlapI), 1:size(L{i+1},2),:) = L{i+1}((overlapI-cutI):size(L{i+1}, 1),:,:);
   %IM((size(IM,1)-cutI):(size(IM,1)+size(L{i+1}, 1)-overlapI), (size(IM,2)-cutJ):(size(IM,2)+size(L{i+1}, 2)-overlapJ),:)  = L{i+1}((overlapI-cutI):size(L{i+1},1),(overlapJ-cutJ):size(L{i+1},2),:);
end;




function IM = MakeImage_v1(A, p, n)
% 
% p.i0 is the expected displacement between the images in the line
% p.di - the expected uncertainty in positions
% p.j0
% p.dj
% have yet to take care of vertical drift

Space =100;


A = double(A);
sizeA = size(A)

pv.i0=p.i0;
pv.di =p.di;
pv.j0=0;
pv.dj = p.dj;

L1 = CombineImageLine_v1(A(:, :, 1:n), p.j0, p.dj);
IM = zeros(size(L1)+2*Space);
IM(Space:(Space+size(L1, 1)), Space:(Space+size(L1, 2))) = L1;

dI = 0;
dJ = 0;


for i =1:(sizeA(3)/n-1),
    i
    L2 = CombineImageLine_v1(A(:, :, (n*i+1):n*(i+1)), p.j0, p.dj);
    
    
    [C, P(i)] = match2images_v2(L1, L2, pv);
    
    dI = dI + P(i).i;
    dJ = dJ + P(i).j;
    
    overlapI = size(IM, 1) - dI;
    if (overlapI<0),
        warning('overlap < 0'),
    elseif (overlapI > size(A, 1)),
        warning('overlap > image dimensions'),
    end;
    
    cut = round(overlapI/2);
    Im((size(Im,1)-cut):(size(Im,1)+size(L, 1)-overlapI), :) = L((overlapI-cut):size(L, 1),:, i+1);
    
end;




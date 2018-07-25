function L = CombineImageLine_v2(Ain ,Chan , J0, dJ)
% assume A is M X N X n matrix where n is the number of images in the line
% J0 is the expected displacement between the images in the line
% dJ - the expected uncertainty in positions
% have yet to take care of vertical drift
A = Ain(:,:,:,Chan);
A = double(A);
sizeA = size(A);

p.i0 = 0;
p.j0 = J0;
p.di= dJ;
p.dj = dJ;

L = Ain(:, :, 1,:);
dI = 0;
dJ = 0;

for i =1:(sizeA(3)-1),
    [C, P(i)] = match2images_v2(A(:, :, i), A(:, :, i+1), p,'correlation');
    
    dI = dI + P(i).i;
    dJ = dJ + P(i).j;
    
    overlapJ = size(L, 2) - dJ;

    if (overlapJ<0),
        warning('overlap < 0'),
    elseif (overlapJ > size(A, 2)),
        warning('overlap > image dimensions'),
    end;
    
    cut = round(overlapJ/2);
    L(:, (size(L,2)-cut):(size(L,2)+sizeA(2)-overlapJ),:) = Ain(:, (overlapJ-cut):sizeA(2), i+1,:);
    
end;
L = squeeze(L);




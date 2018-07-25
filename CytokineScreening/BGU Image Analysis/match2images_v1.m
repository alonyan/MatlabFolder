function C = match2images_v1(A, B)

sizeA = size(A);
sizeB = size(B);

rangeRaws = 1:(sizeA(1)-sizeB(1)+1);
rangeClmns = 1:(sizeA(2)-sizeB(2)+1);

%C = conv2(A, B, 'valid');
for i = rangeRaws,
    for j = rangeClmns,
        D = (A(i:(i+sizeB(1)-1), j:(j+sizeB(2)-1)) - B).^2;
        C(i, j) = sum(D(:));
    end;
end;




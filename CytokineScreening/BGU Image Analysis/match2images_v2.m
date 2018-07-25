function [C, P, ROI_B] = match2images_v2(A, B, p, varargin)

% filter 
% 'deviation'
% 'correlation'

if nargin == 3,
    method = 'deviations';
else
    method = varargin{1};
end;

A = double(A);
B = double(B);

f = fspecial('sobel');
A = sqrt(imfilter(A, f, 'replicate').^2+ imfilter(A, f', 'replicate').^2);
B = sqrt(imfilter(B, f, 'replicate').^2+ imfilter(B, f', 'replicate').^2);

% p.i0 >=0
% p.j0 >=0
% p.di
% p.dj

sizeA = size(A);
sizeB = size(B);

ROI_B = B((p.di+1):(sizeA(1)-p.i0-p.di), (p.dj+1):(sizeA(2)-p.j0-p.dj));
%ROI_B = B(1:(sizeB(1)-p.i0-p.di), 1:(sizeB(2)-p.j0-p.dj));
sizeROI = size(ROI_B)  ;  

rangeRaws = (p.i0+1):(sizeA(1)-sizeROI(1)+1);
rangeClmns = (p.j0+1):(sizeA(2)-sizeROI(2)+1);

%C = conv2(A, B, 'valid');
for i = rangeRaws,
    for j = rangeClmns,
        E = A(i:(i+sizeROI(1)-1), j:(j+sizeROI(2)-1));
        if strcmp(method, 'deviations'),
            D = (E - ROI_B).^2;
            C(i-p.i0, j-p.j0) = sum(D(:));
        elseif strcmp(method, 'correlation'),
            D = (sum(sum(E.*ROI_B)) - mean(E(:))*mean(ROI_B(:)))/std(E(:))/std(ROI_B(:));
            C(i-p.i0, j-p.j0) = -D;
        end;
    end;
end;

[Y, I] = min(C);
[Ym, J]= min(Y);

P.i= I(J)+p.i0-p.di-1;
P.j = J+p.j0-p.dj-1;

%D = zeros(sizeB(1)+P.i, sizeB(2)+P.j,3);
%D(1:sizeA(1), 1:sizeA(2), 1) = A;
%D((P.i+1):(sizeB(1)+P.i), (P.j+1):(sizeB(2)+P.j),2) = B;

%D1((sizeA(1)+1):(sizeB(1)+P.i), (sizeA(2)+1):(sizeB(2)+P.j)) = B((sizeB(1)-P.i+1):sizeB(1), (sizeB(2)-P.j+1):sizeB(2));






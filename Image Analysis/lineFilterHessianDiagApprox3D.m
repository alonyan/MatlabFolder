function response = lineFilterHessianDiagApprox3D(img, sigma)

%make gaussian filter in 1D
g = Gaussian([1,0,sigma], -ceil(5*sigma):ceil(5*sigma));

%calculate 2nd derivative
gxx = (g(5:end)-2*g(3:end-2)+g(1:end-4))/4;

%filter in the "x" direction
A = imfilter(img,gxx,'replicate');
%permute so that y->x, x->z, z->y. Apply "x" direction filter (now y).
%permute back x->y, z->x, y->z. 
B = permute(imfilter(permute(img,[2 3 1]),gxx,'replicate'),[3 1 2]);
%repeat with appropriate permutations
C = permute(imfilter(permute(img,[3 1 2]),gxx,'replicate'),[2 3 1]);
%calculate the maximal response. Since the hessian is diagonal, it's just
%the max of the different blocks.
response = -max(cat(4,A,B,C),[],4);

end

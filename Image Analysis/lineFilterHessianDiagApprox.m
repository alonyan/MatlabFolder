function response = lineFilterHessianDiagApprox(img, sigma)
%lambda = 1;

g = Gaussian([1,0,sigma], -ceil(5*sigma):ceil(5*sigma));

gxx = (g(5:end)-2*g(3:end-2)+g(1:end-4))/4;
gyy = gxx';

A = imfilter(img,gxx,'replicate');
D = imfilter(img,gyy,'replicate');

response = -max(cat(3,A,D),[],3);

end

function [response, orientation] = lineFilterHessian(img, lambda)
%lambda = 5;

g = Gaussian([1,0,lambda], -ceil(5*lambda):ceil(5*lambda));

g = g'*g;

gxx = (g(5:end,:)-2*g(3:end-2,:)+g(1:end-4,:))/4;
gyy = (g(:,5:end)-2*g(:,3:end-2)+g(:,1:end-4))/4;

gxy = (g(3:end,3:end)-g(1:end-2,3:end)-g(3:end,1:end-2)+g(1:end-2,1:end-2))./2;

A = imfilter(img,gxx);
B = imfilter(img,gxy); 
D = imfilter(img,gyy);

%SolPlus = ((A+D)+sqrt((A+D).^2-4.*A.*D-B.^2))/2;
response = -((A+D)-sqrt((A+D).^2-4.*(A.*D-B.^2)))/2;

orientation = atan(((response-A)./B));
end

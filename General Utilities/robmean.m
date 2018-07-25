function y =robmean(x, sigma)
% averages vector x taking into account errors sigma
% size of x and sigma should be equal

x = x(:);
sigma = sigma(:);
if size(x) ~= size(sigma),
    error('the sizes of x and sigma should be equal'),
elseif size(x, 2) ~=1,
    error('x should be a vector'),
end;

y = sum(x./sigma.^2)/ sum(1./sigma.^2);
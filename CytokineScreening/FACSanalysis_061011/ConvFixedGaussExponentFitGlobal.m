function y = ConvFixedGaussExponentFitGlobal(beta, x, param)
pos = beta(1); % center of the Gaussian
sig = beta(2);  % its std

x = x-pos;
[S, X] = meshgrid(beta(3:end), x);
y = erfc( - (X - S*sig^2)/sig/sqrt(2) ).*exp( - S.*X+S.^2*sig^2/2).*S/2;
y(isnan(y)) = 0;
y = y./repmat(sum(y, 1), size(x, 2), 1);
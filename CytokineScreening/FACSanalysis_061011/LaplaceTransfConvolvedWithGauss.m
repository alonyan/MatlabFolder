function y = LaplaceTransfConvolvedWithGauss(beta, x, param)
% assume beta are the coefficients in Laplace Transform
if length(param) ~= (length(beta) + 1),
    errordlg('the length of beta should be smaller than the length of param by 1')
end;

beta = beta(:);
x = x(:);
pos = param(1); % center of the Gaussian
sig = param(2); % width of the Gaussian (std)

s = param(3:end); % other parameters are Laplace transform exponents
x = x - pos;
[S, X] = meshgrid(s,x);

A = (erfc( - (X - S*sig^2)/sig/sqrt(2) ).*exp( - S.*X).*exp(S.^2*sig^2/2).*S/2);
y = beta(end)/sig/sqrt(2*pi)*exp(- x.^2/sig^2/2) + A*beta(1:(end-1)); % add background to the set of exponents


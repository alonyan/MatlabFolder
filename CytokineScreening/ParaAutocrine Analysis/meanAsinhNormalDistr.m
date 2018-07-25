function [x, stdx] = meanAsinhNormalDistr(X, sig)

x = exp(sig.^2/2).*sinh(X);
varx = exp(sig.^2).*(exp(sig.^2) - 1) .* (sinh(X).^2 + 1/2 * (1 - exp(-sig.^2)));
stdx = sqrt(varx);


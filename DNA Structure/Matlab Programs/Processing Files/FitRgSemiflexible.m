function y = FitRgSemiflexible(beta, L)
b = beta(1); % Kuhn length

y = sqrt(L*b/6 -b^2/4 + b^3./(4*L) - b^4./(8*L.^2).*(1 - exp(-2*L./b)));
function y = FitCFwithMultipleGaussians(beta, vt, param)
A=beta(1);
Rsq = beta(2);
w = param.w;
b = param.b;
%wSq = param.wSq;

[VT, W] = meshgrid(vt, w);
[VT, B] = meshgrid(vt, b);

y = A*sum(B./(1+ 2/3* Rsq./W.^2) .* exp(-VT.^2./(W.^2+ 2/3*Rsq)));
y = y';

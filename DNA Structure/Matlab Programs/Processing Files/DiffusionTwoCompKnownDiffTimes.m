function y = DiffusionTwoCompKnownDiffTimes(beta, x, param);

b1 = beta(1);
b2 = beta(2);
tau1 = param(1);
%tau2 =  param(2);
tau2 = beta(3);
wSq = param(3);

y=b1./((1+x./tau1).*sqrt(1 + x./(tau1*wSq))) + b2./((1+x./tau2).*sqrt(1 + x./(tau2*wSq)));
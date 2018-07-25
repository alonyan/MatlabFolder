function y = FIMDAfit(beta, t)
q = beta(1);
tau = beta(2);
a = beta(3);
y  = q*(1+ t./(a*tau)).^(-a);
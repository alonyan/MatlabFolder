function y = PowerFit(beta, x);

b1 = beta(1);
b2 = beta(2);

y=b1*x.^b2;
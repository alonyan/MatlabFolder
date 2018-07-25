function y=YukavaFit(beta, x)
beta1=beta(1);
beta2=beta(2);
beta3 = beta(3);
y=beta1*exp(- beta2*x)./x + beta(3);


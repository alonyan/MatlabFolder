function y = ExponentApproach(beta,x)
amp = beta(1);
lambda = beta(2);

y = amp*(1-exp(-lambda*x));

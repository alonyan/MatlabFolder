function y = Poisson(beta,x)
amp = beta(1);
lambda = beta(2);


y = amp*exp(-lambda)*(lambda.^x)./factorial(x);

function y = ExponentwithBG(beta,x)
amp = beta(1);
lambda = beta(2);
bg = beta(3);

y = amp*exp(-lambda*x)+bg;

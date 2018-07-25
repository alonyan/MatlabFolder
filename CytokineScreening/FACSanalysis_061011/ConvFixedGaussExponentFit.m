function y = ConvFixedGaussExponentFit(beta, x, param)

ampl = beta(1) ; %alpha/2
alpha = beta(2); % the exponential decay rate
pos = param(1); % center of the Gaussian
sig = param(2); 
x = x - pos;
y = ampl*erfc( - (x - alpha*sig^2)/sig/sqrt(2) ).*exp( - alpha*x); %*exp(alpha^2*sig^2/2)
y = y/sum(y(~isnan(y)));
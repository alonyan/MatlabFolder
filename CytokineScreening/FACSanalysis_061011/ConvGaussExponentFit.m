function y = ConvGaussExponentFit(beta, x)

ampl = beta(1) ; %alpha/2
alpha = beta(2); % the exponential decay rate
pos = beta(3); % center of the Gaussian
sig = beta(4); 
x = x - pos;
y = ampl*erfc( - (x - alpha*sig^2)/sig/sqrt(2) ).*exp( - alpha*x); %*exp(alpha^2*sig^2/2)
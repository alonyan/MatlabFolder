function y=Diffusion2Drectified(beta, x)
A = beta(1);
tau = beta(2);
n = beta(3);
y=A./(1+(x/tau).^n);
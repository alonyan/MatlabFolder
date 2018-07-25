function y = ExpGrowth(beta,t)
tau = beta(1);
N0 = beta(2);

y = N0*2.^(t/tau);
function y = BleachingCellFit(beta, t)
A1= beta(1);
tau1 = beta(2);
A2 = beta(3);
tau2 = beta(4);

y = A1*tau1./t.*(1 - exp(-t/tau1)) + A2*exp(-t/tau2);
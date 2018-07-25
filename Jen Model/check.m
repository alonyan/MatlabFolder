function y = check(beta, t)
beta1 = beta(1);
beta2 = beta(2);


y = ((1/(beta1*(beta1-beta2))).*(exp(-beta1*t))-(1/(beta2*(beta1-beta2))).*(exp(-beta2*t))+1/(beta1*beta2));
function y = Rectifier(beta,x)
slope = beta(1);
pos = beta(2);

y = max(0,slope*x-pos);

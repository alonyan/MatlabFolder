function y = PolyAp(beta,t)
amp = beta(1);
n = beta(2);

y = amp*(1-t.*(-n));

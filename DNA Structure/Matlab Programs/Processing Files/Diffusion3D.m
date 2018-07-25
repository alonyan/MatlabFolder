function y = Diffusion3D(beta, x);

b1 = beta(1);
b2 = beta(2);
b3 = beta(3);

y=b1./((1+x./b2).*sqrt(1 + x./(b2*b3)));
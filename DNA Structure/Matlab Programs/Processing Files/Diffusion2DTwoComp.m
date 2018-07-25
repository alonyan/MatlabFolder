function y=Diffusion2DTwoComp(beta, x)
b1 = beta(1);
b2 = beta(2);
b3 = beta(3);
b4 = beta(4);

y=b1./(1+x/b2)+b3./(1+x/b4);
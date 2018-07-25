function y=Diffusion2DTwoCompBG(beta, x)
b1 = beta(1);
b2 = beta(2);
b3 = beta(3);
b4 = beta(4);
b5 = beta(5);

y=b1./(1+x/b2)+b3./(1+x/b4)+b5
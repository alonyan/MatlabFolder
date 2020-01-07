function y=YukavaFit(beta, x)
amp=beta(1);
xi=beta(2);
bg = beta(3);
y=amp*exp(- xi*x)./x + bg;


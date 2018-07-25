function y=ExpCosFit(beta, x)
amp=beta(1);
per=beta(2);
dec=beta(3);
y=amp*cos(2*pi.*x./per).*exp(- x./dec);


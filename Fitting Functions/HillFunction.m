function y = HillFunction (BETA, x)
amp=BETA(1);
coeff = BETA(2);
BG = BETA(3);

y = amp*x./(x+coeff)+BG;
end
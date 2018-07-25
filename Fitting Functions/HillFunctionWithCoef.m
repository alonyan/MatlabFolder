function y = HillFunctionWithCoef(BETA, x)
amp=BETA(1);
ec = BETA(2);
BG = BETA(3);
coeff = BETA(4);

y = amp*1./(1+(ec./x).^coeff)+BG;
end
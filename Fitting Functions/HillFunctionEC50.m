function y = HillFunctionEC50 (BETA, x)

coeff = BETA();
y = x./(x+coeff);
end
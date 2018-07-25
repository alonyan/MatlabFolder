function pSTAT5 = IL2RfitFixAmpl(beta, X, A)
pSTAT5 = beta(1) + A./(1+ beta(2)./X);


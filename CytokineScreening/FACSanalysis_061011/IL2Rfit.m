function pSTAT5 = IL2Rfit(beta, X)
pSTAT5 = beta(1) + beta(2)./(1+ beta(3)./X);


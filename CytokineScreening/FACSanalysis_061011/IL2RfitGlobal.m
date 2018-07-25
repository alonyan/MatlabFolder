function pSTAT5 = IL2RfitGlobal(beta, X)
Ncurves = (length(beta)-1)/2;
pSTAT5 = [];
A = beta(1);
BETA = reshape(beta(2:length(beta)), 2, Ncurves);
for i=1:Ncurves,
    Y = (BETA(1, i) + A./(1+ BETA(2, i)./X));
    pSTAT5 =[pSTAT5 Y];
end;
find(~isfinite(pSTAT5));


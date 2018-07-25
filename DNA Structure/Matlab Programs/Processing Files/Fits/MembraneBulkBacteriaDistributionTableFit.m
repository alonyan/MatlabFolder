function y = MembraneBulkBacteriaDistributionTableFit(beta, x, LookUpCell)
beta
Ns = beta(1);
Nb = beta(2);
R = beta(3);
Xc = beta(4);
%BG = beta(5);

if Ns <0,
    Ns = 0;
end;

if Nb < 0,
    Nb = 0;
end;

y = Ns*interp2(LookUpCell.xx, LookUpCell.RR, LookUpCell.SI, x - Xc, R, '*linear') + Nb*interp2(LookUpCell.xx, LookUpCell.RR, LookUpCell.BI, x - Xc, R, '*linear') ;
y = y(:);
function y=FitSemidiluteStructureFactor(beta, x, param);
%param should be a matrix whos first column is q and second column is
%structure factor of a dilute solution 

b1 = beta(1);
b2 = beta(2);

SQ = interp1(param(:, 1), param(:, 2), x, 'linear', 'extrap');

%eval(['corrF1 = CF1.' fieldStr ';']);
%eval(['corrF2 = CF2.' fieldStr ';'])
%y=b1*interp1(CF1.lag, CF1.AverageCF_CR, x)+b2*interp1(CF2.lag, CF2.AverageCF_CR, x);
y=b1*(b2+1)./(b2./SQ+1);
function y=FitTwoKnownComponents(beta, x, param);
%param should be a cell array containing two correlation function
%structures

b1 = beta(1);
b2 = beta(2);
CF1 = param{1};
CF2= param{2};

y=b1*interp1(CF1.lag, CF1.AverageCF_CR, x) + b2*interp1(CF2.lag, CF2.AverageCF_CR, x);
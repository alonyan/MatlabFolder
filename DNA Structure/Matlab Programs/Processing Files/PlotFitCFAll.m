function FitParamAll=PlotFitCFAll(CF, range, FUN, beta, param)

if (nargin == 5)
    AdditionalParam= (~isempty(param));
else
    AdditionalParam = 0;
end;


semilogx(CF.lag, CF.AverageCF_CR);
v=axis;
v(1)=range(1);
if length(range)>1,
    v(2)=range(2);
end;
axis(v);
if AdditionalParam
    FitParamAll=AxesFit2(CF.lag, CF.AverageAllCF_CR, FUN, beta, CF.errorAllCF_CR, param);
else
    FitParamAll=AxesFit2(CF.lag, CF.AverageAllCF_CR, FUN, beta, CF.errorAllCF_CR);
end;


'betaAll'
for i=1:length(beta),
    FitParamAll.beta(i, :)
end;
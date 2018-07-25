function FitParam = PlotFitCF(CF, range, FUN, beta, param)

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
    FitParam=AxesFit2(CF.lag, CF.AverageCF_CR, FUN, beta, CF.errorCF_CR, param);
else
    FitParam=AxesFit2(CF.lag, CF.AverageCF_CR, FUN, beta, CF.errorCF_CR);
end;

'beta'
for i=1:length(beta),
    FitParam.beta(i, :)
end;
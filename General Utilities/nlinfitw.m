function [beta r J Covar mse] = nlinfitw(x,y,sig,model,guess)
yw = y./sig;
modelw = @(b,x) model(b,x) ./ sig;
[beta r J Covar mse] = nlinfit(x,yw,modelw,guess);
Covar = Covar ./ mse;
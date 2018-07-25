function [FitParam,RESNORM,RESIDUAL,EXITFLAG,OUTPUT,LAMBDA,JACOBIAN] = nlinfitWeight2(x,y,model,beta0, sigma, param, varargin)
% a new function based on lsqcurvefit: allows to define lower and upper
% bounds for the coefficients. The first six parameters are the same as for
% nlinfitWeight1: x,y,model,beta0, sigma, param. If the model function does 
% not contain any fixed parameters use empty vector [] for param.
% Varargin are optional parameters, same as for lsqcurvefit: check help
% lsqcurvefit. In particular, this function allows to put upper/lower bounds on the fit
% parameters (say, if you want to keep them positive).
% Example
% FitParam = nlinfitWeight2(t, G, @Diffusion3Dforced, [0.5 5], errorG, [30], [0 0], [inf inf])
%
% Oleg 17.03.2015 



if ~isempty(param), 
    [fitBETA,RESNORM,RESIDUAL,EXITFLAG,OUTPUT,LAMBDA,JACOB] = ...
        lsqcurvefit(@(beta, xdata) model(beta, xdata, param)./sigma, beta0, x, y./sigma, varargin{:});
else
    [fitBETA,RESNORM,RESIDUAL,EXITFLAG,OUTPUT,LAMBDA,JACOB] = ...
        lsqcurvefit(@(beta, xdata) model(beta, xdata)./sigma, beta0, x, y./sigma, varargin{:});
end;

 % alternative way of estimating errors
% [Q,R] = qr(JACOB,0);
% mse = RESNORM/(size(JACOB,1)-size(JACOB,2));
% Rinv = inv(R);
% Sigma = Rinv*Rinv'*mse;
% delta = sqrt(diag(Sigma));

CI = nlparci(fitBETA ,RESIDUAL,'jacobian',JACOB); % 95% confidence interval
FitParam.beta=fitBETA;
%FitParam.CI = CI; 
FitParam.errBeta= diff(CI, 1, 2)/4; % the CI are for +/- 2 std interval
FitParam.chiSqNorm= RESNORM/(length(x)-length(beta0));
FitParam.x=x;
FitParam.residNorm=RESIDUAL;

end


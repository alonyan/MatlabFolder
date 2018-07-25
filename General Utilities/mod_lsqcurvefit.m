function [p, r,  err]=mod_lsqcurvefit(fixed, x, y, fun, beta0, varargin)
% [p, err]=mod_nlinfit(fixed, x, y, fun, beta0, varargin)
% p: vector containing the fitting results
% r: residuals
% err: error bars of the parameters
% fixed is a vector of the same length of beta0 and containing logical elements (i.e. true and
% false). True values mean FIXED parameters. 
% EXAMPLE
% If you have three parameters, a vector fixed [true true false]
% means that only the third parameter will change


% all the values in beta0 are copied in p however only the free (NOT fixed)
% ones will change
p=beta0; 

% fixed parameters will get zero uncertainity
err=zeros(size(beta0));

% extraction of the free parameters
beta1=beta0(~fixed);

[p1, r1, JJ1] = nlinfit(x,y,@nested_fun,beta1,varargin{:});

% getting the error bars for the free parameters
delta=nlparci(p1, r1, JJ1);
err1=(delta(:, 2)- delta(:, 1))/2;

% update the parameters
p(~fixed)=p1;

%residuals
r=r1;

% ... and the error bars
err(~fixed)=err1;

    % Nested function takes just the parameters to be estimated as inputs
    % It inherits the following from the outer function:
    %   fixed = logical index for fixed elements
    %   beta0 = original guess for the parameters
    function yy=nested_fun(beta, x)
        
        b(fixed)=beta0(fixed);
        b(~fixed)=beta;
        
        yy=fun(b, x);

    end
end 

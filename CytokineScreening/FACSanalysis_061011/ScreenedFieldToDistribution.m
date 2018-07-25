function P = ScreenedFieldToDistribution(beta, X, varargin)

rhostep = 0.01;

Qtag = beta(1);
rho0 = beta(2);
A = beta(3);

alpha = exp(-2*rho0).*(rho0 - 1)./(rho0 + 1);

if length(varargin)>0,
    minrho = varargin{1};
else
    minrho = 0.01;
    while (asinh( Qtag * (exp( - minrho) + alpha*exp(minrho))./minrho) < max(X)),
        minrho = minrho/2;
    end;
end;


rho = minrho:rhostep:rho0;

if length(rho)>1,
    X1 = asinh( Qtag * (exp( - rho) + alpha*exp(rho))./rho);
    %[max(X) max(X1)]
    P1 = A*rho.^4.*sqrt(1 + sinh(X1).^2)./(exp(-rho) .* (1+rho) + alpha * exp(rho) .* (1 - rho));
    %P(rho > rho0) = 0;

    P = interp1(X1, P1, X, 'linear', 'extrap');

    minX = 2*Qtag*exp(-rho0)/(1+rho0);
    P(X  < minX) = 0;
    P(X > max(X1)) = 0;
else
    P = zeros(size(X));
end;



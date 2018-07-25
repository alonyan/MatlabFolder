function y = StickDiffusionPreciseFit(beta, t, wXY)
% after Kruse Phys. Biology 3, 255 (2006)
A = beta(1);
tauDiff = beta(2);
tau1 = beta(3);
tau2 = beta(4);

D = wXY^2/(4*tauDiff);
for i=1:length(t),
    y(i) = quadgk( @(q) myfun(q, t(i), wXY, D, tau1, tau2), 0, inf );
end;

% t=0 level to calculate amplitude
y0 = quadgk( @(q) myfun(q, 0, wXY, D, tau1, tau2), 0, inf );
y = A*y/y0;
y = y(:);

function z = myfun(q, t, wXY, D, tau1, tau2)
Delta = sqrt( (D*q.^2 + 1/tau1 + 1/tau2).^2 - 4*D*q.^2/tau2);
Lam1 = - (D*q.^2 + 1/tau1 +1/tau2)/2 + Delta/2;
Lam2 = Lam1 - Delta;
A1 =(Lam2 + D*q.^2*tau1/(tau1 + tau2))./(Lam2 - Lam1);
A2 =(Lam1 + D*q.^2*tau1/(tau1 + tau2))./(Lam1 - Lam2);

z = q.*exp(-wXY^2*q.^2/4).*( A1.*exp(Lam1*t) + A2.*exp(Lam2*t));
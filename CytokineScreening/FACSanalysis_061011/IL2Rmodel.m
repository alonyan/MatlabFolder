function [NR, NRap] = IL2Rmodel(IL2, Na, Nbg)
k1on = 1.4e7;
k1off = 0.4;
k2on = 3e-4;
k2off = 2.3e-4;
k3 = 1.1e-3;

K = (k2off +k3)*k1off/(k3*k2on);

% Nbg = 10000;
% Na = 10000;
% IL2 = 10.^(-14:0.1:-8);

J = k1on*IL2*Na;

B = Nbg + J/k3 + K;
Delta = B.^2 - 4*Nbg*J/k3;

NR = 0.5*(B - sqrt(Delta));
NRap = Nbg./(1 + K*k3./J);
% semilogx(IL2, NR, IL2, Nbg./(1 + 5e-11./IL2));
% figure(gcf)

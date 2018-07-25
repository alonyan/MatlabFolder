
S.Sq = S.fq./data061008_proc0710.field500.fq;
S.Sq_int =S.fq_int./data061008_proc0710.field500.fq_int;

%%
b = 0.1;
L = 1.5*4300*0.34e-3
S.length = L;
S.Rg_theory = sqrt(L*b/6 -b^2/4 + b^3./(4*L) - b^4./(8*L.^2).*(1 - exp(-2*L/b)));
loglog(S.q, S.Sq_int);
figure(gcf);
pause;

J= InAxes;
curAx = axis;

[BETA, temp, temp] = nlinfitWeight1(S.q(J), S.Sq_int(J), @FitSharpBloomfieldStucFactor, [S.Rg_theory 1], 0.001*ones(size(S.Sq_int(J))), L);
%[BETA, temp, temp] = nlinfitWeight1(S.q(J), S.Sq_int(J), @FitSharpBloomfieldStucFactor, [0.2 1], 0.001*S.Sq_int(J), L);
S.paramSB = BETA;
loglog(S.q, S.Sq_int, 'o', S.q(J), FitSharpBloomfieldStucFactor(BETA, S.q(J), L));
axis(curAx);
figure(gcf);
S.Jfit = J;
S.Rg_fit = BETA(1);
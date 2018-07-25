function P = FIDAsimple_fit(betafit, n)

N = betafit(1);
q = betafit(2);

P = FIDAsimple_v2(n, N, q);
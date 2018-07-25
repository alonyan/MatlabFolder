function P = FIDAsimple_fit(beta, n)

N = beta(1);
q = beta(2);

P =real(FIDAsimple_v2(n, N, q));
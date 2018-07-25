function P = FIDAsimple3comp_fit(beta, n)

N1 = beta(1);
q1 = beta(2);
N2 = beta(3);
q2 = beta(4);
N3 = beta(5);
q3 = beta(6);

P =FIDAsimple3comp_v2(n, N1, q1, N2, q2, N3, q3);
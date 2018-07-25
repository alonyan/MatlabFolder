function P = FIDAsimple3compConstrained_fit(beta, n, param)

q1 = beta(1);
N1 = param(1)/beta(1);
q2 = beta(2);
N2 = param(2)/beta(2);
q3 = beta(3);
N3 = param(3)/beta(3);

P =FIDAsimple3comp_v2(n, N1, q1, N2, q2, N3, q3);
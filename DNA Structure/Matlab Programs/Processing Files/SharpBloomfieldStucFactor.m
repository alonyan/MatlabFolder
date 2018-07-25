function S = SharpBloomfieldStucFactor(q, Rg, L);
% Sharp Bloomfield, Biopolymers (1968)
% Getting final expression from Yamakawa (mostly)

b = 6*Rg^2/L
N = L/b
x = Rg^2*q.^2;

S.q = q;
S.Sq = 2./x.^2.*(x-1+exp(-x)) +(4 - 11* exp(-x))/(15*N) + 7./(15*x*N).*(1-exp(-x));

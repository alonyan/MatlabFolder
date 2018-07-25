function Sq = FitSharpBloomfieldStucFactor(beta, q, L);
% Sharp Bloomfield, Biopolymers (1968)
% Getting final expression from Yamakawa (mostly)

Rg = beta(1);
A = beta(2);
%L = beta(2) ;
b = 6*Rg^2/L
N = L/b
x = Rg^2*q.^2;
Sq = A*2./x.^2.*(x-1+exp(-x)) +(4 - 11* exp(-x))/(15*N) + 7./(15*x*N).*(1-exp(-x));

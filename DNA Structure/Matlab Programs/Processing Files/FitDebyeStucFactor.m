                                             
function Sq = FitDebyeStucFactor(beta, q);
% Sharp Bloomfield, Biopolymers (1968)
% Getting final expression from Yamakawa (mostly)

Rg = beta(1);
A = beta(2);

x = Rg^2*q.^2;
Sq = A*2./x.^2.*(x-1+exp(-x));

                                             
function Sq = FitOrnsteinZernickeStrucFactor(beta, q);
% Sharp Bloomfield, Biopolymers (1968)
% Getting final expression from Yamakawa (mostly)

ksi = beta(1);
A = beta(2);

x = ksi^2*q.^2;
Sq = A./(1+x);

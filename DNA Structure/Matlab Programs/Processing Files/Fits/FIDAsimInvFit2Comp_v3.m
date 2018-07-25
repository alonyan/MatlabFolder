function [GforFit, G] =FIDAsimInvFit2Comp_v2(beta, phi)
%  assumes uniform illumination
%   parameters - 
% output: probability P(n) of having n counts during the sampling time interval
% inputs : n - counts per the sampling time interval
%                     N - number of molecules in the sampling volume
%                     q - photon count from a single molecule in the field 

N1 = beta(1);
q1 = beta(2);
N2 = beta(3);
q2 = beta(4);
%G = exp(N*(exp((exp(sqrt(-1)*xi) - 1)*q) -1) );
xi =xi(1:round(length(phi)/2));
G = (N1*(exp((exp(sqrt(-1)*phi) - 1)*q1) -1) ) + (N2*(exp((exp(sqrt(-1)*phi) - 1)*q2) -1) );
G = exp(G);
G = G(:);
GforFit = [real(G); imag(G)];
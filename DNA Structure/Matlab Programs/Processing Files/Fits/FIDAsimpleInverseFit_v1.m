function G =FIDAsimpleInverseFit_v1(beta, xi)
%  assumes uniform illumination
%   parameters - 
% output: probability P(n) of having n counts during the sampling time interval
% inputs : n - counts per the sampling time interval
%                     N - number of molecules in the sampling volume
%                     q - photon count from a single molecule in the field 

N = beta(1);
q = beta(2);
%G = exp(N*(exp((exp(sqrt(-1)*xi) - 1)*q) -1) );
G = (N*(exp((exp(sqrt(-1)*xi) - 1)*q) -1) );
G = G(:);

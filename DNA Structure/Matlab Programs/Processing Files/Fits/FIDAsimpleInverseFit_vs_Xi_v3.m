function [logGforFit, logG] =FIDAsimpleInverseFit_vs_Xi_v3(beta, xi)
%  assumes uniform illumination
%   parameters - 
% output: probability P(n) of having n counts during the sampling time interval
% inputs : n - counts per the sampling time interval
%                     N - number of molecules in the sampling volume
%                     q - photon count from a single molecule in the field 

N = beta(1);
q = beta(2);
%G = exp(N*(exp((exp(sqrt(-1)*xi) - 1)*q) -1) );
% xi is repeated twice for comlacency with nlinfitWeight1; remove half of
% the vector;
%xi = xi(1:round(length(xi)/2));
logG = (N*(exp((xi - 1)*q) -1) );
logG = logG(:);
logGimag =  mod(imag(logG)+pi , 2*pi) - pi;
logGforFit = [real(logG); logGimag];
%G = [abs(G); sin(angle(G)); cos(angle(G))];
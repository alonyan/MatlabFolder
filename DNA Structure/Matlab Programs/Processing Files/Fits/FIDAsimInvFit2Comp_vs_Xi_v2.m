function [logGforFit, logG] =FIDAsimInvFit2Comp_vs_Xi_v2(beta, xi)
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
logG = (N1*(exp((xi - 1)*q1) -1) ) + (N2*(exp((xi - 1)*q2) -1) );
logG = logG(:);
logGimag =  mod(imag(logG)+pi , 2*pi) - pi;
logGforFit = [real(logG); logGimag];
function P =FIDAsimple_v2(n, N, q)
%  assumes uniform illumination
%   parameters - 
% output: probability P(n) of having n counts during the sampling time interval
% inputs : n - counts per the sampling time interval
%                     N - number of molecules in the sampling volume
%                     q - photon count from a single molecule in the field 

for k = 1:length(n),
    P(k) = quadgk(@(xi)FIDAf(xi, n(k), N, q), -pi, pi)/(2*pi);
end;


function y = FIDAf(xi, n, N, q)
y = exp(N*(exp((exp(sqrt(-1)*xi) - 1)*q) -1)  - sqrt(-1)*n*xi);

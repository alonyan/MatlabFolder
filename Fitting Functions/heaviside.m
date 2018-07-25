function y = heaviside (x)
% HEAVISIDE	The Heaviside Step Function
%
%	heaviside (x) returns the heaviside step function
%
%              ( 0,   x < 0
%	H(x) = | 1/2, x = 0
%              ( 1,   x > 0

y = ones (size (x));
k = find (x < 0);
if (isempty(k) == 0)
	y(k) = zeros(size(k));
end
k = find (x == 0);
if (isempty(k) == 0)
	y(k) = 0.5*ones(size(k));
end
function y = delayedLinear(beta,t)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
a = beta(1);
delta = beta(2);
m = beta(3);

y = a+heaviside(t-delta).*(m*(t-delta));

end


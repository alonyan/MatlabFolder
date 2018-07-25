function y = NGaussianFit_v2(beta, x)
if rem(length(beta),3)
    error('must have 3n fitting parameters')
else
N = length(beta)/3
y=0;
for i=1:N
ampl = beta(3*i-2);
pos = beta(3*i-1);
std = beta(3*i);

y = y+(ampl/std)*exp(-(x - pos).^2/(2*std^2))/sqrt(2*pi) ;
end
end


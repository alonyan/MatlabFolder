function y = NGaussianfft_v1(beta, x,Qtag)
if rem(length(beta),3)
    error('must have 3n fitting parameters')
else
N = length(beta)/3
y=0;
for i=1:N
ampl = beta(3*i-2);
pos = beta(3*i-1);
std = beta(3*i);
y = y+ampl*exp(sqrt(-1)*pos*x/Qtag - 1/2*(std*x/Qtag).^2) ;
end
end


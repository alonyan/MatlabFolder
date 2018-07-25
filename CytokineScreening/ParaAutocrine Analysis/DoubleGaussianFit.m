function y = DoubleGaussianFit(beta, x)
ampl1 = beta(1);
pos1 = beta(2);
std1 = beta(3);
ampl2 = beta(4);
pos2 = beta(5);
std2 = beta(6);

y = ampl1*exp(-(x - pos1).^2/(2*std1^2)) + ampl2*exp(-(x - pos2).^2/(2*std2^2));

end


function y = FiveGaussianFit_v1(beta, x)
ampl1 = beta(1);
pos1 = beta(2);
std1 = beta(3);
ampl2 = beta(4);
pos2 = beta(5);
std2 = beta(6);
ampl3 = beta(7);
pos3 = beta(8);
std3 = beta(9);
ampl4 = beta(10);
pos4 = beta(11);
std4 = beta(12);
ampl5 = beta(13);
pos5 = beta(14);
std5 = beta(15);

y = ampl1*exp(-(x - pos1).^2/(2*std1^2))/sqrt(2*pi)/std1 + ampl2*exp(-(x - pos2).^2/(2*std2^2))/sqrt(2*pi)/std2 + ...
    ampl3*exp(-(x - pos3).^2/(2*std3^2))/sqrt(2*pi)/std3+ ampl4*exp(-(x - pos4).^2/(2*std4^2))/sqrt(2*pi)/std4...
    + ampl5*exp(-(x - pos5).^2/(2*std5^2))/sqrt(2*pi)/std5;

end


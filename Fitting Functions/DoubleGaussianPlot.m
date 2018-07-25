function [y, y1, y2] = DoubleGaussianPlot(beta, x)
ampl1 = beta(1);
pos1 = beta(2);
std1 = beta(3);
ampl2 = beta(4);
pos2 = beta(5);
std2 = beta(6);

y = ampl1*exp(-(x - pos1).^2/(2*std1^2))/sqrt(2*pi)/std1 + ampl2*exp(-(x - pos2).^2/(2*std2^2))/sqrt(2*pi)/std2;
y1 = ampl1*exp(-(x - pos1).^2/(2*std1^2))/sqrt(2*pi)/std1;
y2 = ampl2*exp(-(x - pos2).^2/(2*std2^2))/sqrt(2*pi)/std2;
end
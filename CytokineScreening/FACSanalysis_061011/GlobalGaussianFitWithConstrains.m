function y = GlobalGaussianFitWithConstrains(beta, x)
Nsets = (length(beta)-2)/4;
pos1 = beta(1);
std1 = beta(2);

x = x(:);
y = [];

for j =1:Nsets,
    ampl1 = beta((j-1)*4 + 3);
    ampl2 = beta((j-1)*4 + 4);
    pos2 = beta((j-1)*4 + 5);
    std2 = beta((j-1)*4 + 6);
    y = [y; ampl1*exp(-(x - pos1).^2/(2*std1^2)) + ampl2*exp(-(x - pos2).^2/(2*std2^2))];
end;
        


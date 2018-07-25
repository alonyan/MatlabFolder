function [mean, std] = wmean(data, Cnums,dim)

mean = sum((data.*Cnums),dim)./sum((Cnums),dim);
std = sqrt(sum(((data.^2).*Cnums),dim)./sum((Cnums),dim)-mean.^2);

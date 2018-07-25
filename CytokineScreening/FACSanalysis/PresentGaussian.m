function y = PresentGaussian(beta, x,n)
Nsets = (length(beta)-1)/5;
frac1 = beta(1);
frac2 = 1-frac1;

x = x(:);
y = [];
if n==1
for j =1:Nsets,
    TotAmpl = beta((j-1)*5 + 2);
    ampl1 = TotAmpl*frac1;
    ampl2 = TotAmpl*frac2;
    
    pos1 = beta((j-1)*5 + 3);
    std1 = beta((j-1)*5 + 4);
    pos2 = beta((j-1)*5 + 5);
    std2 = beta((j-1)*5 + 6);
    y = [y; ampl1*exp(-(x - pos1).^2/(2*std1^2))/sqrt(2*pi)/std1 ];
end;
elseif n==2
  for j =1:Nsets,
    TotAmpl = beta((j-1)*5 + 2);
    ampl1 = TotAmpl*frac1;
    ampl2 = TotAmpl*frac2;
    
    pos1 = beta((j-1)*5 + 3);
    std1 = beta((j-1)*5 + 4);
    pos2 = beta((j-1)*5 + 5);
    std2 = beta((j-1)*5 + 6);
    y = [y; ampl2*exp(-(x - pos2).^2/(2*std2^2))/sqrt(2*pi)/std2];
end;  
    
end
      
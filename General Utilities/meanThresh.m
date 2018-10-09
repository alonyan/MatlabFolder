function Thresh = meanThresh(Data)
    if size(Data(:)>2000000)
        [h,x] = hist(datasample(Data(:),2000000),100);
    else
        [h,x] = hist((Data(:)),100);
    end
h = h./sum(h);
Thresh = 0;
Av = 1;
n=0;
while Av>Thresh
    n=n+1;
    Thresh = x(n);
    Jbelow = x<=Thresh;
    Jabove = x>Thresh; 
    Av = ((x(Jbelow)*h(Jbelow)'/sum(h(Jbelow)))+(x(Jabove)*h(Jabove)'/sum(h(Jabove))))/2;
end
end
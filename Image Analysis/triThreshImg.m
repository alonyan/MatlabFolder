function triThresh = triThreshImg(img)
if numel(img)>1000000
    img = datasample(img(:), 1000000);
end
[histIn, x] = hist(img(:), min(1000, round(numel(img(:))/10)));
a = x(find(cumsum(histIn)/sum(histIn)==1,1)); %brightest
b = x(histIn==max(histIn)); %most probable
h = max(histIn); %response at most probable

b = b(1);

m = h/(b-a);

x1=0:0.001:(a-b);
y1=interp1(x,histIn,x1+b);

L = (m.^2+1)*((y1-h).*(1/(m.^2-1))-x1.*m/(m.^2-1)).^2; %Distance between line m*x+b and curve y(x) maths!

triThresh = b+x1(L==max(L));
end
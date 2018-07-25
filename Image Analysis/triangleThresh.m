function triThresh = triangleThresh(histIn,x)
a = x(find(cumsum(histIn)/sum(histIn)>0.99,1)); %brightest
b = x(histIn==max(histIn)); %most probable
h = max(histIn); %response at most probable

m = h/(b-a);

x1=0:0.01:(a-b);
y1=interp1(x,histIn,x1+b);

L = (m.^2+1)*((y1-h).*(1/(m.^2-1))-x1.*m/(m.^2-1)).^2; %Distance between line m*x+b and curve y(x) maths!

triThresh = b+x1(L==max(L));
end
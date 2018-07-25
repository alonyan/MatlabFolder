function fpdf = FrechetPDFfit(beta, x)
% define Frechet distribution according to Wikipedia notation
k = beta(1);
m = beta(2);
s = beta(3);
y = (x-m)./s;
fpdf = k./s.*y.^(-1-k).*exp(-y.^(-k));
fpdf(y <=0) = 0;
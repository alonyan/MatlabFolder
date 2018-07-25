function  fpdf = FrechetPDF(x, k, m, s)
% define Frechet distribution according to Wikipedia notation
y = (x-m)./s;
fpdf = k./s.*y.^(-1-k).*exp(-y.^(-k));
fpdf(y <=0) = 0;
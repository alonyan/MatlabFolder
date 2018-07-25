%% generate data
x = 0:0.01:100;
y = 10+0.2*randn(length(x),1);
nbins = 100;
[H1, X1] = hist(y,nbins)

plot(X1, H1); figure(gcf)
%% remove outliers (this will change based on your data)
outliers = 1e-3;
H1 = H1/sum(H1);

cH1 = cumsum(H1);
J = min(find(cH1 > outliers)) : max(find(cH1 < (1-outliers)));

plot(X1, H1, X1(J), H1(J)); figure(gcf)
%% estimate initial parameters (this will also change based on your data)
pos = H1(J)*X1(J)' %Mean of the histogram
stdev = sqrt(H1(J)*X1(J).^2' - pos^2) %Standard deviation of histogram
amp = max(H1(J))*sqrt(2*pi)*stdev %Amplitude
%% Fit and plot

BETA = lsqcurvefit(@GaussianFit, [amp pos stdev] ,X1(J), H1(J),[0 -inf 0])

plot(X1(J), H1(J), 'o', X1(J), GaussianFit(BETA, X1(J)));
figure(gcf)

%% Area of Gaussian using our GaussianFit function is just BETA(1)
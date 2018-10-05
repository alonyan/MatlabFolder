function [Xb, Yb, stdXb, stdYb, steXb, steYb] = BinData_v1(X, Y, bins);

[X, J] = sort(X);
Y = Y(J);
h = histcounts(X, bins);
h = h(:);
h = [0; h];
h = cumsum(h);
for i=1:(length(h) -1),
    Xt = X((h(i) + 1):h(i+1));
    Xb(i) = nanmean(Xt);
    stdXb(i) = nanstd(Xt);
    steXb(i) = stdXb(i)/sqrt(length(Xt));
    
    Yt = Y((h(i) + 1):h(i+1));
    Yb(i) = nanmean(Yt);
    stdYb(i) = nanstd(Yt);
    steYb(i) = stdYb(i)/sqrt(length(Yt));
end;
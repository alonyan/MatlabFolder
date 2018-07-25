function [Xb, Yb, stdXb, stdYb, steXb, steYb] = BinData_v1(X, Y, bins);

[X, J] = sort(X);
Y = Y(J);
h = histc(X, bins);
h = h(:);
h = [0; h];
h = cumsum(h);
for i=1:(length(h) -1),
    Xt = X((h(i) + 1):h(i+1));
    Xb(i) = mean(Xt);
    stdXb(i) = std(Xt);
    steXb(i) = stdXb(i)/sqrt(length(Xt));
    
    Yt = Y((h(i) + 1):h(i+1));
    Yb(i) = mean(Yt);
    stdYb(i) = std(Yt);
    steYb(i) = stdYb(i)/sqrt(length(Yt));
end;
function y= robustinterp(x, xi, yi, varargin)
if length(varargin) < 1,
    Ninterp_points = 1;
else 
    Ninterp_points = varargin{1};
end;

%extrap = length(find(strcmp(varargin, 'extrap'))) ;
xi = xi(:)';
[h, bin] = histc(x, [-inf xi inf]) ;
ch = cumsum(h);
st = max(bin(1) - 1, Ninterp_points);
fin = min(bin(length(x))-1, length(xi) - Ninterp_points);
for i = st:fin,
    Ji = (i - Ninterp_points+1):(i+Ninterp_points);
    p= robustfit(xi(Ji), yi(Ji));
    
    if i == st,
        J=1:ch(i+1);
    elseif i==fin,
        J=(ch(i) +1):length(x);
    else
        J= (ch(i) + 1):ch(i+1);
    end;
    
    y(J) = p(1) + p(2)*x(J);
end;


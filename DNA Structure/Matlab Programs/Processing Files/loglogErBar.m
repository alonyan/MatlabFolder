                                                                     
                                             
function hh = loglogErBar(x, y, l,u,symbol)
%ERRORBAR Error bar plot.
%   ERRORBAR(X,Y,L,U) plots the graph of vector X vs. vector Y with
%   error bars specified by the vectors L and U.  L and U contain the
%   lower and upper error ranges for each point in Y.  Each error bar
%   is L(i) + U(i) long and is drawn a distance of U(i) above and L(i)
%   below the points in (X,Y).  The vectors X,Y,L and U must all be
%   the same length.  If X,Y,L and U are matrices then each column
%   produces a separate line.
%
%   ERRORBAR(X,Y,E) or ERRORBAR(Y,E) plots Y with error bars [Y-E Y+E].
%   ERRORBAR(...,'LineSpec') uses the color and linestyle specified by
%   the string 'LineSpec'.  See PLOT for possibilities.
%
%   H = ERRORBAR(...) returns a vector of line handles.
%
%   For example,
%      x = 1:10;
%      y = sin(x);
%      e = std(y)*ones(size(x));
%      errorbar(x,y,e)
%   draws symmetric error bars of unit standard deviation.

%   L. Shure 5-17-88, 10-1-91 B.A. Jones 4-5-93
%   Copyright (c) 1984-97 by The MathWorks, Inc.
%   $Revision: 5.11 $  $Date: 1997/04/08 06:45:39 $

if min(size(x))==1,
  npt = length(x);
  x = x(:);
  y = y(:);
    if nargin > 2,
        if ~isstr(l),  
            l = l(:);
        end
        if nargin > 3
            if ~isstr(u)
                u = u(:);
            end
        end
    end
else
  [npt,n] = size(x);
end

if nargin == 3
    if ~isstr(l)  
        u = l;
        symbol = '-';
    else
        symbol = l;
        l = y;
        u = y;
        y = x;
        [m,n] = size(y);
        x(:) = (1:npt)'*ones(1,n);;
    end
end

if nargin == 4
    if isstr(u),    
        symbol = u;
        u = l;
    else
        symbol = '-';
    end
end


if nargin == 2
    l = y;
    u = y;
    y = x;
    [m,n] = size(y);
    x(:) = (1:npt)'*ones(1,n);;
    symbol = '-';
end

u = abs(u);
l = abs(l);
    
if isstr(x) | isstr(y) | isstr(u) | isstr(l)
    error('Arguments must be numeric.')
end

if ~isequal(size(x),size(y)) | ~isequal(size(x),size(l)) | ~isequal(size(x),size(u)),
  error('The sizes of X, Y, L and U must be the same.');
end

%tee = (max(x(:))-min(x(:)))/100;  % make tee .02 x-distance for error bars
tee = (max(x(:))/min(x(find(x(:)>0))))^0.001
xl = x * tee;
xr = x / tee;
n = size(y,2);

% Plot graph and bars
cax = newplot;
next = lower(get(cax,'NextPlot'));
% build up nan-separated vector for bars
xb = [];
yb = [];
nnan(1,1:n) = nan;
for i = 1:npt
    ytop = y(i,:) + u(i,:);
    ybot = y(i,:) - l(i,:);
    xb = [xb;x(i,:);x(i,:);nnan;xl(i,:);xr(i,:);nnan;xl(i,:);xr(i,:);nnan];
    yb = [yb; ytop;ybot;nnan;ytop;ytop;nnan;ybot;ybot;nnan];
end
[ls,col,mark,msg] = colstyle(symbol); if ~isempty(msg), error(msg); end
symbol = [ls mark col]; % Use marker only on data part
esymbol = ['-' col]; % Make sure bars are solid

h = loglog(xb,yb,esymbol); hold on
h = [h;loglog(x,y,symbol)]; hold off

if nargout>0, hh = h; end

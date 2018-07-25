function [minC, maxC] = ColorLims(H,varargin)

if nargin >1
    try
        OLFracB = varargin{1}(1);
        OLFracT = varargin{1}(2);
    catch
        OLFracB = varargin{1};
        OLFracT = varargin{1};
        disp('Using the same outlier fraction for top and bottom.');
    end
else
    OLFracT = 0.01;
    OLFracB = 0.01;
    disp('Using default outlier fraction of 1%');
end
[h,x] = hist(log(H(:)),1000);
minC = exp(x(find(cumsum(h)./sum(h)<OLFracB,1,'last')));
maxC = exp(x(find(cumsum(h)./sum(h)>1-OLFracT,1,'first')));
end
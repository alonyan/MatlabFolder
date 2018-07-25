function [J, varargout] =InAxes(varargin)
% find indexes of plot points which are inside axes rectangle
% by default works on the current axes, otherwise give an axes handle

if length(varargin) > 1,
    error('just one or no arguments required!');
elseif length(varargin) == 1,
    hAx = varargin{1};
else
    hAx = gca;
end;

h = get(hAx, 'Children');

Xlim = get(hAx, 'XLim');
Ylim = get(hAx, 'YLim');

for i = 1:length(h),
    X = get(h(i), 'XData');
    Y = get(h(i), 'YData');
    j= find( (X > Xlim(1)) & (X < Xlim(2)) & (Y > Ylim(1)) & (Y < Ylim(2)));
    
    if i==1,
        J = j;
    else
        varargout{i-1} = j;
    end;
end;

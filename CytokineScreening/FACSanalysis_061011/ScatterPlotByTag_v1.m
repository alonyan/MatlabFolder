function [h,LRx, LRy] = ScatterPlotByTag_v1(DataStruc, tags,varargin)
%figure('color',[1 1 1])
DataStrucNew = DataStruc;
j1 = find(strcmp(DataStruc(1).ListofChannelsWithLabels, tags{1}));
if isempty(j1),
    error('The first tag was not found!')
elseif (length(j1)>1),
    error('More than one channel corresponding to the first tag found!')
end;

if length(tags)==2,
    j2 = find(strcmp(DataStruc(1).ListofChannelsWithLabels, tags{2}));
    if isempty(j2),
        error('The second tag was not found!')
    elseif (length(j2)>1),
        error('More than one channel corresponding to the second tag found!')
    end
    
elseif length(tags)>2,
    error('There should be no more than two items in the tags cell array!!!');
end;

for DataNo = 1:length(DataStruc);
    if length(tags)==2,
        [h,LRx, LRy] = ScatterPlotFACS_v1(DataStruc(DataNo).data(:, [j1, j2]),[],varargin);
        xlabel(tags{1});
        ylabel(tags{2});
    else
        LRy = Inf;
        [h,LRx] = ScatterPlotFACS_v1(DataStruc(DataNo).data(:, j1),varargin); % histogram plot
        xlabel(tags{1});
    end;
    vold = axis;
    figure(gcf);
%     title([DataStruc(DataNo).name ': zoom into data range and press any key'])
%     pause;
% 
%     v = axis;
%      %J = InAxes;
%      %J = J{1};
%      %length(J)
%     %v = sinh(v);
%     v(1:2) = sinh(v(1:2))*LRx;
%     if length(tags)==2,
%         v(3:4) = sinh(v(3:4))*LRy;
%         J = (DataStruc(DataNo).data(:, j1) > v(1)) & (DataStruc(DataNo).data(:, j1) < v(2))...
%             & (DataStruc(DataNo).data(:, j2) > v(3)) & (DataStruc(DataNo).data(:, j2) < v(4));
%         J = find(J);
%         length(J)
%         ScatterPlotFACS_v1(DataStruc(DataNo).data(J, [j1, j2]), [], 'LinearRangeX', LRx, 'LinearRangeY', LRy);
%         xlabel(tags{1});
%         ylabel(tags{2});
%     else
%         J = (DataStruc(DataNo).data(:, j1) > v(1)) & (DataStruc(DataNo).data(:, j1) < v(2));
%         J = find(J);
%         length(J)
%         ScatterPlotFACS_v1(DataStruc(DataNo).data(J, j1), [], 'LinearRangeX', LRx);
%         xlabel(tags{1});
%         ylabel('Histogram');
%     end;
%     
%     %axis(vold)
%     figure(gcf);
end;

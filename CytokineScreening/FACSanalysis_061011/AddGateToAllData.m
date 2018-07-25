%Pick Gate on selected dataset and apply to all;
%...,'DataToShow',6)% default is 1

function [DataStrucNew ,Gate] = AddGateToAllData(DataStruc, tags,varargin)
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

    j3=find(strcmp(varargin, 'DataToShow'));
    if length(j3)>1,
        error('Too many DataToShow inputs!')
    elseif length(j3)==1,
        DataNo = varargin{j3+1};
    else %default
        DataNo = 1;
    end;

    if length(tags)==2,
        [h,LRx, LRy] = ScatterPlotFACS_v1(DataStruc(DataNo).data(:, [j1, j2]));
        xlabel(tags{1});
        ylabel(tags{2});
    else
        [h,LRx] = ScatterPlotFACS_v1(DataStruc(DataNo).data(:, j1)); % histogram plot
        xlabel(tags{1});
    end;
    %vold = axis;
    figure(gcf);
    title([DataStruc(DataNo).name ': zoom into data range and press any key'])
    pause;

    v = axis;
     %J = InAxes;
     %J = J{1};
     %length(J)
    %v = sinh(v);
    v(1:2) = sinh(v(1:2))*LRx;
    
        GateX = [v(1) v(2) v(2) v(1)];
    Gate = GateX;
    
    if length(tags)==2,
        v(3:4) = sinh(v(3:4))*LRy;
    end;
    for DataNo = 1:length(DataStruc)
        
        if length(tags)==2,
            J = (DataStruc(DataNo).data(:, j1) > v(1)) & (DataStruc(DataNo).data(:, j1) < v(2))...
                & (DataStruc(DataNo).data(:, j2) > v(3)) & (DataStruc(DataNo).data(:, j2) < v(4));
            J = find(J);
            length(J)
            ScatterPlotFACS_v1(DataStruc(DataNo).data(J, [j1, j2]), [], 'LinearRangeX', LRx, 'LinearRangeY', LRy);
            xlabel(tags{1});
            ylabel(tags{2});
                     GateY = [v(3) v(3) v(4) v(4)];
         Gate = [GateX' GateY']
        else
            J = (DataStruc(DataNo).data(:, j1) > v(1)) & (DataStruc(DataNo).data(:, j1) < v(2));
            J = find(J);
            length(J)
            ScatterPlotFACS_v1(DataStruc(DataNo).data(J, j1), [], 'LinearRangeX', LRx);
            xlabel(tags{1});
            ylabel('Histogram');
        end;
            figure(gcf);

    
    %axis(vold)
           DataStrucNew(DataNo).data = DataStruc(DataNo).data(J, :);
    end;

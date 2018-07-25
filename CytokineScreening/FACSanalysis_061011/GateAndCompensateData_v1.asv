function FigHdl = GateAndCompensateData_v1(WorkSp, fpath)

    scnsize = get(0,'ScreenSize');
    FigHdl = figure('Toolbar', 'figure', 'Position',  scnsize + [0 30 0  -97]);
    AxesRect = [0.1    0.1500    0.63    0.8150];
    %guidata(FigHdl,B);
    %warning('off', 'MATLAB:Axes:NegativeDataInLogAxis');
    
    % create Axes context menu
    AxesContextMenu = uicontextmenu;
    CreateGateAxCM = uimenu(AxesContextMenu, 'Label', 'Create Gate', 'Callback', {@CreateGateCallBack});
    ApplyGateToSelectedDataAxCM = uimenu(AxesContextMenu, 'Label', 'Apply Gate To Selected Data', 'Callback', {@ApplyGateToSelectedDataCallBack});
    ApplyGateToSelectedGroupsAxCM = uimenu(AxesContextMenu, 'Label', 'Apply Gate To Selected Groups',  'Callback', {@ApplyGateToSelectedGroupsCallBack});
    
    AxHdl = axes('Parent', FigHdl, 'Position', AxesRect ,'uicontextmenu',AxesContextMenu);
    GroupListHdl = uicontrol('Style', 'listbox', 'String', {WorkSp.Group.name}',  'Units', 'normalized', 'Position', [sum(AxesRect([1 3]))+0.02 0.7 0.1 0.25], 'FontSize', 11, ...
                                                                    'Max', length(WorkSp.Group), 'Min', 0, 'Value', 1,  'Callback', {@GroupListCallback});
     tempRect = get(GroupListHdl, 'Position') ;                                                          
     GroupMenuHdl = uicontrol('Style', 'popupmenu', 'String', {'Plot Colors'; 'Plot Same'; 'Draw Gate'; 'Apply  Gate'}, 'Units', 'normalized',  ...
                                    'Position', [(sum(tempRect([1 3]))+0.02) (sum(tempRect([2 4]))-0.1) 0.1 0.1], 'FontSize', 11 ,  'Callback', {@GroupMenuCallback});
    
     WhoPlotted = []; %globals
     CurrentGateIDN = 0;
    %load data
%     for GroupInd=1:length(WorkSp.Group),
%         sid = WorkSp.Group(GroupInd).SampleID;
%         for i=1:length(sid),
%             tempname = WorkSp.Samples(sid(i)).fname;
%             [fcsdat, fcshdr] = fca_readfcs_v2([fpath tempname]);
%             Group(GroupInd).fcsdat(i).name = tempname;
%             Group(GroupInd).fcsdat(i).ListofChannelsWithLabels = {fcshdr.par.name}';
%             Group(GroupInd).fcsdat(i).data = fcsdat;
%         end;
%     end;
    
      for i=1:length(WorkSp.Samples),
            tempname = WorkSp.Samples(i).fname;
            [fcsdat, fcshdr] = fca_readfcs_v2([fpath tempname]);
            Samples(i).name = tempname;
            Samples(i).ListofChannelsWithLabels = {fcshdr.par.name}';
            Samples(i).data = fcsdat;
            Samples(i).Gates=[];
    end;

    GroupInd = get(GroupListHdl, 'Value');
    sid = WorkSp.Group(GroupInd).SampleID;
   % FileNames = {WorkSp.Samples(sid).fname}';
    ListOfChannels = Samples(sid(1)).ListofChannelsWithLabels;
    DataNameList = CreateDataNameList;
    DataListHdl = uicontrol('Style', 'listbox', 'String', DataNameList,  'Units', 'normalized', 'Position', [sum(AxesRect([1 3]))+0.02 0.1 0.2 0.5], 'FontSize', 11, ...
                                                                    'Max', length(WorkSp.Group), 'Min', 0, 'Value', 1);
    tempRect = get(DataListHdl, 'Position') ;
    DataMenuHdl = uicontrol('Style', 'popupmenu', 'String', {'Plot Colors'; 'Plot Same'; 'Draw Gate'; 'Apply  Gate'}, 'Units', 'normalized',  ...
                                    'Position', [(sum(tempRect([1 3])) - 0.1) (sum(tempRect([2 4])) - 0.05) 0.1 0.1], 'FontSize', 11,  'Callback', {@DataMenuCallback});
    DataInd = get(DataListHdl, 'Value');
%    GateListHdl = uicontrol('Style', 'listbox', 'String', {Samples(sid(DataInd)).Gates.name}',  'Units', 'normalized', 'Position', ... 
%                                        [(sum(tempRect([1 3]))+0.02) tempRect(2:3) tempRect(4)-0.1], 'FontSize', 11, 'Max', length(WorkSp.Group), 'Min', 0, 'Value', 1);
    XLabelHdl = uicontrol('Style', 'popupmenu', 'String', ListOfChannels, 'Units', 'normalized',  ...
                                    'Position', [(AxesRect(1)+AxesRect(3)/2 - 0.05) (AxesRect(2)-0.15) 0.1 0.1], 'FontSize', 11);
    YLabelHdl = uicontrol('Style', 'popupmenu', 'String', [ListOfChannels; 'Histogram'], 'Units', 'normalized',  ...
                                    'Position', [(AxesRect(1)-0.09) (AxesRect(2)+AxesRect(4)/2 - 0.05) 0.06 0.1], 'FontSize', 11);

    
    function GroupListCallback(hObject, eventdata)
        DataNameList = CreateDataNameList;
%         GroupInd = get(GroupListHdl, 'Value');
%         sid = WorkSp.Group(GroupInd).SampleID;
%         FileNames = {WorkSp.Samples(sid).fname}';
        set(DataListHdl, 'Value', 1, 'String', DataNameList)
    end

    function DataMenuCallback(hObject, eventdata)
        GroupInd = get(GroupListHdl, 'Value');
        sid = WorkSp.Group(GroupInd).SampleID;
        DataInd = get(DataListHdl, 'Value');
        DataNameList = get(DataListHdl, 'Value');
      %  GateInd = get(GateListHdl, 'Value');
        ActionNames = get(hObject, 'String');
        Xind = get(XLabelHdl, 'Value');
        Yind = get(YLabelHdl, 'Value');
        switch ActionNames{get(hObject, 'Value')}
            case 'Plot Colors',
                [SampleInd GateInd] = WhomToPlot;
                for i = 1:length(SampleInd),
                    if GateInd(i) == 0,
                        plot(Samples(SampleInd(i)).data(:, Xind), Samples(SampleInd(i)).data(:, Yind), '.');
                    else % apply gates
                        GatedData = Samples(SampleInd(i)).data;
                        for j =  Samples(SampleInd(i)).Gates(GateInd(i)).tree,
                            Xindt = Samples(SampleInd(i)).Gates(j).Xind;
                            Yindt = Samples(SampleInd(i)).Gates(j).Yind;
                            post = Samples(SampleInd(i)).Gates(j).pos;
                            InROIt = inpolygon(GatedData(:, Xindt), GatedData(:, Yindt), post(:, 1), post(:, 2));
                            GatedData = GatedData(InROIt, :);
                        end;
                        plot(GatedData(:, Xind), GatedData(:, Yind), '.');
                    end;
                    hold all;
                end;
                hold off;
                WhoPlotted =  [SampleInd GateInd];
                        
            case 'Draw Gate',
                zoom off;
                % get data from the graph
                hlines = get(AxHdl, 'Children');
                Xdata = [];
                Ydata = [];
                for i=1:length(hlines),
                    if strcmp(get(hlines(i), 'Type'), 'line'),
                        Xdata = [Xdata get(hlines(i), 'XData')];
                        Ydata = [Ydata get(hlines(i), 'YData')];
                    end;
                end;
                hpoly = impoly(AxHdl, []);
                api = iptgetapi(hpoly);
                api.setColor('black');    
                pos = api.getPosition();
                inROI = inpolygon(Xdata, Ydata, pos(:, 1), pos(:, 2));
                plot(Xdata, Ydata, '.');
                hold on;
                plot(Xdata(inROI), Ydata(inROI), 'r.');
                hold off;
                Xstring = get(XLabelHdl, 'String');
                Ystring = get(YLabelHdl, 'String');
                MyData.LastROI.name = [Xstring{Xind} '_' Ystring{Yind}];
                MyData.LastROI.pos = pos;
                MyData.LastROI.Xind = Xind;
                MyData.LastROI.Yind = Yind;           
                guidata(FigHdl, MyData);
                
            case 'Apply  Gate',
                MyData = guidata(FigHdl)
                for i=1:size(WhoPlotted, 1),      
                    tempGate = MyData.LastROI;
                    ParentGate = WhoPlotted(i, 2);
                    GateNo = ParentGate+1;
                    if ParentGate > 0,
                        tempGate.tree = [Samples(WhoPlotted(i, 1)).Gates(ParentGate).tree GateNo];
                    else
                        tempGate.tree =  GateNo;
                    end;
                    tempGate.name = [repmat('  ', 1, length(tempGate.tree)) num2str(GateNo) ') ' tempGate.name]
                    if (length(Samples(WhoPlotted(i, 1)).Gates) > ParentGate), % renumber gates below
                        J = GateNo:length(Samples(WhoPlotted(i, 1)).Gates);
                        Samples(WhoPlotted(i, 1)).Gates(J+1) =  Samples(WhoPlotted(i, 1)).Gates(J);
                        for j = (J+1),
                            Samples(WhoPlotted(i, 1)).Gates(j).tree = Samples(WhoPlotted(i, 1)).Gates(j).tree+1;
                            % modify names
                            s = regexp(Samples(WhoPlotted(i, 1)).Gates(j).name, '\s(\d+)', 'end');
                            tempname = [repmat('  ', 1, length(Samples(WhoPlotted(i, 1)).Gates(j).tree)) num2str(j)];
                            Samples(WhoPlotted(i, 1)).Gates(j).name = [tempname Samples(WhoPlotted(i, 1)).Gates(j).name((s+1):end)];                       
                        end;
                    end;                       
                    if isempty(Samples(WhoPlotted(i, 1)).Gates),
                        Samples(WhoPlotted(i, 1)).Gates = tempGate;
                    else
                        Samples(WhoPlotted(i, 1)).Gates(GateNo) = tempGate;
                    end;
                end;   
                 DataNameList = CreateDataNameList;
                 set(DataListHdl, 'String', DataNameList);
        end; %switch
    end; %DataMenuCallback
    
    function DataNameList = CreateDataNameList;
        GroupInd = get(GroupListHdl, 'Value');
        sid = WorkSp.Group(GroupInd).SampleID;
        DataNameList = {};
        for i=sid,
            DataNameList = [DataNameList; WorkSp.Samples(i).fname];
            if ~isempty(Samples(i).Gates),
                DataNameList= [DataNameList;{Samples(i).Gates.name}'];
            end;
%             for j=1:length(Samples(i).Group),
%                 tempname = 
%             end;
        end;
    end;
    
    function [SampleInd GateInd] = WhomToPlot
        SampleInd = [];
        GateInd = [];
        DataInd = get(DataListHdl, 'Value');
        DataNameList = get(DataListHdl, 'String');
        for i = DataInd,
            s = regexp(DataNameList{i},  '\s(\d+)', 'tokens');
            if ~isempty(s),
                GateNo = str2num(s{1}{1});
            else
                GateNo = 0;
            end;
            i = i - GateNo;
            SampleNo = find(strcmp({Samples.name}', DataNameList{i}));
            SampleInd = [SampleInd; SampleNo];
            GateInd = [GateInd; GateNo];
        end;
    end;
    
    function CreateGateCallBack(hObject, eventdata)
         zoom off;
        Xind = get(XLabelHdl, 'Value');
        Yind = get(YLabelHdl, 'Value');

        % get data from the graph
%         hlines = get(AxHdl, 'Children');
%         Xdata = [];
%         Ydata = [];
%         for i=1:length(hlines),
%             if strcmp(get(hlines(i), 'Type'), 'line'),
%                 Xdata = [Xdata get(hlines(i), 'XData')];
%                 Ydata = [Ydata get(hlines(i), 'YData')];
%             end;
%         end;
        hpoly = impoly(AxHdl, []);
        api = iptgetapi(hpoly);
        api.setColor('black');    
        pos = api.getPosition();
        inROI = inpolygon(Xdata, Ydata, pos(:, 1), pos(:, 2));
%         plot(Xdata, Ydata, '.');
%         hold on;
%         plot(Xdata(inROI), Ydata(inROI), 'r.');
%         hold off;
%         Xstring = get(XLabelHdl, 'String');
%         Ystring = get(YLabelHdl, 'String');
        CurrentGateIDN = CurrentGateIDN + 1;
        MyData.LastROI.IDN = CurrentGateIDN;
        MyData.LastROI.name = [Xstring{Xind} '_' Ystring{Yind}];
        MyData.LastROI.pos = pos;
        MyData.LastROI.Xind = Xind;
        MyData.LastROI.Yind = Yind;    
        
        %start apply gate
                for i=1:size(WhoPlotted, 1),      
                    tempGate = MyData.LastROI;
                    ParentGate = WhoPlotted(i, 2);
                    GateNo = ParentGate+1;
                    if ParentGate > 0,
                        tempGate.tree = [Samples(WhoPlotted(i, 1)).Gates(ParentGate).tree GateNo];
                    else
                        tempGate.tree =  GateNo;
                    end;
                    tempGate.name = [repmat('  ', 1, length(tempGate.tree)) num2str(GateNo) ') ' tempGate.name]
                    if (length(Samples(WhoPlotted(i, 1)).Gates) > ParentGate), % renumber gates below
                        J = GateNo:length(Samples(WhoPlotted(i, 1)).Gates);
                        Samples(WhoPlotted(i, 1)).Gates(J+1) =  Samples(WhoPlotted(i, 1)).Gates(J);
                        for j = (J+1),
                            Samples(WhoPlotted(i, 1)).Gates(j).tree = Samples(WhoPlotted(i, 1)).Gates(j).tree+1;
                            % modify names
                            s = regexp(Samples(WhoPlotted(i, 1)).Gates(j).name, '\s(\d+)', 'end');
                            tempname = [repmat('   ', 1, length(Samples(WhoPlotted(i, 1)).Gates(j).tree)) num2str(j)];
                            Samples(WhoPlotted(i, 1)).Gates(j).name = [tempname Samples(WhoPlotted(i, 1)).Gates(j).name((s+1):end)];                       
                        end;
                    end;                       
                    if isempty(Samples(WhoPlotted(i, 1)).Gates),
                        Samples(WhoPlotted(i, 1)).Gates = tempGate;
                    else
                        Samples(WhoPlotted(i, 1)).Gates(GateNo) = tempGate;
                    end;
                end;   
                 DataNameList = CreateDataNameList;
                 set(DataListHdl, 'String', DataNameList); %apply gate
        
        guidata(FigHdl, MyData);
    end;
    function  ApplyGateToSelectedDataCallBack(hObject, eventdata)
    end;
    function ApplyGateToSelectedGroupsCallBack(hObject, eventdata)
    end;

end
                            
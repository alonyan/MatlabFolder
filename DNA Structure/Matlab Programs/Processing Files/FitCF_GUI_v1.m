function FigHdl = FitCF_GUI_v1(B, minVt, dynRange, showRange, lowestG, calc_range)
beta = [];
pGauss= [];

FigHdl = figure('Toolbar', 'figure');
%guidata(FigHdl,B);

%warning('off', 'MATLAB:Axes:NegativeDataInLogAxis');

AxHdl = axes('Parent', FigHdl, 'Position',[0.08    0.1100    0.7    0.8150]);
%ContinuePBHdl = uicontrol('Parent', FigHdl, 'Style','pushbutton','String', 'Proceed',  'Position', [500 50 60 40]);
ProceedPBHdl = uicontrol('Parent', FigHdl, 'Style','pushbutton','String', 'Proceed', 'Units', 'normalized', 'Position', [0.87 0.1 0.1 0.1], 'Callback', {@ProceedPBHcallback});
ChooseDynRangeST1Hdl = uicontrol('Parent', FigHdl, 'Style','text','String', 'Choose Dynamic Range by:', 'Units', 'normalized', 'Position', [0.79 0.9 0.19 0.1]);
%NonlinearityRDHdl = uicontrol('Parent', FigHdl, 'Style','radiobutton','String', 'Nonlinearity', 'Units', 'normalized', 'Position', [0.79 0.85 0.14 0.05]);
%MaxSlopeChangeETHdl = uicontrol('Parent', FigHdl, 'Style','edit','String', '0.1', 'Units', 'normalized', 'Position', [0.93 0.85 0.05 0.05]);
ManuallyRDHdl = uicontrol('Parent', FigHdl, 'Style','radiobutton','String', 'Manually', 'Units', 'normalized', 'Position', [0.79 0.8 0.14 0.05]);
DynRangeETHdl = uicontrol('Parent', FigHdl, 'Style','edit','String', num2str(dynRange), 'Units', 'normalized', 'Position', [0.93 0.8 0.05 0.05], 'Callback', {@DynRangeETHcallback});
ShowRangeSTHdl = uicontrol('Parent', FigHdl, 'Style','text','String', 'Show Range', 'Units', 'normalized', 'Position', [0.79 0.6 0.14 0.05]);
ShowRangeETHdl = uicontrol('Parent', FigHdl, 'Style','edit','String', num2str(showRange), 'Units', 'normalized', 'Position', [0.93 0.6 0.05 0.05], 'Callback', {@ShowRangeETHcallback});
SkipDisplSTHdl = uicontrol('Parent', FigHdl, 'Style','radiobutton','String', 'Skip vt_um < ', 'Units', 'normalized', 'Position', [0.79 0.7 0.15 0.05]);
MinVtETHdl = uicontrol('Parent', FigHdl, 'Style','edit','String', num2str(minVt), 'Units', 'normalized', 'Position', [0.93 0.7 0.05 0.05], 'Callback', {@MinVtETHcallback});
%StopPBHdl = uicontrol('Parent', FigHdl, 'Style','pushbutton','String', 'Stop', 'Units', 'normalized', 'Position', [0.35 0.93 0.1 0.05], 'Callback', {@StopPBHcallback});

j=find((B.lag>calc_range(1))&(B.lag < calc_range(2)));
length(j)
i = j(1);
FittingRoutine;

    function FittingRoutine
        j3= find(B.vt_um(i, :) > minVt); 
        j2 = find((B.ReNormalized(i, :) < (B.ReNormalized(i, j3(1))/dynRange)) | (B.ReNormalized(i, :) < lowestG));
        if isempty(j2);
            j2 = j3;
        else
            j2 = intersect(1:(j2(1) -1), j3);
        end;
     
        j4 = find((B.ReNormalized(i, :) < (B.ReNormalized(i, j3(1))/(showRange))) | (B.ReNormalized(i, :) < lowestG));
        if isempty(j4);
            j4 = j3;
        else
            j4 = intersect(1:(j4(1) -1), j3);
        end;
        
 %       semilogyErBar(B.vt_um(i, j2).^2, B.ReNormalized(i, j2), B.errorReNormalized(i, j2),  'o') ;
  %      v= axis;
    
        j1 = j2;
        pGauss(i, :) = polyfit(B.vt_um(i, j1).^2, log(B.ReNormalized(i, j1)), 1);
        [BETA, delta, resid] =nlinfitWeight1(B.vt_um(i, j1), B.ReNormalized(i, j1), @gaussian, [exp(pGauss(i, 2)) (-pGauss(i,1)).^(-1/2)], B.errorReNormalized(i, j1)');
        beta(i, :) = BETA';
    
        semilogyErBar(B.vt_um(i, j4).^2, B.ReNormalized(i, j4), B.errorReNormalized(i, j4),  'co') ;
        hold on;
        semilogy( B.vt_um(i, j2).^2, B.ReNormalized(i, j2), 'o', B.vt_um(i, j4).^2, exp(polyval(pGauss(i, :), B.vt_um(i, j4).^2)),  B.vt_um(i, j4).^2, gaussian(BETA, B.vt_um(i, j4))) ;     
        hold off;
        axis tight;
        title(AxHdl, num2str(i));
    end;


    function ProceedPBHcallback(hObject, eventdata)
        if i < j(length(j)),
            i= i+1;
            FittingRoutine;
            B.pGauss = pGauss(j(1):i, :);
            B.betaGauss = beta(j(1):i, :);
            B.lagHsq = B.lag(j(1):i);
            guidata(FigHdl,B);
        else
            msgbox('That is it! Call the data!');
        end;
    end;

    function MinVtETHcallback(hObject, eventdata)
        user_entry = str2double(get(hObject,'string'));
        if isnan(user_entry)
                errordlg('You must enter a numeric value','Bad Input','modal')
        else
            minVt = user_entry;
            FittingRoutine;
        end
    end;

    function DynRangeETHcallback(hObject, eventdata)
        user_entry = str2double(get(hObject,'string'));
        if isnan(user_entry)
                errordlg('You must enter a numeric value','Bad Input','modal')
        else
            dynRange = user_entry;
            FittingRoutine;
        end
    end;
    
        function ShowRangeETHcallback(hObject, eventdata)
        user_entry = str2double(get(hObject,'string'));
        if isnan(user_entry)
                errordlg('You must enter a numeric value','Bad Input','modal')
        else
            showRange = user_entry;
            FittingRoutine;
        end
    end;
    
end
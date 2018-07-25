function FigHdl = FitCF_GUI_v2(B, minVt, dynRange, showRange, lowestG, calc_range)
beta = [];
pGauss= [];
hSq_UniformSum = [];
hSq_UniformField=[];
A_UniformSum =[];
A_UniformField=[];

FigHdl = figure('Toolbar', 'figure');
%guidata(FigHdl,B);

%warning('off', 'MATLAB:Axes:NegativeDataInLogAxis');

AxHdl = axes('Parent', FigHdl, 'Position',[0.08    0.1100    0.7    0.8150]);
%ContinuePBHdl = uicontrol('Parent', FigHdl, 'Style','pushbutton','String', 'Proceed',  'Position', [500 50 60 40]);
ProceedPBHdl = uicontrol('Parent', FigHdl, 'Style','pushbutton','String', 'Proceed', 'Units', 'normalized', 'Position', [0.87 0.3 0.1 0.1], 'Callback', {@ProceedPBHcallback});
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
CalculateMSDPBHdl = uicontrol('Parent', FigHdl, 'Style','pushbutton','String', 'Calculate MSD', 'Units', 'normalized', 'Position', [0.87 0.1 0.1 0.1], 'Callback', {@CalculateMSD_PBHcallback});

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
        
        BETA = nlinfitWeight1(B.vt_um(i, j4), B.ReNormalized(i, j4), @FitCFwithMultipleGaussians, [1 ((BETA(2)/B.field(1).paramGauss(2)).^2-1) *3/2], B.errorReNormalized(i, j4)', B.field(1).paramUniformSum);
        hSq_UniformSum(i, :)  = BETA(2);
        A_UniformSum(i, :) = BETA(1);
        
        BETA = nlinfitWeight1(B.vt_um(i, j4), B.ReNormalized(i, j4), @FitCFwithMultipleGaussians, [1 BETA(2)], B.errorReNormalized(i, j4)', B.field(1).paramUniformField);
        hSq_UniformField(i, :)  = BETA(2);
        A_UniformField(i, :) = BETA(1);

        semilogyErBar(B.vt_um(i, j4).^2, B.ReNormalized(i, j4), B.errorReNormalized(i, j4),  'co') ;
        hold on;
        semilogy( B.vt_um(i, j2).^2, B.ReNormalized(i, j2), 'o', B.vt_um(i, j4).^2, exp(polyval(pGauss(i, :), B.vt_um(i, j4).^2)),  B.vt_um(i, j4).^2, gaussian(beta(i, :), B.vt_um(i, j4))) ;     
        semilogy(B.vt_um(i, j4).^2, FitCFwithMultipleGaussians([A_UniformSum(i, :), hSq_UniformSum(i, :)], B.vt_um(i, j4), B.field(1).paramUniformSum), '-. b');
        semilogy(B.vt_um(i, j4).^2, FitCFwithMultipleGaussians([A_UniformField(i, :), hSq_UniformField(i, :)], B.vt_um(i, j4), B.field(1).paramUniformField), '--k');

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
            B.Rsq_UniformSum = hSq_UniformSum(j(1):i, :);
            B.Rsq_UniformField=hSq_UniformField(j(1):i, :);
            B.A_UniformSum =A_UniformSum(j(1):i, :);
            B.A_UniformField=A_UniformField(j(1):i, :);
            guidata(FigHdl,B);
        else
            msgbox('That is it! Call the data!');
        end;
    end;

       function CalculateMSD_PBHcallback(hObject, eventdata)
        B = guidata(FigHdl);
        field = B.field;
        
        B.hSq_intercept = interp1(B.model.G, B.model.hSq, B.betaGauss(:, 1));
        for i = 1: length(field),
            hSq_weighted(:, i) = ((B.betaGauss(:, 2)/B.field(i).paramGauss(2)).^2-1) *3/2;
            Rsq_weighted(:, i) = hSq_weighted(:, i) *B.field(i).paramGauss(2).^2;
            Rsq_intercept(:, i) = B.hSq_intercept *B.field(i).paramGauss(2).^2;
            Rsq_slow(:, i) = B.hSq_slow *B.field(i).paramGauss(2).^2;
        end;
      

        B.hSq_weighted = hSq_weighted;
        B.Rsq_weighted = Rsq_weighted;
        B.Rsq_intercept = Rsq_intercept;
        B.Rsq_slow = Rsq_slow;
  
         loglog(B.lag,  B.Rsq_slow, B.lagHsq, B.Rsq_intercept, B.lagHsq, B.Rsq_weighted, 'o', B.lagHsq, 0.05*B.lagHsq.^(0.5), B.lagHsq, 0.2*B.lagHsq.^(2/3), B.lagHsq, B.Rsq_UniformSum, '*b', B.lagHsq, B.Rsq_UniformField, '*g');
        legend('hsq slow', 'Rsq intercept', 'hSq weighted 1', 'hSq weighted2' , 'hSq weighted 3', 'power 0.5', 'power 2/3', 'Location',  'NorthWest')
        axis tight;
        axs = axis;
        axs(1) = 1e-2; axs(3) =1e-1*0.2^2;
        axis(axs)

        guidata(FigHdl, B);
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
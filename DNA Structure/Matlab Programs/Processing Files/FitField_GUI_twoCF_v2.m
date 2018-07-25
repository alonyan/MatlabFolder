function FigHdl = FitField_GUI_twoCF_v2(B, minVt, dynRange, showRange, lowestG, wSq, NormRange)
% added static and slow  measurements in parallel
beta = [];
pGauss= [];

FigHdl = figure('Toolbar', 'figure', 'Units', 'normalized', 'position', [0    0.0391    1.0000    0.8737]);
guidata(FigHdl,B);

%warning('off', 'MATLAB:Axes:NegativeDataInLogAxis');
TotalSpeeds = size(B.Normalized, 2);
Panel1Rect = [0.785 0.5 0.215 0.05];
ShowCBRect = [0.01 0.1 0.05 0.8];
SlowETRect = [0.07 0.1 0.1 0.8];
FastETRect = [0.19 0.1 0.1 0.8];
FitCBRect = [0.30 0.1 0.05 0.8];
WxyETRect = [0.36 0.1 0.15 0.8];
PlotSlowCBRect = [0.52 0.1 0.05 0.8];
ZcorrCBRect = [0.58 0.1 0.05 0.8];
NormRangeETRect= [0.65 0.1 0.1 0.8];
NoSTRect = [0.01 0.1 0.1 0.8];

AxHdl = axes('Parent', FigHdl, 'Position',[0.08    0.1100    0.7    0.8150]);

TitlesSTHdl = uicontrol('Parent', FigHdl, 'Style','text','String', 'Plot Slow Fast Fit wXY PS  Zcor NR(us)', 'Units', 'normalized', 'Position', Panel1Rect+ [0 0.05 0 0], 'HorizontalAlignment', 'left');

Panel1Hdl = uipanel(FigHdl, 'Units', 'normalized', 'Position', Panel1Rect);
ShowCB1Hdl = uicontrol('Parent', Panel1Hdl, 'Style','checkbox', 'Value', 1, 'Units', 'normalized', 'Position', ShowCBRect);
SlowET1Hdl = uicontrol('Parent', Panel1Hdl, 'Style','edit','String', '1', 'Units', 'normalized', 'Position', SlowETRect);
FastET1Hdl = uicontrol('Parent', Panel1Hdl, 'Style','edit','String', num2str(TotalSpeeds), 'Units', 'normalized', 'Position', FastETRect);
FitCB1Hdl = uicontrol('Parent', Panel1Hdl, 'Style','checkbox', 'Value', 1, 'Units', 'normalized', 'Position', FitCBRect);
WxyET1Hdl = uicontrol('Parent', Panel1Hdl, 'Style','text','String', '__', 'Units', 'normalized', 'Position', WxyETRect);
PlotSlowCB1Hdl = uicontrol('Parent', Panel1Hdl, 'Style','checkbox', 'Value', 1, 'Units', 'normalized', 'Position', PlotSlowCBRect);
ZcorrCB1Hdl = uicontrol('Parent', Panel1Hdl, 'Style','checkbox', 'Value', 1, 'Units', 'normalized', 'Position', ZcorrCBRect);
NormRangeET1Hdl = uicontrol('Parent', Panel1Hdl, 'Style','edit','String', num2str(NormRange), 'Units', 'normalized', 'Position', NormRangeETRect);


Panel4Hdl = uipanel(FigHdl, 'Units', 'normalized', 'Position', Panel1Rect + [0  -0.2  0 0] );
NoST4Hdl = uicontrol('Parent', Panel4Hdl, 'Style','text', 'String', '1)', 'Units', 'normalized', 'Position', NoSTRect);
Fit1CB4Hdl = uicontrol('Parent', Panel4Hdl, 'Style','checkbox', 'Value', 0, 'Units', 'normalized', 'Position', ShowCBRect+ [0.1 0 0 0]);
W1_ST4Hdl = uicontrol('Parent', Panel4Hdl, 'Style','text','String', '__', 'Units', 'normalized', 'Position', WxyETRect - [0.2 0 0 0]);
S1_ST4Hdl = uicontrol('Parent', Panel4Hdl, 'Style','text','String', '__', 'Units', 'normalized', 'Position', WxyETRect - [0.05 0 0 0]);
Fit2CB4Hdl = uicontrol('Parent', Panel4Hdl, 'Style','checkbox', 'Value', 0, 'Units', 'normalized', 'Position', ShowCBRect+ [0.5 0 0 0]);
W2_ST4Hdl = uicontrol('Parent', Panel4Hdl, 'Style','text','String', '__', 'Units', 'normalized', 'Position', WxyETRect + [0.2 0 0 0]);
S2_ST4Hdl = uicontrol('Parent', Panel4Hdl, 'Style','text','String', '__', 'Units', 'normalized', 'Position', WxyETRect + [0.35 0 0 0]);
%FitCB4Hdl = uicontrol('Parent', Panel4Hdl, 'Style','checkbox', 'Value', 0, 'Units', 'normalized', 'Position', FitCBRect);
%WxyET4Hdl = uicontrol('Parent', Panel4Hdl, 'Style','text','String', '__', 'Units', 'normalized', 'Position', WxyETRect);
%PlotSlowCB4Hdl = uicontrol('Parent', Panel4Hdl, 'Style','checkbox', 'Value', 0, 'Units', 'normalized', 'Position', PlotSlowCBRect);
%ZcorrCB4Hdl = uicontrol('Parent', Panel4Hdl, 'Style','checkbox', 'Value', 0, 'Units', 'normalized', 'Position', ZcorrCBRect);
%NormRangeET4Hdl = uicontrol('Parent', Panel4Hdl, 'Style','edit','String', num2str(NormRange), 'Units', 'normalized', 'Position', NormRangeETRect);

%ContinuePBHdl = uicontrol('Parent', FigHdl, 'Style','pushbutton','String', 'Proceed',  'Position', [500 50 60 40]);
ProceedPBHdl = uicontrol('Parent', FigHdl, 'Style','pushbutton','String', 'Proceed', 'Units', 'normalized', 'Position', [0.87 0.05 0.1 0.1], 'Callback', {@ProceedPBHcallback});
ChooseDynRangeST1Hdl = uicontrol('Parent', FigHdl, 'Style','text','String', 'Choose Dynamic Range by:', 'Units', 'normalized', 'Position', [0.79 0.9 0.19 0.1]);
%NonlinearityRDHdl = uicontrol('Parent', FigHdl, 'Style','radiobutton','String', 'Nonlinearity', 'Units', 'normalized', 'Position', [0.79 0.85 0.14 0.05]);
%MaxSlopeChangeETHdl = uicontrol('Parent', FigHdl, 'Style','edit','String', '0.1', 'Units', 'normalized', 'Position', [0.93 0.85 0.05 0.05]);
ManuallyRDHdl = uicontrol('Parent', FigHdl, 'Style','radiobutton','String', 'Manually', 'Units', 'normalized', 'Position', [0.79 0.8 0.14 0.04]);
DynRangeETHdl = uicontrol('Parent', FigHdl, 'Style','edit','String', num2str(dynRange), 'Units', 'normalized', 'Position', [0.93 0.8 0.05 0.04], 'Callback', {@DynRangeETHcallback});
SkipDisplSTHdl = uicontrol('Parent', FigHdl, 'Style','radiobutton','String', 'Skip vt_um < ', 'Units', 'normalized', 'Position', [0.79 0.75 0.15 0.04]);
MinVtETHdl = uicontrol('Parent', FigHdl, 'Style','edit','String', num2str(minVt), 'Units', 'normalized', 'Position', [0.93 0.75 0.05 0.04], 'Callback', {@MinVtETHcallback});
ShowRangeSTHdl = uicontrol('Parent', FigHdl, 'Style','text','String', 'Show Range', 'Units', 'normalized', 'Position', [0.79 0.7 0.14 0.04]);
ShowRangeETHdl = uicontrol('Parent', FigHdl, 'Style','edit','String', num2str(showRange), 'Units', 'normalized', 'Position', [0.93 0.7 0.05 0.04], 'Callback', {@ShowRangeETHcallback});
%CalculateMSDPBHdl = uicontrol('Parent', FigHdl, 'Style','pushbutton','String', 'Calculate MSD', 'Units', 'normalized', 'Position', [0.87 0.0 0.1 0.1], 'Callback', {@CalculateMSD_PBHcallback});

%StopPBHdl = uicontrol('Parent', FigHdl, 'Style','pushbutton','String', 'Stop', 'Units', 'normalized', 'Position', [0.35 0.93 0.1 0.05], 'Callback', {@StopPBHcallback});


    function fieldAr = PlotFitRoutine
        function field = CalculateField(slow, fast, plotTag, fitTags, paramHandles, colorStr, plotSlowTag, ZcorrTag, NR)
            NR = NR*1e-3;
            j1 = find((B.lag > NR(1)) & (B.lag < NR(2)));
            Gfast = B.Normalized(:, fast)/robmean(B.Normalized(j1, fast), B.errorNormalized(j1, fast));
            Gslow = B.Normalized(:, slow)/robmean(B.Normalized(j1, slow), B.errorNormalized(j1, slow));
            NofMultipleGauss = 9;
            
            fitTag = fitTags(1);
            fit1Tag = fitTags(2);
            fit2Tag = fitTags(3);
            WxyETHdl = paramHandles(1);
            W1_STHdl = paramHandles(2);
            S1_STHdl = paramHandles(3);
            W2_STHdl = paramHandles(4);
            S2_STHdl = paramHandles(5);
                     
           field.fast = fast;
           field.slow = slow;
           field.r = B.vt_um(:, fast);
           field.G = (Gfast./Gslow).^(1./Gslow);
           field.NormRange = NR;
           
           if ZcorrTag,
               field.G = field.G.^(1./sqrt(1+ (1./Gslow - 1)/wSq ));
           end;
           field.errorG =B.errorNormalized(:, fast);
           
           j3= find(field.r > minVt); 
           j2 = find((field.G < 1/dynRange) | (field.G < lowestG));
           j2 = intersect(j2, j3);
            if isempty(j2);
                field.J_fit = j3;
            else
                field.J_fit = intersect(1:(j2(1) -1), j3);
            end;
            
           j4 = find((field.G < 1/showRange) | (field.G < lowestG));
           j4 = intersect(j4, j3);
            if isempty(j4);
                field.J_show = setdiff(j3, field.J_fit);
            else
                field.J_show = setdiff(intersect(1:(j4(1) -1), j3), field.J_fit);
            end;
            
            BETA =nlinfitWeight1(field.r(field.J_fit), field.G(field.J_fit), @gaussian, [1 0.2], field.errorG(field.J_fit));
            field.paramGauss = BETA;
            set(WxyETHdl, 'String', num2str(field.paramGauss(2)));
            
            if fit1Tag,
                BETA = nlinfitWeight1([field.J_fit field.J_show], field.G([field.J_fit field.J_show]) , @FitFieldWithMultipleGaussians,  [0.3 0.05], field.errorG([field.J_fit field.J_show]), {'UniformSum' NofMultipleGauss B slow fast wSq});
                field.paramUniformSum.beta = BETA;
                field.paramUniformSum.w = BETA(1) + (-NofMultipleGauss:NofMultipleGauss)/NofMultipleGauss*3*BETA(2);
                field.paramUniformSum.b = ones(1, 2*NofMultipleGauss+1)/(2*NofMultipleGauss+1);
                set(W1_STHdl, 'String', num2str(field.paramUniformSum.beta(1)));
                set(S1_STHdl, 'String', num2str(field.paramUniformSum.beta(2)));
            end;
            
           if fit2Tag,
                BETA = nlinfitWeight1([field.J_fit field.J_show], field.G([field.J_fit field.J_show]) , @FitFieldWithMultipleGaussians,  [0.3 0.05], field.errorG([field.J_fit field.J_show]), {'UniformField' NofMultipleGauss B slow fast wSq});
                field.paramUniformField.beta = BETA;
                field.paramUniformField.w = BETA(1) + (-NofMultipleGauss:NofMultipleGauss)/NofMultipleGauss*3*BETA(2);
                field.paramUniformField.b = 1./field.paramUniformField.w.^2/sum( 1./field.paramUniformField.w.^2);
                set(W2_STHdl, 'String', num2str(field.paramUniformField.beta(1)));
                set(S2_STHdl, 'String', num2str(field.paramUniformField.beta(2)));
           end;

            
            if plotTag
                semilogy(field.r(field.J_fit).^2, field.G(field.J_fit), ['o' colorStr], field.r(field.J_show).^2, field.G(field.J_show), ['*' colorStr] );
            end;
            
            if fitTag,
                semilogy(field.r([field.J_fit field.J_show]).^2, gaussian(field.paramGauss, field.r([field.J_fit field.J_show])), ['-' colorStr]);
            end;
            
            if plotSlowTag,
                semilogy(field.r([field.J_fit field.J_show]).^2, B.Normalized([field.J_fit field.J_show], slow), ['--' colorStr]);
            end;
            
            if fit1Tag,
                semilogy(field.r([field.J_fit field.J_show]).^2, FitFieldWithMultipleGaussians(field.paramUniformSum.beta, [field.J_fit field.J_show], {'UniformSum' NofMultipleGauss B slow fast wSq}), ['-.' colorStr]);
            end;

            if fit2Tag,
                semilogy(field.r([field.J_fit field.J_show]).^2, FitFieldWithMultipleGaussians(field.paramUniformField.beta, [field.J_fit field.J_show], {'UniformField' NofMultipleGauss B slow fast wSq}), ['-' colorStr]);
            end;

            
            set(AxHdl, 'XScale', 'linear', 'YScale', 'log'); 
            axis tight;
            
            %semilogy(field.r.^2, field.G, field.r.^2, Gaussian(BETA, field.r)) ;
        end; % CalculateField
       
        cla(AxHdl);
        hold on;
        
        fitTags = [get(FitCB1Hdl, 'Value') get(Fit1CB4Hdl, 'Value') get(Fit2CB4Hdl, 'Value')];
        paramHandles = [WxyET1Hdl W1_ST4Hdl S1_ST4Hdl W2_ST4Hdl S2_ST4Hdl];
        fieldAr = CalculateField(str2num(get(SlowET1Hdl, 'String')), str2num(get(FastET1Hdl, 'String')), get(ShowCB1Hdl, 'Value'), fitTags, paramHandles, 'b', get(PlotSlowCB1Hdl, 'Value'), get(ZcorrCB1Hdl, 'Value'), str2num(get(NormRangeET1Hdl, 'String')));

         hold off;
        axis tight;  
    end; %PlotFitRoutine


    function ProceedPBHcallback(hObject, eventdata)
        B.field = PlotFitRoutine;
        guidata(FigHdl,B);
    end;

%     function CalculateMSD_PBHcallback(hObject, eventdata)
%         B = guidata(FigHdl);
%         field = B.field;
%         for i = 1: length(field),
%             hSq_weighted(:, i) = ((B.betaGauss(:, 2)/B.field(i).paramGauss(2)).^2-1) *3/2;
%             Rsq_weighted(:, i) = hSq_weighted(:, i) *B.field(i).paramGauss(2).^2;
%             Rsq_intercept(:, i) = B.hSq_intercept *B.field(i).paramGauss(2).^2;
%             Rsq_slow(:, i) = B.hSq_slow *B.field(i).paramGauss(2).^2;
%         end;
%          loglog(B.lag,  B.hSq_slow, B.lagHsq, B.hSq_intercept, B.lagHsq, hSq_weighted, 'o', B.lagHsq, 1.5*B.lagHsq.^(0.52), B.lagHsq, 2*B.lagHsq.^(2/3));
%         legend('hsq slow', 'hSq intercept', 'hSq weighted 1', 'hSq weighted2' , 'hSq weighted 3', 'power', 'power', 'Location',  'NorthWest')
%         axis tight;
%         axs = axis;
%         axs(1) = 1e-2; axs(3) =1e-1;
%         axis(axs)
% 
%         B.hSq_weighted = hSq_weighted;
%         B.Rsq_wieghted = Rsq_weighted;
%         B.Rsq_intercept = Rsq_intercept;
%         B.Rsq_slow = Rsq_slow;
%         guidata(FigHdl, B);
%     end;
%     
    function MinVtETHcallback(hObject, eventdata)
        user_entry = str2double(get(hObject,'string'));
        if isnan(user_entry)
                errordlg('You must enter a numeric value','Bad Input','modal')
        else
            minVt = user_entry;
 %           FittingRoutine;
        end
    end;

    function DynRangeETHcallback(hObject, eventdata)
        user_entry = str2double(get(hObject,'string'));
        if isnan(user_entry)
                errordlg('You must enter a numeric value','Bad Input','modal')
        else
            dynRange = user_entry;
%            FittingRoutine;
        end
    end;
    
   function ShowRangeETHcallback(hObject, eventdata)
        user_entry = str2double(get(hObject,'string'));
        if isnan(user_entry)
                errordlg('You must enter a numeric value','Bad Input','modal')
        else
            showRange = user_entry;
        end
    end;

    
end
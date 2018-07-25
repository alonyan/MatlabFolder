clear
clc
close all
filepath = G:\TTTTa\131009\;
dataname = 'L6o25';

 fields_to_removeGood = {
           'corrfunc' 
           'AfterPulseCalculated'
           'trace'
           'CR'
           'CF_CR'
           'dIdI'
           'corrfuncgood'
           'tracegood'
           'CF_CRgood'
           'dIdIgood'
           'AveragedIdI'
           'AverageAlldIdI'
           'errordIdI'
           'errorAlldIdI'
           'WeightAverageCF'
           'WeightAverageAllCF'
           'errorWA_CF'
           'errorAllWA_CF'
           'score'
           'AfterPulse'
           'Xcoord'
           'Ycoord'
           'Zcoord'
           'v_um_s'
           't_v'
           };
       
  fields_to_removeBad = {
            'corrfuncbad'
           'tracebad'
           'CF_CRbad'
           'dIdIbad'
      };
  
warning('off', 'MATLAB:Axes:NegativeDataInLogAxis')
%% Get files
cd('C:\Oleg\Yariv\030908')
slow=uigetfile('*.*')
fast=uigetfile('*.*')

%% Static and dynamic Rh6G measurements to evaluate field size
cd('F:\Oleg\Matlab Programs\Processing Files')
StaticName ={ slow} % define static rh file name
St = LoadMultipleCorrFunc_v2(filepath, StaticName, 'Rejection', 1.5, 'NormalizationRange', [1e-3 2e-3],  'DeleteList', []);
FitParam = PlotFitCF(St, [0.002 1000], @Diffusion3D, [20000 0.05 30]);
wSq = FitParam.beta(3, 1);
tau = FitParam.beta(2, 1);

%%
DynamicName = {fast}%dynamic
Dyn = LoadMultipleCorrFunc_v2(filepath, DynamicName , 'Rejection', 2, 'NormalizationRange', [1e-3 2e-3],  'DeleteList', []);


%%
if isfield(St,  'corrfuncbad')
        Dyn = rmfield(Dyn, [fields_to_removeGood; fields_to_removeBad]);
else 
        Dyn = rmfield(Dyn, fields_to_removeGood);
end;


%% Find range for baseline subtraction
semilogx(Dyn.lag, Dyn. Normalized);
axis([1e-3 10000 -0.1 0.1])
figure(gcf)
title('find range for baseline subtraction');
pause;
Dyn.rangeBL = InAxes;
Dyn.Normalized = (Dyn.Normalized - mean(Dyn.Normalized(InAxes)))/(1 - mean(Dyn.Normalized(InAxes)));
semilogx(Dyn.lag, Dyn. Normalized);


%% make field and fit it
minVt = 0.05; % um
dynRange  = 5;
lowestG = 1e-2;
showRange =20;
NormRange = [1 3]*1e-3;
B.lag = St.lag;
B.vt_um = [St.vt_um Dyn.vt_um];
B.Normalized = [St.Normalized Dyn.Normalized];
B.errorNormalized = [St.errorNormalized Dyn.errorNormalized];

FigHdl = FitField_GUI_twoCF(B, minVt, dynRange, showRange, lowestG, wSq, NormRange*1e3)
%% Extract field 
B = guidata(FigHdl);
close(FigHdl);
wXY = B.field.paramGauss(2)
eval([dataname '.B = B;']);

tau = FitParam.beta(2, 1)
D = wXY^2/(4*tau) %um^2/ms
AA=[wXY, tau, D]
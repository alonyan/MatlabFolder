%% Loading  Data
filepath = 'D:\People\Manish\Experiments\140610\';
filenames = { 'L18KSALT100mM_Sgl_St'};
Rejection =100;
NormRange = [1e-3 2e-3];
S = LoadMultipleCorrFunc_v3(filepath, filenames, 'Rejection', Rejection, 'NormalizationRange', NormRange,  'DeleteList', []);
%% Cluster analysis
Nclust = round(size(S.corrfunc, 2)/2);
LinkageType ='single'% 'single', 'average', 'weighted'
Range = [0.1 1000]; % range of decay of the correlation function
[T, j, DeleteList] = ClusterizeCF_CR_v1(S, 'No of Clusters', Nclust, 'Normalization range', [1e-3 5e-3], 'Distance range', Range, 'Linkage', LinkageType);

%% Reload if needed
Rejection =10;
 S = LoadMultipleCorrFunc_v2(filepath, filenames, 'Rejection', Rejection, 'DeleteList', DeleteList);
 
%% Plot Speed
plot(S.t_v, S.v_um_s)
figure(gcf)
%% Find range for baseline subtraction
semilogx(S.lag, S. Normalized);
title('find range for baseline subtraction');
pause;
S.rangeBL = InAxes;
S.Normalized = (S.Normalized - mean(S.Normalized(InAxes)))/(1 - mean(S.Normalized(InAxes)));
semilogx(S.lag, S. Normalized);


title('find plateau for normalization');
pause;
S.rangeNorm = InAxes;
S.Normalized = S.Normalized /mean(S.Normalized(InAxes));
S.G0 = mean(S.AverageCF_CR(S.rangeNorm)) - mean(S.AverageCF_CR(S.rangeBL));
semilogx(S.lag, S. Normalized);

%% remove fields which are not needed for futher processing
fields_to_remove = {
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
    'corrfuncbad'
    'tracebad'
    'CF_CRbad'
    'dIdIbad'
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
S = rmfield(S, fields_to_remove)

%% Fit If the Fitting function is known
FitRange = [0.002 1000];
FitParam = PlotFitCF(S, FitRange, @Diffusion3D, [30000 0.05 30])
figure(gcf)
%% Extract displacement for zero speed
RhFileNames = {'Rh6G'};
Rh6G = LoadMultipleCorrFunc_v2(filepath, RhFileNames, 'Rejection', 2, 'NormalizationRange', NormRange,  'DeleteList', []);
S_ext = ExtractWithoutNoiseStructures_v3_1(S,  [], 'Average', [3e-3 5e-3], 'Rh6G calibration',  {Rh6G Rh6G 30000 0.002 'All'}, 'Create Model', {'diff3D'})
figure;
t = S_ext.displacement.lag;
loglog(S_ext.displacement.lag, S_ext.displacement.Rsq, t, 0.07*t); figure(gcf)
%% Create Data Structure
F300dUTPDNA_pwo1_Rh = S_ext;
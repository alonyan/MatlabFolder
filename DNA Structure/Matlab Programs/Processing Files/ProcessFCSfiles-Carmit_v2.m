%% Loading  picture

%filepath = 'D:\carmit\Backup021008Carmit\Experiments\011209_FCS\';
filepath = 'D:\carmit\Backup021008Carmit\Experiments\031209_FCS\';
%picName = 'UFo_MSl2_GFP_met_Ars4h_11.mat'
%picName = 'Ufo_GFP_SD_SDArs2h30min_b_3.mat'%not G
picName = 'Ufo_GFP_SD_SDArs2h30min_c_4.mat'%Granule
load([filepath picName]);
ScanParam
[Pict1, Norm1, Pict2, Norm2, PixSize, LineScaleV, Counts] = ReconstructImage_v4(AI, Cnt, 1, ScanParam);
pic1 = Pict1./Norm1;pic2 = Pict2./Norm2;
 meanPic = mean([pic1(find(~isnan(pic1))); pic2(find(~isnan(pic2)))])
stdPic = std([pic1(find(~isnan(pic1))); pic2(find(~isnan(pic2)))])
range =meanPic+ stdPic*[-1 3];
subplot(1, 2, 1); colormap('jet');imagesc(pic1, range);axis image; axis off;  subplot(1, 2, 2); imagesc(pic2, range);axis image; axis off; 
%colorbar; 
figure(gcf);

%%
%filenames = { 'UFo_MSl2_GFP_met_Ars4h_corr_11'};
%filenames = { 'Ufo_GFP_SD_SDArs2h30min_b_corr_3'};
filenames = {'Ufo_GFP_SD_SDArs2h30min_c__corr_5'};
Rejection =2;
NormRange = [15e-3 30e-3];
S = LoadMultipleCorrFunc_v2(filepath, filenames, 'Rejection', Rejection, 'NormalizationRange', NormRange,  'DeleteList', []);

%% Cluster analysis
Nclust =  size(S.corrfunc, 2)/4;
LinkageType ='single'% 'single', 'average', 'weighted'
Range = [0.1 1000]; % range of decay of the correlation function
[T, j, DeleteList] = ClusterizeCF_CR_v1(S, 'No of Clusters', Nclust, 'Normalization range', -1, 'Distance range', Range, 'Linkage', LinkageType);

%% Reload if needed
Rejection =10;
 S = LoadMultipleCorrFunc_v2(filepath, filenames, 'Rejection', Rejection, 'DeleteList', DeleteList);
 
% %% Plot Speed
% plot(S.t_v, S.v_um_s)

% %% Find range for baseline subtraction
% semilogx(S.lag, S. Normalized);
% title('find range for baseline subtraction');
% pause;
% S.rangeBL = InAxes;
% S.Normalized = (S.Normalized - mean(S.Normalized(InAxes)))/(1 - mean(S.Normalized(InAxes)));
% semilogx(S.lag, S. Normalized);
% 
% 
% title('find plateau for normalization');
% pause;
% S.rangeNorm = InAxes;
% S.Normalized = S.Normalized /mean(S.Normalized(InAxes));
% S.G0 = mean(S.AverageCF_CR(S.rangeNorm)) - mean(S.AverageCF_CR(S.rangeBL));
% semilogx(S.lag, S. Normalized);

% %% remove fields which are not needed for futher processing
% fields_to_remove = {
%     'corrfunc' 
%     'AfterPulseCalculated'
%     'trace'
%     'CR'
%     'CF_CR'
%     'dIdI'
%     'corrfuncgood'
%     'tracegood'
%     'CF_CRgood'
%     'dIdIgood'
%     'corrfuncbad'
%     'tracebad'
%     'CF_CRbad'
%     'dIdIbad'
%      'AveragedIdI'
%     'AverageAlldIdI'
%      'errordIdI'
%     'errorAlldIdI'
%     'WeightAverageCF'
%     'WeightAverageAllCF'
%     'errorWA_CF'
%     'errorAllWA_CF'
%     'score'
%     'AfterPulse'
%     'Xcoord'
%     'Ycoord'
%     'Zcoord'
%      'v_um_s'
%     't_v'
%     };
% S = rmfield(S, fields_to_remove)

%% Fit If the Fitting function is known
FitRange = [0.02 1000];
FitParam = PlotFitCF(S, FitRange, @Diffusion3D, [2400 1 70])
figure(gcf)
S.FitParam_1comp = FitParam;
S.tau = S.FitParam_1comp.beta(2, 1);
S.Nmolec = S.countrateGood/S.G0;
S.GoodnessOFFit=FitParam.chiSqNorm;
S.countrateGood
%% Create Data Structure
eval([filenames{1} '_proc  = S;']);
close all;
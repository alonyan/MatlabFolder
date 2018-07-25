%clear
close all
NormRange = [1e-3 2e-3];
filepath = 'G:\Esti\Experiments\030809\';

%% Blank file name
blank_fname_In ={ 'in46' };
blankIn = LoadMultipleCorrFunc_v2(filepath,  blank_fname_In, 'Rejection',2, 'NormalizationRange', NormRange,  'DeleteList', []);
[p, q] = sort(blankIn.score, 'descend')
FitParam_blank = PlotFitCF(blankIn, [0.002 1000], @Diffusion2D, [20000 0.05]);
wSq = FitParam_blank.beta(3, 1);
tau_blank_In = FitParam_blank.beta(2, 1);

%% Cluster analysis
Nclust = 30;
LinkageType ='single'% 'single', 'average', 'weighted'
Range = [0.1 10000]; % range of decay of the correlation function
[T, j, DeleteList] = ClusterizeCF_CR_v1(blankIn, 'No of Clusters', Nclust, 'Normalization range', [1e-3 5e-3], 'Distance range', Range, 'Linkage', LinkageType);

%% Reload if needed
%Rejection =10;
 blankIn = LoadMultipleCorrFunc_v2(filepath, blank_fname_In, 'Rejection', 10, 'DeleteList', DeleteList);
 
%% Outside vesicle
blank_fname_Out ={ 'out46' };
blankOut = LoadMultipleCorrFunc_v2(filepath,  blank_fname_Out, 'Rejection', 2, 'NormalizationRange', NormRange,  'DeleteList', []);
[p, q] = sort(blankOut.score, 'descend')
FitParam_blank = PlotFitCF(blankOut, [0.002 1000], @Diffusion2D, [20000 0.05]);
wSq = FitParam_blank.beta(3, 1);
tau_blank_Out = FitParam_blank.beta(2, 1);

%% Cluster analysis
Nclust = 30;
LinkageType ='single'% 'single', 'average', 'weighted'
Range = [0.1 10000]; % range of decay of the correlation function
[T, j, DeleteList] = ClusterizeCF_CR_v1(blankOut, 'No of Clusters', Nclust, 'Normalization range', [1e-3 5e-3], 'Distance range', Range, 'Linkage', LinkageType);

%% Reload if needed
%Rejection =10;
 blankOut = LoadMultipleCorrFunc_v2(filepath, blank_fname_Out, 'Rejection', 10, 'DeleteList', DeleteList);

%% Sample
sample_fname = {'cor47'}%dynamic
sample = LoadMultipleCorrFunc_v2(filepath, sample_fname , 'Rejection', 2, 'NormalizationRange', NormRange,  'DeleteList', []);

%% Cluster analysis
Nclust = round(size(sample.corrfunc, 2)/2);
LinkageType ='single'% 'single', 'average', 'weighted'
Range = [0.1 10000]; % range of decay of the correlation function
[T, j, DeleteList] = ClusterizeCF_CR_v1(sample, 'No of Clusters', Nclust, 'Normalization range', [1e-3 5e-3], 'Distance range', Range, 'Linkage', LinkageType);

%% Reload if needed
%Rejection =10;
 sample = LoadMultipleCorrFunc_v2(filepath, sample_fname, 'Rejection', 10, 'DeleteList', DeleteList);
 
%%
FitParam_sample = PlotFitCF(sample, [0.02 1000], @Diffusion2D, [25000 10]);
tau_sample = FitParam_sample.beta(2, 1);
figure(gcf)

%%  Remove noise from sample
fracIn = 0.5;
fracOut = 0.5;
blank.lag = blankOut.lag;
blank.AveragedIdI  =  blankOut.AveragedIdI*fracOut + blankIn.AveragedIdI*fracIn;
blank.countrateGood = blankOut.countrateGood *fracOut+ blankIn.countrateGood*fracIn;
blank.errorCF_CR = sqrt(blankOut.errorCF_CR.^2*fracOut^2+ blankIn.errorCF_CR.^2*fracIn^2);
blank.AverageCF_CR = blank.AveragedIdI/blank.countrateGood;
j= find((blank.lag>NormRange(1)) &    (blank.lag<NormRange(2)));
blank.G0 = robmean(blank.AverageCF_CR(j), blank.errorCF_CR(j));

membr = sample;
membr.AveragedIdI = sample.AveragedIdI - blank.AveragedIdI;
membr.countrateGood = sample.countrateGood - blank.countrateGood;
membr.AverageCF_CR = membr.AveragedIdI/membr.countrateGood;
membr.errorCF_CR = sqrt(sample.errorCF_CR.^2+ blank.errorCF_CR.^2);

j= find((membr.lag>NormRange(1)) &    (membr.lag<NormRange(2)));
membr.G0 = robmean(membr.AverageCF_CR(j), membr.errorCF_CR(j));

semilogx(blank.lag, blank.AverageCF_CR, sample.lag, sample.AverageCF_CR, membr.lag, membr.AverageCF_CR);
figure(gcf)

%% Fit 2D diffusion to membr
FitParam_membr = PlotFitCF(membr, [0.02 1000], @Diffusion2D, [20000 1]);
hold all;
semilogx(blank.lag, blank.AverageCF_CR);
hold off;
tau_membr = FitParam_membr.beta(2, 1)
ChiSq = FitParam_membr.chiSqNorm  
figure(gcf)
 'estimate oligomerisation from amplitudes'
 membr.G0/blank.G0
 'estimate oligomerisation from fits'
 FitParam_membr.beta(1, 1)/ FitParam_blank.beta(1, 1)

%%
struc_name = input('What is the name of the resulting structure?   ', 's');
S.blank = blank;
S.sample = sample;
S.membr = membr;
S.FitParam_blank = FitParam_blank;
S.FitParam_sample = FitParam_sample;
S.FitParam_membr = FitParam_membr;
S.tau_membr = tau_membr;
S.oligomerFromAmpl =  membr.G0/blank.G0;
S.oligomerFromFit =  FitParam_membr.beta(1, 1)/ FitParam_blank.beta(1, 1);

S.blankG0 = blank.G0;
S.membrG0 = membr.G0;
S.Nmolecules_on_membr = membr.countrateGood/membr.G0;
S.molecules_per_umSq = S.Nmolecules_on_membr/(pi*0.25^2) ;
eval([struc_name '=S'])

%% save to file
fname = 'process070709'
save([filepath fname])



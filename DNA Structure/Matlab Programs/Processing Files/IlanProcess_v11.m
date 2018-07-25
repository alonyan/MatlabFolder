%clear
close all
clear all
NormRange = [1e-3 2e-3];
filepath = 'D:\People\Ilan\Experiments\080210\'

%%  Load picture
picName = 's_M1_80_2mkW_a_7.mat'
load([filepath picName]);
ScanParam
[Pict1, Norm1, Pict2, Norm2, PixSize, LineScaleV, Counts] = ReconstructImage_v4(AI, Cnt,1, ScanParam);
pic1 = Pict1./Norm1;pic2 = Pict2./Norm2;
 meanPic = mean([pic1(find(~isnan(pic1))); pic2(find(~isnan(pic2)))])
stdPic = std([pic1(find(~isnan(pic1))); pic2(find(~isnan(pic2)))])
 range =meanPic+ stdPic*[-1 3];
%range =[ min(min(pic1(:)), min(pic2(:))) max(max(pic1(:)), max(pic2(:))) ]; % change made by ilan 09/02/2010 17:47
%subplot(1, 2, 1); imagesc(pic1, range);axis image; axis off; title(picName); subplot(1, 2, 2); 
imagesc(pic2, range);axis image; axis off; colorbar; figure(gcf);

%% Look at the wall width
linesJ = 80:81;
 plot([pic1(linesJ, :)'  pic2(linesJ, :)'])
 title(['PixSize = ' num2str(PixSize)]);
 figure(gcf)

%% Blank file name
blank_fname_In ={ 's_M1_80_2mkW_a__corr_8' };
blankIn = LoadMultipleCorrFunc_v3(filepath,  blank_fname_In, 'Rejection',2, 'NormalizationRange', NormRange,  'DeleteList', [  ] );

%blankIn = LoadMultipleCorrFunc_v2(filepath,  blank_fname_In, 'Rejection',2, 'NormalizationRange', NormRange,  'DeleteList', q(1:size(blankIn.corrfuncbad, 2)));
[p, q] = sort(blankIn.score, 'descend')
FitParam_blank = PlotFitCF(blankIn, [0.001 1000], @Diffusion3D, [450 1 30]);
wSq = FitParam_blank.beta(3, 1);
tau_blank_In = FitParam_blank.beta(2, 1);
size(blankIn.CF_CRbad, 2)

%% Cluster analysis
Nclust = 30;round(size(blankIn.corrfunc, 2)/2);
LinkageType ='single'% 'single', 'average', 'weighted'
Range = [0.1 10000]; % range of decay of the correlation function
[T, j, DeleteList] = ClusterizeCF_CR_v1(blankIn, 'No of Clusters', Nclust, 'Normalization range', [1e-3 5e-3], 'Distance range', Range, 'Linkage', LinkageType);
%% Reload if needed
%Rejection =10;
 blankIn = LoadMultipleCorrFunc_v2(filepath, blank_fname_In, 'Rejection', 10, 'DeleteList', DeleteList);
 FitParam_blank = PlotFitCF(blankIn, [0.002 1000], @Diffusion3D, [20000 0.05 30]);
wSq = FitParam_blank.beta(3, 1);
tau_blank_In = FitParam_blank.beta(2, 1);

%%  Diffusion Two Comp 2D if needed
figure;
hold on;
FitParam_blank = PlotFitCF(blankIn, [0.04 1000], @DiffusionTwoComp2D, [100 2 100 40]);
FitParam_StickDiff = PlotFitCF(blankIn, [0.04 1000], @StickDiffusionPreciseFit, [700 2 200 200], 0.25);
hold off 
Xlabel('Time[msec]');
Ylabel('gg')
%% Stick-diffusion Precise
figure;
FitParam_StickDiff = PlotFitCF(blankIn, [0.04 1000],@StickDiffusionPreciseFit, [700 2 200 200], 0.25);
title('Stick-diffusion Precise');


%% Outside vesicle
blank_fname_Out ={ 'gl_94_2mkW_a__corr_10_out' };
blankOut = LoadMultipleCorrFunc_v2(filepath,  blank_fname_Out, 'Rejection', 10, 'NormalizationRange', NormRange,  'DeleteList', [   ]);
%blankOut = LoadMultipleCorrFunc_v2(filepath,  blank_fname_Out, 'Rejection',2, 'NormalizationRange', NormRange,  'DeleteList', q(1:size(blankOut.corrfuncbad, 2)));
[p, q] = sort(blankOut.score, 'descend')
FitParam_blank = PlotFitCF(blankOut, [0.002 1000], @Diffusion3D, [20000 0.05 30]);
wSq = FitParam_blank.beta(3, 1);
tau_blank_Out = FitParam_blank.beta(2, 1);
size(blankOut.CF_CRbad, 2)
%% Cluster analysis
Nclust = round(size(blankOut.corrfunc, 2)/2);
LinkageType ='single'% 'single', 'average', 'weighted'
Range = [0.1 10000]; % range of decay of the correlation function
[T, j, DeleteList] = ClusterizeCF_CR_v1(blankOut, 'No of Clusters', Nclust, 'Normalization range', [1e-3 5e-3], 'Distance range', Range, 'Linkage', LinkageType);

%% Reload if needed
%Rejection =10;
 blankOut = LoadMultipleCorrFunc_v2(filepath, blank_fname_Out, 'Rejection', 10, 'DeleteList', DeleteList);
FitParam_blank = PlotFitCF(blankOut, [0.002 1000], @Diffusion3D, [20000 0.05 30]);
wSq = FitParam_blank.beta(3, 1);
tau_blank_Out = FitParam_blank.beta(2, 1);
size(blankOut.CF_CRbad, 2)
%% Sample (onthe membrane)
sample_fname = {'gl_94_2mkW_a__corr_10'};%dynamic
sample = LoadMultipleCorrFunc_v2(filepath, sample_fname , 'Rejection',  2, 'NormalizationRange', NormRange,  'DeleteList', [   ]);
[sc, I] = sort(sample.score, 'descend')
size(sample.CF_CRbad, 2)
%% Cluster analysis
Nclust = round(size(sample.corrfunc, 2)/2);
LinkageType ='single'% 'single', 'average', 'weighted'
Range = [0.1 10000]; % range of decay of the correlation function
[T, j, DeleteList] = ClusterizeCF_CR_v1(sample, 'No of Clusters', Nclust, 'Normalization range', [1e-3 5e-3], 'Distance range', Range, 'Linkage', LinkageType);

%% Reload if needed
%Rejection =10;
 sample = LoadMultipleCorrFunc_v2(filepath, sample_fname, 'Rejection', 10, 'DeleteList', DeleteList);
 
%%
FitParam_sample = PlotFitCF(sample, [0.02 1000], @Diffusion2D, [5000 1]);
tau_sample = FitParam_sample.beta(2, 1);
figure(gcf)
title('PlotFitCF - Sample ')

%%
close all

%%  Diffusion Two Comp 2D if needed for sample
figure;
FitParam_sample = PlotFitCF(sample, [0.01 1000], @DiffusionTwoComp2D, [450 0.8 300 50])
figure(gcf)
title('Diffusion Two Comp2D - Sample ')

 %%   Stick Diffusion Fit if needed for sample
figure;
FitParam_sample = PlotFitCF(sample, [0.01 1000], @Stick_DiffusionFit, [1200 1.785 101.20 50])
figure(gcf)
title('Stick Diffusion Fit - Sample')

%%  Remove noise from sample
j=1:209;
fracIn = 0;
fracOut = 1;
blank.lag = blankOut.lag(j);
blank.AveragedIdI  =  blankOut.AveragedIdI(j)*fracOut + blankIn.AveragedIdI(j)*fracIn;
blank.countrateGood = blankOut.countrateGood *fracOut+ blankIn.countrateGood*fracIn;
blank.errorCF_CR = sqrt(blankOut.errorCF_CR(j).^2*fracOut^2+ blankIn.errorCF_CR(j).^2*fracIn^2);
blank.AverageCF_CR = blank.AveragedIdI/blank.countrateGood;
j1= find((blank.lag>NormRange(1)) &    (blank.lag<NormRange(2)));
blank.G0 = robmean(blank.AverageCF_CR(j1), blank.errorCF_CR(j1));

membr.lag = blankOut.lag(j);;
membr.AveragedIdI = sample.AveragedIdI(j) - blank.AveragedIdI(j);
membr.countrateGood = sample.countrateGood - blank.countrateGood;
membr.AverageCF_CR = membr.AveragedIdI/membr.countrateGood;
membr.errorCF_CR = sqrt(sample.errorCF_CR(j).^2+ blank.errorCF_CR(j).^2);

j1= find((membr.lag>NormRange(1)) &    (membr.lag<NormRange(2)));
membr.G0 = robmean(membr.AverageCF_CR(j1), membr.errorCF_CR(j1));

semilogx(blank.lag, blank.AverageCF_CR, sample.lag, sample.AverageCF_CR, membr.lag, membr.AverageCF_CR);
figure(gcf)

%% Fit 2D diffusion to membrane
figure;
FitParam_membr = PlotFitCF(membr, [0.02 1000], @Diffusion2D, [6000 1]);
title('Diffution2D -  membrane ')
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
close all
 %% Fit 2D Two Comp diffusion to membrane
figure;
FitParam_membr = PlotFitCF(membr, [0.02 1000], @DiffusionTwoComp2D, [1200 0.6 500 50]);
title('Diffusion Two Comp2D - Membrane ')
hold all;
semilogx(blank.lag, blank.AverageCF_CR);
hold off;
tau_membr = [FitParam_membr.beta(2, 1)   FitParam_membr.beta(4, 1)]
ChiSq = FitParam_membr.chiSqNorm  
figure(gcf)
 'estimate oligomerisation from amplitudes'
membr.G0/blank.G0
 'estimate oligomerisation from fits'
[FitParam_membr.beta(1, 1)/ FitParam_blank.beta(1, 1)    FitParam_membr.beta(3, 1)/ FitParam_blank.beta(1, 1) ]

%% Stick Diffusion Fit for membrane if needed
figure;
FitParam_membr = PlotFitCF(membr, [0.01 1000], @Stick_DiffusionFit, [1000 0.8 100 50])
figure(gcf)
title('Stick Diffusion Fit - Membrane')
hold all;
semilogx(blank.lag, blank.AverageCF_CR);
hold off;
tau_membr = [FitParam_membr.beta(2, 1)   FitParam_membr.beta(4, 1)]
ChiSq = FitParam_membr.chiSqNorm  
figure(gcf)
 'estimate oligomerisation from amplitudes'
membr.G0/blank.G0
 'estimate oligomerisation from fits'
[FitParam_membr.beta(1, 1)/ FitParam_blank.beta(1, 1)    FitParam_membr.beta(3, 1)/ FitParam_blank.beta(1, 1) ]

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
fname = 'process050209'
save([filepath fname])

%% temp

plot(rand(4))
h_legend=legend('One','Two','Three','Four');
set(h_legend,'FontSize',16);


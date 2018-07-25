% clear & put the name files: filepath, FileName, FileRef
close all
NormRange = [1e-3 2e-3];
filepath = 'G:\Ilan\Experiments\141009\';
FileName = 'egfp_corr_10';
FileRef =  'his_egfp_015mkM';
fname = 'egfp_corr_10' %% this is the file where the data will be kept. 

%% ref file name
blank_fname_ref={FileRef};
blankRef = LoadMultipleCorrFunc_v2('G:\Ilan\Experiments\141009\',  blank_fname_ref, 'Rejection',0.1, 'NormalizationRange', NormRange,  'DeleteList', []);
[p, q] = sort(blankRef.score, 'descend')
FitParam_blank = PlotFitCF(blankRef, [0.002 1000], @Diffusion2D, [20000 0.05])
RefG0 = FitParam_blank.beta(1,1);
wSq = FitParam_blank.beta(3, 1);
tau_blank_In = FitParam_blank.beta(2, 1)

%% Blank file name
blank_fname_In ={strcat(FileName, '_inside') };
blankIn = LoadMultipleCorrFunc_v2(filepath,  blank_fname_In, 'Rejection',2, 'NormalizationRange', NormRange,  'DeleteList', []);
[p, q] = sort(blankIn.score, 'descend')
FitParam_blank = PlotFitCF(blankIn, [0.002 1000], @Diffusion2D, [20000 0.05]);
wSq = FitParam_blank.beta(3, 1);
tau_blank_In = FitParam_blank.beta(2, 1);

%% Outside vesicle
blank_fname_Out ={strcat(FileName, '_outside') };
blankOut = LoadMultipleCorrFunc_v2(filepath,  blank_fname_Out, 'Rejection', 2, 'NormalizationRange', NormRange,  'DeleteList', []);
[p, q] = sort(blankOut.score, 'descend')
FitParam_blank = PlotFitCF(blankOut, [0.002 1000], @Diffusion2D, [20000 0.05]);
wSq = FitParam_blank.beta(3, 1);
tau_blank_Out = FitParam_blank.beta(2, 1);


%% Sample
sample_fname = {FileName }%dynamic
sample = LoadMultipleCorrFunc_v2(filepath, sample_fname , 'Rejection',2, 'NormalizationRange', NormRange,  'DeleteList', []);
FitParam_sample = PlotFitCF(sample, [0.02 1000], @Diffusion2D, [20000 1]);
tau_sample = FitParam_sample.beta(2, 1);

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
S.oligomerFromAmplBlank =  membr.G0/blank.G0;
S.blankG0 = blank.G0;
S.membrG0 = membr.G0;
S.RefG0 = RefG0;
S.oligomerFromAmplRef= S.membrG0 /(S.RefG0*1.414);
S.Nmolecules_on_membr = membr.countrateGood/membr.G0;
S.molecules_per_umSq = S.Nmolecules_on_membr/(pi*0.25^2) ;
eval([struc_name '=S'])


%%  Show & Save liposom image (ZX-scan)
corrpos = strfind(FileName, '_corr');
scan_fname = strcat(FileName(1:(corrpos-1)),FileName((corrpos+5):end));
[ShowSaveImage, Pict_ZX] = OpenAndSaveLVimage(filepath, scan_fname) ;

%%  Show & Save liposom image (XY-scan)
underpos = strfind(scan_fname, '_');
numb=eval(scan_fname((underpos(end)+1):end));
Numb=num2str(numb-1)
ScanNameXY = strcat(scan_fname(1:(underpos(end))),Numb)
[ShowSaveImage, Pict_XY]  = OpenAndSaveLVimage(filepath, ScanNameXY) ;

%% save to file
save([filepath fname])



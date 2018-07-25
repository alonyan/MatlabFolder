addpath(genpath('/Users/oleg/Documents/MATLAB/General Utilities'));
addpath(genpath('/usr/local/Cellar/openslide'));
addpath(genpath('/Users/oleg/Documents/MATLAB/openslide-matlab-master'));
addpath(genpath('/Users/oleg/Documents/MATLAB/OpenSlideProject'));

openslide_load_library

%% Process experiment of 05202015: slides 1M01; 1M08; 1M09; 1M10
% controls 1M11-14
% 
clear chanName PathNchannels
MainFPath1 = '/Volumes/My Passport for Mac/Pictures Disk Backup/MSKCC/BGU/InVivoMicroscopyData061115/DAPI 488 594/';
MainFPath2 = '/Volumes/My Passport for Mac/Pictures Disk Backup/MSKCC/BGU/InVivoMicroscopyData061115/DAPI 488 647/';
fname = '1M10'
PathNchannels(1).fpath = [MainFPath1 fname '.mrxs'];
PathNchannels(1).chanName = {'DAPI_1', 'pSTAT5_1' , 'foxp3'};
PathNchannels(1).tag = {'DAPI', '488', '594'};
PathNchannels(2).fpath = [MainFPath2 fname '.mrxs'];
PathNchannels(2).chanName = {'DAPI_2', 'pSTAT5_2' , 'sources'};
PathNchannels(2).tag = {'DAPI', '488', '647'};

FigHdl = OpenSlideGUI_v13(PathNchannels);

%% Use threshold of 120 to avoid some junk in spare of DAPI places: probably red blood cells

ThreshTregs = 120; 
DirName ='/Volumes/My Passport for Mac/Pictures Disk Backup/MSKCC/BGU/InVivoMicroscopyData061115/AnalyzedImages/05202015/WT_High/';
FileNameTmpl = 'LN_IM*_wt_high*.mat';
strucName = ['LN_wt_high_Treg' num2str(ThreshTregs)];
fnames = dir([DirName FileNameTmpl]);

for i=1:length(fnames),
    i
    fname = fnames(i).name;
    S = load([DirName fname]);
    R= AnalyzeRegion_v5(S, 'Threshold Tregs', ThreshTregs);
    if i == 1,
        r = R.corrSourceTreg_pSTAT5.r;
        Gbg_ave = zeros(size(r));
        G_ave = zeros(size(r));
        errorG = zeros(size(r));
        Nbin = zeros(size(r));
        G_pSTAT5 = zeros(size(r));
        Nbin_pSTAT5 = zeros(size(r));
        Treg_density = 0;
        NTreg = 0;
        Source_density = 0;
        NSource = 0;
        Treg_ave_pSTAT5 = 0;
    end;
    pos = strfind(fname, '.mat');
    eval([strucName '.' fname(1:(pos-1)) '= R;']);
    
    Gbg_ave = Gbg_ave + R.corrSourceTreg_pSTAT5.Gbg.*R.corrSourceTreg_pSTAT5.Nbin;
    G_ave = G_ave + R.corrSourceTreg_pSTAT5.G.*R.corrSourceTreg_pSTAT5.Nbin;
    errorG = errorG + R.corrSourceTreg_pSTAT5.error_G.^2.*R.corrSourceTreg_pSTAT5.Nbin.^2;
    Nbin = Nbin + R.corrSourceTreg_pSTAT5.Nbin;
    G_pSTAT5 = G_pSTAT5 + R.autocorr_pSTAT5.G.*R.autocorr_pSTAT5.Nbin;
    Nbin_pSTAT5 = Nbin_pSTAT5 + R.autocorr_pSTAT5.Nbin;
    
    
    Treg_density = Treg_density + R.stats.Treg_density*length(R.Tregs);
    Treg_ave_pSTAT5 = Treg_ave_pSTAT5 + R.stats.Treg_ave_pSTAT5*length(R.Tregs);
    NTreg = NTreg + length(R.Tregs);
    Source_density = Source_density + R.stats.Source_density*length(R.Sources);
    NSource = NSource + length(R.Sources);   
end;

Gbg_ave = Gbg_ave./Nbin;
G_ave = G_ave./Nbin;
G_pSTAT5 = G_pSTAT5./Nbin_pSTAT5;
errorG = sqrt(errorG)./Nbin;
Treg_density = Treg_density/NTreg;
Treg_ave_pSTAT5 =Treg_ave_pSTAT5/NTreg;
Source_density = Source_density/NSource;

eval([strucName '.r = r;']);
eval([strucName '.G_Source_pSTAT5 = Gbg_ave;']);
eval([strucName '.G_pSTAT5 = G_pSTAT5;']);
eval([strucName '.errorG = errorG;']);
eval([strucName '.Treg_density = Treg_density;']);
eval([strucName '.Treg_ave_pSTAT5 = Treg_ave_pSTAT5;']);
eval([strucName '.Source_density = Source_density;']);





plot(r, Gbg_ave, '-o', r, G_pSTAT5, '-o');
% hold on
% errorbar(r_celldia, Gbg_ave, Gbg_error);
% hold off
xlabel('r (\mu m)', 'FontSize', 18)
ylabel('<pSTAT5>', 'FontSize', 18)
set(gca, 'FontSize', 14)
figure(gcf)

%%
%% plot all pSTAT5 correlations
fldnames = fieldnames(eval(strucName))
J = find(~cellfun('isempty', strfind(fldnames, 'LN')))

r = eval([strucName '.' fldnames{J(1)} '.corrSourceTreg_pSTAT5.r']);

for i = 1:length(J),
    P = eval([strucName '.' fldnames{J(i)}]);
    
    if length(P.Tregs)>900,
        plot(r, P.corrSourceTreg_pSTAT5.Gbg);
        hold all;
    end
end
hold off;
figure(gcf)

%% average fields again putting a lower limit on the number of Tregs in a slice

MinTregs = 2000;

for i=1:length(J),
    %i
    R= eval([strucName '.' fldnames{J(i)}]);
    if i == 1,
        r = R.corrSourceTreg_pSTAT5.r;
        Gbg_ave = zeros(size(r));
        G_ave = zeros(size(r));
        errorG = zeros(size(r));
        Nbin = zeros(size(r));
        G_pSTAT5 = zeros(size(r));
        errorG_pSTAT5 = zeros(size(r));
        Nbin_pSTAT5 = zeros(size(r));
        Treg_density = 0;
        NTreg = 0;
        Source_density = 0;
        NSource = 0;
        Treg_ave_pSTAT5 = 0;
    end;
    
    if length(R.Tregs) > MinTregs,
        Gbg_ave = Gbg_ave + R.corrSourceTreg_pSTAT5.Gbg.*R.corrSourceTreg_pSTAT5.Nbin;
        G_ave = G_ave + R.corrSourceTreg_pSTAT5.G.*R.corrSourceTreg_pSTAT5.Nbin;
        errorG = errorG + R.corrSourceTreg_pSTAT5.error_G.^2.*R.corrSourceTreg_pSTAT5.Nbin.^2;
        Nbin = Nbin + R.corrSourceTreg_pSTAT5.Nbin;
        G_pSTAT5 = G_pSTAT5 + R.autocorr_pSTAT5.G.*R.autocorr_pSTAT5.Nbin;
        i
        errorG_pSTAT5 = errorG_pSTAT5 + R.autocorr_pSTAT5.error_G.^2.*R.autocorr_pSTAT5.Nbin.^2;
        Nbin_pSTAT5 = Nbin_pSTAT5 + R.autocorr_pSTAT5.Nbin;


        Treg_density = Treg_density + R.stats.Treg_density*length(R.Tregs);
        Treg_ave_pSTAT5 = Treg_ave_pSTAT5 + R.stats.Treg_ave_pSTAT5*length(R.Tregs);
        NTreg = NTreg + length(R.Tregs);
        Source_density = Source_density + R.stats.Source_density*length(R.Sources);
        NSource = NSource + length(R.Sources);   
    end
end;

Gbg_ave = Gbg_ave./Nbin;
G_ave = G_ave./Nbin;
G_pSTAT5 = G_pSTAT5./Nbin_pSTAT5;
errorG = sqrt(errorG)./Nbin;
errorG_pSTAT5 = sqrt(errorG_pSTAT5)./Nbin_pSTAT5;
Treg_density = Treg_density/NTreg;
Treg_ave_pSTAT5 =Treg_ave_pSTAT5/NTreg;
Source_density = Source_density/NSource;

eval([strucName '.r = r;']);
eval([strucName '.G_Source_pSTAT5 = Gbg_ave;']);
eval([strucName '.G_pSTAT5 = G_pSTAT5;']);
eval([strucName '.errorG = errorG;']);
eval([strucName '.Treg_density = Treg_density;']);
eval([strucName '.Treg_ave_pSTAT5 = Treg_ave_pSTAT5;']);
eval([strucName '.Source_density = Source_density;']);

plot(r, Gbg_ave, '-o', r, G_pSTAT5, '-o');
% hold on
% errorbar(r_celldia, Gbg_ave, Gbg_error);
% hold off
xlabel('r (\mu m)', 'FontSize', 18)
ylabel('<pSTAT5>', 'FontSize', 18)
set(gca, 'FontSize', 14)
figure(gcf)

%%
plot(r, 60*(Gbg_ave - 86.6), '-o', r, G_pSTAT5+40, '-o');
% hold on
% errorbar(r_celldia, Gbg_ave, Gbg_error);
% hold off
xlabel('r (\mu m)', 'FontSize', 18)
ylabel('<pSTAT5>', 'FontSize', 18)
set(gca, 'FontSize', 14)
figure(gcf)

%% Fit Gbg_ave with Yukava 
errorbar(r, Gbg_ave, errorG);
figure(gcf)

plot(r, Gbg_ave, '-o');
title('Zoom into fit range');
figure(gcf)
pause;
J = InAxes;
beta0(1) = Gbg_ave(1)*r(1);
beta0(2) = 0.01;
beta0(3) =  Gbg_ave(J(end));
FitParam = nlinfitWeight2(r(J), Gbg_ave(J),@YukavaFit, beta0, errorG(J), []);

errorbar(r, Gbg_ave, errorG);
hold on;

h = plot(r, Gbg_ave, 'o', r(J), YukavaFit(FitParam.beta, r(J)), '-r');
set(h(2), 'LineWidth', 2)
hold off;
xlabel('r (\mu m)', 'FontSize', 18)
ylabel('Gbg_ave', 'FontSize', 18)
set(gca, 'FontSize', 14)
figure(gcf)


%% Fit pSTAT5 correlations with ExpFit
semilogy(r, G_pSTAT5, 'o');

title('Zoom into fit range');
figure(gcf)
pause;
J = InAxes;
clear beta;
beta0(1) = G_pSTAT5(1);
beta0(2) = 0.01;
FitParam = nlinfitWeight2(r(J), G_pSTAT5(J),@ExpFit, beta0, errorG_pSTAT5(J), []);

errorbar(r, G_pSTAT5, errorG_pSTAT5);
hold on;

h = plot(r, G_pSTAT5, 'o', r(J), ExpFit(FitParam.beta, r(J)));
hold off;
set(gca, 'Yscale', 'log')
set(h(2), 'LineWidth', 2)
hold off;
xlabel('r (\mu m)', 'FontSize', 18)
ylabel('G pSTAT5', 'FontSize', 18)
set(gca, 'FontSize', 14)
figure(gcf)

%%
save '/Volumes/My Passport for Mac/Pictures Disk Backup/MSKCC/BGU/InVivoMicroscopyData061115/AnalyzedImages/05202015/process_291015' 




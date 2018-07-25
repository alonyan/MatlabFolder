%% load MinD files: provide path and template
fpath = 'F:\Ilan\Experiment\process080210-minD.mat'
load(fpath);

% name template
nametemplate = 's_M1*';
strucnames = who( 's_M1*')
%check printout of structure names in the Matlab space
commandwindow
%%  We are going to do PCA on dIdI field of the correlation structure:
%  these are primary data without normalization
% we will do it both on original dIdI and on dIdI corrected for
% photobleaching

%for i = 1:length(strucnames), 
% list structures either one-by-one or in a loop
i = 11;
    S = eval(strucnames{i});
    
    % original dIdI is there but dIdI corrected for photobleaching we have
    % to create
    S.dIdIcorrected = S.CF_CRcorrected.*repmat(S.CR, size(S.CF_CRcorrected, 1), 1);
    S.AverageAlldIdIcorrected = mean(S.dIdIcorrected, 2);
    
    % do PCA on original data
    
    % restrict data to some reasonable times
    J = find(S.lag > 0.001);
    
    [COEFF,SCORE,latent,tsquare] = princomp(S.dIdI(J, :)');
    'eigenvalues'
    S.PCA.eigenvalues = latent;
    % see printout in Matlab space how dominant the first component is (these are eigenvalues):
    latent(1:10)
    'fraction of the main component in the total variance'
    latent(1)/sum(latent);
    S.PCA.variance_fraction = latent(1)/sum(latent);
    
    % now  the same thing explicitely
     [latent(1)/sum(latent) 1 - sum(var(S.dIdI(J, :) -  repmat(S.AverageAlldIdI(J), 1, size(S.dIdI, 2)) - COEFF(:, 1)*SCORE(:, 1)', 0, 2))/sum(var(S.dIdI(J, :), 0, 2))] 
     commandwindow
    %temp  = input('Press any return to continue');
%%
    % the fact that the first eigenvalue is so much larger than the others
    % shows that the first component
    % accounts for most of the variance. You can see/show that by presenting
    % several runs as a sum of the mean and the first component only:
    % change jrun below to verify:
    jrun = 10;
    semilogx(S.lag(J), S.dIdI(J, jrun), S.lag(J), S.AverageAlldIdI(J) + COEFF(:, 1)*SCORE(jrun, 1));
    figure(gcf)
    S.PCA.scoresOf2components = SCORE(:, 1:2);
    S.PCA.two_components = COEFF(:, 1:2);
    S.PCA.lag = S.lag(J);
%% Have a look at the first two componens (change sign below so that it looks positive)
    semilogx(S.lag(J), [-COEFF(:, 1), -COEFF(:, 2)]); figure(gcf)
 % notice how slowly decaying is the first component for minD: in the few files I tried for tailed GFP it was decaying much faster
%% Check now whether appearance of this component correlates with the
% emission intensity
% first correlation coefficient - check the diagonal component. They should
% be close to 1 for high correlation
S.PCA.corrcoef = corrcoef(-SCORE(:, 1), S.CR - S.countrate);
'correlation coefficient between between the first component and emission intensity'
S.PCA.corrcoef
commandwindow

% now plot
p = polyfit(S.CR - S.countrate, -SCORE(:, 1)', 1)
plot(S.CR - S.countrate, -SCORE(:, 1),  'o', S.CR - S.countrate, polyval(p, S.CR - S.countrate)); figure(gcf)
% the line is a linear fit:  its slope*component amplitude  = is fluorescence per molecule in the first component
Jampl = find((S.PCA.lag > 0.01) & (S.PCA.lag < 0.02));
S.PCA.Jampl = Jampl;
S.PCA.p = p;
S.PCA.mol_brightness = p(1)*mean(- COEFF(Jampl, 1));
'molecular brightness in the first component'
S.PCA.mol_brightness

'molecular brightness in the first component of the first run'
S.PCA.mol_brightness_1run = -SCORE(1, 1)/(S.CR(1) - S.countrate)*mean(- COEFF(Jampl, 1));
S.PCA.mol_brightness_1run

'amplitude of the first run'
S.G0_good(1)
% I am getting rather high values ~ 3700 today. I believe yesterday I got
% smaller ones. I need to check whether there have been any mistakes. But I
% do not see anything obvious. I was probably trying other files. Check
% all.

%% Now the same thing for the data corrected for photobleaching just to see if there is any difference (I do not think there is much) 

    [COEFF,SCORE,latent,tsquare] = princomp(S.dIdIcorrected(J, :)');
    S.PCA.eigenvalues_corrected = latent;
    % see printout in Matlab space how dominant the first component is (these are eigenvalues):
    latent(1:10)
    latent(1)/sum(latent);
    'variance due to the  first component'
    S.PCA.variance_fraction_corrected = latent(1)/sum(latent);
    
    % now  the same thing explicitely
     [latent(1)/sum(latent) 1 - sum(var(S.dIdI(J, :) -  repmat(S.AverageAlldIdI(J), 1, size(S.dIdI, 2)) - COEFF(:, 1)*SCORE(:, 1)', 0, 2))/sum(var(S.dIdI(J, :), 0, 2))] 
     commandwindow
    %temp  = input('Press any return to continue');
%%
    % the fact that the first eigenvalue is so much larger than the others
    % shows that the first component
    % accounts for most of the variance. You can see/show that by presenting
    % several runs as a sum of the mean and the first component only:
    % change jrun below to verify:
    jrun = 6;
    semilogx(S.lag(J), S.dIdIcorrected(J, jrun), S.lag(J), S.AverageAlldIdIcorrected(J) + COEFF(:, 1)*SCORE(jrun, 1));
    figure(gcf)
    S.PCA.scoresOf2components_corrected = SCORE(:, 1:2);
    S.PCA.two_components_corrected = COEFF(:, 1:2);
%% Have a look at the first two componens (change sign below so that it looks positive)
    semilogx(S.lag(J), [-COEFF(:, 1), -COEFF(:, 2)]); figure(gcf)
 % notice how slowly decaying is the first component for minD: in the few files I tried for tailed GFP it was decaying much faster
%% Check now whether appearance of this component correlates with the
% emission intensity
% first correlation coefficient - check the diagonal component. They should
% be close to 1 for high correlation
S.PCA.corrcoef_corrected = corrcoef(-SCORE(:, 1), S.CR - S.countrate);
S.PCA.corrcoef_corrected
commandwindow
% now plot
p = polyfit(S.CR - S.countrate, -SCORE(:, 1)', 1)
plot(S.CR - S.countrate, -SCORE(:, 1),  'o', S.CR - S.countrate, polyval(p, S.CR - S.countrate)); figure(gcf)
% the line is a linear fit: its slope*component amplitude  = fluorescence per molecule in the
% first component (see printout in Matlab space)
S.PCA.p_corrected = p;
p(1)

'molecular brightness in the first component'
S.PCA.mol_brightness_corrected = p(1)*mean(- COEFF(Jampl, 1));
S.PCA.mol_brightness_corrected

'molecular brightness in the first component of the first run'
S.PCA.mol_brightness_1run_corrected = -SCORE(1, 1)/(S.CR(1) - S.countrate)*mean(- COEFF(Jampl, 1));
S.PCA.mol_brightness_1run_corrected

'amplitude of the first run'
S.G0_good(1)

% I am getting rather high values ~ 37000 today. I believe yesterday I got
% smaller ones. I need to check whether there have been any mistakes. But I
% do not see anything obvious. I was probably trying other files. Check
% all.

%% now put everything back into original structure
eval([strucnames{i} '= S']);

%% when you have done all the files do not forget to save everything
%end; %for
save 'F:\Ilan\Experiment\process040410_minD' 's_M1*'

%% plot principal components from all minD files
hold off;
for i=1:length(strucnames),
    S = eval(strucnames{i});
    semilogx(S.PCA.lag, -S.PCA.two_components(:, 1));
    hold all
end;
figure(gcf)

%% plot traces of all minD files
fig1 = figure;
fig2 = figure;
hold off;
for i=1:length(strucnames),
    S = eval(strucnames{i});
    Tr = S.trace(:);
    Tr = Tr(find(Tr>0));
    t_Tr = (1:length(Tr))'*0.105;
    figure(fig1);
    semilogy(t_Tr, Tr)
    hold all;
    figure(fig2);
    %betaTr = nlinfit(t_Tr, Tr, @BleachingCellFit, [max(Tr)*0.8 10 max(Tr)*0.2 100]);
    semilogy(t_Tr, Tr/Tr(1)); % rescaled data
    hold all
    [i S.betaTr(4) S.PCA.variance_fraction]
end;
figure(gcf)

%% plot principal components and traces of all minD files
fig1 = figure;
fig2 = figure;
hold off;
for i=1:length(strucnames),
    S = eval(strucnames{i});
    Tr = S.trace(:);
    Tr = Tr(find(Tr>0));
    t_Tr = (1:length(Tr))'*0.105;
    figure(fig1);
    semilogx(S.PCA.lag, -S.PCA.two_components(:, 1));
    hold all;
    figure(fig2);
    %betaTr = nlinfit(t_Tr, Tr, @BleachingCellFit, [max(Tr)*0.8 10 max(Tr)*0.2 100]);
    semilogy(t_Tr, Tr/Tr(1)); % rescaled data
    hold all
    [i S.betaTr(4) S.PCA.variance_fraction]
end;
figure(gcf)

%% go over fits to trace in minD files

strucnames = who(  's_M1*')
fig1 = figure;
fig2 = figure;

for i=1:length(strucnames),
    S = eval(strucnames{i});
    Tr = S.trace(:);
    Tr = Tr(find(Tr>0));
    t_Tr = (1:length(Tr))'*0.105;
    figure(fig1);
    semilogx(S.PCA.lag, -S.PCA.two_components(:, 1), '-k');
    figure(fig2);
    [betaTr, R] = nlinfit(t_Tr, Tr, @BleachingCellFit, [max(Tr)*0.8 10 max(Tr)*0.2 100]);
    semilogy(t_Tr, Tr, '.',  t_Tr, BleachingCellFit(betaTr, t_Tr));
    R'*R
    title(i)
    figure(gcf);
    [betaTr S.betaTr]
    pause;
    [betaTr2Exp, R] = nlinfit(t_Tr, Tr, @TwoExponentFit, [max(Tr)*0.8 10 max(Tr)*0.2 100]);
    semilogy(t_Tr, Tr, '.', t_Tr, TwoExponentFit(betaTr2Exp, t_Tr));
    title(i)
    figure(gcf);
    R'*R
    pause;
    [betaTr2Exp S.betaTr2Exp]
end;

%% summarize trace fits
betaTr = [];
betaTr2Exp = [];
for i=1:length(strucnames),
    S = eval(strucnames{i});
 
    betaTr2Exp = [betaTr2Exp; S.betaTr2Exp];
    betaTr = [betaTr; S.betaTr];
end;
'amplitudes'
[betaTr2Exp(:, [1 3]) betaTr(:, [1 3])]
'times'
[betaTr2Exp(:, [2 4]) betaTr(:, [2 4])]
commandwindow
minD.betaTr = betaTr;
minD.betaTr2Exp  = betaTr2Exp;
%%  try to fit the principal components
midTau = [];
beta1 = [];

for i=1:length(strucnames),
    S = eval(strucnames{i});
    Jfit = find(S.PCA.lag > 0.02);
    J1fit = find(S.lag > 0.02);
   beta2comp =nlinfitWeight1(S.PCA.lag(Jfit), -S.PCA.two_components(Jfit, 1), @Diffusion2DTwoComp,  [0.05 10 0.05 200], S.errorAlldIdI(J1fit)*1e-9)
%   betaRect =nlinfitWeight1(S.PCA.lag(Jfit), -S.PCA.two_components(Jfit, 1), @Diffusion2Drectified,  [0.1 10 0.5], S.errorAlldIdI(J1fit)*1e-9)
   commandwindow
  % semilogx(S.PCA.lag(Jfit), [-S.PCA.two_components(Jfit, 1) Diffusion2Drectified(betaRect, S.PCA.lag(Jfit))]);
   semilogx(S.PCA.lag(Jfit), [-S.PCA.two_components(Jfit, 1) Diffusion2DTwoComp(beta2comp, S.PCA.lag(Jfit))]);
   title(i)
   figure(gcf);
   pause
   betaSD =nlinfitWeight1(S.PCA.lag(Jfit), -S.PCA.two_components(Jfit, 1), @Stick_DiffusionFit, [0.09 10 600 100], S.errorAlldIdI(J1fit)*1e-9)
   commandwindow
   semilogx(S.PCA.lag(Jfit), [-S.PCA.two_components(Jfit, 1) Stick_DiffusionFit(betaSD, S.PCA.lag(Jfit))]);
   title(i)
   figure(gcf);
   pause
   betaSDprec =nlinfitWeight1(S.PCA.lag(Jfit), -S.PCA.two_components(Jfit, 1), @StickDiffusionPreciseFit, betaSD, S.errorAlldIdI(J1fit)*1e-9, 0.25)
   %betaSD = [ beta1 betaSD];
   %subplot(1, 2, 1);
   %beta = PlotFitCF(S1, [0.01 1000], @Diffusion2DTwoComp, [1500 0.5 2000 40]);
   semilogx(S.PCA.lag, [-S.PCA.two_components(:, 1) StickDiffusionPreciseFit(betaSDprec, S.PCA.lag, 0.25)]);
   figure(gcf);
   pause
   %% find time of half decay
   A = mean(S.PCA.two_components(Jampl, 1))
   [temp, jthd] = min(abs(S.PCA.two_components(:, 1) - A/2));
   thd = S.PCA.lag(jthd);
   midTau = [midTau thd];  
   S.PCA.midTau = thd;
   eval([strucnames{i} '= S;']);
  % pause;
end;
beta1
midTau
%%
minD.PCAmidTau = midTau;
save 'D:\Oleg\Students\Ilan\Experiment\process040410_minD' 's_M1*' minD

%% Have another look at PCH file
%  PCH file
fpath = 'D:\Oleg\Students\Ilan\Experiment\080210\'; 
PCHname =  's_M1_80_2mkW_a__pch_2'
S = s_M1_80_2mkW_a__corr_2;
fid = fopen([fpath PCHname])
fread(fid, 1, 'int16')
fread(fid, 1, 'int32')
fread(fid, 1, 'int32')
dt = fread(fid, 1, 'double')*1e-3;
LogBookSize = fread(fid, 1, 'int32')
LogBook = fscanf(fid, '%c', LogBookSize)
c = fread(fid, inf, 'uint8');
c(1:9)
c = c(9:length(c));
fclose(fid);
len = length(c);

%%  Fit each correlation function after  subtracting the trend from trace and plot corresponding PCH
clear betaCF2comp;
Nruns=size(S.CF_CR, 2);
clear N_fcs q_fcs; %  N_pch  q_pch betaFIDA
c1 = [] 
figure(fig1);
FitRange = [0.01 1000];
h = annotation(gcf, 'textbox','String',{''}, 'Position',[ 0.3738    0.8474    0.0694    0.0375], 'EdgeColor', 'none');
S2 = S; % choose either photobleaching subtracted or original data
cleaningStrategy =1;

%for i = 1:Nruns,
    i=1
 %   figure(fig1);
  %  semilogx(S.lag, S.CF_CR(:, i)); title(['count rate per molecule = ' num2str(S.G0_good(i))]);
  %  axis([0.01 1000 0 2*S.G0_good(i)])
  %  figure(fig2)
  %  plot(S.trace(:, i)); title(['total count rate = ' num2str(S.CR(i))]);
   % pause;
  
  % S1.AverageCF_CR = S1.CF_CR(:, i);
   J = find((S2.lag > FitRange(1) )&(S2.lag < FitRange(2)));
   
   beta =nlinfitWeight1(S2.lag(J), S2.CF_CR(J, i), @Diffusion2DTwoComp,  [1500 0.5 2000 40], S2.errorCF_CR(J));
   subplot(1, 2, 1);
   %beta = PlotFitCF(S1, [0.01 1000], @Diffusion2DTwoComp, [1500 0.5 2000 40]);
   semilogx(S2.lag(J), [S2.CF_CR(J, i) Diffusion2DTwoComp(beta, S2.lag(J))]);

   set(gca, 'Position', [ 0.0533    0.0960    0.4113    0.8290]);
 %  axis([0.04 1000 -1000 3000])
  title([num2str(i) ':' ]);
  
  set(h, 'String', {num2str(beta)});
  
   figure(gcf);
   betaCF2comp(:, i) = beta; %beta.beta(:, 1);
   
   %**********************************************
   % PCH
   Jmin = [];
    ccut = c(round(((i-1)*len/Nruns +1):(i*len/Nruns)));
    n = 0:max(c);
    hc = hist(ccut, n);
    subplot(1, 2, 2);
    set(gca, 'Position', [ 0.5152    0.1010    0.4543    0.8265]);
    N_fcs(i) = S.CR(i)/S.G0_good(i);
    q_fcs(i) = S.G0_good(i)*dt;
    
   
    P = FIDAsimple_v2(n, N_fcs(i),  q_fcs(i));
    
    if cleaningStrategy ==1,    
     	% cleaning the trace by calculating   the probability of 5 consecutive
        % points
        j1  = find(smooth(log(P(ccut+1))) <  -7);
       % j2 = unique([j1- 2 j1- 1 j1 j1+1 j1+2]);
         j2 = unique([ j1 ]);
        j2 = j2(find((j2>0) & (j2 <= length(ccut))));
        size(j2)
    end;
    
    if cleaningStrategy ==2, 
        span =1500;
     	% cleaning the trace by iterating each 5000 points
        [temp, Jmin] = min(P(ccut+1));
        Jran = Jmin;
        runFlag = 1;
        while runFlag,
       
            Jran = Jran - 5000;
            if (Jran - span) <= 1,
                    runFlag =0;
             end;
            if (Jran + span) >1,           
                stretch = max(Jran-span, 1):min(Jran+span, length(ccut));
                [temp, jmin] = min(P(ccut(stretch)+1));
                Jmin = [Jmin (min(stretch) - 1 + jmin)];
                Jran = (min(stretch) - 1 + jmin);
            end;
        end;
        
        runFlag = 1;
        Jran = max(Jmin);
        while runFlag,
            Jran = Jran + 5000;
            if (Jran+span) >= length(ccut),
                runFlag = 0;
            end;
            
            if (Jran - span) < length(ccut),
                stretch = max(Jran-span, 1):min(Jran+span, length(ccut));
                [temp, jmin] = min(P(ccut(stretch)+1));
                Jmin = [Jmin (min(stretch) - 1 + jmin)];
                Jran = (min(stretch) - 1 + jmin);
            end;
        end;
        
        j1  = Jmin;
        j2 = unique([j1-3 j1-2 j1-1 j1 j1+1 j1+2 j1+3]);
        j2 = j2(find((j2>0) & (j2<=length(ccut))));
    end;
    
    figure(fig2);
    plot(1:length(ccut), ccut, j2, ccut(j2), 'r'); figure(gcf);
   pause;
    ccut(j2) = [];
    plot(ccut);
    figure(fig2);
 %  pause;
%    J = find( P*sum(hc) > 0.01 );
%    n = n(J);
 %   P = P(J);
    n= min(ccut):max(ccut);
    minn = min(n);
    maxn = max(n);
%    J = find((ccut<= maxn) & (ccut >= minn));
 %   ccut = ccut(J);
    
    c1 = [c1; ccut];
    hc = hist(ccut, n);
    Pexp = hc/sum(hc);
    Pexp = Pexp(:);
    P = P(n+1);
   
   figure(fig1); 
%     semilogy(n, Pexp,'o',  n, P);
%     title(i);
%     figure(gcf);
%     pause;
 betaFIDA(i,:) = nlinfitWeight1(n, Pexp, @FIDAsimple_fit, [N_fcs(i) q_fcs(i)], max(sqrt(Pexp/sum(hc)), 1/sum(hc)));
 betaPoiss(i,:) = nlinfitWeight1(n, Pexp, @PoissonFit, N_fcs(i)*q_fcs(i), max(sqrt(Pexp/sum(hc)), 1/sum(hc)));
 % semilogy(n, Pexp, 'o', n, P)
  semilogy(n, Pexp, 'o', n, P, n, FIDAsimple_v2(n, betaFIDA(i, 1),  betaFIDA(i, 2)), n, PoissonFit(betaPoiss(i,:), n ))
  title(i)  
   figure(fig1);
 %  pause;
   %close all;
%end; %for

%% cut short pieces of the photon count
n1 = min(n):4:max(n);
hc = hist(ccut(1:250), n1);
Pexp = hc/sum(hc)/median(diff(n1));
Pexp = Pexp(:);
betaPoiss(i,:) = nlinfitWeight1(n1, Pexp, @PoissonFit, N_fcs(i)*q_fcs(i), max(sqrt(Pexp/sum(hc)), 1/sum(hc)));
 % semilogy(n, Pexp, 'o', n, P)
semilogy(n1, Pexp, 'o', n, P, n1, FIDAsimple_v2(n1, betaFIDA(i, 1),  betaFIDA(i, 2)), n1, PoissonFit(betaPoiss(i,:), n1 ))
title(i)  
figure(fig1);
%% load MinD files: provide path and template
fpath = 'F:\Ilan\Experiment\process020210-tail.mat'
load(fpath);

% name template
nametemplate = 's_224*';
strucnames = who( nametemplate)
%check printout of structure names in the Matlab space
commandwindow
%%  We are going to do PCA on dIdI field of the correlation structure:
%  these are primary data without normalization
% we will do it both on original dIdI and on dIdI corrected for
% photobleaching
t=0;
sol=0;
PCA_frst_value=0;
for i = 1:length(strucnames), 
% list structures either one-by-one or in a loop
%i = 10;
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
    t=latent(1)/sum(latent);
    
    S.PCA.variance_fraction = latent(1)/sum(latent);
    
    % now  the same thing explicitely
     [latent(1)/sum(latent) 1 - sum(var(S.dIdI(J, :) -  repmat(S.AverageAlldIdI(J), 1, size(S.dIdI, 2)) - COEFF(:, 1)*SCORE(:, 1)', 0, 2))/sum(var(S.dIdI(J, :), 0, 2))] 
     sol=sol+t
     PCA_frst_value=PCA_frst_value+S.PCA.eigenvalues(1,:)
end;
solf=sol/length(strucnames)
PCA_frst_value=PCA_frst_value/length(strucnames)
     commandwindow
    %temp  = input('Press any return to continue');
%%
    % the fact that the first eigenvalue is so much larger than the others
    % shows that the first component
    % accounts for most of the variance. You can see/show that by presenting
    % several runs as a sum of the mean and the first component only:
    % change jrun below to verify:
    jrun = 3;
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

'amplitude of the first run';
S.G0_good(1)

% I am getting rather high values ~ 37000 today. I believe yesterday I got
% smaller ones. I need to check whether there have been any mistakes. But I
% do not see anything obvious. I was probably trying other files. Check
% all.

%% now put everything back into original structure
eval([strucnames{i} '= S']);

%% when you have done all the files do not forget to save everything
%end; %for
save 'D:\Oleg\Students\Ilan\Experiment\process040410_tail' 's_224*'

%% plot principal components from all tail files
hold off;
for i=1:length(strucnames),
    S = eval(strucnames{i});
    semilogx(S.PCA.lag, -S.PCA.two_components(:, 1));
    hold all
end;
figure(gcf)

%% plot traces of all tail files
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

%% plot principal components and traces of all tail files
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

%% compare between tail and minD files
strucnames = who(  's_224*')
strucnames_minD = who(  's_M1*')
fig1 = figure;
fig2 = figure;

for i=1:length(strucnames),
    S = eval(strucnames{i});
    Tr = S.trace(:);
    Tr = Tr(find(Tr>0));
    t_Tr = (1:length(Tr))'*0.105;
    figure(fig1);
    semilogx(S.PCA.lag, -S.PCA.two_components(:, 1), '-k');
    hold on;
    figure(fig2);
    %betaTr = nlinfit(t_Tr, Tr, @BleachingCellFit, [max(Tr)*0.8 10 max(Tr)*0.2 100]);
    semilogy(t_Tr, Tr/Tr(1), '-k'); % rescaled data
    hold on
    [i S.betaTr(4) S.PCA.variance_fraction]
end;

for i=1:length(strucnames_minD),
    S = eval(strucnames_minD{i});
    Tr = S.trace(:);
    Tr = Tr(find(Tr>0));
    t_Tr = (1:length(Tr))'*0.105;
    figure(fig1);
    semilogx(S.PCA.lag, -S.PCA.two_components(:, 1), '-b');
    hold on;
    figure(fig2);
    %betaTr = nlinfit(t_Tr, Tr, @BleachingCellFit, [max(Tr)*0.8 10 max(Tr)*0.2 100]);
    semilogy(t_Tr, Tr/Tr(1), '-b'); % rescaled data
    hold on
    [i S.betaTr(4) S.PCA.variance_fraction]
end;
figure(gcf)

%% go over fits to trace in tail files

strucnames = who(  's_224*')
strucnames_minD = who(  's_M1*')
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
    betaTr = nlinfit(t_Tr, Tr, @BleachingCellFit, [max(Tr)*0.8 10 max(Tr)*0.2 100]);
    semilogy(t_Tr, Tr, t_Tr, BleachingCellFit(betaTr, t_Tr));
    figure(gcf);
    [betaTr S.betaTr]
    pause;
    betaTr2Exp = nlinfit(t_Tr, Tr, @TwoExponentFit, [max(Tr)*0.8 10 max(Tr)*0.2 100]);
    semilogy(t_Tr, Tr, t_Tr, TwoExponentFit(betaTr2Exp, t_Tr));
    figure(gcf);
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
tail.betaTr = betaTr;
tail.betaTr2Exp  = betaTr2Exp;
%%  try to fit the principal components
strucnames = who(  's_224*')
midTau = [];
beta1 = [];
for i=1:length(strucnames),
    S = eval(strucnames{i});
    beta =nlinfitWeight1(S.PCA.lag, -S.PCA.two_components(:, 1), @Diffusion2Drectified,  [0.1 10 0.5], S.errorAlldIdI(J)*1e-9);
   beta1 = [ beta1 beta];
   %subplot(1, 2, 1);
   %beta = PlotFitCF(S1, [0.01 1000], @Diffusion2DTwoComp, [1500 0.5 2000 40]);
   semilogx(S.PCA.lag, [-S.PCA.two_components(:, 1) Diffusion2Drectified(beta, S.PCA.lag)]);
   figure(gcf);
   %% find time of half decay
   A = mean(S.PCA.two_components(Jampl, 1))
   [temp, jthd] = min(abs(S.PCA.two_components(:, 1) - A/2));
   thd = S.PCA.lag(jthd);
   midTau = [midTau thd];  
   S.PCA.midTau = thd;
   eval([strucnames{i} '= S']);
   pause;
end;
beta1
midTau;
%%
tail.PCAmidTau = midTau;
save 'D:\Oleg\Students\Ilan\Experiment\process040410_tail' 's_224*' tail
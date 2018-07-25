%clear
close all
NormRange = [1e-2 3e-2];
fpath = 'D:\People\Ilan\Experiments\290110\'
scrsz = get(0,'ScreenSize'); 
fig1 = figure('PaperSize',[20.98 29.68], 'Position', scrsz + [0 34 1440 -108]);
fig2 = figure('PaperSize',[20.98 29.68], 'Position', scrsz + [0 34 1440 -108]);
%%  Load many pictures
fnames = dir([fpath '*.mat']);
Nhor = 4;
Nvert = 3;

j =1;
for i=1:length(fnames),
    if j <= (Nhor*Nvert),
        picName = fnames(i).name
        load([fpath picName]);
        ScanParam
        [Pict1, Norm1, Pict2, Norm2, PixSize, LineScaleV, Counts] = ReconstructImage_v4(AI, Cnt, 1, ScanParam);
        pic1 = Pict1./Norm1;pic2 = Pict2./Norm2;
        meanPic = mean([pic1(find(~isnan(pic1))); pic2(find(~isnan(pic2)))])
        stdPic = std([pic1(find(~isnan(pic1))); pic2(find(~isnan(pic2)))])
        % range =meanPic+ stdPic*[-1 3];
        range =[ min(min(pic1(:)), min(pic2(:))) max(max(pic1(:)), max(pic2(:))) ]; % change made by ilan 09/02/2010 17:47
        subplot(Nvert, Nhor, j); imagesc(pic1, range);axis image; axis off;
        j=j+1;
        title([num2str(i) ' of ' num2str(length(fnames)) ' ' ScanParam.ScanType])
    else
        figure(gcf);
        pause;
        j=1;
    end;
end;

%%  Load single picture
picNum = 86;
picName = fnames(picNum).name
load([fpath picName]);
ScanParam
[Pict1, Norm1, Pict2, Norm2, PixSize, LineScaleV, Counts] = ReconstructImage_v4(AI, Cnt, 1, ScanParam);
pic1 = Pict1./Norm1;pic2 = Pict2./Norm2;
 meanPic = mean([pic1(find(~isnan(pic1))); pic2(find(~isnan(pic2)))])
stdPic = std([pic1(find(~isnan(pic1))); pic2(find(~isnan(pic2)))])
% range =meanPic+ stdPic*[-1 3];
range =[ min(min(pic1(:)), min(pic2(:))) max(max(pic1(:)), max(pic2(:))) ]; % change made by ilan 09/02/2010 17:47
subplot(1, 2, 1); imagesc(pic1, range);axis image; axis off;  subplot(1, 2, 2); imagesc(pic2, range);axis image; axis off; colorbar; figure(gcf);

%% FCS file
FCSname ={ 's_221_c_corr_6' };
S = LoadMultipleCorrFunc_v2(fpath,  FCSname, 'Rejection',100, 'NormalizationRange', NormRange,  'DeleteList', [] );
Nruns = size(S.CF_CR, 2);

%% Analyze trace
Tr = S.trace(:);
Tr = Tr(find(Tr>0));
t_Tr = (1:length(Tr))'*0.105;
 betaTr = nlinfit(t_Tr, Tr, @BleachingCellFit, [max(Tr)*0.8 10 max(Tr)*0.2 100]);
 semilogy(t_Tr, Tr, t_Tr, BleachingCellFit(betaTr, t_Tr));
 figure(gcf);
 betaTr
 %pause;
 betaTr2Exp = nlinfit(t_Tr, Tr, @TwoExponentFit, [max(Tr)*0.8 10 max(Tr)*0.2 100]);
 semilogy(t_Tr, Tr, t_Tr, TwoExponentFit(betaTr2Exp, t_Tr));
 figure(gcf);
 betaTr2Exp 
S.betaTr = betaTr;
S.betaTr2Exp= betaTr2Exp;
%% subtract photobleaching from individual files
%clear betaCF1;
Nruns = size(S.CF_CR,2)
for i = 1:Nruns,
 
 %   figure(fig1);
  %  semilogx(S.lag, S.CF_CR(:, i)); title(['count rate per molecule = ' num2str(S.G0_good(i))]);
  %  axis([0.01 1000 0 2*S.G0_good(i)])
  %  figure(fig2)
  %  plot(S.trace(:, i)); title(['total count rate = ' num2str(S.CR(i))]);
   % pause;
   figure(fig1);
   S1=S;
   
   tr = (S.trace(:, i));
   J = find(tr > 0);
   tr = tr(J);
   ttr = (1:length(tr))'*104.8576;
   p = polyfit(ttr, tr, 1);
   
   tr1 = polyval(p, ttr);
   
   ctr = xcorr(tr1, 'unbiased');
   ctr = ctr(length(tr) :length(ctr)); 
   tctr = (0:(length(ctr)-1))*104.8576;
   ctr = (ctr/mean(tr)^2-1)*S.CR(i);
   title(num2str(i));
   J1 = find(tctr > 1000);
   S1.CF_CR(:, i) = S.CF_CR(:, i) - interp1(tctr(J1), ctr(J1), S1.lag, 'linear',  'extrap');
   semilogx(S1.lag, [S.CF_CR(:, i) S1.CF_CR(:, i)], tctr, ctr, S1.lag, interp1(tctr(J1), ctr(J1), S1.lag, 'linear',  'extrap'));
   axis([0.04 1000 -1000 3000])
   title(num2str(i))
end;
semilogx(S1.lag, S1.CF_CR);
figure(gcf)

%%  Fit each correlation function after  subtracting the trend from trace and plot corresponding PCH
clear betaCF2comp;
Nruns=size(S.CF_CR, 2);
clear N_fcs q_fcs; %  N_pch  q_pch betaFIDA
c1 = [] 
figure(fig1);
FitRange = [0.01 1000];
h = annotation(gcf, 'textbox','String',{''}, 'Position',[ 0.3738    0.8474    0.0694    0.0375], 'EdgeColor', 'none');
S2 = S1; % choose either photobleaching subtracted or original data
cleaningStrategy =2;

for i = 1:Nruns,
    i
 %   figure(fig1);
  %  semilogx(S.lag, S.CF_CR(:, i)); title(['count rate per molecule = ' num2str(S.G0_good(i))]);
  %  axis([0.01 1000 0 2*S.G0_good(i)])
  %  figure(fig2)
  %  plot(S.trace(:, i)); title(['total count rate = ' num2str(S.CR(i))]);
   % pause;
  
  % S1.AverageCF_CR = S1.CF_CR(:, i);
   J = find((S2.lag > FitRange(1) )&(S2.lag < FitRange(2)));
   
   beta =nlinfitWeight1(S2.lag(J), S2.CF_CR(J, i), @Diffusion2DTwoComp,  [1500 0.5 2000 40], S2.errorCF_CR(J));
   %subplot(1, 2, 1);
   %beta = PlotFitCF(S1, [0.01 1000], @Diffusion2DTwoComp, [1500 0.5 2000 40]);
   semilogx(S2.lag(J), [S2.CF_CR(J, i) Diffusion2DTwoComp(beta, S2.lag(J))]);

   set(gca, 'Position', [ 0.0533    0.0960    0.4113    0.8290]);
 %  axis([0.04 1000 -1000 3000])
  title([num2str(i) ':' ]);
  
  set(h, 'String', {num2str(beta)});
  
   figure(gcf);
   betaCF2comp(:, i) = beta; %beta.beta(:, 1);
end;
S.betaCF2comp= betaCF2comp;
S.CF_CRcorrected = S1.CF_CR;

%% Put data into a named structure
eval([FCSname{1} '= S;']);

%% save data
save([fpath 'process290110']);


%clear
close all
NormRange = [1e-2 3e-2];
fpath = 'F:\Ilan\Experiment\290110\'
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
FCSname ={ 's_M1_80_2mkW_a__corr_8' };
S = LoadMultipleCorrFunc_v3(fpath,  FCSname, 'Rejection',100, 'NormalizationRange', NormRange,  'DeleteList', [] );
Nruns = size(S.CF_CR, 2);

%%  PCH file
PCHname =  's_M1_80_2mkW_a__pch_8'
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

%% Analyze trace
Tr = S.trace(:);
Tr = Tr(find(Tr>0));
t_Tr = (1:length(Tr))'*0.105;
 betaTr = nlinfit(t_Tr, Tr, @BleachingCellFit, [max(Tr)*0.8 10 max(Tr)*0.2 100]);
 semilogy(t_Tr, Tr, t_Tr, BleachingCellFit(betaTr, t_Tr));
 figure(gcf);
 betaTr
 pause;
 betaTr2Exp = nlinfit(t_Tr, Tr, @TwoExponentFit, [max(Tr)*0.8 10 max(Tr)*0.2 100]);
 semilogy(t_Tr, Tr, t_Tr, TwoExponentFit(betaTr2Exp, t_Tr));
 figure(gcf);
 betaTr2Exp

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
S2 = S; % choose either photobleaching subtracted or original data
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
        j2 = unique([j1- 2 j1- 1 j1 j1+1 j1+2]);
        j2 = j2(find(j2>0));
    end;
    
    if cleaningStrategy ==2, 
        span =1500;
     	% cleaning the trace by iterating each 5000 points
        [temp, Jmin] = min(P(ccut+1));
        Jran = Jmin;
        while Jran > 1,
            Jran = Jran - 5000;
            stretch = max(Jran-span, 1):min(Jran+span, length(ccut));
            [temp, jmin] = min(P(ccut(stretch)+1));
            Jmin = [Jmin (min(stretch) - 1 + jmin)];
            Jran = (min(stretch) - 1 + jmin);
        end;
        
        Jran = Jmin;
        while Jran < length(ccut),
            Jran = Jran + 5000;
            stretch = max(Jran-span, 1):min(Jran+span, length(ccut));
            [temp, jmin] = min(P(ccut(stretch)+1));
            Jmin = [Jmin (min(stretch) - 1 + jmin)];
            Jran = (min(stretch) - 1 + jmin);
        end;
        
        j1  = Jmin;
        j2 = unique([j1-3 j1-2 j1-1 j1 j1+1 j1+2 j1+3]);
        j2 = j2(find(j2>0));
    end;
    
    figure(fig2);
    plot(1:length(ccut), ccut, j2, ccut(j2), 'r'); figure(gcf);
%    pause;
    ccut(j2) = [];
    plot(ccut);
    figure(fig2);
%    pause;
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
    P = P(n+1);
   
   figure(fig1); 
%     semilogy(n, Pexp,'o',  n, P);
%     title(i);
%     figure(gcf);
%     pause;
 % betaFIDA(i,:) = nlinfit(n, Pexp, @FIDAsimple_fit, [N_fcs(i) q_fcs(i)]);
  semilogy(n, Pexp, 'o', n, P)
 % semilogy(n, Pexp, 'o', n, P, n, FIDAsimple_v2(n, betaFIDA(i, 1),  betaFIDA(i, 2)))
  title(i)  
   figure(fig1);
  pause;
   %close all;
end;

%% Inspect c1 and remove leftovers
figure(fig2);
plot(c1);
title('Zoom into a bad part');
pause;
J1 = InAxes;
r = input('Remove points? (Y/N) ', 's');
if r== 'Y',
    c1(J1) = [];
end;
figure(fig2)
plot(c1);

%% FIMDA - prepare array
clear N_fcs q_fcs  N_pch  q_pch betaCF Pexp fimda betaFIMDA
Nruns=size(S.CF_CR, 2);
coarsegrain = round(2.^(1:7)+1);
dt1 = dt*[1 coarsegrain];

fimda(1).c = c1;

for j=1:length(coarsegrain),
    fimda(j+1).c = smooth(c1, coarsegrain(j))*coarsegrain(j);
end;
coarsegrain = [1 coarsegrain];
%% 
clear Pexp n
bins =50;

for i = 2:2%Nruns,
        N_fcs(i) = S.CR(i)/S.G0_good(i);
        q_fcs(i) = S.G0_good(i)*dt;
        figure(fig2);
        for j = 1:length(coarsegrain),
            j
            len1 = length(fimda(j).c);
            ccut2 = fimda(j).c(round(((i-1)*len1/Nruns +1):(i*len1/Nruns)));
            maxn = max(ccut2);
            minn = min(ccut2);
            step = ceil((maxn-minn)/bins)
            n(:, j) = minn + (0:49)'*step;
            hc = hist(ccut2, n(:, j));
            Pexp(:, j) = hc'/sum(hc)/step;
        end;
        semilogy(n, Pexp, 'o'); figure(gcf)
        pause;
   % Fits

    for j = 1:length(dt1),
        j
        J = find(Pexp(:, j) > 0);
        J = min(J):max(J);
        if j==1,
            startBeta = [N_fcs(i)/2 q_fcs(i)*0.5  N_fcs(i)/2 q_fcs(i)*2];
        else 
            startBeta =  betaFIMDA(j-1, :)
            startBeta(2) = startBeta(2)*dt1(j)/dt1(j-1);
            startBeta(4) = startBeta(4)*dt1(j)/dt1(j-1);
        end;
        betaFIMDA(j, :) = nlinfit(n(J, j)', Pexp(J, j)', @FIDAsimple2comp_fit, startBeta);
        semilogy(n(J, j), Pexp(J, j), 'o', n(J, j), FIDAsimple2comp_fit(betaFIMDA(j, :), n(J, j)));   
       figure(gcf)
        pause;
%         betaFIMDA(j, :) = nlinfit(n(J), Pexp(J, j)', @FIDAsimple_fit, [N_fcs(i) q_fcs(i)*dt1(j)/dt]);
%         semilogy(n(J), Pexp(J, j), 'o', n(J), FIDAsimple_fit(betaFIMDA(j, :), n(J)));   
%        figure(gcf)
%         pause;
    end;
    
end;%Nrun


%%
betaCF2comp'
  %% Calculate brightnesses
bulk_bleach_time = betaTr2Exp(4);
I_bulk0 = betaTr2Exp(3);
surf_bleach_time = betaTr2Exp(2);
I_surf0 = betaTr2Exp(1);

A_bulk = betaCF2comp(1, :);
tauDiff_bulk0 = betaCF2comp(2, :);
A_surf = betaCF2comp(3, :);
tauDiff_surf= betaCF2comp(4, :);

tempTr = S.trace(:, 1);
T = length(find(tempTr>0))*0.105;
t_Tr1= (0.5:Nruns)*T;

I_bulk  = I_bulk0 *exp(-t_Tr1/bulk_bleach_time);
I_surf  = I_surf0 *exp(-t_Tr1/surf_bleach_time);

q_bulk  = A_bulk .* (I_bulk+I_surf)./I_bulk;
q_surf  = A_surf .* (I_bulk+I_surf)./I_surf;

plot(1:Nruns, [q_surf./q_bulk; betaTr2Exp(3)/betaTr2Exp(1)*exp(-t*(1/betaTr2Exp(4) - 1/betaTr2Exp(2))) ./(betaCF2comp(1, :)./betaCF2comp(3, :))], 'o'); figure(gcf)
plot(1:Nruns, [q_surf; q_bulk], 'o'); figure(gcf)
%betaTr2Exp(3)/betaTr2Exp(1)*exp(-t*(1/betaTr2Exp(4) - 1/betaTr2Exp(2))) ./(betaCF2comp(1, :)./betaCF2comp(3, :)),

%%  clean up and 
clear N_fcs q_fcs  N_pch  q_pch betaFIDA
Nruns=size(S.CF_CR, 2);
c1 = []
for i = 1:Nruns,
 %   figure(fig1);
  %  semilogx(S.lag, S.CF_CR(:, i)); title(['count rate per molecule = ' num2str(S.G0_good(i))]);
  %  axis([0.01 1000 0 2*S.G0_good(i)])
  %  figure(fig2)
  %  plot(S.trace(:, i)); title(['total count rate = ' num2str(S.CR(i))]);
   % pause;
    ccut = c(round(((i-1)*len/Nruns +1):(i*len/Nruns)));
%   figure(fig1); plot(ccut);
 %   title('Choose min/max ranges')
    n = 0:max(ccut);
    hc = hist(ccut, n);
  %  figure(fig2); plot(n, hc);
   % title('Choose min/max ranges')
  %  pause;   
    
    N_fcs(i) = S.CR(i)/S.G0_good(i);
    q_fcs(i) = S.G0_good(i)*dt;
    
    N_fcs(i)
    q_fcs(i)
    
    P = FIDAsimple_v2(n, N_fcs(i),  q_fcs(i));
    J = find( P*sum(hc) > 0.01 );
    n = n(J);
    P = P(J);
    minn = min(n);
    maxn = max(n);
    J = find((ccut<= maxn) & (ccut >= minn));
    ccut = ccut(J);
    
    c1 = [c1; ccut];
    hc = hist(ccut, n);
    Pexp = hc/sum(hc);
   
    
%     semilogy(n, Pexp,'o',  n, P);
%     title(i);
%     figure(gcf);
%     pause;
  betaFIDA(i,:) = nlinfit(n, Pexp, @FIDAsimple_fit, [N_fcs(i) q_fcs(i)]);
  figure(fig1);
  %semilogy(n, Pexp, 'o', n, [P; P2D; P3D])
  semilogy(n, Pexp, 'o', n, P, n, FIDAsimple_v2(n, betaFIDA(i, 1),  betaFIDA(i, 2)))
  title(i)  
  % semilogy(n, Pexp, 'o', n, FIDAsimple_fit(beta, n));
  pause;
end;

S.betaFIDA = betaFIDA;
S.N_fcs = N_fcs;
S.q_fcs = q_fcs;
S.c1 = c1;
%% try coarse graining
clear N_fcs q_fcs  N_pch  q_pch betaCF betaFIDA
Nruns=size(S.CF_CR, 2);
coarsegrain = 3;
dt1 = dt*coarsegrain;
for i = 3:3%Nruns,
 %   figure(fig1);
  %  semilogx(S.lag, S.CF_CR(:, i)); title(['count rate per molecule = ' num2str(S.G0_good(i))]);
  %  axis([0.01 1000 0 2*S.G0_good(i)])
  %  figure(fig2)
  %  plot(S.trace(:, i)); title(['total count rate = ' num2str(S.CR(i))]);
   % pause;
   figure(fig1);
   S1=S;
   S1.AverageCF_CR = S.CF_CR(:, i);
   betaCF(i) = PlotFitCF(S1, [0.04 1000], @Diffusion2DTwoComp, [1500 0.5 2000 40]);
   betaCF(i)
   
   
    ccut = c(round(((i-1)*len/Nruns +1):(i*len/Nruns)));
   
    % removing outliers
    n = 0:max(ccut);
    hc = hist(ccut, n);
  %  figure(fig2); plot(n, hc);
   % title('Choose min/max ranges')
  %  pause;   
    
    N_fcs(i) = S.CR(i)/S.G0_good(i);
    q_fcs(i) = S.G0_good(i)*dt;
    
    
    
    P = FIDAsimple_v2(n, N_fcs(i),  q_fcs(i));
    n = n(find( P*sum(hc) > 0.1 )); 
    minn = min(n);
    maxn = max(n);
    J = find((ccut<= maxn) & (ccut >= minn));
    ccut = ccut(J);
   % end removing outliers 
    
    L1 = floor(size(ccut, 1)/coarsegrain)
    ccut1 = reshape(ccut(1:(L1*coarsegrain)), coarsegrain, L1);
    ccut2 = sum(ccut1, 1);
  
    n = 0:max(ccut2);
    hc = hist(ccut2, n);
    Pexp = hc/sum(hc);

    'Number of molecules'
    [ S.CR(i)/S.G0_good(i)      mean(ccut)^2/(var(ccut) - mean(ccut))] 
    
    N_fcs(i) = S.CR(i)/S.G0_good(i);
    q_fcs(i) = S.G0_good(i)*dt1;
    
    N_fcs(i)
    q_fcs(i)
   % beta = nlinfit(n, Pexp, @FIDAsimple_fit, [N_fcs(i) q_fcs(i)]);
    
 %   N_pch(i)  = beta(1)
  %  q_pch(i) = beta(2)
    P = FIDAsimple_v2(n, N_fcs(i),  q_fcs(i));
    betaFIDA(:,i) = nlinfit(n, Pexp, @FIDAsimple_fit, [N_fcs(i) q_fcs(i)]);
   %P2D = FIDAfun2D_v2(n, N_fcs(i),  q_fcs(i)*2);
   'past 2D'
  %P3D = FIDAfun3D_v2(n, N_fcs(i),  q_fcs(i)*2^(3/2));
  figure(fig1);
  %semilogy(n, Pexp, 'o', n, [P; P2D; P3D])
  semilogy(n, Pexp, 'o', n, FIDAsimple_v2(n, betaFIDA(i, 1),  betaFIDA(i, 2)))
  title(i)  
  % semilogy(n, Pexp, 'o', n, FIDAsimple_fit(beta, n));
end;

%%
clear betaCF;
for i = 4:4%Nruns,
    i
 %   figure(fig1);
  %  semilogx(S.lag, S.CF_CR(:, i)); title(['count rate per molecule = ' num2str(S.G0_good(i))]);
  %  axis([0.01 1000 0 2*S.G0_good(i)])
  %  figure(fig2)
  %  plot(S.trace(:, i)); title(['total count rate = ' num2str(S.CR(i))]);
   % pause;
   figure(fig1);
   S1=S;
   S1.AverageCF_CR = S.CF_CR(:, i);
   beta = PlotFitCF(S1, [0.04 1000], @Diffusion2DTwoComp, [1500 0.5 2000 40]);
   axis([0.04 1000 -200 2000])
   betaCF(:, i) = beta.beta(:, 1);
   %close all;
end;
%%
f = sqrt(2);
q2 = betaCF(1, :)/f + betaCF(3, :);
N1 = betaCF(1, :).*S.CR./(f^2*q2.^2);
N2 = betaCF(3, :).*S.CR./(q2.^2);

%% All runs
% exclude first
js = 30;
je = 59;
len = length(c1);
   ccut = c1(round(((js-1)*len/Nruns +1):(je*len/Nruns)));
%   figure(fig1); plot(ccut);
 %   title('Choose min/max ranges')
    n = 0:max(ccut);
    hc = hist(ccut, n);
  %  figure(fig2); plot(n, hc);
   % title('Choose min/max ranges')
  %  pause;   
  Pexp = hc/sum(hc);

    N_fcsA= mean(S.CR(js:je)./S.G0_good(js:je));
    q_fcsA = mean(S.G0_good(js:je))*dt
   
    P = FIDAsimple_v2(n, N_fcsA,  q_fcsA);
    semilogy(n, Pexp, 'o', n, P)
    figure(gcf)
    pause;
    %fit with two components
     betaPCH2comp = nlinfit(n, Pexp, @FIDAsimple2comp_fit, [N_fcsA/4 q_fcsA*2 N_fcsA/2 q_fcsA/2]);
     semilogy(n, Pexp, 'o', n, FIDAsimple2comp_fit(betaPCH2comp, n));   
     figure(gcf)
    
    
%%
    n = n(find( P*sum(hc) > 0.1 )); 
    minn = min(n);
    maxn = max(n);
    J = find((ccut<= maxn) & (ccut >= minn));
    ccut = ccut(J);
    
    hc = hist(ccut, n);
    Pexp = hc/sum(hc);
    
   % beta = nlinfit(n, Pexp, @FIDAsimple_fit, [N_fcs(i) q_fcs(i)]);
    
 %   N_pch(i)  = beta(1)
  %  q_pch(i) = beta(2)
    P = FIDAsimple_v2(n, N_fcsA,  q_fcsA);
    'past stats'
   %P2D = FIDAfun2D_v2(n, N_fcs(i),  q_fcs(i)*2);
   'past 2D'
  %P3D = FIDAfun3D_v2(n, N_fcs(i),  q_fcs(i)*2^(3/2));
  figure(fig1);
  %semilogy(n, Pexp, 'o', n, [P; P2D; P3D])
  semilogy(n, Pexp, 'o', n, P)

  
  % semilogy(n, Pexp, 'o', n, FIDAsimple_fit(beta, n));
%% 
%% try coarse graining - FIMDA
clear N_fcs q_fcs  N_pch  q_pch betaCF Pexp beta
Nruns=size(S.CF_CR, 2);
coarsegrain = round(2.^(1:7));
dt1 = dt*[1 coarsegrain];

for i = 30:30%Nruns,
    %    figure(fig1);
%    S1=S;
%    S1.AverageCF_CR = S.CF_CR(:, i);
%    betaCF(i) = PlotFitCF(S1, [0.04 1000], @Diffusion2DTwoComp, [1500 0.5 2000 40]);
%    betaCF(i)
    
    ccut = c(round(((i-1)*len/Nruns +1):(i*len/Nruns)));
   
    % removing outliers
    n = 0:max(ccut);
    hc = hist(ccut, n);
  %  figure(fig2); plot(n, hc);
   % title('Choose min/max ranges')
  %  pause;  
    N_fcs(i) = S.CR(i)/S.G0_good(i);
    q_fcs(i) = S.G0_good(i)*dt;
    P = FIDAsimple_v2(n, N_fcs(i),  q_fcs(i));
    n = n(find( P*sum(hc) > 0.1 )); 
    minn = min(n);
    maxn = max(n);
    J = find((ccut<= maxn) & (ccut >= minn));
    ccut = ccut(J);
   % end removing outliers 
   
   % find likely max n after all of the coarsening
  L1 = floor(size(ccut, 1)/max(coarsegrain))
   ccut1 = reshape(ccut(1:(L1*max(coarsegrain))), max(coarsegrain), L1);
   ccut2 = sum(ccut1, 1);
   maxn = max(ccut2);
   n = minn:maxn;
   
   hc = hist(ccut, n);
   Pexp(:, 1) = hc'/sum(hc);
   
   for j = 1:length(coarsegrain)
       j
        L1 = floor(size(ccut, 1)/coarsegrain(j))
        ccut1 = reshape(ccut(1:(L1*coarsegrain(j))), coarsegrain(j), L1);
        ccut2 = sum(ccut1, 1);
        hc = hist(ccut2, n);
        Pexp(:, j+1) = hc'/sum(hc);
   end;
   semilogy(n, Pexp, 'o'); figure(gcf)
   pause;
   % Fits

    for j = 1:length(dt1),
        J = find(Pexp(:, j) > 0);
        J = min(J):max(J);
        beta(j, :) = nlinfit(n(J), Pexp(J, j)', @FIDAsimple_fit, [N_fcs(i) q_fcs(i)*dt1(j)/dt]);
        semilogy(n(J), Pexp(J, j), 'o', n(J), FIDAsimple_fit(beta(j, :), n(J)));   
       figure(gcf)
        pause;
    end;
    
end;%Nrun
%%
for j=1: length(dt1),
        N(j) = beta(j, 1);
        q(j) = beta(j, 2);
 end;

 plot(dt1, (q./dt1).^(-1), 'o'); figure(gcf);

%



%% FIMDA all runs simultaneously
clear N_fcs q_fcs  N_pch  q_pch betaCF Pexp beta
Nruns=size(S.CF_CR, 2);
coarsegrain = round(2.^(1:10));
dt1 = dt*[1 coarsegrain];

js = 30;
je = 59;
len = length(c1);
 ccut = c1(round(((js-1)*len/Nruns +1):(je*len/Nruns)));
   
%   figure(fig1); plot(ccut);
 %   title('Choose min/max ranges')
    n = 0:max(ccut);
    hc = hist(ccut, n);
  %  figure(fig2); plot(n, hc);
   % title('Choose min/max ranges')
  %  pause;   
  

%     N_fcsA= S.countrateGood/S.G0
%     q_fcsA = S.G0*dt
%    
%    P = FIDAsimple_v2(n, N_fcsA,  q_fcsA);
%     
% 
%     n = n(find( P*sum(hc) > 0.01 )); 
%     minn = 0%min(n);
%     maxn = 30%max(n);
%     J = find((ccut<= maxn) & (ccut >= minn));
%     ccut = ccut(J);
    
     % find likely max n after all of the coarsening
  L1 = floor(size(ccut, 1)/max(coarsegrain))
   ccut1 = reshape(ccut(1:(L1*max(coarsegrain))), max(coarsegrain), L1);
   ccut2 = sum(ccut1, 1);
   maxn = max(ccut2);
   n = minn:maxn;
   
   hc = hist(ccut, n);
   Pexp(:, 1) = hc'/sum(hc);
   
   for j = 1:length(coarsegrain)
       j
        L1 = floor(size(ccut, 1)/coarsegrain(j))
        ccut1 = reshape(ccut(1:(L1*coarsegrain(j))), coarsegrain(j), L1);
        ccut2 = sum(ccut1, 1);
        plot(ccut2);
        figure(gcf);
        pause;
        hc = hist(ccut2, n);
        Pexp(:, j+1) = hc'/sum(hc);
   end;
   semilogy(n, Pexp, 'o'); figure(gcf)
  ;

%% Fits

    for j = 1:length(dt1),
        semilogy(n, Pexp(:, j), 'o');
        title('Zoom into fitting region')
        figure(gcf);
        pause;
        J = InAxes;
    %     beta(j, :) = nlinfit(n(J), Pexp(J, j)', @FIDAsimple2comp_fit, [N_fcsA/3 2*q_fcsA*dt1(j)/dt N_fcsA/3 q_fcsA*dt1(j)/dt/3]);
        betaFIMDA(j, :) = nlinfit(n(J), Pexp(J, j)', @FIDAsimple2comp_fit, [0.2 0.8*dt1(j)/dt 10 0.1*dt1(j)/dt/3]);
        semilogy(n(J), Pexp(J, j), 'o', n(J), FIDAsimple2comp_fit(betaFIMDA(j, :), n(J)));   
       figure(gcf)
        pause;
    end;
%% plot
s1 = size(betaFIMDA, 1);
plot(dt1(1:s1), betaFIMDA(1, 2)./(betaFIMDA(:, 2)./dt1(1:s1)'), 'o',  dt1(1:s1), betaFIMDA(1, 4)./(betaFIMDA(:, 4)./dt1(1:s1)'), 'o'); figure(gcf)
pause;
plot(dt1(1:s1), betaFIMDA(:, 1).*(betaFIMDA(:, 2)./dt1(1:s1)'), 'o',  dt1(1:s1), betaFIMDA(:, 3).*(betaFIMDA(:, 4)./dt1(1:s1)'), 'o'); figure(gcf)
G2 = (betaFIMDA(:, 4)./dt1(1:s1)')./betaFIMDA(1, 4)*dt;
betaG2 = nlinfit(dt1([1 3:s1])', G2([1 3:s1]), @FIMDAfit, [1 1e-3 1])
plot(dt1(1:s1), G2, 'o', dt1(1:s1), FIMDAfit(betaG2, dt1(1:s1))); figure(gcf)
pause;
G1 = (betaFIMDA(:, 2)./dt1(1:s1)')./betaFIMDA(1, 2)*dt;
betaG1 = nlinfit(dt1([1 3:s1])', G1([1 3:s1]), @FIMDAfit, [1 50e-3 1])
plot(dt1(1:s1), G1, 'o', dt1(1:s1), FIMDAfit(betaG1, dt1(1:s1))); figure(gcf)

%%  Fit each correlation function while subtracting the trend from trace
clear betaCF2comp;
for i = 1:Nruns,
    i
 %   figure(fig1);
  %  semilogx(S.lag, S.CF_CR(:, i)); title(['count rate per molecule = ' num2str(S.G0_good(i))]);
  %  axis([0.01 1000 0 2*S.G0_good(i)])
  %  figure(fig2)
  %  plot(S.trace(:, i)); title(['total count rate = ' num2str(S.CR(i))]);
   % pause;
   figure(fig1);
   S1=S;
   S1.AverageCF_CR = S.CF_CR(:, i);
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
   semilogx(S1.lag, S1.AverageCF_CR, tctr, ctr, S1.lag, interp1(tctr(J1), ctr(J1), S1.lag, 'linear',  'extrap'));
   axis([0.04 1000 -1000 3000])
  pause;
   
 
   S1.AverageCF_CR = S1.AverageCF_CR - interp1(tctr(J1), ctr(J1), S1.lag, 'linear',  'extrap');
   
   beta = PlotFitCF(S1, [0.04 1000], @Diffusion2DTwoComp, [1500 0.5 2000 40]);
 
   axis([0.04 1000 -1000 3000])
   title(num2str(i));
   figure(gcf);
%   pause;
   betaCF2comp(:, i) = beta.beta(:, 1);
   %close all;
end;
    
%% Fit with one component after subtracting photobleaching
%  Fit each correlation function while subtracting the trend from trace
clear betaCF2;
for i = 1:Nruns,
    i
 %   figure(fig1);
  %  semilogx(S.lag, S.CF_CR(:, i)); title(['count rate per molecule = ' num2str(S.G0_good(i))]);
  %  axis([0.01 1000 0 2*S.G0_good(i)])
  %  figure(fig2)
  %  plot(S.trace(:, i)); title(['total count rate = ' num2str(S.CR(i))]);
   % pause;
   figure(fig1);
   S1=S;
   S1.AverageCF_CR = S.CF_CR(:, i);
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
   semilogx(S1.lag, S1.AverageCF_CR, tctr, ctr, S1.lag, interp1(tctr(J1), ctr(J1), S1.lag, 'linear',  'extrap'));
   axis([0.04 1000 -1000 3000])
  pause;
   
 
   S1.AverageCF_CR = S1.AverageCF_CR - interp1(tctr(J1), ctr(J1), S1.lag, 'linear',  'extrap');
   
   beta = PlotFitCF(S1, [0.04 1000], @Diffusion3D, [1500 0.5 40]);
 
   axis([0.04 1000 -1000 3000])
   title(num2str(i));
   figure(gcf);
   pause;
   betaCF2(:, i) = beta.beta(:, 1);
   %close all;
end;

%% subtract photobleaching from individual files
clear betaCF1;
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

%% Fit mean
semilogx(S1.lag,mean(S1.CF_CR, 2)); figure(gcf)
axis([1e-2 2000 -500 2500])
title('zoom into ROI')
pause;
J = InAxes;
 betaMean = nlinfitWeight(S1.lag(J), mean(S1.CF_CR(J, :), 2), @Diffusion2DTwoComp, [1000 1 1000 100], S1.errorCF_CR(J));
semilogx(S1.lag,mean(S1.CF_CR, 2), S1.lag, Diffusion2DTwoComp(betaMean, S1.lag)); figure(gcf)

%% Fit median
semilogx(S1.lag,median(S1.CF_CR, 2)); figure(gcf)
axis([1e-2 2000 -500 2500])
title('zoom into ROI')
pause;
J = InAxes;
 betaMedian = nlinfitWeight(S1.lag(J), median(S1.CF_CR(J, :), 2), @Diffusion2DTwoComp, [1000 1 1000 100], S1.errorCF_CR(J));
semilogx(S1.lag,median(S1.CF_CR, 2), S1.lag, Diffusion2DTwoComp(betaMedian, S1.lag)); figure(gcf)

%% Take median of first 20 runs
S1.Median1 = median(S1.CF_CR(:, 1:20), 2);
semilogx(S1.lag,S1.Median1); figure(gcf)
axis([1e-2 2000 -500 2500])
title('zoom into ROI')
pause;
J = InAxes;

 betaMedian1 = nlinfitWeight(S1.lag(J), S1.Median1(J), @Diffusion2DTwoComp, [1000 1 1000 100], std(S1.CF_CR(J, 1:20),0, 2));
semilogx(S1.lag,S1.Median1, S1.lag, Diffusion2DTwoComp(betaMedian1, S1.lag)); figure(gcf)
%% Take median of the last 20 runs
S1.Median2 = median(S1.CF_CR(:, 41:size(S1.CF_CR, 2)), 2);
semilogx(S1.lag,S1.Median2); figure(gcf)
axis([1e-2 2000 -500 2500])
title('zoom into ROI')
pause;
J = InAxes;

 betaMedian2 = nlinfitWeight(S1.lag(J), S1.Median2(J), @Diffusion2DTwoComp, [1000 1 1000 100], std(S1.CF_CR(J, 40:size(S1.CF_CR, 2)),0, 2));
semilogx(S1.lag,S1.Median2, S1.lag, Diffusion2DTwoComp(betaMedian2, S1.lag)); figure(gcf)
%% 
CR1 = mean(S1.CR(1:20));
CR2 = mean(S1.CR(40:size(S1.CF_CR, 2)));

Detr = (betaMedian2(3).*betaMedian1(1) -  betaMedian1(3).*betaMedian2(1));
q1= Detr/(betaMedian2(3) - betaMedian1(3))
q2= Detr/(betaMedian1(1) - betaMedian2(1))

%%  Fit each correlation function after  subtracting the trend from trace
clear betaCF1;
for i = 1:Nruns,
    i
 %   figure(fig1);
  %  semilogx(S.lag, S.CF_CR(:, i)); title(['count rate per molecule = ' num2str(S.G0_good(i))]);
  %  axis([0.01 1000 0 2*S.G0_good(i)])
  %  figure(fig2)
  %  plot(S.trace(:, i)); title(['total count rate = ' num2str(S.CR(i))]);
   % pause;
   figure(fig1);
   S1.AverageCF_CR = S1.CF_CR(:, i);
   
   beta = PlotFitCF(S1, [0.01 1000], @Diffusion2DTwoComp, [1500 0.5 2000 40]);
 
   axis([0.04 1000 -1000 3000])
   title(num2str(i));
   figure(gcf);
   pause;
   betaCF1(:, i) = beta.beta(:, 1);
   %close all;
end;

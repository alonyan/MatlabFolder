

cd '/Users/Alonyan/Documents/MATLAB/OlegCytokineModeling/Modelling Pulsed Source/'
set(0, 'DefaultAxesFontSize', 14)
   Markersize = 4;
BigFontSize = 13;
AxisFontSize = 12;
TitleFontSize = 16;
%%
fpath = '/Users/Alonyan/Documents/MATLAB/OlegCytokineModeling/Modelling Pulsed Source/'
%save([fpath  'Process121216'],'-v7.3')
%%
load([fpath  'Process121216'])


   %%
   load('/Users/Alonyan/GoogleDrive/School/My Papers/Screening Paper/FiguresShort/DataCompactImaging.mat')
 %%  
   
    fname = 'ProdsBottom100';

%close all;
FitData = Data.(fname).Fit.FitData;

xtrueAll = cat(2, FitData.xtrue)
MassMeanAll = cat(2, FitData.MassMean)

[xtrueAll, I] = sort(xtrueAll);
MassMeanAll = MassMeanAll(I)

%semilogy(xtrueAll, MassMeanAll)
clear MassMeanAllHist MasserrHist xtrueerrHist
[h,x] = hist(xtrueAll,30);
h=[1 cumsum(h)];
for i=1:length(h)-1
MassMeanAllHist(i) = mean(MassMeanAll(h(i):h(i+1)))
MasserrHist(i) = std(MassMeanAll(h(i):h(i+1)),1)./sqrt(h(i+1)-h(i))
xtrueerrHist(i) = std(xtrueAll(h(i):h(i+1)),1)%./sqrt(h(i+1)-h(i)-1)
end
range1 = 1:21;
g = ploterr(x(range1),MassMeanAllHist(range1),[],MasserrHist(range1),'o','logy','abshhxy', .8)%,x*0.625, 1000*exp(-(x*0.625)/15))

set(g,'MarkerFaceColor', get(g(1),'color'),'MarkerEdgeColor',get(g(1),'color'), 'linewidth', 1.5,'markersize', Markersize);

hold all;

%% assume 5 min secretion at high rate 10*12 molec per second. Then nothing for 55 min
EC50 = 10; %in pM
R = 5; % cell radius in um
secretion_rate = 120; %molecules per sec
D = 100; % diffusion coeff um^2/s

J = 20%secretion_rate/(4*pi*R*D)*1e15/6e23/(EC50*1e-12);
L = 1000; %simulation space length in cell radia
x = linspace(1, L, 10000); %in cell radia
t1 = [1 10 60 60*(2:5)]; %time points in sec for presentation
t1ave = 30*(1:10); %time points in sec for averaging (every 30s)
%J = 1/600;

S1secr = TimeDependent3D_Cytokine_DiffusionOnly(t1*D/R^2, x, J)%to unitless time
S1ave = TimeDependent3D_Cytokine_DiffusionOnly(t1ave*D/R^2, x, J)%for averaging

Cstationary = J./S1secr.profiles.r*EC50; 


%% now assume 5-55 min of no secretion
t2 = [1 10 60 300*(1:11)]; %time points in sec for presentation
t2ave = 30*(1:110); %time points in sec for averaging (every 30s)
%J = 1/600;

S2secr = TimeDependent3D_Cytokine_DiffusionOnly(t2*D/R^2, x, 0, 'Initial Conditions', S1secr.profiles.C(:, end))%to unitless time
S2ave = TimeDependent3D_Cytokine_DiffusionOnly(t2ave*D/R^2, x, 0, 'Initial Conditions', S1secr.profiles.C(:, end))%for averaging


%%
SteadyState = SolveCytokineDistribution_3Da(15, 6.8, L,'Number of points', 1000)
%% averaging

%combine
Scomb = S1ave;
Scomb.profiles.t = [Scomb.profiles.t, Scomb.profiles.t(end)+S2ave.profiles.t];
Scomb.profiles.C = [Scomb.profiles.C, S2ave.profiles.C];
Scomb.profiles.response = [Scomb.profiles.response, S2ave.profiles.response];
Scomb.CF.G = [Scomb.CF.G, S2ave.CF.G];
Scomb.CF.Gresponse = [Scomb.CF.Gresponse, S2ave.CF.Gresponse];

for i = 1:(size(Scomb.profiles.response, 2)/20),
    Scomb.profiles.responseAve(:, i) = mean(Scomb.profiles.response(:, (20*(i-1)+1):(20*i)), 2);
    % calculate correlations
    x = Scomb.profiles.r;
    
    %for zero-padding for Fourier transform
    minx = min(x);
    dx = median(diff(x));
    xpad = ((dx/2):dx:minx)';
    ypad = zeros(size(xpad));
    Y.r = [xpad; Scomb.profiles.r];
    Y.fr = [ypad; Scomb.profiles.responseAve(:, i)];
    FY = FourierTransform(Y, '3D');
    FYsq.r = FY.q;
    FYsq.fr = abs(FY.fq).^2;
    CF = FourierTransform(FYsq, '3D');
        %S.CF.r = CF.q;
    Scomb.CF.GresponseAve(:, i) = CF.fq;
end

%% Fig1: plot everything for short pulses
%close all
fig1 = figure('Position',[360   278   510   660],'Color',[1 1 1]);

axes('Position',[0.1 0.83 0.8 0.22])

Im2A = imread('/Users/Alonyan/Documents/MATLAB/OlegCytokineModeling/Modelling Pulsed Source/Model1.tiff');


h= imshow(Im2A(:,:,1:3)); figure(gcf)

axes('Position', [0.1 0.65 0.2, 0.1545])
%concentration during pulse
%plotColor('semilogy', S1secr.profiles.r/2, S1secr.profiles.response); %convert x-scale to diameters
h = semilogy(S1secr.profiles.r/2, S1secr.profiles.response(:,3:end),SteadyState.r./2, SteadyState.response,'--k');
tzeva1 = makeColorMap([0 1 0],[0,0,1],length(h)-1);
for i=1:length(h)-1
    set(h(i),'color',tzeva1(i,:))
end
set(h,'linewidth', 1.5)
hold on
g = ploterr(x(range1),MassMeanAllHist(range1)./MassMeanAllHist(range1(1)),[],MasserrHist(range1)./MassMeanAllHist(range1(2)),'o','logy','abshhxy', .8)%,x*0.625, 1000*exp(-(x*0.625)/15))
set(g, 'color',[0.5, 0.5, 0.5])
set(g,'MarkerFaceColor', get(g(1),'color'),'MarkerEdgeColor',get(g(1),'color'), 'linewidth', 1.5,'markersize', Markersize);
uistack(h(end), 'top')
figure(gcf)
maxC = max(S1secr.profiles.response);
%text(4, 90, ['L = ' num2str(L)], 'FontSize', 14)
set(gca, 'YLim', [1/100 1], 'XLim', [0 40], 'FontSize', 12,'xtick',[1 10 20 30 40 50 60],'TickLength', [0.03 0.1]);
v = axis;
%hold on;
%h = semilogy(S.profiles.r/2, Cstationary(:), '-k');
%set(h, 'LineWidth', 2);
%hold off;
hleg = legend({'t = 01:00 min', 't = 02:00 min', ...
    't = 03:00 min',  't = 04:00 min',...
     't = 05:00 min'},'Fontsize', 10)
 legend boxoff;
 set(hleg,'Position',[0.75, 0.658, 0.1, 0.1])
title({'response profiles' 'during production'})
ylabel('Response (a.u.)', 'FontSize', 12)
xlabel('r (cell dia)', 'FontSize', 12)
axis(v);
%text(5, 15, 'A', 'FontSize', 16)




axes('Position', [0.45 0.65 0.2, 0.1545])
%concentrations during swithc off
h = semilogy( S2secr.profiles.r/2, S2secr.profiles.response(:, [1 3 4 5 9 14]),SteadyState.r./2, SteadyState.response,'--k'); %convert x-scale to diameters
tzeva2 = makeColorMap([0,0,1],[1,1,0],length(h)-1);
for i=1:length(h)-1
    set(h(i),'color',tzeva2(i,:))
end
set(h,'linewidth', 1.5)
hold on
g = ploterr(x(range1),MassMeanAllHist(range1)./MassMeanAllHist(range1(1)),[],MasserrHist(range1)./MassMeanAllHist(range1(2)),'o','logy','abshhxy', .8)%,x*0.625, 1000*exp(-(x*0.625)/15))
set(g, 'color',[0.5, 0.5, 0.5])
set(g,'MarkerFaceColor', get(g(1),'color'),'MarkerEdgeColor',get(g(1),'color'), 'linewidth', 1.5,'markersize', Markersize);
uistack(h(end), 'top')
figure(gcf)
maxC = max(S2secr.profiles.response);
%text(4, 90, ['L = ' num2str(L)], 'FontSize', 14)
set(gca, 'YLim', [1/100 1], 'XLim', [0 40], 'FontSize', 12,'xtick',[1 10 20 30 40 50 60],'TickLength', [0.03 0.1]);
%set(gca, 'FontSize', 12);

hleg = legend([h(2:7) ; g(1)], { 't = 06:00 min', 't = 10:00 min', ...
    't = 15:00 min', 't = 35:00 min',...
    't = 60:00 min' 'Diffusion-Consumption','Experimental data'},'Fontsize', 10);

legend boxoff;
 set(hleg,'Position',[0.793, 0.525, 0.1, 0.1])

title({'response profiles' 'after production'})
ylabel('response (a.u.)', 'FontSize', 12)
xlabel('r (cell dia)', 'FontSize', 12)
%text(50, 5, 'C', 'FontSize', 16);


axes('Position', [0.1 0.37 0.2, 0.1545])
% concentration correlations during pulse
% normalize G to unity
G = S1secr.CF.Gresponse./repmat(max(S1secr.CF.Gresponse), size(S1secr.CF.Gresponse, 1), 1);
%plotColor('semilogy', ); %convert x-scale to diameters
h = semilogy(S1secr.CF.r/2, G(:, 3:end),S3Stat.CF.r/2, S3Stat.CF.Gresponse(:,3)./max(S3Stat.CF.Gresponse(:,3)),'--k');
tzeva1 = makeColorMap([0 1 0],[0,0,1],length(h)-1);
for i=1:length(h)-1
    set(h(i),'color',tzeva1(i,:))
end
set(h,'linewidth', 1.5)
figure(gcf)
set(gca, 'YLim', [1/10 1],'xlim',[0, 40], 'FontSize', 12,'xtick',[1 10 20 30 40 50 60],'TickLength', [0.03 0.1]);
%text(4, 90, ['L = ' num2str(L)], 'FontSize', 14)
Rstationary = J./S1secr.profiles.r;
title({'response autocorrelations' 'during production'})
ylabel('G - autocorrelation', 'FontSize', 12)
xlabel('r (cell dia)', 'FontSize', 12)
%text(70, 0.5, 'B', 'FontSize', 16)

axes('Position', [0.45 0.37 0.2, 0.1545])
%concentration correlations during switch off
% normalize G to unity
G = S2secr.CF.Gresponse(:, [1 3 4 5 9 14])./repmat(max(S2secr.CF.Gresponse(:, [1 3 4 5 9 14])), size(S2secr.CF.Gresponse(:, [1:4 5 9 14]), 1), 1);
h = semilogy( S2secr.CF.r/2, G,S3Stat.CF.r/2, S3Stat.CF.Gresponse(:,3)./max(S3Stat.CF.Gresponse(:,3)),'--k'); %convert x-scale to diameters
%tzeva1 = makeColorMap([0,0,1],[1,0,0],length(h));
for i=1:length(h)-1
    set(h(i),'color',tzeva2(i,:))
end
set(h,'linewidth', 1.5)
figure(gcf)
set(gca, 'YLim', [1/10 1],'xlim',[0, 40], 'FontSize', 12,'xtick',[1 10 20 30 40 50 60],'TickLength', [0.03 0.1]);
%text(4, 90, ['L = ' num2str(L)], 'FontSize', 14)

title({'response autocorrelation' 'after production'})
ylabel('G - autocorrelation', 'FontSize', 12)
xlabel('r (cell dia)', 'FontSize', 12)


 a = annotation('textbox',[ 0.01 0.96    0.02    0.05],'string','A', 'Fontsize',TitleFontSize,'LineStyle','none')
 a = annotation('textbox',[ 0.01 0.83    0.02    0.05],'string','B', 'Fontsize',TitleFontSize,'LineStyle','none')
 a = annotation('textbox',[ 0.36 0.83    0.05    0.05],'string','C', 'Fontsize',TitleFontSize,'LineStyle','none')
 a = annotation('textbox',[ 0.01 0.55    0.05    0.05],'string','D', 'Fontsize',TitleFontSize,'LineStyle','none')  
 a = annotation('textbox',[ 0.36 0.55    0.05    0.05],'string','E', 'Fontsize',TitleFontSize,'LineStyle','none')  

 
%%
    set(gcf, 'PaperPositionMode','auto')

savpath = fpath;
        print(gcf,'-dpdf',[savpath ,'PulseSource']);


%% now to oscillating source
% assume 5 min secretion at  rate 10*2 molec per second. Then nothing for 5
% min and then repeated switches on and off

L = 1000; %simulation space length in cell radia
x = linspace(1, L, 10000); %in cell radia
%t1 = [1 10 60 60*(2:5)]; %time points in sec for presentation
t1ave = 30*(1:10); %time points in sec for averaging (every 30s)

t2ave = t1ave;

S1ave = TimeDependent3D_Cytokine_DiffusionOnly(t1ave*D/R^2, x, J)%for averaging
S2ave = TimeDependent3D_Cytokine_DiffusionOnly(t2ave*D/R^2, x, 0, 'Initial Conditions', S1ave.profiles.C(:, end))%for averaging
Cstationary = J./S1secr.profiles.r*EC50; 

Scomb = S1ave;
Scomb.profiles.t = [Scomb.profiles.t, Scomb.profiles.t(end)+S2ave.profiles.t];
Scomb.profiles.C = [Scomb.profiles.C, S2ave.profiles.C];
Scomb.profiles.response = [Scomb.profiles.response, S2ave.profiles.response];
Scomb.CF.G = [Scomb.CF.G, S2ave.CF.G];
Scomb.CF.Gresponse = [Scomb.CF.Gresponse, S2ave.CF.Gresponse];

% repeat 5 times
for i=1:5,
    i
    S1ave = TimeDependent3D_Cytokine_DiffusionOnly(t1ave*D/R^2, x, J, 'Initial Conditions', Scomb.profiles.C(:, end))%for averaging
    S2ave = TimeDependent3D_Cytokine_DiffusionOnly(t2ave*D/R^2, x, 0, 'Initial Conditions', S1ave.profiles.C(:, end))%for averaging
    Cstationary = J./S1secr.profiles.r*EC50; 
    
    Scomb.profiles.t = [Scomb.profiles.t, Scomb.profiles.t(end)+S1ave.profiles.t];
    Scomb.profiles.C = [Scomb.profiles.C, S1ave.profiles.C];
    Scomb.profiles.response = [Scomb.profiles.response, S1ave.profiles.response];
    Scomb.CF.G = [Scomb.CF.G, S1ave.CF.G];
    Scomb.CF.Gresponse = [Scomb.CF.Gresponse, S1ave.CF.Gresponse];

    
    Scomb.profiles.t = [Scomb.profiles.t, Scomb.profiles.t(end)+S2ave.profiles.t];
    Scomb.profiles.C = [Scomb.profiles.C, S2ave.profiles.C];
    Scomb.profiles.response = [Scomb.profiles.response, S2ave.profiles.response];
    Scomb.CF.G = [Scomb.CF.G, S2ave.CF.G];
    Scomb.CF.Gresponse = [Scomb.CF.Gresponse, S2ave.CF.Gresponse];
end;

%% averaging
Scomb.profiles.C_Ave = [];
Scomb.profiles.responseAve = [];
Scomb.CF.G_Ave = [];
Scomb.CF.GresponseAve = [];

steps = 20;
for i = 1:(size(Scomb.profiles.response, 2)/steps),
    Scomb.profiles.C_Ave(:, i) = mean(Scomb.profiles.C(:, (steps*(i-1)+1):(steps*i)), 2);
    Scomb.profiles.responseAve(:, i) = mean(Scomb.profiles.response(:, (steps*(i-1)+1):(steps*i)), 2);
    % calculate correlations
    x = Scomb.profiles.r;
    
    %for zero-padding for Fourier transform
    minx = min(x);
    dx = median(diff(x));
    xpad = ((dx/2):dx:minx)';
    ypad = zeros(size(xpad));
    Y.r = [xpad; Scomb.profiles.r];
    Y.fr = [ypad; Scomb.profiles.responseAve(:, i)];
    FY = FourierTransform(Y, '3D');
    FYsq.r = FY.q;
    FYsq.fr = abs(FY.fq).^2;
    CF = FourierTransform(FYsq, '3D');
        %S.CF.r = CF.q;
    Scomb.CF.GresponseAve(:, i) = CF.fq;
    
    Y.r = [xpad; Scomb.profiles.r];
    Y.fr = [ypad; Scomb.profiles.C_Ave(:, i)];
    FY = FourierTransform(Y, '3D');
    FYsq.r = FY.q;
    FYsq.fr = abs(FY.fq).^2;
    CF = FourierTransform(FYsq, '3D');
        %S.CF.r = CF.q;
    Scomb.CF.G_Ave(:, i) = CF.fq;

end

%% Fig. 2
%close all
fig1 = figure('Position',[360   278   510   660],'Color',[1 1 1]);

axes('Position',[0.1 0.83 0.8 0.22])

Im2A = imread('/Users/Alonyan/Documents/MATLAB/OlegCytokineModeling/Modelling Pulsed Source/Model2.tiff');


h= imshow(Im2A(:,:,1:3)); figure(gcf)

axes('Position', [0.1 0.65 0.2, 0.1545])
%concentration during pulse
h = semilogy(Scomb.profiles.r/2, Scomb.profiles.responseAve./Scomb.profiles.responseAve(1,1),SteadyState.r./2, SteadyState.response,'--k'); %convert x-scale to diameters
tzeva1 = makeColorMap([0.4 0 0.6],[1,1,0],6);
for i=1:6
    set(h(i),'color',tzeva1(i,:))
end
set(h,'linewidth', 1.5)
figure(gcf)
maxC = max(max(Scomb.profiles.responseAve));
%text(4, 90, ['L = ' num2str(L)], 'FontSize', 14)
set(gca, 'YLim', [1/100 1], 'XLim', [0 40], 'FontSize', 12,'xtick',[1 10 20 30 40 50 60],'TickLength', [0.03 0.1]);

hold on
g = ploterr(x(range1),MassMeanAllHist(range1)./MassMeanAllHist(range1(1)),[],MasserrHist(range1)./MassMeanAllHist(range1(2)),'o','logy','abshhxy', .8)%,x*0.625, 1000*exp(-(x*0.625)/15))
set(g, 'color',[0.5, 0.5, 0.5])
set(g,'MarkerFaceColor', get(g(1),'color'),'MarkerEdgeColor',get(g(1),'color'), 'linewidth', 1.5,'markersize', Markersize);
uistack(h(end), 'top')


v = axis;
%hold on;
%Cstationary = (J/2)./S1secr.profiles.r*EC50; 
%h = semilogy(S.profiles.r/2, Cstationary(:), '-k');
%set(h, 'LineWidth', 2);
%hold off;
hleg = legend([h; g(1)],{'t = 10 min', 't = 20 min', 't = 30 min', 't = 40 min', ...
    't = 50 min', 't = 60 min','Diffusion-Consumption','Experimental data'})
legend boxoff
 set(hleg,'Position',[0.8, 0.665, 0.1, 0.1],'Fontsize', 10)

title({'response profiles' 'periodic source'})
ylabel('response (a.u.)', 'FontSize', 12)
xlabel('r (cell dia)', 'FontSize', 12)
axis(v);



axes('Position', [0.45 0.65 0.2, 0.1545])
% concentration correlations during pulse
% normalize G to unity
G = Scomb.CF.GresponseAve./repmat(max(Scomb.CF.GresponseAve), size(Scomb.CF.GresponseAve, 1), 1);
h = semilogy(Scomb.CF.r/2, G ,S3Stat.CF.r/2, S3Stat.CF.Gresponse(:,3)./max(S3Stat.CF.Gresponse(:,3)),'--k'); %convert x-scale to diameters
tzeva1 = makeColorMap([0.6 0 0.6],[1,1,0],6);
for i=1:6
    set(h(i),'color',tzeva1(i,:))
end
set(h,'linewidth', 1.5)
figure(gcf)
set(gca, 'YLim', [1/10 1], 'FontSize', 12, 'XLim', [0 40],'xtick',[1 10 20 30 40 50 60],'TickLength', [0.03 0.1]);
%text(4, 90, ['L = ' num2str(L)], 'FontSize', 14)
Rstationary = J./Scomb.profiles.r;
title({'response autocorrelation' 'periodic source'})
ylabel('G - autocorrelation', 'FontSize', 12)
xlabel('r (cell dia)', 'FontSize', 12)



 a = annotation('textbox',[ 0.01 0.96    0.02    0.05],'string','A', 'Fontsize',TitleFontSize,'LineStyle','none')
 a = annotation('textbox',[ 0.01 0.83    0.02    0.05],'string','B', 'Fontsize',TitleFontSize,'LineStyle','none')
 a = annotation('textbox',[ 0.37 0.83    0.05    0.05],'string','C', 'Fontsize',TitleFontSize,'LineStyle','none')
% 
% subplot(2, 2, 3);
% %averaged response
% plotColor('semilogy', Scomb.profiles.r/2, Scomb.profiles.responseAve); %convert x-scale to diameters
% figure(gcf)
% maxC = max(Scomb.profiles.responseAve(:));
% %text(4, 90, ['L = ' num2str(L)], 'FontSize', 14)
% set(gca, 'YLim', [1/100 1], 'XLim', [0 60], 'FontSize', 12);
% %v = axis;
% Rstationary = J./(J+Scomb.profiles.r);
% %hold on;
% %h = semilogy(S.profiles.r/2, Rstationary, '-k');
% %set(h, 'LineWidth', 2);
% %axis(v);
% %hold off;
% legend({'t = 10 min', 't = 20 min', 't = 30 min', 't = 40 min', ...
%     't = 50 min', 't = 60 min'})
% 
% title('Response Profiles')
% ylabel('response', 'FontSize', 14)
% xlabel('r (cell dia)', 'FontSize', 14)
% text(30, 0.1, 'E', 'FontSize', 16)
% 
% subplot(2, 2, 4)
% % normalize G to unity
% G = Scomb.CF.GresponseAve./repmat(max(Scomb.CF.GresponseAve), size(Scomb.CF.GresponseAve, 1), 1);
% plotColor('semilogy', Scomb.CF.r/2, G); %convert x-scale to diameters
% figure(gcf)
% set(gca, 'YLim', [1/100 1], 'FontSize', 12, 'XLim', [0 250]);
% %text(4, 90, ['L = ' num2str(L)], 'FontSize', 14)
% 
% title('Response Correlations')
% ylabel('G response', 'FontSize', 14)
% xlabel('r (cell dia)', 'FontSize', 14)
% text(330, 0.5, 'F', 'FontSize', 16)
% 



%%
    set(gcf, 'PaperPositionMode','auto')

savpath = fpath;
        print(gcf,'-dpdf',[savpath ,'PeriodSource']);



%% assume 5 min secretion at high rate 10*12 molec per second. Then nothing for 55 min. With Consumption!!!!
%EC50 = 10; %in pM
%R = 5; % cell radius in um
%secretion_rate = 120; %molecules per sec
%D = 100; % diffusion coeff um^2/s
L = 300; 
x = linspace(1, L, 4000);

%J = 30%secretion_rate/(4*pi*R*D)*1e15/6e23/(EC50*1e-12);

t1 = [1:10 60 60*(2:1:5)]; %time points in sec for presentation
t1ave = 30*(1:10); %time points in sec for averaging (every 30s)
ksi = 7; 
%J = 1/600;

S3secr = TimeDependent3D_Cytokine_v1(t1*D/R^2, x, J, 'ksi', ksi, 'Dimensionality', 2);%to unitless time
S3ave = TimeDependent3D_Cytokine_v1(t1ave*D/R^2, x, J, 'ksi', ksi, 'Dimensionality', 2);%for averaging

Cstationary = SolveCytokineDistribution_3Da(J, ksi, L,'Number of points', 400)

%% now assume 5 min of no secretion
t2 = [1 10 60 300*(1:11)]; %time points in sec for presentation
t2ave = 30*(1:110); %time points in sec for averaging (every 30s)
%J = 1/600;

S4secr = TimeDependent3D_Cytokine_v1(t2*D/R^2, x, 0, 'ksi', ksi, 'Initial Conditions', S3secr.profiles.C(:, end))%to unitless time
S4ave = TimeDependent3D_Cytokine_v1(t2ave*D/R^2, x, 0, 'ksi', ksi, 'Initial Conditions', S3secr.profiles.C(:, end))%for averaging

%% averaging

%combine
Scomb1 = S3ave;
Scomb1.profiles.t = [Scomb1.profiles.t, Scomb1.profiles.t(end)+S4ave.profiles.t];
Scomb1.profiles.C = [Scomb1.profiles.C, S4ave.profiles.C];
Scomb1.profiles.response = [Scomb1.profiles.response, S4ave.profiles.response];
Scomb1.CF.G = [Scomb1.CF.G, S4ave.CF.G];
Scomb1.CF.Gresponse = [Scomb1.CF.Gresponse, S4ave.CF.Gresponse];

for i = 1:(size(Scomb1.profiles.response, 2)/20),
    Scomb1.profiles.responseAve(:, i) = mean(Scomb1.profiles.response(:, (20*(i-1)+1):(20*i)), 2);
    % calculate correlations
    x = Scomb1.profiles.r;
    
    %for zero-padding for Fourier transform
    minx = min(x);
    dx = median(diff(x));
    xpad = ((dx/2):dx:minx)';
    ypad = zeros(size(xpad));
    Y.r = [xpad; Scomb1.profiles.r];
    Y.fr = [ypad; Scomb1.profiles.responseAve(:, i)];
    FY = FourierTransform(Y, '3D');
    FYsq.r = FY.q;
    FYsq.fr = abs(FY.fq).^2;
    CF = FourierTransform(FYsq, '3D');
        %S.CF.r = CF.q;
    Scomb1.CF.GresponseAve(:, i) = CF.fq;
end


%% Fig1: plot everything for short pulses
%close all
fig2 = figure('Position',[360   278   510   660],'Color',[1 1 1]);

axes('Position',[0.1 0.83 0.65 0.22])

Im2A = imread('/Users/Alonyan/Documents/MATLAB/OlegCytokineModeling/Modelling Pulsed Source/Model1.tiff');


h= imshow(Im2A(:,:,1:3)); figure(gcf)

axes('Position', [0.1 0.65 0.24, 0.18])
%concentration during pulse
%plotColor('semilogy', S1secr.profiles.r/2, S1secr.profiles.response); %convert x-scale to diameters
h = [];
tzeva1 = makeColorMap([0 1 0],[0,0,1],7);
    h = semilogy(S3secr.profiles.r/2, S3secr.profiles.response,'-', S3Stat.profiles.r./2, S3Stat.profiles.response(:,3),'-k');

for i=1:7
    hold on;
    set(h(i),'color',tzeva1(i,:),'markerfacecolor',tzeva1(i,:))
end

set(h,'linewidth', 1.5,'Markersize', 3)
figure(gcf)
maxC = max(S3secr.profiles.response);
%text(4, 90, ['L = ' num2str(L)], 'FontSize', 14)
set(gca, 'YLim', [1/100 1], 'XLim', [0 40], 'FontSize', 12,'xtick',[1 10 20 30 40 50 60]);
v = axis;
%hold on;
%h = semilogy(S.profiles.r/2, Cstationary(:), '-k');
%set(h, 'LineWidth', 2);
%hold off;
hleg = legend({'t = 00:01 min', 't = 00:10 min', 't = 01:00 min', 't = 02:00 min', ...
    't = 03:00 min',  't = 04:00 min',...
     't = 05:00 min'},'Fontsize', 10)
 legend boxoff;
 set(hleg,'Position',[0.8, 0.65, 0.1, 0.1])
title({'response profiles' 'during production'})
ylabel('Response (a.u.)', 'FontSize', 12)
xlabel('r (cell dia)', 'FontSize', 12)
axis(v);
%text(5, 15, 'A', 'FontSize', 16)




axes('Position', [0.5 0.65 0.24, 0.18])
%concentrations during swithc off
h = semilogy( S4secr.profiles.r/2, S4secr.profiles.response(:, [1:4 5 9 14]),'-', S3Stat.profiles.r./2, S3Stat.profiles.response(:,3),'-k'); %convert x-scale to diameters
tzeva2 = makeColorMap([0,0,1],[1,1,0],length(h)-1);
for i=1:length(h)-1
    set(h(i),'color',tzeva2(i,:),'markerfacecolor',tzeva2(i,:))
end
set(h,'linewidth', 1.5,'Markersize', 3)
figure(gcf)
maxC = max(S4secr.profiles.response);
%text(4, 90, ['L = ' num2str(L)], 'FontSize', 14)
set(gca, 'YLim', [1/100 1], 'XLim', [0 40], 'FontSize', 12,'xtick',[1 10 20 30 40 50 60]);
%set(gca, 'FontSize', 12);

hleg = legend({'t = 05:01 min', 't = 05:10 min', 't = 06:00 min', 't = 10:00 min', ...
    't = 15:00 min', 't = 35:00 min',...
    't = 60:00 min'},'Fontsize', 10);

legend boxoff;
 set(hleg,'Position',[0.8, 0.485, 0.1, 0.1])

title({'response profiles' 'after production'})
ylabel('response (a.u.)', 'FontSize', 12)
xlabel('r (cell dia)', 'FontSize', 12)
%text(50, 5, 'C', 'FontSize', 16);


axes('Position', [0.1 0.33 0.24, 0.18])
% concentration correlations during pulse
% normalize G to unity
G = S3secr.CF.Gresponse./repmat(max(S3secr.CF.Gresponse), size(S3secr.CF.Gresponse, 1), 1);
%plotColor('semilogy', ); %convert x-scale to diameters
h = semilogy(S3secr.CF.r/2, G, S3Stat.CF.r/2, S3Stat.CF.Gresponse(:,3)./max(S3Stat.CF.Gresponse(:,3)),'-k');
%tzeva1 = makeColorMap([0 1 0],[0,0,1],7);
for i=1:7
    set(h(i),'color',tzeva1(i,:))
end
set(h,'linewidth', 1.5)
figure(gcf)
set(gca, 'YLim', [1/10 1],'xlim',[0, 40], 'FontSize', 12,'xtick',[1 10 20 30 40 50 60]);
%text(4, 90, ['L = ' num2str(L)], 'FontSize', 14)
Rstationary = J./S3secr.profiles.r;
title({'response autocorrelations' 'during production'})
ylabel('G - autocorrelation', 'FontSize', 12)
xlabel('r (cell dia)', 'FontSize', 12)
%text(70, 0.5, 'B', 'FontSize', 16)

axes('Position', [0.5 0.33 0.24, 0.18])
%concentration correlations during switch off
% normalize G to unity
G = S4secr.CF.Gresponse(:, [1:4 5 9 14])./repmat(max(S4secr.CF.Gresponse(:, [1:4 5 9 14])), size(S4secr.CF.Gresponse(:, [1:4 5 9 14]), 1), 1);
h = semilogy( S4secr.CF.r/2, G,S3Stat.CF.r/2, S3Stat.CF.Gresponse(:,3)./max(S3Stat.CF.Gresponse(:,3)),'-k'); %convert x-scale to diameters
%tzeva1 = makeColorMap([0,0,1],[1,0,0],length(h));
for i=1:length(h)-1
    set(h(i),'color',tzeva2(i,:))
end
set(h,'linewidth', 1.5)
figure(gcf)
set(gca, 'YLim', [1/10 1],'xlim',[0, 40], 'FontSize', 12,'xtick',[1 10 20 30 40 50 60]);
%text(4, 90, ['L = ' num2str(L)], 'FontSize', 14)

title({'response autocorrelation' 'after production'})
ylabel('G - autocorrelation', 'FontSize', 12)
xlabel('r (cell dia)', 'FontSize', 12)
%text(330, 0.5, 'D', 'FontSize', 16)






savpath = '/Users/Alonyan/Desktop/';%the folder where the figure should go

set(gcf, 'PaperPositionMode','auto')
        
FigureName = 'untitled1' %name you want for the figure file

     print(gcf,'-dpdf',[savpath ,FigureName]);
%%
%% now to oscillating source
% assume 5 min secretion at  rate 10*2 molec per second. Then nothing for 5
% min and then repeated switches on and off

L = 300; %simulation space length in cell radia
x = linspace(1, L, 4000); %in cell radia
t1ave = 30*(1:10); %time points in sec for averaging (every 30s)




%t2 = [1 10 60 300*(1:11)]; %time points in sec for presentation
%t2ave = 30*(1:110); %time points in sec for averaging (every 30s)
%J = 1/600;

t2ave = t1ave;

S3ave = TimeDependent3D_Cytokine_v1(t1ave*D/R^2, x, J, 'ksi', ksi)%for averaging
S4ave = TimeDependent3D_Cytokine_v1(t2ave*D/R^2, x, 0, 'ksi', ksi, 'Initial Conditions', S3ave.profiles.C(:, end))%for averaging
%Cstationary = J./S1secr.profiles.r*EC50; 

Scomb2 = S3ave;
Scomb2.profiles.t = [Scomb2.profiles.t, Scomb2.profiles.t(end)+S4ave.profiles.t];
Scomb2.profiles.C = [Scomb2.profiles.C, S4ave.profiles.C];
Scomb2.profiles.response = [Scomb2.profiles.response, S4ave.profiles.response];
Scomb2.CF.G = [Scomb2.CF.G, S4ave.CF.G];
Scomb2.CF.Gresponse = [Scomb2.CF.Gresponse, S4ave.CF.Gresponse];

% repeat 5 times
for i=1:5,
    i
    S3ave = TimeDependent3D_Cytokine_v1(t1ave*D/R^2, x, J, 'ksi', ksi, 'Initial Conditions', Scomb2.profiles.C(:, end))%for averaging
    S4ave = TimeDependent3D_Cytokine_v1(t2ave*D/R^2, x, 0, 'ksi', ksi, 'Initial Conditions', S3ave.profiles.C(:, end))%for averaging
    Cstationary = J./S1secr.profiles.r*EC50; 
    
    Scomb2.profiles.t = [Scomb2.profiles.t, Scomb2.profiles.t(end)+S3ave.profiles.t];
    Scomb2.profiles.C = [Scomb2.profiles.C, S3ave.profiles.C];
    Scomb2.profiles.response = [Scomb2.profiles.response, S3ave.profiles.response];
    Scomb2.CF.G = [Scomb2.CF.G, S3ave.CF.G];
    Scomb2.CF.Gresponse = [Scomb2.CF.Gresponse, S3ave.CF.Gresponse];

    
    Scomb2.profiles.t = [Scomb2.profiles.t, Scomb2.profiles.t(end)+S4ave.profiles.t];
    Scomb2.profiles.C = [Scomb2.profiles.C, S4ave.profiles.C];
    Scomb2.profiles.response = [Scomb2.profiles.response, S4ave.profiles.response];
    Scomb2.CF.G = [Scomb2.CF.G, S4ave.CF.G];
    Scomb2.CF.Gresponse = [Scomb2.CF.Gresponse, S4ave.CF.Gresponse];
end;

%% averaging
Scomb2.profiles.C_Ave = [];
Scomb2.profiles.responseAve = [];
Scomb2.CF.G_Ave = [];
Scomb2.CF.GresponseAve = [];

steps = 20;
for i = 1:(size(Scomb2.profiles.response, 2)/steps),
    Scomb2.profiles.C_Ave(:, i) = mean(Scomb2.profiles.C(:, (steps*(i-1)+1):(steps*i)), 2);
    Scomb2.profiles.responseAve(:, i) = mean(Scomb2.profiles.response(:, (steps*(i-1)+1):(steps*i)), 2);
    % calculate correlations
    x = Scomb2.profiles.r;
    
    %for zero-padding for Fourier transform
    minx = min(x);
    dx = median(diff(x));
    xpad = ((dx/2):dx:minx)';
    ypad = zeros(size(xpad));
    Y.r = [xpad; Scomb2.profiles.r];
    Y.fr = [ypad; Scomb2.profiles.responseAve(:, i)];
    FY = FourierTransform(Y, '3D');
    FYsq.r = FY.q;
    FYsq.fr = abs(FY.fq).^2;
    CF = FourierTransform(FYsq, '3D');
        %S.CF.r = CF.q;
    Scomb2.CF.GresponseAve(:, i) = CF.fq;
    
    Y.r = [xpad; Scomb2.profiles.r];
    Y.fr = [ypad; Scomb2.profiles.C_Ave(:, i)];
    FY = FourierTransform(Y, '3D');
    FYsq.r = FY.q;
    FYsq.fr = abs(FY.fq).^2;
    CF = FourierTransform(FYsq, '3D');
        %S.CF.r = CF.q;
    Scomb2.CF.G_Ave(:, i) = CF.fq;

end




%% Fig. 2
%close all
fig3 = figure('Position',[360   278   510   660],'Color',[1 1 1]);

axes('Position',[0.1 0.83 0.65 0.22])

Im2A = imread('/Users/Alonyan/Documents/MATLAB/OlegCytokineModeling/Modelling Pulsed Source/Model2.tiff');


h= imshow(Im2A(:,:,1:3)); figure(gcf)

axes('Position', [0.1 0.65 0.24, 0.18])
%concentration during pulse
h = semilogy(Scomb2.profiles.r/2, Scomb2.profiles.responseAve, S3Stat.profiles.r./2, S3Stat.profiles.response,'k'); %convert x-scale to diameters
tzeva1 = makeColorMap([0.4 0 0.6],[1,1,0],length(h)-1);
for i=1:length(h)-1
    set(h(i),'color',tzeva1(i,:))
end
set(h,'linewidth', 1.5)
figure(gcf)
maxC = max(max(Scomb2.profiles.responseAve));
%text(4, 90, ['L = ' num2str(L)], 'FontSize', 14)
set(gca, 'YLim', [maxC/100 maxC], 'XLim', [0 40], 'FontSize', 12,'xtick',[1 10 20 30 40 50 60]);

v = axis;
%hold on;
%Cstationary = (J/2)./S1secr.profiles.r*EC50; 
%h = semilogy(S.profiles.r/2, Cstationary(:), '-k');
%set(h, 'LineWidth', 2);
%hold off;
hleg = legend({'t = 10 min', 't = 20 min', 't = 30 min', 't = 40 min', ...
    't = 50 min', 't = 60 min'})
legend boxoff
 set(hleg,'Position',[0.8, 0.7, 0.1, 0.1])

title({'Response profiles' 'periodic source'})
ylabel('response (a.u.)', 'FontSize', 12)
xlabel('r (cell dia)', 'FontSize', 12)
axis(v);



axes('Position', [0.5 0.65 0.24, 0.18])
% concentration correlations during pulse
% normalize G to unity
G = Scomb2.CF.GresponseAve./repmat(max(Scomb2.CF.GresponseAve), size(Scomb2.CF.GresponseAve, 1), 1);
h = semilogy(Scomb2.CF.r/2, G, S3Stat.CF.r/2, S3Stat.CF.Gresponse(:,3)./max(S3Stat.CF.Gresponse(:,3)),'-k'); %convert x-scale to diameters
tzeva1 = makeColorMap([0.6 0 0.6],[1,1,0],length(h)-1);
for i=1:length(h)-1
    set(h(i),'color',tzeva1(i,:))
end
set(h,'linewidth', 1.5)
figure(gcf)
set(gca, 'YLim', [1/10 1], 'FontSize', 12, 'XLim', [0 40],'xtick',[1 10 20 30 40 50 60]);
%text(4, 90, ['L = ' num2str(L)], 'FontSize', 14)
Rstationary = J./Scomb2.profiles.r;
title({'Response autocorrelation' 'periodic source'})
ylabel('G', 'FontSize', 12)
xlabel('r (cell dia)', 'FontSize', 12)

% 


%%

S3Stat = TimeDependent3D_Cytokine_v1(([0 60*5 60*60])*D/R^2, x, J, 'ksi', ksi, 'Dimensionality', 2);%to unitless time
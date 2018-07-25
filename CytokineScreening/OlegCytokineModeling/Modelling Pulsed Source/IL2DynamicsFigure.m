%%
fpath = '/Users/Alonyan/GoogleDrive/Experiments/IL2DynamicsMilt_112216'
load([fpath filesep 'Process_IL2SecretionDyn112216'])

fpath = '/Users/Alonyan/Desktop/2016-12-06 CD4 IL2 for Alon';
load([fpath filesep 'Process120916'], 'Data')

time = 5*[0:120]/60;
   Markersize = 4;
BigFontSize = 13;
AxisFontSize = 12;
TitleFontSize = 16;
%%
IndexMatch = {};
i=1;
FitParams = [];
for SInd=1:20
    Scan = Data.Activated(SInd).scan;
    for WInd=1:length(Scan.Well)
        IndexMatch{i} = [SInd, WInd];
        i=i+1;
        FitParams = [FitParams;Scan.Well(WInd).FitParam];
    end
end


AllScoresCont = []
for i=2:5
    
        plot(reshape(extractfield(Data.UnActivated(i).scan.Well,'score'), 121, []),'.')
        shg
        pause(0.2);
        AllScoresCont = [AllScoresCont, reshape(extractfield(Data.UnActivated(i).scan.Well,'score'), 121, [])];
end
 
      set(0,'DefaultTextInterpreter', 'tex')
set(0, 'DefaultAxesFontName', 'Arial')
set(0, 'DefaultUIControlFontName', 'Arial')
set(0,'defaulttextfontname','Arial');
   Markersize = 4;
BigFontSize = 13;
AxisFontSize = 12;
TitleFontSize = 16;


close all
fig1 = figure('Position',[360   278   510   660],'Color',[1 1 1]);


yThresh = 1.55;
yThreshLin = LRAPC*sinh(yThresh);

  
                
    timepoints = 40+[0 15 30 60 90 120 24*60]
    fracs = [];
    range = 1:7;
    for i=range 
        xThresh = Xthreshes(i);
        xThreshLin = LRPE*sinh(xThresh);
    axes('Position', [0.08+0.131*(i-1) 0.865  0.1294 0.10])
        dataname = 'SamplesPermActivated'
        
        [h,LRx, LRy] = ScatterPlotByTag_v1(eval([dataname '(' num2str(i) ')']), { '<PE ( 561 )-A>: Milt0-40' '<APC-A>: Intracellular'},'Nbins',20,'Ylim',[-1000 300000],'Xlim',[-1000 300000],'MaxPointsToPlot',20000, 'LinearRangeX',50, 'LinearRangeY', 1000)
                
                if i==1
                xl = xlabel('IL-2 secreted', 'Fontsize', 12)
                yl = ylabel('IL-2 Intracellular', 'Fontsize', 12)
                else
                xl = xlabel('', 'Fontsize', 12)
                yl = ylabel('', 'Fontsize', 12)
                end
                if i==7;
                    title('24h ')
                else
                    title([num2str(timepoints(i)) 'm '])
                end
                [Xticks ,XTickLabel] = LinRangeToTicks(LRx);
                [Yticks ,YTickLabel] = LinRangeToTicks(LRy);
                if i==1
                set(gca,'box','on', 'XTick', Xticks, 'XTickLabel', XTickLabel,'YTick', Yticks, 'YTickLabel', YTickLabel,'TickLength', [0.03 0.1],'layer','top','linewidth', 0.5, 'Xlim',[-0.5 6], 'Ylim',[-0.05 5]);
                else
                set(gca,'box','on', 'XTick', Xticks, 'XTickLabel', XTickLabel,'YTick', Yticks, 'YTickLabel', '','TickLength', [0.03 0.1],'layer','top','linewidth', 0.5, 'Xlim',[-0.5 6], 'Ylim',[-0.05 5]);
                end
                line([-0.5 6], [yThresh yThresh],'LineWidth',1.5,'Color','k')
                line([xThresh xThresh], [-0.5 6],'LineWidth',1.5,'Color','k')
                
                dataPE = GetFACSdataFromMatLabStructByTag(eval([dataname '(' num2str(i) ')']), 'PE')
                dataAPC = GetFACSdataFromMatLabStructByTag(eval([dataname '(' num2str(i) ')']), 'APC')
                Q1 = sum((dataPE.PE>xThreshLin).*(dataAPC.APC>yThreshLin))./length(dataPE.PE)
                Q2 = sum((dataPE.PE<xThreshLin).*(dataAPC.APC>yThreshLin))./length(dataPE.PE)
                Q3 = sum((dataPE.PE<xThreshLin).*(dataAPC.APC<yThreshLin))./length(dataPE.PE)
                Q4 = sum((dataPE.PE>xThreshLin).*(dataAPC.APC<yThreshLin))./length(dataPE.PE)
                text(3.3, 4, num2str(Q1,'%3.2f'))
                text(3.3, 0.5, num2str(Q4,'%3.2f'))
                text(0.1, 4, num2str(Q2,'%3.2f'))
                
                fracs = [fracs, Q1/(Q1+Q4)]
    end;
      axes('Position', [0.07 0.59 0.246 0.19])
  
    [alpha,resnorm,residual,exitflag,output,lambda,jacobian] = lsqcurvefit(@(alpha,x) alpha(1)*exp(-x./alpha(2)), [0.9, 100], [timepoints(range)], [fracs(range)])
    [ci se] = nlparci(alpha,residual,'jacobian',jacobian)
    h = plot([timepoints(range)], [fracs(range)],'-ok',[0:0.1:3000], alpha(1)*exp(-[0:0.1:3000]./alpha(2)),'--b')

    set(gca,'ylim',[0,1], 'xlim',[30, 180])
    xlabel('Time after secr. assay(m)', 'Fontsize', 12)
    ylabel('Fraction of IL-2^{ +} cells', 'Fontsize', 12)
    set(h,'linewidth', 1.5, 'markerfacecolor','k', 'markersize', 5)
    text(35, 0.3, 'prod. time \approx 9 \pm 2 h')
    set(gca,'xtick', [0 30 60 90 120 150 180],'ytick', [0 0.2 0.4 0.6 0.8 1], 'Fontsize', 10)

    
      
    x0 = 0.5;
    y0 = 0.6;
    xThresh = Xthreshes(1);
xThreshLin = LRPE*sinh(xThresh);
    axes('Position', [x0 y0  0.13 0.10])
        dataname = 'SamplesPermActivated'
        [h,LRx, LRy] = ScatterPlotByTag_v1(eval([dataname '(1)']), { '<PE ( 561 )-A>: Milt0-40' '<APC-A>: Intracellular'},'Nbins',20,'Ylim',[-1000 300000],'Xlim',[-1000 300000],'MaxPointsToPlot',10000, 'LinearRangeX',50, 'LinearRangeY', 1000)

                xl = xlabel('IL-2 secreted', 'Fontsize', 12)
                yl = ylabel('IL-2 Intracellular', 'Fontsize', 12)
                title('Permeabilized ','Fontsize', 12)
                [Xticks ,XTickLabel] = LinRangeToTicks(LRx);
                [Yticks ,YTickLabel] = LinRangeToTicks(LRy);

                set(gca,'box','on', 'XTick', Xticks, 'XTickLabel', XTickLabel,'YTick', Yticks, 'YTickLabel', YTickLabel,'TickLength', [0.03 0.1],'layer','top','linewidth', 0.5, 'Xlim',[-0.5 6], 'Ylim',[-0.05 5]);
                line([-0.5 6], [yThresh yThresh],'LineWidth',1.5,'Color','k')
                line([xThresh xThresh], [-0.5 6],'LineWidth',1.5,'Color','k')
                
                dataPE = GetFACSdataFromMatLabStructByTag(eval([dataname '(1)']), 'PE')
                dataAPC = GetFACSdataFromMatLabStructByTag(eval([dataname '(1)']), 'APC')
                Q1 = sum((dataPE.PE>xThreshLin).*(dataAPC.APC>yThreshLin))./length(dataPE.PE)
                Q2 = sum((dataPE.PE<xThreshLin).*(dataAPC.APC>yThreshLin))./length(dataPE.PE)
                Q3 = sum((dataPE.PE<xThreshLin).*(dataAPC.APC<yThreshLin))./length(dataPE.PE)
                Q4 = sum((dataPE.PE>xThreshLin).*(dataAPC.APC<yThreshLin))./length(dataPE.PE)
                text(3.3, 4, num2str(Q1,'%3.2f'))
                text(3.3, 0.5, num2str(Q4,'%3.2f'))
                text(0.15, 4, num2str(Q2,'%3.2f'))

        axes('Position', [x0+0.17 y0  0.13 0.10])
        dataname = 'ControlsNoPermActivated'
        [h,LRx, LRy] = ScatterPlotByTag_v1(eval([dataname '(1)']), { '<PE ( 561 )-A>: Milt0-40' '<APC-A>: Intracellular'},'Nbins',20,'Ylim',[-10000 300000],'Xlim',[-1000 300000],'MaxPointsToPlot',10000, 'LinearRangeX',50, 'LinearRangeY', 1000)

                xl = xlabel('', 'Fontsize', 12)
                yl = ylabel('', 'Fontsize', 12)
                title({'Not' 'Permeabilized '},'Fontsize', 12)
                [Xticks ,XTickLabel] = LinRangeToTicks(LRx);
                [Yticks ,YTickLabel] = LinRangeToTicks(LRy);

                set(gca,'box','on', 'XTick', Xticks, 'XTickLabel', XTickLabel,'YTick', Yticks, 'YTickLabel', '','TickLength', [0.03 0.1],'layer','top','linewidth', 0.5, 'Xlim',[-0.5 6], 'Ylim',[-0.05 5]);
                line([-0.5 6], [yThresh yThresh],'LineWidth',1.5,'Color','k')
                line([xThresh xThresh], [-0.5 6],'LineWidth',1.5,'Color','k')
                
                dataPE = GetFACSdataFromMatLabStructByTag(eval([dataname '(1)']), 'PE')
                dataAPC = GetFACSdataFromMatLabStructByTag(eval([dataname '(1)']), 'APC')
                Q1 = sum((dataPE.PE>xThreshLin).*(dataAPC.APC>yThreshLin))./length(dataPE.PE)
                Q2 = sum((dataPE.PE<xThreshLin).*(dataAPC.APC>yThreshLin))./length(dataPE.PE)
                Q3 = sum((dataPE.PE<xThreshLin).*(dataAPC.APC<yThreshLin))./length(dataPE.PE)
                Q4 = sum((dataPE.PE>xThreshLin).*(dataAPC.APC<yThreshLin))./length(dataPE.PE)
                text(3.3, 4, num2str(Q1,'%3.2f'))
                text(3.3, 0.5, num2str(Q4,'%3.2f'))
                text(0.15, 4, num2str(Q2,'%3.2f'))
                
     axes('Position', [x0+2*0.17 y0  0.13 0.10])
        dataname = 'SamplesPermNonActivated'
        [h,LRx, LRy] = ScatterPlotByTag_v1(eval([dataname '(1)']), { '<PE ( 561 )-A>: Milt0-40' '<APC-A>: Intracellular'},'Nbins',20,'Ylim',[-1000 300000],'Xlim',[-1000 300000],'MaxPointsToPlot',10000, 'LinearRangeX',50, 'LinearRangeY', 1000)

                xl = xlabel('', 'Fontsize', 12)
                yl = ylabel('', 'Fontsize', 12)
                title({'Not activated,' 'Permeabilized '},'Fontsize', 12)
                [Xticks ,XTickLabel] = LinRangeToTicks(LRx);
                [Yticks ,YTickLabel] = LinRangeToTicks(LRy);

                set(gca,'box','on', 'XTick', Xticks, 'XTickLabel', XTickLabel,'YTick', Yticks, 'YTickLabel', '','TickLength', [0.03 0.1],'layer','top','linewidth', 0.5, 'Xlim',[-0.5 6], 'Ylim',[-0.05 5]);
                line([-0.5 6], [yThresh yThresh],'LineWidth',1.5,'Color','k')
                line([xThresh xThresh], [-0.5 6],'LineWidth',1.5,'Color','k')
                dataPE = GetFACSdataFromMatLabStructByTag(eval([dataname '(1)']), 'PE')
                dataAPC = GetFACSdataFromMatLabStructByTag(eval([dataname '(1)']), 'APC')
                Q1 = sum((dataPE.PE>xThreshLin).*(dataAPC.APC>yThreshLin))./length(dataPE.PE)
                Q2 = sum((dataPE.PE<xThreshLin).*(dataAPC.APC>yThreshLin))./length(dataPE.PE)
                Q3 = sum((dataPE.PE<xThreshLin).*(dataAPC.APC<yThreshLin))./length(dataPE.PE)
                Q4 = sum((dataPE.PE>xThreshLin).*(dataAPC.APC<yThreshLin))./length(dataPE.PE)
                text(3.3, 4, num2str(Q1,'%3.2f'))
                text(3.3, 0.5, num2str(Q4,'%3.2f'))
                text(0.15, 4, num2str(Q2,'%3.2f'))
                
           annotation('arrow',[0.65, 0.9],[0.55 0.55])
           annotation('arrow',[0.25, 0.9],[0.82 0.82])
           annotation('textbox',[x0+0.12, 0.7, 0.1, 0.1],'String','Staining controls ','edgecolor', 'none','FontSize', 13)
           

    
    
    
    
    
    
    
    
    cnt=0
Ind2Show = [4 25 19];


ind = Ind2Show(1);%[16 28 45]
%[ 8  14 15 16 17 20 27 28 30 34 35 36  38 39 43 44 45 ]
SInd = IndexMatch{ind}(1);
WInd = IndexMatch{ind}(2);
Scan = Data.Activated(SInd).scan;
rangex=Scan.Well(WInd).rangex;
rangey=Scan.Well(WInd).rangey;
Brightness = [4 1]
t=0:0.01:4;


for i=11:2:29
    
    axes('Position', [0.01+0.075*cnt 0.45 0.07 0.07*51/66])
ImGreen = Scan.Green{i}(rangex, rangey);
ImBW = Scan.BF{i}(rangex, rangey);

Channel{1} = ind2rgb(ImGreen-5000,makeColorMap([0 0 0], [0,1,0], 2000));
Channel{2} = ind2rgb(ImBW-4500,makeColorMap([0 0 0], [1,1,1], 6000));
RGB=zeros(size(Channel{1}));
for j=1:2
RGB = RGB+Brightness(j).*Channel{j};
end;
RGB(RGB>1) = 1;
imagesc(RGB)
PicComment_v1('str', [num2str(i*5) 'm'],'loc','se1','fontsize', 7)
if cnt == 0;
    scalebar_v1('len', 10,'location', 'sw','string','','color','r','mppx',0.8,'mppy',0.8)
end;
    set(gca,'xticklabel','','yticklabel','','visible','off')

cnt=cnt+1

end

    axes('Position', [0.85 0.42 0.1 0.07])

h = plot(t, delayedLinear(Scan.Well(WInd).FitParam,t)-Scan.Well(WInd).FitParam(1),'--k', time(1:2:end), Scan.Well(WInd).score(1:2:end)-Scan.Well(WInd).FitParam(1), 'o', time, AllScoresCont(:,1)-repmat(AllScoresCont(1,1),121,1),'o')
set(gca,'xlim', [0, 4],'xtick',[1 2 3 4 5 6],'xticklabel','','ylim',[0,800],'Ytick',[0 200 400 600],'Yticklabel',[0 2 4 6 8 10],'Fontsize', 10,'TickLength', [0.03 0.1])
set(h, 'linewidth', 1.5, 'Markersize',3)
set(h(2), 'Markerfacecolor','b')
set(h(3), 'Markerfacecolor',[0, 0.5 0])

hleg = legend(h([2, 3]), 'PMA+Ionomycin','DMSO control');
set(hleg,'fontsize',9,'Position',[0.76    0.49    0.2177    0.0462])
legend boxoff





cnt=0

ind = Ind2Show(2);%[13 16 28 45]
%[ 8  14 15 16 17 20 27 28 30 34 35 36  38 39 43 44 45 ]
SInd = IndexMatch{ind}(1);
WInd = IndexMatch{ind}(2);
Scan = Data.Activated(SInd).scan;
rangex=Scan.Well(WInd).rangex;
rangey=Scan.Well(WInd).rangey;
Brightness = [4 1]

for i=18:2:36
    
    axes('Position', [0.01+0.075*cnt 0.38 0.07 0.07*51/66])
ImGreen = Scan.Green{i}(rangex, rangey);
ImBW = Scan.BF{i}(rangex, rangey);

Channel{1} = ind2rgb(ImGreen-5000,makeColorMap([0 0 0], [0,1,0], 2000));
Channel{2} = ind2rgb(ImBW-4500,makeColorMap([0 0 0], [1,1,1], 6000));
RGB=zeros(size(Channel{1}));
for j=1:2
RGB = RGB+Brightness(j).*Channel{j};
end;
RGB(RGB>1) = 1;
imagesc(RGB)
PicComment_v1('str', [num2str(i*5) 'm'],'loc','se1','fontsize', 7)
    set(gca,'xticklabel','','yticklabel','','visible','off')

cnt=cnt+1

end

    axes('Position', [0.85 0.35 0.1 0.07])

h = plot(t, delayedLinear(Scan.Well(WInd).FitParam,t)-Scan.Well(WInd).FitParam(1),'--k',time(1:2:end), Scan.Well(WInd).score(1:2:end)-Scan.Well(WInd).FitParam(1), 'o', time, AllScoresCont(:,2)-repmat(AllScoresCont(1,2),121,1),'o')
set(gca,'xlim', [0, 4],'xtick',[1 2 3 4 5 6],'xticklabel','','ylim',[0,800],'Ytick',[0 200 400 600 ],'Yticklabel',[0 2 4 6 8 10],'Fontsize', 10,'TickLength', [0.03 0.1])
set(h, 'linewidth', 1.5, 'Markersize',3)
set(h(2), 'Markerfacecolor','b')
set(h(3), 'Markerfacecolor',[0, 0.5 0])
%hleg = legend(h([1, 3]), 'PMA+Ionomycin','DMSO control');
%set(hleg,'fontsize',9)
%legend boxoff





cnt=0

ind = Ind2Show(3);%[16 28 45]
%[ 8  14 15 16 17 20 27 28 30 34 35 36  38 39 43 44 45 ]
SInd = IndexMatch{ind}(1);
WInd = IndexMatch{ind}(2);
Scan = Data.Activated(SInd).scan;
rangex=Scan.Well(WInd).rangex;
rangey=Scan.Well(WInd).rangey;
Brightness = [4 1]

for i=24:2:42
    
    axes('Position', [0.01+0.075*cnt 0.31 0.07 0.07*51/66])
ImGreen = Scan.Green{i}(rangex, rangey);
ImBW = Scan.BF{i}(rangex, rangey);

Channel{1} = ind2rgb(ImGreen-5000,makeColorMap([0 0 0], [0,1,0], 2000));
Channel{2} = ind2rgb(ImBW-4500,makeColorMap([0 0 0], [1,1,1], 6000));
RGB=zeros(size(Channel{1}));
for j=1:2
RGB = RGB+Brightness(j).*Channel{j};
end;
RGB(RGB>1) = 1;
imagesc(RGB)

PicComment_v1('str', [num2str(i*5) 'm'],'loc','se1','fontsize', 7)

    set(gca,'xticklabel','','yticklabel','','visible','off')

cnt=cnt+1

end

    axes('Position', [0.85 0.28 0.1 0.07])

h = plot(t, delayedLinear(Scan.Well(WInd).FitParam,t)-Scan.Well(WInd).FitParam(1),'--k',time(2:2:end), Scan.Well(WInd).score(2:2:end)-Scan.Well(WInd).FitParam(1), 'o',time, AllScoresCont(:,3)-repmat(AllScoresCont(1,3),121,1),'o')
yl = ylabel('IL-2 (a.u.)','Fontsize', 10)
xl = xlabel('Time (h)','Fontsize', 10)
set(gca,'xlim', [0, 4],'xtick',[1 2 3 4 5 6],'ylim',[0,800],'Ytick',[0 200 400 600],'Yticklabel',[0 2 4 6 8 10],'Fontsize', 10,'TickLength', [0.03 0.1])
set(h, 'linewidth', 1.5, 'Markersize',3)
set(h(2), 'Markerfacecolor','b')
set(h(3), 'Markerfacecolor',[0, 0.5 0])
%hleg = legend(h([1, 3]), 'PMA+Ionomycin','DMSO control');
%set(hleg,'fontsize',9)
%legend boxoff



%dmso:
SInd = 4;
WInd = 1;
Scan = Data.UnActivated(SInd).scan;
rangex=Scan.Well(WInd).rangex;
rangey=Scan.Well(WInd).rangey;
Brightness = [4 1]
t=0:0.01:4;


cnt = 0
for i=15:2:33
    
    axes('Position', [0.01+0.075*cnt 0.24 0.07 0.07*51/66])
ImGreen = Scan.Green{i}(rangex, rangey);
ImBW = Scan.BF{i}(rangex, rangey);

Channel{1} = ind2rgb(ImGreen-5000,makeColorMap([0 0 0], [0,1,0], 2000));
Channel{2} = ind2rgb(ImBW-4500,makeColorMap([0 0 0], [1,1,1], 6000));
RGB=zeros(size(Channel{1}));
for j=1:2
RGB = RGB+Brightness(j).*Channel{j};
end;
RGB(RGB>1) = 1;
imagesc(RGB)
PicComment_v1('str', [num2str(i*5) 'm'],'loc','se1','fontsize', 7)

    set(gca,'xticklabel','','yticklabel','','visible','off')

cnt=cnt+1

end





cnt = 0
for ind = [7 10 13 14 16 17 18 21]% 22 24 27 32 35 41 43 45 46];%[7 10 13 14 16 17 18 21 22 24 27 32 35 41 43 45 46]
%[ 8  14 15 16 17 20 27 28 30 34 35 36  38 39 43 44 45 ]
SInd = IndexMatch{ind}(1);
WInd = IndexMatch{ind}(2);
Scan = Data.Activated(SInd).scan;
rangex=Scan.Well(WInd).rangex;
rangey=Scan.Well(WInd).rangey;

axes('Position', [0.08+0.11*cnt 0.13 0.1 0.07])

h = plot(t, delayedLinear(Scan.Well(WInd).FitParam,t)-Scan.Well(WInd).FitParam(1),'--k', time(1:2:end), Scan.Well(WInd).score(1:2:end)-Scan.Well(WInd).FitParam(1), 'o', time, AllScoresCont(:,3)-repmat(AllScoresCont(1,3),121,1),'o')
if cnt == 0
%yl = ylabel('IL-2 (a.u.)','Fontsize', 10)
%xl = xlabel('Time (h)','Fontsize', 10)
set(gca,'xlim', [0, 4],'xtick',[1 2 3 4 5 6],'ylim',[0,800],'Ytick',[0 200 400 600 800 1000],'Yticklabel',[0 2 4 6 8 10],'Fontsize', 10,'TickLength', [0.03 0.1])
else
set(gca,'xlim', [0, 4],'xtick',[1 2 3 4 5 6],'ylim',[0,800],'Ytick',[0 200 400 600 800 1000],'Yticklabel',[],'Fontsize', 10,'TickLength', [0.03 0.1])    
end
set(h, 'linewidth', 1.5, 'Markersize',3)
set(h(2), 'Markerfacecolor','b')
set(h(3), 'Markerfacecolor',[0, 0.5 0])
%hleg = legend(h([1, 3]), 'PMA+Ionomycin','DMSO control');
%set(hleg,'fontsize',9)
%legend boxoff
cnt=cnt+1;
end;

cnt = 0
for ind = [ 22 24 27 32 35 43 45 46];%[7 10 13 14 16 17 18 21 22 24 27 32 35 41 43 45 46]
%[ 8  14 15 16 17 20 27 28 30 34 35 36  38 39 43 44 45 ]
SInd = IndexMatch{ind}(1);
WInd = IndexMatch{ind}(2);
Scan = Data.Activated(SInd).scan;
rangex=Scan.Well(WInd).rangex;
rangey=Scan.Well(WInd).rangey;

axes('Position', [0.08+0.11*cnt 0.04 0.1 0.07])

h = plot(t, delayedLinear(Scan.Well(WInd).FitParam,t)-Scan.Well(WInd).FitParam(1),'--k',time(2:2:end), Scan.Well(WInd).score(2:2:end)-Scan.Well(WInd).FitParam(1), 'o', time, AllScoresCont(:,3)-repmat(AllScoresCont(1,3),121,1),'o')
if cnt == 0
yl = ylabel('IL-2 (a.u.)','Fontsize', 10)
xl = xlabel('Time (h)','Fontsize', 10)
set(gca,'xlim', [0, 4],'xtick',[1 2 3 4 5 6],'ylim',[0,800],'Ytick',[0 200 400 600 800 1000],'Yticklabel',[0 2 4 6 8 10],'Fontsize', 10,'TickLength', [0.03 0.1])
else
set(gca,'xlim', [0, 4],'xtick',[1 2 3 4 5 6],'ylim',[0,800],'Ytick',[0 200 400 600 800 1000],'Yticklabel',[],'Fontsize', 10,'TickLength', [0.03 0.1])    
end
set(h, 'linewidth', 1.5, 'Markersize',3)
set(h(2), 'Markerfacecolor','b')
set(h(3), 'Markerfacecolor',[0, 0.5 0])
%hleg = legend(h([1, 3]), 'PMA+Ionomycin','DMSO control');
%set(hleg,'fontsize',9)
%legend boxoff
cnt=cnt+1;
end;

        annotation('arrow', [0.825 0.825], [0.3 0.45])
        annotation('arrow', [0.055 0.055], [0.03 0.2])
        annotation('arrow', [0.08 0.82], [0.015 0.015])
        
        
        %annotation('arrow', [0.765 0.8], [0.48 0.46])
        %annotation('arrow', [0.765 0.8], [0.41 0.39])
        %annotation('arrow', [0.765 0.8], [0.34 0.32])
        
        annotation('textbox',[0.01 0.475, 0.2, 0.05],'string','Producer 1:','edgecolor','none')
        annotation('textbox',[0.01 0.405, 0.2, 0.05],'string','Producer 2:','edgecolor','none')
        annotation('textbox',[0.01 0.335, 0.2, 0.05],'string','Producer 3:','edgecolor','none')
        annotation('textbox',[0.01 0.265, 0.2, 0.05],'string','DMSO:','edgecolor','none')

        
        annotation('textbox',[0.841 0.445, 0.2, 0.05],'string','Producer 1','edgecolor','none','fontsize',7)
        annotation('textbox',[0.841 0.375, 0.2, 0.05],'string','Producer 2','edgecolor','none','fontsize',7)
        annotation('textbox',[0.841 0.305, 0.2, 0.05],'string','Producer 3','edgecolor','none','fontsize',7)
        
         a = annotation('textbox',[ 0.01 0.96    0.02    0.05],'string','A', 'Fontsize',TitleFontSize,'LineStyle','none')
 a = annotation('textbox',[ 0.01 0.76    0.02    0.05],'string','B', 'Fontsize',TitleFontSize,'LineStyle','none')
 a = annotation('textbox',[ 0.37 0.76    0.05    0.05],'string','C', 'Fontsize',TitleFontSize,'LineStyle','none')
 a = annotation('textbox',[ 0.01 0.5    0.05    0.05],'string','D', 'Fontsize',TitleFontSize,'LineStyle','none')   
 a = annotation('textbox',[ 0.76 0.5    0.05    0.05],'string','E', 'Fontsize',TitleFontSize,'LineStyle','none')   
 
  a = annotation('textbox',[ 0.01 0.19    0.05    0.05],'string','F', 'Fontsize',TitleFontSize,'LineStyle','none')
        
%%
    set(gcf, 'PaperPositionMode','auto')

savpath = '/Users/Alonyan/Desktop/';
        print(gcf,'-dpdf',[savpath ,'Untitled']);
%%      

        

        %annotation('arrow', [x0-dx x0+1.2*(width+dx)], [y1 y1]-0.03)
        
%%        
        
                    


    %     

    
    
    
   
% %%
% 
% fpath = '/Users/Alonyan/Google Drive/Experiments/In vivo/FoxP3 for paper'
% load([fpath filesep 'Process_InVivo08252015Foxp3'])
% 
% fpath = '/Users/Alonyan/Google Drive/Experiments/In vivo/In vivo_06222015_ALON - pSTAT5'
% load([fpath filesep 'Process_InVivo06222015New'])
% 
% 
% magenta = [1 0 1];cyan = [0 1 1];red = [1 0 0];lime = [0 1 0];green = [0 0.5 0]; blue = [0 0 1];
% black = [0 0 0];yellow = [1 1 0];orange = [255,140,0]./255;violet = [138,43,226]./255;purple = [128,0,128]./255;
% 
% color = [ blue' red' lime' violet' green' purple' yellow'  cyan'   orange'  black'  magenta'  ]
% close all
% set(0,'DefaultTextInterpreter', 'tex')
% set(0, 'DefaultAxesFontName', 'Arial')
% set(0, 'DefaultUIControlFontName', 'Arial')
% set(0,'defaulttextfontname','Arial');
%    Markersize = 5;
% BigFontSize = 16;
% AxisFontSize = 14;
% TitleFontSize = 15;
% 
% fig1 = figure('Position',[360   278   510   660],'Color',[1 1 1]);
% 
% 
% 
% 
% axes('Position', [0.09 .737 0.34 0.2230])
% 
% range = [1 2];
% xlim = [-0.5 8.5];
% i = 1;
% 
% data = proc_Samples.Controls;
% 
% LinearRange = 700;
% H = data.pSTAT5.H(:,range);
% X = data.pSTAT5.X;
% 
% h = plot(X,H./repmat(max(H),size(H,1),1),asinh([3000 3000]./LinearRange), [0,1] ,'--k'); figure(gcf)
%     set(h, 'LineWidth', 2.2);
%     set(gca, 'Xlim', xlim , 'Ylim', [1E-5 1] , 'FontSize', AxisFontSize)
% ylabel('Normalized Distribution', 'FontSize', AxisFontSize)
% xlabel('pSTAT5', 'FontSize', AxisFontSize)
% 
% 
%     for i = 1:length(h)-1
%         set(h(i), 'color', color(:,i+2)')
%     end
% 
%         a1 = sort(- (1:9)'*10.^(1:2)); 
%         a2 =(1:9)'*10.^(1:5);
%         a = [sort(a1(:)); 0; a2(:)];
% 
%         emptyStr = {''; ''; '';''; ''; '';''; ''};
%         XTickLabel = [emptyStr; '   '; emptyStr; {''}; '0'; {''}; emptyStr; '   '; emptyStr; '1'; emptyStr; '10'; emptyStr; '100'; emptyStr];
%         XTicks = asinh(a/LinearRange);
% 
%         set(gca, 'XTick', XTicks, 'XTickLabel', XTickLabel);
% 
% 
%      set(gca, 'Xlim', xlim , 'Ylim', [1E-5 1] , 'FontSize', AxisFontSize)
%     XThresh = asinh(Thresh./LinearRange);
% 
% FractionPositive = sum(H(X > XThresh,:))
% 
%         x = [6.2 8.5];
%         y = [0.4 1];
% scribepin = scribe.scribepin('parent',gca,'DataAxes',gca,'DataPosition',[x;y;[0,0]]');
% figPixelPos = scribepin.topixels;
% figPos = getpixelposition(gcf);
% figPixelPos(:,2) = figPos(4) - figPixelPos([2,1],2);
% figNormPos = hgconvertunits(gcf,[figPixelPos(1,1:2),diff(figPixelPos)],'pixels','norm',gcf);
% annotationX1 = figNormPos([1,1])+figNormPos(3)*[1,0];
% annotationY1 = figNormPos([2,2]) + figNormPos(4)*[1,0];
% 
% 
% axes('Position', [annotationX1(2) annotationY1(1) -diff(annotationX1) diff(annotationY1)])
% b(1) = bar(1,FractionPositive(1));
% set(b(1), 'FaceColor',get(h(1),'color'))
% hold on;
% b(2) = bar(2,FractionPositive(2));
% set(b(2), 'FaceColor',get(h(2),'color'))
% 
% yl = ylabel('Fraction pSTAT5+','Fontsize', 10)
% set(yl,'Position',[-0.36 0.39 0])
% set(gca,'xlim', [0.5 2.5],'ylim',[0 1],'Xtick',[0.7 1.7],'Xticklabel',{''; ''},'Fontsize', 11,'ytick', [0 0.5 1])
% %xticklabel_rotate([], 90)
% hleg = legend('Positive', 'Negative','Location','northoutside')
% legend boxoff;
% set(hleg,'Fontsize', 11)
% 
%          hLine = findobj(hleg);
%          set(hLine(6:7),'Xdata',[0.02    0.02    0.2    0.2   0.02])
%          set(hLine(3),'Position',[0.255 0.273989 0])
%                   set(hLine(5),'Position',[0.255 0.726011 0])
% 
% %
% 
% 
% 
% 
% 
% 
% 
% 
% % Controls LNs
% axes('Position', [0.55 0.85 0.15 0.11])
% 
% TregDataName = {'LNs_Tregs' 'Spleen_Tregs' 'Controls'};
% ranges = {[1 4], [5 2], [6 3]}
% 
% range = ranges{1};
% data = proc_Samples.(TregDataName{1});
% 
% xlim = [-0.5 5.5];
% 
% LinearRange = 700;
% 
% 
% H = data.pSTAT5.H(:,range);
% X = data.pSTAT5.X;
% 
% h = plot(X,H./repmat(max(H),size(H,1),1),asinh([Thresh Thresh]./LinearRange), [0,1] ,'--k'); figure(gcf)
%     set(h, 'LineWidth', 2.2);
%     set(gca, 'Xlim', xlim , 'Ylim', [1E-5 1] , 'FontSize', AxisFontSize,'TickLength', [0.03 0.1])
% 
% 
%     for i = 1:length(h)-1
%         set(h(i), 'color', color(:,i)')
%     end
%     %        set(h(end), 'color', red)
% 
% 
%         %a1 = - (1:9)'*10.^(1:3);
%         a1 = sort(- (1:9)'*10.^(1:2)); 
%         a2 =(1:9)'*10.^(1:5);
%         a = [sort(a1(:)); 0; a2(:)];
% 
%         emptyStr = {''; ''; '';''; ''; '';''; ''};
%         XTickLabel = [emptyStr; '   '; emptyStr; {''}; '0'; {''}; emptyStr; '   '; emptyStr; '1'; emptyStr; '10'; emptyStr; '100'; emptyStr];
%         XTicks = asinh(a/LinearRange);
% 
%         set(gca, 'XTick', XTicks, 'XTickLabel', []);
%   
%         
%         
%     set(gca, 'Xlim', xlim , 'Ylim', [1E-5 1] , 'FontSize', AxisFontSize)
%     XThresh = asinh(Thresh./LinearRange);
% 
% FractionPositive1 = sum(H(X > XThresh,:))
% 
%         x = [3.5 4];
%         y = [0.9 0.9];
% scribepin = scribe.scribepin('parent',gca,'DataAxes',gca,'DataPosition',[x;y;[0,0]]');
% figPixelPos = scribepin.topixels;
% figPos = getpixelposition(gcf);
% figPixelPos(:,2) = figPos(4) - figPixelPos([2,1],2);
% figNormPos = hgconvertunits(gcf,[figPixelPos(1,1:2),diff(figPixelPos)],'pixels','norm',gcf);
% annotationX1 = figNormPos([1,1])+figNormPos(3)*[1,0];
% annotationY1 = figNormPos([2,2]) + figNormPos(4)*[1,0];
% 
% 
%         annotation('textbox',[annotationX1(2) annotationY1(1)-0.04 -diff(annotationX1) 0.04],'string','Lymph Nodes','HorizontalAlignment' ,'center','LineStyle','none','Fontsize', 12)
%   
% 
% 
% 
% % Sp
% 
% axes('Position', [0.55 0.737 0.15 0.11])
% 
% TregDataName = {'LNs_Tregs' 'Spleen_Tregs' 'Controls'};
% ranges = {[4 1], [5 2], [6 3]}
% 
% range = ranges{1};
% data = proc_Samples.(TregDataName{2});
% 
% xlim = [-0.5 5.5];
% 
% LinearRange = 700;
% 
% 
% H = data.pSTAT5.H(:,range);
% X = data.pSTAT5.X;
% 
% h = plot(X,H./repmat(max(H),size(H,1),1),asinh([Thresh Thresh]./LinearRange), [0,1] ,'--k'); figure(gcf)
%     set(h, 'LineWidth', 2.2);
%     set(gca, 'Xlim', xlim , 'Ylim', [1E-5 1] , 'FontSize', AxisFontSize,'TickLength', [0.03 0.1])
% %title('Response to exogenous IL2 for cells in a cluster', 'FontSize', 28)
% yl = ylabel('Normalized Distribution', 'FontSize', AxisFontSize)
% set(yl,'Position', [-2.5 1 1.00011])
% xl = xlabel('pSTAT5', 'FontSize', AxisFontSize)
% set(xl,'Position',[2.66558 -0.24 1.00011])
% 
%     for i = 1:length(h)-1
%         set(h(i), 'color', color(:,i)')
%     end
%     %        set(h(end), 'color', red)
% 
% 
%         %a1 = - (1:9)'*10.^(1:3);
%         a1 = sort(- (1:9)'*10.^(1:2)); 
%         a2 =(1:9)'*10.^(1:5);
%         a = [sort(a1(:)); 0; a2(:)];
% 
%         emptyStr = {''; ''; '';''; ''; '';''; ''};
%         XTickLabel = [emptyStr; '   '; emptyStr; {''}; '0'; {''}; emptyStr; '   '; emptyStr; '1'; emptyStr; '10'; emptyStr; '100'; emptyStr];
%         XTicks = asinh(a/LinearRange);
% 
%         set(gca, 'XTick', XTicks, 'XTickLabel', XTickLabel);
%   
%         
%         
%     set(gca, 'Xlim', xlim , 'Ylim', [1E-5 1] , 'FontSize', AxisFontSize)
%     XThresh = asinh(Thresh./LinearRange);
% 
% FractionPositive2 = sum(H(X > XThresh,:))
% 
%         x = [3.5 4];
%         y = [0.9 0.9];
% scribepin = scribe.scribepin('parent',gca,'DataAxes',gca,'DataPosition',[x;y;[0,0]]');
% figPixelPos = scribepin.topixels;
% figPos = getpixelposition(gcf);
% figPixelPos(:,2) = figPos(4) - figPixelPos([2,1],2);
% figNormPos = hgconvertunits(gcf,[figPixelPos(1,1:2),diff(figPixelPos)],'pixels','norm',gcf);
% annotationX1 = figNormPos([1,1])+figNormPos(3)*[1,0];
% annotationY1 = figNormPos([2,2]) + figNormPos(4)*[1,0];
% 
% 
%         annotation('textbox',[annotationX1(2) annotationY1(1)-0.04 -diff(annotationX1) 0.04],'string','Spleen','HorizontalAlignment' ,'center','LineStyle','none','Fontsize', 12)
%   
% 
% 
% 
% axes('Position', [0.81 0.74 0.18 0.2])
% b(1) = bar(1,FractionPositive1(1));
% set(b(1), 'FaceColor',get(h(1),'color'))
% hold on;
% b(2) = bar(2,FractionPositive1(2));
% set(b(2), 'FaceColor',get(h(2),'color'))
% 
% b(3) = bar(3.5,FractionPositive2(1));
% set(b(3), 'FaceColor',get(h(1),'color'))
% 
% b(4) = bar(4.5,FractionPositive2(2));
% set(b(4), 'FaceColor',get(h(2),'color'))
% 
% ylabel('Fraction pSTAT5+','Fontsize', 15)
% %set(gca,'xlim', [0.5 5],'ylim',[0 1],'Xtick',[1 2 4 5],'Xticklabel',{'Wildtype';'Boosted'; 'Wildtype';'Boosted'},'Fontsize', AxisFontSize)
% set(gca,'xlim', [0.5 5],'ylim',[0 1],'Xtick',[1.5 4],'Xticklabel',{[]},'Fontsize', AxisFontSize)
% set(gca,'ytick', [0 0.2 0.4 0.6 0.8 1],'TickLength', [0.03 0.1])
% 
% hleg = legend('Wildtype','Boosted')
% legend boxoff
% set(hleg,'Fontsize', 11,'Location','northoutside')
% 
% hLine = findobj(hleg);
% set(hLine(6:7),'XData',[ 0.07 0.07 0.25 0.25 0.07])
% set(hLine(3),'Position',[0.305 0.273989 0])
% set(hLine(5),'Position',[0.305 0.726011 0])
% 
% %xticklabel_rotate([], 45)
% 
%         x = [1 2];
%         y = [-0.1 -0.1];
% scribepin = scribe.scribepin('parent',gca,'DataAxes',gca,'DataPosition',[x;y;[0,0]]');
% figPixelPos = scribepin.topixels;
% figPos = getpixelposition(gcf);
% figPixelPos(:,2) = figPos(4) - figPixelPos([2,1],2);
% figNormPos = hgconvertunits(gcf,[figPixelPos(1,1:2),diff(figPixelPos)],'pixels','norm',gcf);
% annotationX1 = figNormPos([1,1])+figNormPos(3)*[1,0];
% annotationY1 = figNormPos([2,2]) + figNormPos(4)*[1,0];
% 
% 
%         annotation('line',annotationX1,annotationY1,'Linewidth', 1.5) 
%         annotation('textbox',[annotationX1(2) annotationY1(1)-0.04 -diff(annotationX1) 0.04],'string','Lymph  Nodes','HorizontalAlignment' ,'center','LineStyle','none','Fontsize', 12)
%   
% 
%                 x = [3.5 4.5];
% scribepin = scribe.scribepin('parent',gca,'DataAxes',gca,'DataPosition',[x;y;[0,0]]');
% figPixelPos = scribepin.topixels;
% figPos = getpixelposition(gcf);
% figPixelPos(:,2) = figPos(4) - figPixelPos([2,1],2);
% figNormPos = hgconvertunits(gcf,[figPixelPos(1,1:2),diff(figPixelPos)],'pixels','norm',gcf);
% annotationX1 = figNormPos([1,1])+figNormPos(3)*[1,0];
% annotationY1 = figNormPos([2,2]) + figNormPos(4)*[1,0];
% 
% 
%         annotation('line',annotationX1,annotationY1,'Linewidth', 1.5) 
%         annotation('textbox',[annotationX1(2) annotationY1(1)-0.04 -diff(annotationX1) 0.04],'string','Spleen','HorizontalAlignment' ,'center','LineStyle','none','Fontsize', 12)
%   
%         
%       
% axes('Position', [0.62 0.51  0.15 0.11])
% [h,LRx, ~] = ScatterPlotByTag_v1(AllCells,{'<FITC-A>: CD4'},'Nbins',100,'PlotGate',CD4Gate(1:2,1),'Xlim',[-100 100000])
% set(gca,'Xlim',[-1.5 6])
% xl = xlabel('CD4', 'Fontsize', AxisFontSize)
% set(xl,'Position',get(xl,'Position').*[1 0.3 1])
% 
% yl = ylabel('Cell #', 'Fontsize', AxisFontSize)
% set(yl,'Position',[-3 316.096 1.00011])
%         a1 = sort(- (1:9)'*10.^(1:2)); 
%         a2 =(1:9)'*10.^(1:5);
%         a = [sort(a1(:)); 0; a2(:)];
% 
%         emptyStr = {''; ''; '';''; ''; '';''; ''};
%         XTickLabel = [emptyStr; ''; emptyStr; {''}; '0'; {''}; emptyStr; ''; emptyStr; '   1'; emptyStr; '   10'; emptyStr; ''; emptyStr];
%         XTicks = asinh(a/LRx);
%           
%         set(gca, 'XTick', XTicks, 'XTickLabel', XTickLabel,'TickLength', [0.03 0.1],'Ylim', [0 650],'Ytick', [0 200 400 600],'YtickLabel',[0 2 4 6]);
% annotation('textbox',[0.61 0.61  0.3 0.04] ,'String','\times 10^2','LineStyle','none');
% 
% % ,'PlotGate',Foxp3Gate
% axes('Position', [0.83 0.51  0.15 0.11])
% 
% [h,LRx, LRy] = ScatterPlotByTag_v1(CD4, { '<PE-Gr-A>: CD25'  '<APC-A>: Foxp3' },'Nbins',20,'Ylim',[-100 12000],'Xlim',[-100 30000],'MaxPointsToPlot',50000)
% 
% 
%         a1 = sort(- (1:9)'*10.^(1:2)); 
%         a2 =(1:9)'*10.^(1:5);
%         a = [sort(a1(:)); 0; a2(:)];
% 
%         emptyStr = {''; ''; '';''; ''; '';''; ''};
%         XTickLabel = [emptyStr; ''; emptyStr; {''}; '0'; {''}; emptyStr; ''; emptyStr; '   1'; emptyStr; '   10'; emptyStr; ''; emptyStr];
%         XTicks = asinh(a/LRx);
%         YTicks = asinh(a/LRy);
%           
%         set(gca, 'XTick', XTicks, 'XTickLabel', XTickLabel, 'YTick', YTicks, 'YTickLabel', XTickLabel,'TickLength', [0.03 0.1],'Box','on');
% xl = xlabel('CD25', 'Fontsize', AxisFontSize);
% set(xl,'Position',get(xl,'Position')+[0 0.3 0]);
% 
% yl = ylabel('FoxP3', 'Fontsize', AxisFontSize);
% set(yl,'Position' ,[-2.5 1.68421 1.00011])
% annotation('arrow', [0.77 0.83], [0.61 0.61])
% 
% 
%         
%         
%         
%         
%     fpath = '/Users/Alonyan/Google Drive/Experiments/In vivo/In vivo 05182015 - Milt!/IL2 miltenyi'
% load([fpath filesep 'Process_InVivoMilt051815'])
% 
%     
%         %
%    ax1 = axes('Position',[0.07 0.5 0.18 0.13]);
% nameList = {'5E6';'5E5'; '5E6';'5E5'}
% 
% b(1) = bar([1 4],asinh(proc_Samples.LNs_Positive.PE.geomeanD([2 1])./LinearRange),0.25,'b')
% hold on;
% b(2) = bar([2 5],asinh(proc_Samples.LNs_Positive.PE.geomeanD([4 3])./LinearRange),0.25,'r')
% 
% b(3) = bar([1 4]+6,asinh(proc_Samples.Spleen_Positive.PE.geomeanD([2 1])./LinearRange),0.25,'b')
% b(4) = bar([2 5]+6,asinh(proc_Samples.Spleen_Positive.PE.geomeanD([4 3])./LinearRange),0.25,'r')
% 
% set(gca, 'YTick', XTicks, 'YTickLabel', XTickLabel,'Fontsize', AxisFontSize);
% 
% %hleg = legend('Wildtype','IL2ic Boosted')
% %set(hleg,'Location','northwest','Fontsize', 11)
% %legend boxoff;
% yl = ylabel('IL2 GMFI','Fontsize',AxisFontSize)
% set(yl,'Position',[-1.5    1.4511    1.0001])
%         figure(gcf)
%         set(gca,'XTick', [1.5  4.5 1.5+6   4.5+6], 'XTickLabel', nameList([2 1 2 1]), 'Xlim', [0 12], 'Ylim', [0 3],'Fontsize', 11)
%         hold off;
% 
%         
%         
%         x = [1.5 4.5];
%         y = [-0.7 -0.7];
% scribepin = scribe.scribepin('parent',ax1,'DataAxes',ax1,'DataPosition',[x;y;[0,0]]');
% figPixelPos = scribepin.topixels;
% figPos = getpixelposition(gcf);
% figPixelPos(:,2) = figPos(4) - figPixelPos([2,1],2);
% figNormPos = hgconvertunits(gcf,[figPixelPos(1,1:2),diff(figPixelPos)],'pixels','norm',gcf);
% annotationX1 = figNormPos([1,1])+figNormPos(3)*[1,0];
% annotationY1 = figNormPos([2,2]) + figNormPos(4)*[1,0];
% 
% 
%         annotation('line',annotationX1,annotationY1,'Linewidth', 1.5) 
%         annotation('textbox',[annotationX1(2) annotationY1(1)-0.04 -diff(annotationX1) 0.04],'string','Lymph  Nodes','HorizontalAlignment' ,'center','LineStyle','none','Fontsize', 12)
%         
%                 x = [1.5 4.5]+6;
% scribepin = scribe.scribepin('parent',ax1,'DataAxes',ax1,'DataPosition',[x;y;[0,0]]');
% figPixelPos = scribepin.topixels;
% figPos = getpixelposition(gcf);
% figPixelPos(:,2) = figPos(4) - figPixelPos([2,1],2);
% figNormPos = hgconvertunits(gcf,[figPixelPos(1,1:2),diff(figPixelPos)],'pixels','norm',gcf);
% annotationX2 = figNormPos([1,1])+figNormPos(3)*[1,0];
% annotationY2 = figNormPos([2,2]) + figNormPos(4)*[1,0];
% 
% 
%         annotation('line',annotationX2,annotationY2,'Linewidth', 1.5) 
%                 annotation('textbox',[annotationX2(2) annotationY2(1)-0.04 -diff(annotationX2) 0.04],'string','Spleen','HorizontalAlignment' ,'center','LineStyle','none','Fontsize', 12)
% 
%                 
%                 
%                 
%                 skip1 = 0.28;
%                 
%                 ax1 = axes('Position',[0.07+skip1 0.5 0.18 0.13]);
% 
% nameList = {'5E6';'5E5'; '5E6';'5E5'}
% 
% b(1) = bar([1 4],proc_Samples.LNs_Producers.PosFrac([2 1]),0.25,'b')
% hold on;
% b(2) = bar([2 5],proc_Samples.LNs_Producers.PosFrac([4 3]),0.25,'r')
% 
% b(3) = bar([1 4]+6,proc_Samples.Spleen_Producers.PosFrac([2 1]),0.25,'b')
% b(4) = bar([2 5]+6,proc_Samples.Spleen_Producers.PosFrac([4 3]),0.25,'r')
% 
% %
% set(gca, 'Ylim', [0 1]);
% % hleg = legend('Wildtype','IL2ic Boosted')
% % set(hleg,'Location','northwest','Fontsize', 11)
% % legend boxoff;
% ylabel('Fraction producing','Fontsize', AxisFontSize)
%         figure(gcf)
%         set(gca,'XTick', [1.5  4.5 1.5+6   4.5+6], 'XTickLabel', nameList([2 1 2 1]), 'Xlim', [0 12],'Fontsize', 11)
%         hold off;
% 
%         
% 
%         annotation('line',annotationX1+skip1,annotationY1,'Linewidth', 1.5) 
%         annotation('textbox',[annotationX1(2)+skip1 annotationY1(1)-0.04 -diff(annotationX1) 0.04],'string','Lymph  Nodes','HorizontalAlignment' ,'center','LineStyle','none','Fontsize', 12)
%         
%         annotation('line',annotationX2+skip1,annotationY2,'Linewidth', 1.5) 
%         annotation('textbox',[annotationX2(2)+skip1 annotationY2(1)-0.04 -diff(annotationX2) 0.04],'string','Spleen','HorizontalAlignment' ,'center','LineStyle','none','Fontsize', 12)
% 
%         
%          a = annotation('textbox',[ 0.0 0.95    0.05    0.05],'string','A', 'Fontsize',TitleFontSize,'LineStyle','none')
%          
%  a = annotation('textbox',[ 0.47 0.95    0.05    0.05],'string','B', 'Fontsize',TitleFontSize,'LineStyle','none')
%  
%  a = annotation('textbox',[ 0.0 0.62    0.05    0.05],'string','C', 'Fontsize',TitleFontSize,'LineStyle','none')
%  
%  a = annotation('textbox',[ 0.555 0.62    0.05    0.05],'string','D', 'Fontsize',TitleFontSize,'LineStyle','none')
%  
%       %   fig1 = figure('Position',[360   278   510   660],'Color',[1 1 1]);
% 
%  a = annotation('textbox',[ 0.0 0.38    0.05    0.05],'string','E', 'Fontsize',TitleFontSize,'LineStyle','none')
% 
% 
%       
%         
%         x0 = 0.08;
%         x1 = 0.52;
% 
%         y0=0.07;
%         margin = 0.012;
%         width = 0.14;
%         
% 
% rati = 660/510
% 
% axes('Position',[x0 y0 width*rati width])
% 
% i=2;
% [h, LRx, LRy] = ScatterPlotByTag_v1(LNs_AllT(i), { '<APC-A>: CTFR'  'SSC-A' },'Nbins',20,'Xlim',[-100 100000], 'Ylim',[-100 110000],'MaxPointsToPlot',200000,'LogYscale', 0, 'PlotGate',GateProds);
% set(gca,'Xlim',[-1.5 7.5], 'Ylim',[0 100000],'TickLength', [0.03 0.1],'Box','on')
% 
% 
%         a1 = sort(- (1:9)'*10.^(1:2)); 
%         a2 =(1:9)'*10.^(1:5);
%         a = [sort(a1(:)); 0; a2(:)];
% 
%         emptyStr = {''; ''; '';''; ''; '';''; ''};
%         XTickLabel = [emptyStr; ''; emptyStr; {''}; '0'; {''}; emptyStr; ''; emptyStr; '   1'; emptyStr; '   10'; emptyStr; ''; emptyStr];
%         XTicks = asinh(a/LRx);
%           
%         set(gca, 'XTick', XTicks, 'XTickLabel', XTickLabel, 'YTick', [0 50000 100000], 'YTickLabel', [0 5 10],'TickLength', [0.03 0.1],'Box','on');
% yl = ylabel('Side Scatter','Fontsize', AxisFontSize)
% xl = xlabel('CTFR','Fontsize', AxisFontSize)
% 
% %set(yl,'Position',[-3.1 75000 1.00011])
% set(xl,'Position',[2.90909 -22000 1.00011])  
% 
% 
%         x = [-2.9 -2.9];
%         y = [-16500 125000];
% scribepin = scribe.scribepin('parent',gca,'DataAxes',gca,'DataPosition',[x;y;[0,0]]');
% figPixelPos = scribepin.topixels;
% figPos = getpixelposition(gcf);
% figPixelPos(:,2) = figPos(4) - figPixelPos([2,1],2);
% figNormPos = hgconvertunits(gcf,[figPixelPos(1,1:2),diff(figPixelPos)],'pixels','norm',gcf);
% annotationX1 = figNormPos([1,1])+figNormPos(3)*[1,0];
% annotationY1 = figNormPos([2,2]) + figNormPos(4)*[1,0];
% 
% annotation('arrow', annotationX1, annotationY1)
% 
%         x = [-2.9 10];
%         y = [-16500 -16500];
% scribepin = scribe.scribepin('parent',gca,'DataAxes',gca,'DataPosition',[x;y;[0,0]]');
% figPixelPos = scribepin.topixels;
% figPos = getpixelposition(gcf);
% figPixelPos(:,2) = figPos(4) - figPixelPos([2,1],2);
% figNormPos = hgconvertunits(gcf,[figPixelPos(1,1:2),diff(figPixelPos)],'pixels','norm',gcf);
% annotationX1 = figNormPos([1,1])+figNormPos(3)*[1,0];
% annotationY1 = figNormPos([2,2]) + figNormPos(4)*[1,0];
% 
% annotation('arrow', annotationX1([2 1]), annotationY1)
% 
% 
% 
% 
%         x = [4.1 6];
%         y = [65000 75000];
% scribepin = scribe.scribepin('parent',gca,'DataAxes',gca,'DataPosition',[x;y;[0,0]]');
% figPixelPos = scribepin.topixels;
% figPos = getpixelposition(gcf);
% figPixelPos(:,2) = figPos(4) - figPixelPos([2,1],2);
% figNormPos = hgconvertunits(gcf,[figPixelPos(1,1:2),diff(figPixelPos)],'pixels','norm',gcf);
% annotationX1 = figNormPos([1,1])+figNormPos(3)*[1,0];
% annotationY1 = figNormPos([2,2]) + figNormPos(4)*[1,0];
% 
% annotation('textbox',[annotationX1(2) annotationY1(1) -diff(annotationX1) diff(annotationY1)],'String',num2str(100./TcellsperProd_LNs(i),2),'LineStyle', 'none')
% 
% 
% axes('Position',[x0+width*rati+margin*rati y0 width*rati width])
% 
% i=3;
% [h, LRx, LRy] = ScatterPlotByTag_v1(LNs_AllT(i), { '<APC-A>: CTFR'  'SSC-A' },'Nbins',20,'Xlim',[-100 100000], 'Ylim',[-100 110000],'MaxPointsToPlot',200000,'LogYscale', 0, 'PlotGate',GateProds);
% set(gca,'Xlim',[-1.5 7.5], 'Ylim',[0 100000],'TickLength', [0.03 0.1],'Box','on')
% 
% 
%         a1 = sort(- (1:9)'*10.^(1:2)); 
%         a2 =(1:9)'*10.^(1:5);
%         a = [sort(a1(:)); 0; a2(:)];
% 
%         emptyStr = {''; ''; '';''; ''; '';''; ''};
%         XTickLabel = [emptyStr; ''; emptyStr; {''}; '0'; {''}; emptyStr; ''; emptyStr; '   1'; emptyStr; '   10'; emptyStr; ''; emptyStr];
%         XTicks = asinh(a/LRx);
%           
%         set(gca, 'XTick', XTicks, 'XTickLabel', XTickLabel, 'YTick', [0 50000 100000], 'YTickLabel', [],'TickLength', [0.03 0.1],'Box','on');
% ylabel('','Fontsize', AxisFontSize)
% xlabel('','Fontsize', AxisFontSize)
% 
%         
%         x = [4.1 6];
%         y = [65000 75000];
% scribepin = scribe.scribepin('parent',gca,'DataAxes',gca,'DataPosition',[x;y;[0,0]]');
% figPixelPos = scribepin.topixels;
% figPos = getpixelposition(gcf);
% figPixelPos(:,2) = figPos(4) - figPixelPos([2,1],2);
% figNormPos = hgconvertunits(gcf,[figPixelPos(1,1:2),diff(figPixelPos)],'pixels','norm',gcf);
% annotationX1 = figNormPos([1,1])+figNormPos(3)*[1,0];
% annotationY1 = figNormPos([2,2]) + figNormPos(4)*[1,0];
% 
% annotation('textbox',[annotationX1(2) annotationY1(1) -diff(annotationX1) diff(annotationY1)],'String',num2str(100./TcellsperProd_LNs(i),2),'LineStyle', 'none')
% 
% axes('Position',[x0 y0+width+margin width*rati width])
% 
% i=5;
% [h, LRx, LRy] = ScatterPlotByTag_v1(LNs_AllT(i), { '<APC-A>: CTFR'  'SSC-A' },'Nbins',20,'Xlim',[-100 100000], 'Ylim',[-100 110000],'MaxPointsToPlot',200000,'LogYscale', 0, 'PlotGate',GateProds);
% set(gca,'Xlim',[-1.5 7.5], 'Ylim',[0 100000],'TickLength', [0.03 0.1],'Box','on')
% 
% 
%         a1 = sort(- (1:9)'*10.^(1:2)); 
%         a2 =(1:9)'*10.^(1:5);
%         a = [sort(a1(:)); 0; a2(:)];
% 
%         emptyStr = {''; ''; '';''; ''; '';''; ''};
%         XTickLabel = [emptyStr; ''; emptyStr; {''}; '0'; {''}; emptyStr; ''; emptyStr; '   1'; emptyStr; '   10'; emptyStr; ''; emptyStr];
%         XTicks = asinh(a/LRx);
%           
%         set(gca, 'XTick', XTicks, 'XTickLabel', [], 'YTick', [0 50000 100000], 'YTickLabel', [0 5 10],'TickLength', [0.03 0.1],'Box','on');
% ylabel('','Fontsize', AxisFontSize)
% xlabel('','Fontsize', AxisFontSize)
% 
%         
%         x = [4.1 6];
%         y = [65000 75000];
% scribepin = scribe.scribepin('parent',gca,'DataAxes',gca,'DataPosition',[x;y;[0,0]]');
% figPixelPos = scribepin.topixels;
% figPos = getpixelposition(gcf);
% figPixelPos(:,2) = figPos(4) - figPixelPos([2,1],2);
% figNormPos = hgconvertunits(gcf,[figPixelPos(1,1:2),diff(figPixelPos)],'pixels','norm',gcf);
% annotationX1 = figNormPos([1,1])+figNormPos(3)*[1,0];
% annotationY1 = figNormPos([2,2]) + figNormPos(4)*[1,0];
% 
% annotation('textbox',[annotationX1(2) annotationY1(1) -diff(annotationX1) diff(annotationY1)],'String',num2str(100./TcellsperProd_LNs(i),2),'LineStyle', 'none')
% 
% 
% 
% 
% 
% axes('Position',[x0+margin*rati+width*rati y0+margin+width width*rati width])
% 
% i=6;
% [h, LRx, LRy] = ScatterPlotByTag_v1(LNs_AllT(i), { '<APC-A>: CTFR'  'SSC-A' },'Nbins',20,'Xlim',[-100 100000], 'Ylim',[-100 110000],'MaxPointsToPlot',200000,'LogYscale', 0, 'PlotGate',GateProds);
% set(gca,'Xlim',[-1.5 7.5], 'Ylim',[0 100000],'TickLength', [0.03 0.1],'Box','on')
% 
% 
%         a1 = sort(- (1:9)'*10.^(1:2)); 
%         a2 =(1:9)'*10.^(1:5);
%         a = [sort(a1(:)); 0; a2(:)];
% 
%         emptyStr = {''; ''; '';''; ''; '';''; ''};
%         XTickLabel = [emptyStr; ''; emptyStr; {''}; '0'; {''}; emptyStr; ''; emptyStr; '   1'; emptyStr; '   10'; emptyStr; ''; emptyStr];
%         XTicks = asinh(a/LRx);
%           
%         set(gca, 'XTick', XTicks, 'XTickLabel', [], 'YTick', [0 50000 100000], 'YTickLabel', [],'TickLength', [0.03 0.1],'Box','on');
% ylabel('','Fontsize', AxisFontSize)
% xlabel('','Fontsize', AxisFontSize)
% 
%         
%         x = [4.1 6];
%         y = [65000 75000];
% scribepin = scribe.scribepin('parent',gca,'DataAxes',gca,'DataPosition',[x;y;[0,0]]');
% figPixelPos = scribepin.topixels;
% figPos = getpixelposition(gcf);
% figPixelPos(:,2) = figPos(4) - figPixelPos([2,1],2);
% figNormPos = hgconvertunits(gcf,[figPixelPos(1,1:2),diff(figPixelPos)],'pixels','norm',gcf);
% annotationX1 = figNormPos([1,1])+figNormPos(3)*[1,0];
% annotationY1 = figNormPos([2,2]) + figNormPos(4)*[1,0];
% 
% annotation('textbox',[annotationX1(2) annotationY1(1) -diff(annotationX1) diff(annotationY1)],'String',num2str(100./TcellsperProd_LNs(i),2),'LineStyle', 'none')
% 
% 
% axes('Position',[x1 y0 width*rati width])
% 
% i=2;
% [h, LRx, LRy] = ScatterPlotByTag_v1(Spleen_AllT(i), { '<APC-A>: CTFR'  'SSC-A' },'Nbins',20,'Xlim',[-100 100000], 'Ylim',[-100 110000],'MaxPointsToPlot',200000,'LogYscale', 0, 'PlotGate',GateProds);
% set(gca,'Xlim',[-1.5 7.5], 'Ylim',[0 100000],'TickLength', [0.03 0.1],'Box','on')
% 
% 
%         a1 = sort(- (1:9)'*10.^(1:2)); 
%         a2 =(1:9)'*10.^(1:5);
%         a = [sort(a1(:)); 0; a2(:)];
% 
%         emptyStr = {''; ''; '';''; ''; '';''; ''};
%         XTickLabel = [emptyStr; ''; emptyStr; {''}; '0'; {''}; emptyStr; ''; emptyStr; '   1'; emptyStr; '   10'; emptyStr; ''; emptyStr];
%         XTicks = asinh(a/LRx);
%           
%         set(gca, 'XTick', XTicks, 'XTickLabel', XTickLabel, 'YTick', [0 50000 100000], 'YTickLabel', [0 5 10],'TickLength', [0.03 0.1],'Box','on');
% ylabel('','Fontsize', AxisFontSize)
% xlabel('','Fontsize', AxisFontSize)
% 
%         
%         x = [4.1 6];
%         y = [65000 75000];
% scribepin = scribe.scribepin('parent',gca,'DataAxes',gca,'DataPosition',[x;y;[0,0]]');
% figPixelPos = scribepin.topixels;
% figPos = getpixelposition(gcf);
% figPixelPos(:,2) = figPos(4) - figPixelPos([2,1],2);
% figNormPos = hgconvertunits(gcf,[figPixelPos(1,1:2),diff(figPixelPos)],'pixels','norm',gcf);
% annotationX1 = figNormPos([1,1])+figNormPos(3)*[1,0];
% annotationY1 = figNormPos([2,2]) + figNormPos(4)*[1,0];
% 
% annotation('textbox',[annotationX1(2) annotationY1(1) -diff(annotationX1) diff(annotationY1)],'String',num2str(100./TcellsperProd_Sp(i),2),'LineStyle', 'none')
% 
% 
% axes('Position',[x1+width*rati+margin*rati y0 width*rati width])
% 
% i=3;
% [h, LRx, LRy] = ScatterPlotByTag_v1(Spleen_AllT(i), { '<APC-A>: CTFR'  'SSC-A' },'Nbins',20,'Xlim',[-100 100000], 'Ylim',[-100 110000],'MaxPointsToPlot',200000,'LogYscale', 0, 'PlotGate',GateProds);
% set(gca,'Xlim',[-1.5 7.5], 'Ylim',[0 100000],'TickLength', [0.03 0.1],'Box','on')
% 
% 
%         a1 = sort(- (1:9)'*10.^(1:2)); 
%         a2 =(1:9)'*10.^(1:5);
%         a = [sort(a1(:)); 0; a2(:)];
% 
%         emptyStr = {''; ''; '';''; ''; '';''; ''};
%         XTickLabel = [emptyStr; ''; emptyStr; {''}; '0'; {''}; emptyStr; ''; emptyStr; '   1'; emptyStr; '   10'; emptyStr; ''; emptyStr];
%         XTicks = asinh(a/LRx);
%           
%         set(gca, 'XTick', XTicks, 'XTickLabel', XTickLabel, 'YTick', [0 50000 100000], 'YTickLabel', [],'TickLength', [0.03 0.1],'Box','on');
% ylabel('','Fontsize', AxisFontSize)
% xlabel('','Fontsize', AxisFontSize)
% 
%         
%         x = [4.1 6];
%         y = [65000 75000];
% scribepin = scribe.scribepin('parent',gca,'DataAxes',gca,'DataPosition',[x;y;[0,0]]');
% figPixelPos = scribepin.topixels;
% figPos = getpixelposition(gcf);
% figPixelPos(:,2) = figPos(4) - figPixelPos([2,1],2);
% figNormPos = hgconvertunits(gcf,[figPixelPos(1,1:2),diff(figPixelPos)],'pixels','norm',gcf);
% annotationX1 = figNormPos([1,1])+figNormPos(3)*[1,0];
% annotationY1 = figNormPos([2,2]) + figNormPos(4)*[1,0];
% 
% annotation('textbox',[annotationX1(2) annotationY1(1) -diff(annotationX1) diff(annotationY1)],'String',num2str(100./TcellsperProd_Sp(i),2),'LineStyle', 'none')
% 
% 
% 
% axes('Position',[x1 y0+width+margin width*rati width])
% 
% i=5;
% [h, LRx, LRy] = ScatterPlotByTag_v1(Spleen_AllT(i), { '<APC-A>: CTFR'  'SSC-A' },'Nbins',20,'Xlim',[-100 100000], 'Ylim',[-100 110000],'MaxPointsToPlot',200000,'LogYscale', 0, 'PlotGate',GateProds);
% set(gca,'Xlim',[-1.5 7.5], 'Ylim',[0 100000],'TickLength', [0.03 0.1],'Box','on')
% 
% 
%         a1 = sort(- (1:9)'*10.^(1:2)); 
%         a2 =(1:9)'*10.^(1:5);
%         a = [sort(a1(:)); 0; a2(:)];
% 
%         emptyStr = {''; ''; '';''; ''; '';''; ''};
%         XTickLabel = [emptyStr; ''; emptyStr; {''}; '0'; {''}; emptyStr; ''; emptyStr; '   1'; emptyStr; '   10'; emptyStr; ''; emptyStr];
%         XTicks = asinh(a/LRx);
%           
%         set(gca, 'XTick', XTicks, 'XTickLabel', [], 'YTick', [0 50000 100000], 'YTickLabel', [0 5 10],'TickLength', [0.03 0.1],'Box','on');
% ylabel('','Fontsize', AxisFontSize)
% xlabel('','Fontsize', AxisFontSize)
% 
%         
%         x = [4.1 6];
%         y = [65000 75000];
% scribepin = scribe.scribepin('parent',gca,'DataAxes',gca,'DataPosition',[x;y;[0,0]]');
% figPixelPos = scribepin.topixels;
% figPos = getpixelposition(gcf);
% figPixelPos(:,2) = figPos(4) - figPixelPos([2,1],2);
% figNormPos = hgconvertunits(gcf,[figPixelPos(1,1:2),diff(figPixelPos)],'pixels','norm',gcf);
% annotationX1 = figNormPos([1,1])+figNormPos(3)*[1,0];
% annotationY1 = figNormPos([2,2]) + figNormPos(4)*[1,0];
% 
% annotation('textbox',[annotationX1(2) annotationY1(1) -diff(annotationX1) diff(annotationY1)],'String',num2str(100./TcellsperProd_Sp(i),2),'LineStyle', 'none')
% 
% 
% 
% axes('Position',[x1+margin*rati+width*rati y0+margin+width width*rati width])
% 
% i=6;
% [h, LRx, LRy] = ScatterPlotByTag_v1(Spleen_AllT(i), { '<APC-A>: CTFR'  'SSC-A' },'Nbins',20,'Xlim',[-100 100000], 'Ylim',[-100 110000],'MaxPointsToPlot',200000,'LogYscale', 0, 'PlotGate',GateProds);
% set(gca,'Xlim',[-1.5 7.5], 'Ylim',[0 100000],'TickLength', [0.03 0.1],'Box','on')
% 
% 
%         a1 = sort(- (1:9)'*10.^(1:2)); 
%         a2 =(1:9)'*10.^(1:5);
%         a = [sort(a1(:)); 0; a2(:)];
% 
%         emptyStr = {''; ''; '';''; ''; '';''; ''};
%         XTickLabel = [emptyStr; ''; emptyStr; {''}; '0'; {''}; emptyStr; ''; emptyStr; '   1'; emptyStr; '   10'; emptyStr; ''; emptyStr];
%         XTicks = asinh(a/LRx);
%           
%         set(gca, 'XTick', XTicks, 'XTickLabel', [], 'YTick', [0 50000 100000], 'YTickLabel', [],'TickLength', [0.03 0.1],'Box','on');
% ylabel('','Fontsize', AxisFontSize)
% xlabel('','Fontsize', AxisFontSize)
% 
%         
%         x = [4.1 6];
%         y = [65000 75000];
% scribepin = scribe.scribepin('parent',gca,'DataAxes',gca,'DataPosition',[x;y;[0,0]]');
% figPixelPos = scribepin.topixels;
% figPos = getpixelposition(gcf);
% figPixelPos(:,2) = figPos(4) - figPixelPos([2,1],2);
% figNormPos = hgconvertunits(gcf,[figPixelPos(1,1:2),diff(figPixelPos)],'pixels','norm',gcf);
% annotationX1 = figNormPos([1,1])+figNormPos(3)*[1,0];
% annotationY1 = figNormPos([2,2]) + figNormPos(4)*[1,0];
% 
% annotation('textbox',[annotationX1(2) annotationY1(1) -diff(annotationX1) diff(annotationY1)],'String',num2str(100./TcellsperProd_Sp(i),2),'LineStyle', 'none')
% 
% AnnotX1 = [x0+0.5*(width*rati) x0+1.5*width*rati+margin*rati]
% AnnotX2 = [x1+0.5*(width*rati) x1+1.5*width*rati+margin*rati]
% AnnotY = [0.37 0.37]
% annotation('line', AnnotX1,AnnotY,'Linewidth', 1.5) 
%         annotation('textbox',[AnnotX1(1) AnnotY(1) diff(AnnotX1) 0.03],'string','Lymph Nodes','HorizontalAlignment' ,'center','LineStyle','none','Fontsize', 12)
% 
% annotation('line', AnnotX2,AnnotY,'Linewidth', 1.5) 
%         annotation('textbox',[AnnotX2(1) AnnotY(1) diff(AnnotX2) 0.03],'string','Spleen','HorizontalAlignment' ,'center','LineStyle','none','Fontsize', 12)
% %%
%     set(gcf, 'PaperPositionMode','auto')
%     saveas(gcf,['/Users/Alonyan/Google Drive/School/My Papers/Screening Paper/Figures/' ,'FigureSup5'],'epsc');
% 
%     
%     
    
    
    
    
    
    
    
    
    
    %%

fpath = '/Users/Alonyan/Google Drive/Experiments/In vivo/FoxP3 for paper'
load([fpath filesep 'Process_InVivo08252015Foxp3'])

fpath = '/Users/Alonyan/Google Drive/Experiments/In vivo/In vivo_06222015_ALON - pSTAT5'
load([fpath filesep 'Process_InVivo06222015New'])

%%
magenta = [1 0 1];cyan = [0 1 1];red = [1 0 0];lime = [0 1 0];green = [0 0.5 0]; blue = [0 0 1];
black = [0 0 0];yellow = [1 1 0];orange = [255,140,0]./255;violet = [138,43,226]./255;purple = [128,0,128]./255;

color = [ blue' red' lime' violet' green' purple' yellow'  cyan'   orange'  black'  magenta'  ]
close all
set(0,'DefaultTextInterpreter', 'tex')
set(0, 'DefaultAxesFontName', 'Arial')
set(0, 'DefaultUIControlFontName', 'Arial')
set(0,'defaulttextfontname','Arial');
   Markersize = 5;
BigFontSize = 16;
AxisFontSize = 14;
TitleFontSize = 15;

fig1 = figure('Position',[360   278   510   660],'Color',[1 1 1]);




axes('Position', [0.1 .75 0.2 0.15])

range = [2 1];
xlim = [-0.5 7.5];
i = 1;

data = proc_Samples.Controls;

LinearRange = 240;
H = data.pSTAT5.H(:,range);
X = data.pSTAT5.X;

h = plot(X,H./repmat(max(H),size(H,1),1),asinh([3000 3000]./LinearRange), [0,1] ,'--k'); figure(gcf)
    set(h, 'LineWidth', 1.5);
    set(gca, 'Xlim', xlim , 'Ylim', [1E-5 1] , 'FontSize', AxisFontSize)
ylabel('% of Max', 'FontSize', AxisFontSize)
xlabel('pSTAT5', 'FontSize', AxisFontSize)


    for i = 1:length(h)-1
        set(h(i), 'color', color(:,i+2)')
    end

        a1 = sort(- (1:9)'*10.^(1:2)); 
        a2 =(1:9)'*10.^(1:5);
        a = [sort(a1(:)); 0; a2(:)];

        emptyStr = {''; ''; '';''; ''; '';''; ''};
        XTickLabel = [emptyStr; '   '; emptyStr; {''}; '0'; {''}; emptyStr; '   '; emptyStr; '1'; emptyStr; '10'; emptyStr; '100'; emptyStr];
        XTicks = asinh(a/LinearRange);

        set(gca, 'XTick', XTicks, 'XTickLabel', XTickLabel,'YTick', [0 0.2 0.4 0.6 0.8 1], 'YTickLabel', [0 20 40 60 80 100]);


     set(gca, 'Xlim', xlim , 'Ylim', [1E-5 1] , 'FontSize', AxisFontSize)
    XThresh = asinh(Thresh./LinearRange);

FractionPositive = sum(H(X > XThresh,:))

        x = [6.2 8.5];
        y = [0.4 1];
[annotationX1, annotationY1] = gcatogcf_v1(x,y)

hleg = legend('Positive', 'Negative')
set(hleg,'Fontsize' , 11,'Position',[0.10          0.91 0.20          0.04])
legend boxoff;


%         x = [-3 -3];
%         y = [-0.25 1];
% [annotationArrowX1, annotationArrowY1] = gcatogcf_v1(x,y)
% annotation('arrow', annotationArrowX1, annotationArrowY1)
        x = [-1 9];
        y = [-0.25 -0.25];
[annotationArrowX2, annotationArrowY2] = gcatogcf_v1(x,y)
annotation('arrow', annotationArrowX2([2 1]), annotationArrowY2)



% Controls LNs
axes('Position', [0.31 0.75 0.2 0.15])

TregDataName = {'LNs_Tregs' 'Spleen_Tregs' 'Controls'};
ranges = {[6 3],[1 4], [5 2]}

range = ranges{1};
data = proc_Samples.(TregDataName{1});


LinearRange = 240;


H = data.pSTAT5.H(:,range);
X = data.pSTAT5.X;

h = plot(X,H./repmat(max(H),size(H,1),1),asinh([Thresh Thresh]./LinearRange), [0,1] ,'--k'); figure(gcf)
    set(h, 'LineWidth', 1.5);
    set(gca, 'Xlim', xlim , 'Ylim', [1E-5 1] , 'FontSize', AxisFontSize,'TickLength', [0.03 0.1])

    %yl = ylabel('% of Max', 'FontSize', AxisFontSize)
%xl = xlabel('pSTAT5', 'FontSize', AxisFontSize)

    for i = 1:length(h)-1
        set(h(i), 'color', color(:,i)')
    end
    %        set(h(end), 'color', red)


        %a1 = - (1:9)'*10.^(1:3);
        a1 = sort(- (1:9)'*10.^(1:2)); 
        a2 =(1:9)'*10.^(1:5);
        a = [sort(a1(:)); 0; a2(:)];

        emptyStr = {''; ''; '';''; ''; '';''; ''};
        XTickLabel = [emptyStr; '   '; emptyStr; {''}; '0'; {''}; emptyStr; '   '; emptyStr; '1'; emptyStr; '10'; emptyStr; '100'; emptyStr];
        XTicks = asinh(a/LinearRange);

        set(gca, 'XTick', XTicks, 'XTickLabel', XTickLabel,'YTick', [0 0.2 0.4 0.6 0.8 1], 'YTickLabel', []);
  
        
        
    XThresh = asinh(Thresh./LinearRange);

FractionPositive1 = sum(H(X > XThresh,:))

        x = [5 6];
        y = [0.9 0.9];
[annotationX1, annotationY1] = gcatogcf_v1(x,y)

hleg = legend(h(1:2),'Wildtype','Boosted')
set(hleg,'Fontsize' , 11,'Position',[0.31          0.91 0.20          0.04])
legend boxoff;

        annotation('textbox',[annotationX1(2) annotationY1(1)-0.04 -diff(annotationX1) 0.04],'string','Lymph Nodes','HorizontalAlignment' ,'center','LineStyle','none','Fontsize', 12)
  



% Sp

axes('Position', [0.52 0.75 0.2 0.15])

TregDataName = {'LNs_Tregs' 'Spleen_Tregs' 'Controls'};
ranges = {[6 3],[1 4], [5 2]}

range = ranges{1};
data = proc_Samples.(TregDataName{2});
LinearRange = 240;

H = data.pSTAT5.H(:,range);
X = data.pSTAT5.X;
h = plot(X,H./repmat(max(H),size(H,1),1),asinh([Thresh Thresh]./LinearRange), [0,1] ,'--k'); figure(gcf)
    set(h, 'LineWidth', 2.2);
    set(gca, 'Xlim', xlim , 'Ylim', [1E-5 1] , 'FontSize', AxisFontSize,'TickLength', [0.03 0.1])

    %yl = ylabel('% of Max', 'FontSize', AxisFontSize)
%xl = xlabel('pSTAT5', 'FontSize', AxisFontSize)

    for i = 1:length(h)-1
        set(h(i), 'color', color(:,i)')
    end

        set(gca, 'XTick', XTicks, 'XTickLabel', XTickLabel,'YTick', [0 0.2 0.4 0.6 0.8 1], 'YTickLabel', []);
  
        
        
    XThresh = asinh(Thresh./LinearRange);

FractionPositive2 = sum(H(X > XThresh,:))

        x = [5 6];
        y = [0.9 0.9];
[annotationX1, annotationY1] = gcatogcf_v1(x,y)



        annotation('textbox',[annotationX1(2) annotationY1(1)-0.04 -diff(annotationX1) 0.04],'string','Spleen','HorizontalAlignment' ,'center','LineStyle','none','Fontsize', 12)
  

hleg = legend(h(3),'Threshold')
set(hleg,'Fontsize' , 11,'Position',[0.52          0.91 0.20          0.04])
legend boxoff;


% axes('Position', [0.81 0.74 0.18 0.2])
% b(1) = bar(1,FractionPositive1(1));
% set(b(1), 'FaceColor',get(h(1),'color'))
% hold on;
% b(2) = bar(2,FractionPositive1(2));
% set(b(2), 'FaceColor',get(h(2),'color'))
% 
% b(3) = bar(3.5,FractionPositive2(1));
% set(b(3), 'FaceColor',get(h(1),'color'))
% 
% b(4) = bar(4.5,FractionPositive2(2));
% set(b(4), 'FaceColor',get(h(2),'color'))
% 
% ylabel('Fraction pSTAT5+','Fontsize', 15)
% %set(gca,'xlim', [0.5 5],'ylim',[0 1],'Xtick',[1 2 4 5],'Xticklabel',{'Wildtype';'Boosted'; 'Wildtype';'Boosted'},'Fontsize', AxisFontSize)
% set(gca,'xlim', [0.5 5],'ylim',[0 1],'Xtick',[1.5 4],'Xticklabel',{[]},'Fontsize', AxisFontSize)
% set(gca,'ytick', [0 0.2 0.4 0.6 0.8 1],'TickLength', [0.03 0.1])
% 
% hleg = legend('Wildtype','Boosted')
% legend boxoff
% set(hleg,'Fontsize', 11,'Location','northoutside')
% 
% hLine = findobj(hleg);
% set(hLine(6:7),'XData',[ 0.07 0.07 0.25 0.25 0.07])
% set(hLine(3),'Position',[0.305 0.273989 0])
% set(hLine(5),'Position',[0.305 0.726011 0])
% 
% %xticklabel_rotate([], 45)
% 
%         x = [1 2];
%         y = [-0.1 -0.1];
% [annotationX1, annotationY1] = gcatogcf_v1(x,y)
% 
% 
% 
%         annotation('line',annotationX1,annotationY1,'Linewidth', 1.5) 
%         annotation('textbox',[annotationX1(2) annotationY1(1)-0.04 -diff(annotationX1) 0.04],'string','Lymph  Nodes','HorizontalAlignment' ,'center','LineStyle','none','Fontsize', 12)
%   
% 
%                 x = [3.5 4.5];
% [annotationX1, annotationY1] = gcatogcf_v1(x,y)
% 
% 
% 
%         annotation('line',annotationX1,annotationY1,'Linewidth', 1.5) 
%         annotation('textbox',[annotationX1(2) annotationY1(1)-0.04 -diff(annotationX1) 0.04],'string','Spleen','HorizontalAlignment' ,'center','LineStyle','none','Fontsize', 12)
%   
%         
        %   FOXP3 
      
axes('Position', [0.08 0.51  0.15 0.11])
[h,LRx, ~] = ScatterPlotByTag_v1(AllCells,{'<FITC-A>: CD4'},'Nbins',100,'PlotGate',CD4Gate(1:2,1),'Xlim',[-100 100000])
set(gca,'Xlim',[-1.5 6])

xl = xlabel('CD4', 'Fontsize', AxisFontSize)
%set(xl,'Position',get(xl,'Position').*[1 0.3 1])

yl = ylabel('Cell #', 'Fontsize', AxisFontSize)
%set(yl,'Position',[-3 316.096 1.00011])
        a1 = sort(- (1:9)'*10.^(1:2)); 
        a2 =(1:9)'*10.^(1:5);
        a = [sort(a1(:)); 0; a2(:)];

        emptyStr = {''; ''; '';''; ''; '';''; ''};
        XTickLabel = [emptyStr; ''; emptyStr; {''}; '0'; {''}; emptyStr; ''; emptyStr; '   1'; emptyStr; '   10'; emptyStr; ''; emptyStr];
        XTicks = asinh(a/LRx);
          
        set(gca, 'XTick', XTicks, 'XTickLabel', XTickLabel,'TickLength', [0.03 0.1],'Ylim', [0 3300],'Ytick', [0 1000 2000 3000],'YtickLabel',[0 1 2 3]);
annotation('textbox',[0.07 0.61  0.3 0.04] ,'String','\times 10^3','LineStyle','none');

% ,'PlotGate',Foxp3Gate
axes('Position', [0.29 0.51  0.15 0.11])

[h,LRx, LRy] = ScatterPlotByTag_v1(CD4, { '<PE-Gr-A>: CD25'  '<APC-A>: Foxp3' },'Nbins',20,'Ylim',[-100 12000],'Xlim',[-100 30000],'MaxPointsToPlot',10000)
    %Foxp3Gate
    
        Xgate = [Foxp3Gate(:, 1); Foxp3Gate(1, 1)];
        Ygate = [Foxp3Gate(:, 2); Foxp3Gate(1, 2)];
        Xgate = asinh(Xgate/LRx);
        Ygate = asinh(Ygate/LRy);
        
        hline = refline(0, Ygate(1))
        set(hline,'color','k')
        hline = line([Xgate(1), Xgate(1)], get(gca,'ylim'));
        set(hline,'color','k')

        a1 = sort(- (1:9)'*10.^(1:2)); 
        a2 =(1:9)'*10.^(1:5);
        a = [sort(a1(:)); 0; a2(:)];

        emptyStr = {''; ''; '';''; ''; '';''; ''};
        XTickLabel = [emptyStr; ''; emptyStr; {''}; '0'; {''}; emptyStr; ''; emptyStr; '   1'; emptyStr; '   10'; emptyStr; ''; emptyStr];
        XTicks = asinh(a/LRx);
        YTicks = asinh(a/LRy);
          
        set(gca, 'XTick', XTicks, 'XTickLabel', XTickLabel, 'YTick', YTicks, 'YTickLabel', XTickLabel,'TickLength', [0.03 0.1],'Box','on');
xl = xlabel('CD25', 'Fontsize', AxisFontSize);
set(xl,'Position',get(xl,'Position')+[0 0.3 0]);

yl = ylabel('FoxP3', 'Fontsize', AxisFontSize);
set(yl,'Position' ,[-2.5 1.68421 1.00011])
annotation('arrow', [0.23 0.29], [0.61 0.61])
       
        
      
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
%% Supp figure - production

 
fpath = '/Users/Alonyan/Google Drive/Experiments/In vivo/In vivo_06222015_ALON - pSTAT5'
load([fpath filesep 'Process_InVivo06222015New'])

%%
fpath = '/Users/Alonyan/Google Drive/Experiments/In vivo/In vivo 05182015 - Milt!/IL2 miltenyi'
load([fpath filesep 'Process_InVivoMilt051815'])
%%
close all

 fig1 = figure('Position',[360   278   510   660],'Color',[1 1 1]);

color = [ blue' red' lime' violet' green' purple' yellow'  cyan'   orange'  black'  magenta'  ]

TregDataName = {'LNs_Producers' 'Spleen_Producers' 'Controls'};

ranges = {[1 3], [2 4], [1 2]}
xlim = [-0.5 6];
LinearRange = 150;
Channel = {'PE' 'Gr'}


% Positioning params
x0=0.1;
x1 = 0.54;

y0=0.64;
rati = 660/510;
dy = .015;
dx = dy*rati;
hight = 0.14;
width = hight*rati;


MaxPoints = 1000; %Change this for production
axes('Position',[x0 y0 width hight]) %LN Boost hi

i=2;
[h, LRx, LRy] = ScatterPlotByTag_v1(LNs_AllT(i), { '<APC-A>: CTFR'  'SSC-A' },'Nbins',20,'Xlim',[-100 100000], 'Ylim',[-100 110000],'MaxPointsToPlot',MaxPoints,'LogYscale', 0, 'PlotGate',GateProds);
set(gca,'Xlim',[-1.5 7.5], 'Ylim',[0 100000],'TickLength', [0.03 0.1],'Box','on')


        a1 = sort(- (1:9)'*10.^(1:2)); 
        a2 =(1:9)'*10.^(1:5);
        a = [sort(a1(:)); 0; a2(:)];

        emptyStr = {''; ''; '';''; ''; '';''; ''};
        XTickLabel = [emptyStr; ''; emptyStr; {''}; '0'; {''}; emptyStr; ''; emptyStr; '   1'; emptyStr; '   10'; emptyStr; ''; emptyStr];
        XTicks = asinh(a/LRx);
          
        set(gca, 'XTick', XTicks, 'XTickLabel', XTickLabel, 'YTick', [0 50000 100000], 'YTickLabel', [0 5 10],'TickLength', [0.03 0.1],'Box','on');
       
yl = ylabel('Side Scatter','Fontsize', AxisFontSize)
xl = xlabel('Celltrace Far-Red','Fontsize', AxisFontSize)

set(yl,'Position',[-4 65000 1.00011])
set(xl,'Position',[2.9 -22000 1.00011])  


        x = [-3.6 -3.6];
        y = [-19000 125000];
[annotationArrowX1, annotationArrowY1] = gcatogcf_v1(x,y)
annotation('arrow', annotationArrowX1, annotationArrowY1)
        x = [-3.6 10];
        y = [-19000 -19000];
[annotationArrowX2, annotationArrowY2] = gcatogcf_v1(x,y)
annotation('arrow', annotationArrowX2([2 1]), annotationArrowY2)
        x = [4.1 6];
        y = [55000 65000];
[annotationX1, annotationY1] = gcatogcf_v1(x,y);
annotation('textbox',[annotationX1(2) annotationY1(1) -diff(annotationX1) diff(annotationY1)],'String',num2str(100./TcellsperProd_LNs(i),2),'LineStyle', 'none')


axes('Position',[x0+width+dx y0 width hight])%LN Boost Lo
i=1;
[h, LRx, LRy] = ScatterPlotByTag_v1(LNs_AllT(i), { '<APC-A>: CTFR'  'SSC-A' },'Nbins',20,'Xlim',[-100 100000], 'Ylim',[-100 110000],'MaxPointsToPlot',MaxPoints,'LogYscale', 0, 'PlotGate',GateProds);
set(gca,'Xlim',[-1.5 7.5], 'Ylim',[0 100000],'TickLength', [0.03 0.1],'Box','on')       
        set(gca, 'XTick', XTicks, 'XTickLabel', XTickLabel, 'YTick', [0 50000 100000], 'YTickLabel', [],'TickLength', [0.03 0.1],'Box','on');
ylabel('','Fontsize', AxisFontSize)
xlabel('','Fontsize', AxisFontSize)
        x = [4.1 6];
        y = [55000 65000]; 
[annotationX1, annotationY1] = gcatogcf_v1(x,y);
annotation('textbox',[annotationX1(2) annotationY1(1) -diff(annotationX1) diff(annotationY1)],'String',num2str(100./TcellsperProd_LNs(i),2),'LineStyle', 'none')

axes('Position',[x0 y0+hight+dy width hight])%LN Wt hi
i=5;
[h, LRx, LRy] = ScatterPlotByTag_v1(LNs_AllT(i), { '<APC-A>: CTFR'  'SSC-A' },'Nbins',20,'Xlim',[-100 100000], 'Ylim',[-100 110000],'MaxPointsToPlot',MaxPoints,'LogYscale', 0, 'PlotGate',GateProds);
set(gca,'Xlim',[-1.5 7.5], 'Ylim',[0 100000],'TickLength', [0.03 0.1],'Box','on')        
        set(gca, 'XTick', XTicks, 'XTickLabel', [], 'YTick', [0 50000 100000], 'YTickLabel', [0 5 10],'TickLength', [0.03 0.1],'Box','on');
ylabel('','Fontsize', AxisFontSize)
xlabel('','Fontsize', AxisFontSize)      
        x = [4.1 6];
        y = [55000 65000]; 
[annotationX1, annotationY1] = gcatogcf_v1(x,y);
annotation('textbox',[annotationX1(2) annotationY1(1) -diff(annotationX1) diff(annotationY1)],'String',num2str(100./TcellsperProd_LNs(i),2),'LineStyle', 'none')

axes('Position',[x0+dx+width y0+dy+hight width hight])%LN Wt Lo
i=4;
[h, LRx, LRy] = ScatterPlotByTag_v1(LNs_AllT(i), { '<APC-A>: CTFR'  'SSC-A' },'Nbins',20,'Xlim',[-100 100000], 'Ylim',[-100 110000],'MaxPointsToPlot',MaxPoints,'LogYscale', 0, 'PlotGate',GateProds);
set(gca,'Xlim',[-1.5 7.5], 'Ylim',[0 100000],'TickLength', [0.03 0.1],'Box','on')
        set(gca, 'XTick', XTicks, 'XTickLabel', [], 'YTick', [0 50000 100000], 'YTickLabel', [],'TickLength', [0.03 0.1],'Box','on');
ylabel('','Fontsize', AxisFontSize)
xlabel('','Fontsize', AxisFontSize)
      
        x = [4.1 6];
        y = [55000 65000]; 
[annotationX1, annotationY1] = gcatogcf_v1(x,y);
annotation('textbox',[annotationX1(2) annotationY1(1) -diff(annotationX1) diff(annotationY1)],'String',num2str(100./TcellsperProd_LNs(i),2),'LineStyle', 'none')



axes('Position',[x1 y0 width hight])
i=2;
[h, LRx, LRy] = ScatterPlotByTag_v1(Spleen_AllT(i), { '<APC-A>: CTFR'  'SSC-A' },'Nbins',20,'Xlim',[-100 100000], 'Ylim',[-100 110000],'MaxPointsToPlot',MaxPoints,'LogYscale', 0, 'PlotGate',GateProds);
set(gca,'Xlim',[-1.5 7.5], 'Ylim',[0 100000],'TickLength', [0.03 0.1],'Box','on')
        set(gca, 'XTick', XTicks, 'XTickLabel', XTickLabel, 'YTick', [0 50000 100000], 'YTickLabel', [0 5 10],'TickLength', [0.03 0.1],'Box','on');
ylabel('','Fontsize', AxisFontSize)
xlabel('','Fontsize', AxisFontSize)
        
        x = [4.1 6];
        y = [55000 65000]; 
[annotationX1, annotationY1] = gcatogcf_v1(x,y);
annotation('textbox',[annotationX1(2) annotationY1(1) -diff(annotationX1) diff(annotationY1)],'String',num2str(100./TcellsperProd_Sp(i),2),'LineStyle', 'none')

axes('Position',[x1+width+dx y0 width hight])
i=1;
[h, LRx, LRy] = ScatterPlotByTag_v1(Spleen_AllT(i), { '<APC-A>: CTFR'  'SSC-A' },'Nbins',20,'Xlim',[-100 100000], 'Ylim',[-100 110000],'MaxPointsToPlot',MaxPoints,'LogYscale', 0, 'PlotGate',GateProds);
set(gca,'Xlim',[-1.5 7.5], 'Ylim',[0 100000],'TickLength', [0.03 0.1],'Box','on')    
        set(gca, 'XTick', XTicks, 'XTickLabel', XTickLabel, 'YTick', [0 50000 100000], 'YTickLabel', [],'TickLength', [0.03 0.1],'Box','on');
ylabel('','Fontsize', AxisFontSize)
xlabel('','Fontsize', AxisFontSize)
        x = [4.1 6];
        y = [55000 65000]; 
[annotationX1, annotationY1] = gcatogcf_v1(x,y);
annotation('textbox',[annotationX1(2) annotationY1(1) -diff(annotationX1) diff(annotationY1)],'String',num2str(100./TcellsperProd_Sp(i),2),'LineStyle', 'none')


axes('Position',[x1 y0+hight+dy width hight])

i=5;
[h, LRx, LRy] = ScatterPlotByTag_v1(Spleen_AllT(i), { '<APC-A>: CTFR'  'SSC-A' },'Nbins',20,'Xlim',[-100 100000], 'Ylim',[-100 110000],'MaxPointsToPlot',MaxPoints,'LogYscale', 0, 'PlotGate',GateProds);
set(gca,'Xlim',[-1.5 7.5], 'Ylim',[0 100000],'TickLength', [0.03 0.1],'Box','on')
          
        set(gca, 'XTick', XTicks, 'XTickLabel', [], 'YTick', [0 50000 100000], 'YTickLabel', [0 5 10],'TickLength', [0.03 0.1],'Box','on');
ylabel('','Fontsize', AxisFontSize)
xlabel('','Fontsize', AxisFontSize)
  
        x = [4.1 6];
        y = [55000 65000]; 
[annotationX1, annotationY1] = gcatogcf_v1(x,y);
annotation('textbox',[annotationX1(2) annotationY1(1) -diff(annotationX1) diff(annotationY1)],'String',num2str(100./TcellsperProd_Sp(i),2),'LineStyle', 'none')


axes('Position',[x1+dx+width y0+dy+hight width hight])

i=4;
[h, LRx, LRy] = ScatterPlotByTag_v1(Spleen_AllT(i), { '<APC-A>: CTFR'  'SSC-A' },'Nbins',20,'Xlim',[-100 100000], 'Ylim',[-100 110000],'MaxPointsToPlot',MaxPoints,'LogYscale', 0, 'PlotGate',GateProds);
set(gca,'Xlim',[-1.5 7.5], 'Ylim',[0 100000],'TickLength', [0.03 0.1],'Box','on')



        set(gca, 'XTick', XTicks, 'XTickLabel', [], 'YTick', [0 50000 100000], 'YTickLabel', [],'TickLength', [0.03 0.1],'Box','on');
ylabel('','Fontsize', AxisFontSize)
xlabel('','Fontsize', AxisFontSize)       
        x = [4.1 6];
        y = [55000 65000]; 
[annotationX1, annotationY1] = gcatogcf_v1(x,y);
annotation('textbox',[annotationX1(2) annotationY1(1) -diff(annotationX1) diff(annotationY1)],'String',num2str(100./TcellsperProd_Sp(i),2),'LineStyle', 'none')


AnnotX1 = [x0+0.5*(width) x0+1.5*width+dx]
AnnotX2 = [x1+0.5*(width) x1+1.5*width+dx]
AnnotY = [y0+2*hight+0.04 y0+2*hight+0.04]
annotation('line', AnnotX1,AnnotY,'Linewidth', 1.5) 
        annotation('textbox',[AnnotX1(1) AnnotY(1) diff(AnnotX1) 0.03],'string','Lymph Nodes','HorizontalAlignment' ,'center','LineStyle','none','Fontsize', 12)

annotation('line', AnnotX2,AnnotY,'Linewidth', 1.5) 
        annotation('textbox',[AnnotX2(1) AnnotY(1) diff(AnnotX2) 0.03],'string','Spleen','HorizontalAlignment' ,'center','LineStyle','none','Fontsize', 12)



        

AnnotX = [x1+2*width+0.04*rati x1+2*width+0.04*rati ]
AnnotY1 = [y0+0.15*(hight) y0+.85*hight]
AnnotY2 = [y0+1.15*(hight)+dy y0+1.85*hight+dy]
annotation('line', AnnotX,AnnotY1,'Linewidth', 1.5,'color',color(:,1)) 
t = text(10.3, -35000,'Wildtype','Fontsize', 12,'Rotation', 270)

annotation('line', AnnotX,AnnotY2,'Linewidth', 1.5,'color',color(:,2)) 
t = text(10.3, 75000,'Boosted','Fontsize', 12,'Rotation', 270)

   
        
        
     
  
    
    
    jumpY = 0.26;
    
% annotation('arrow', annotationArrowX1, annotationArrowY1-jumpY)
annotation('arrow', annotationArrowX2([2 1]), annotationArrowY2-jumpY) 
        
        

y0=y0-jumpY;
xlim = [-1  6.5]
    
    % LN hi
    axes('Position', [x0 y0 width hight])

range = ranges{1};
data = proc_Samples.(TregDataName{1});
H = data.(Channel{1}).H(:,range);
X = data.(Channel{1}).X;

h = plot(X,H./repmat(max(H),size(H,1),1),asinh([Thresh Thresh]./LinearRange), [0,1] ,'--k'); figure(gcf)
    set(h, 'LineWidth', 2.2);
    set(gca, 'Xlim', xlim , 'Ylim', [1E-5 1] , 'FontSize', 10,'TickLength', [0.03 0.1])

    for i = 1:length(h)-1
        set(h(i), 'color', color(:,i)')
    end

        a1 = sort(- (1:9)'*10.^(1:2)); 
        a2 =(1:9)'*10.^(1:5);
        a = [sort(a1(:)); 0; a2(:)];

        emptyStr = {''; ''; '';''; ''; '';''; ''};
        XTickLabel = [emptyStr; '   '; emptyStr; {''}; '0'; {''}; emptyStr; '   '; emptyStr; '1'; emptyStr; '10'; emptyStr; '100'; emptyStr];
        XTicks = asinh(a/LinearRange);

        set(gca, 'XTick', XTicks, 'XTickLabel', XTickLabel,'YTick', [0 0.2 0.4 0.6 0.8 1], 'YTickLabel', [0 20 40 60 80 100]);
      
    XThresh = asinh(Thresh./LinearRange);

FractionPositive1 = sum(H(X > XThresh,:))


yl1 = ylabel('% of Max','Fontsize', AxisFontSize)
xl1 = xlabel('IL-2 Production','Fontsize', AxisFontSize)

%set(yl1,'Position',[-2.44293 0.483701 1.00011])
%set(xl1,'Position',[2.71467 -0.211944 1.00011])

        % LN Lo
        
                        legX = 0.35;
                        legY = y0+0.14;
                        hleg1=legend(h(1),'Wildtype')
                        set(hleg1,'Fontsize',14,'Position',[legX legY 0.1 0.05])
                        legend('boxoff')
                        hLine = findobj(hleg1,'type','line');
                        set(hLine(2),'Xdata',[mean(get(hLine(2),'Xdata')) mean(get(hLine(2),'Xdata'))]+[0.05 -0.05])


    axes('Position', [x0+width+dx y0 width hight])

        
        range = ranges{2};
data = proc_Samples.(TregDataName{1});
H = data.(Channel{2}).H(:,range);
X = data.(Channel{2}).X;

h = plot(X,H./repmat(max(H),size(H,1),1),asinh([Thresh Thresh]./LinearRange), [0,1] ,'--k'); figure(gcf)
    set(h, 'LineWidth', 2.2);
    set(gca, 'Xlim', xlim , 'Ylim', [1E-5 1] , 'FontSize', 10,'TickLength', [0.03 0.1])

    for i = 1:length(h)-1
        set(h(i), 'color', color(:,i)')
    end

        set(gca, 'XTick', XTicks, 'XTickLabel', XTickLabel,'YTick', [0 0.2 0.4 0.6 0.8 1], 'YTickLabel', []);
      
    XThresh = asinh(Thresh./LinearRange);

FractionPositive1 = sum(H(X > XThresh,:))

                    legX = 0.55;
                        legY = y0+0.14;
                        hleg1=legend(h(2),'Boosted')
                        set(hleg1,'Fontsize',14,'Position',[legX legY 0.1 0.05])
                        legend('boxoff')
                        hLine = findobj(hleg1,'type','line');
                        set(hLine(2),'Xdata',[mean(get(hLine(2),'Xdata')) mean(get(hLine(2),'Xdata'))]+[0.05 -0.05])

        % Sp Hi
            axes('Position', [x1 y0 width hight])


range = ranges{1};
data = proc_Samples.(TregDataName{2});
H = data.(Channel{1}).H(:,range);
X = data.(Channel{1}).X;

h = plot(X,H./repmat(max(H),size(H,1),1),asinh([Thresh Thresh]./LinearRange), [0,1] ,'--k'); figure(gcf)
    set(h, 'LineWidth', 2.2);
    set(gca, 'Xlim', xlim , 'Ylim', [1E-5 1] , 'FontSize', 10,'TickLength', [0.03 0.1])

    for i = 1:length(h)-1
        set(h(i), 'color', color(:,i)')
    end


        set(gca, 'XTick', XTicks, 'XTickLabel', XTickLabel,'YTick', [0 0.2 0.4 0.6 0.8 1], 'YTickLabel', [0 20 40 60 80 100]);
      
    XThresh = asinh(Thresh./LinearRange);

FractionPositive1 = sum(H(X > XThresh,:))


        
        % Sp Lo
    axes('Position', [x1+width+dx y0 width hight])

        
        range = ranges{2};
data = proc_Samples.(TregDataName{2});
H = data.(Channel{2}).H(:,range);
X = data.(Channel{2}).X;

h = plot(X,H./repmat(max(H),size(H,1),1),asinh([Thresh Thresh]./LinearRange), [0,1] ,'--k'); figure(gcf)
    set(h, 'LineWidth', 2.2);
    set(gca, 'Xlim', xlim , 'Ylim', [1E-5 1] , 'FontSize', 10,'TickLength', [0.03 0.1])

    for i = 1:length(h)-1
        set(h(i), 'color', color(:,i)')
    end

        set(gca, 'XTick', XTicks, 'XTickLabel', XTickLabel ,'YTick', [0 0.2 0.4 0.6 0.8 1], 'YTickLabel', []);
      
    XThresh = asinh(Thresh./LinearRange);

FractionPositive1 = sum(H(X > XThresh,:))

  
        

        
  a = annotation('textbox',[ 0.02 0.95    0.05    0.05],'string','A', 'Fontsize',TitleFontSize,'LineStyle','none')
         
  a = annotation('textbox',[ 0.02 0.52    0.05    0.05],'string','B', 'Fontsize',TitleFontSize,'LineStyle','none')

    %%
    
        set(gcf, 'PaperPositionMode','auto')
    saveas(gcf,['/Users/Alonyan/Google Drive/School/My Papers/Screening Paper/Figures/' ,'FigureSup5'],'epsc');

    
    
    
    %%
    TregFracLNs = (proc_Samples.LNs_Tregs.CD25.cellNo)./(proc_Samples.LNs_Tcells.CD25.cellNo);
    TregFracSpleen = (proc_Samples.Spleen_Tregs.CD25.cellNo)./(proc_Samples.Spleen_Tcells.CD25.cellNo);

    
    [h, herr] = barwitherr([std(TregFracSpleen(4:6)) std(TregFracSpleen(1:3)) ;std(TregFracLNs(4:6)) std(TregFracLNs(1:3))],[mean(TregFracSpleen(4:6)) mean(TregFracSpleen(1:3)); mean(TregFracLNs(4:6)) mean(TregFracLNs(1:3))])
    
%%
close all
fig1 = figure('Position',[360   278   510   660],'Color',[1 1 1]);

%     axes('Position', [0.1, 0.74, 0.15 0.11])
% [h, LRx, ~] = ScatterPlotByTag_v1(LNs_AllCells(5), { '<Pacific Blue-A>: CD4'},'Nbins',50,'PlotGate',CD4Gate(1:2,1));
%     set(gca,'Xlim', [-1.5 4.5], 'Ylim', [0 4500])
%     xl = xlabel('CD4 (a.u.)', 'Fontsize', AxisFontSize)
% set(xl,'Position',get(xl,'Position').*[1 0.5 1])
% 
% yl = ylabel('Cell #', 'Fontsize', AxisFontSize)
%         a1 = sort(- (1:9)'*10.^(1:2)); 
%         a2 =(1:9)'*10.^(1:5);
%         a = [sort(a1(:)); 0; a2(:)];
% 
%         emptyStr = {''; ''; '';''; ''; '';''; ''};
%         XTickLabel = [emptyStr; ''; emptyStr; {''}; '0'; {''}; emptyStr; ''; emptyStr; '   1'; emptyStr; '   10'; emptyStr; ''; emptyStr];
%         XTicks = asinh(a/LRx);
%           
%         set(gca, 'XTick', XTicks, 'XTickLabel', XTickLabel,'TickLength', [0.03 0.1],'Ytick', [0 1000 2000 3000 4000],'YtickLabel',[0 1 2 3 4]);
% annotation('textbox',get(gca,'Position')+[0 0.115 0 -0.08] ,'String','\times 10^3','LineStyle','none');

    
axes('Position', [0.08 0.75  0.15 0.11])
[h,LRx, ~] = ScatterPlotByTag_v1(AllCells,{'<FITC-A>: CD4'},'Nbins',100,'PlotGate',CD4Gate(1:2,1),'Xlim',[-100 100000])
set(gca,'Xlim',[-1.5 6])

xl = xlabel('CD4', 'Fontsize', AxisFontSize)
%set(xl,'Position',get(xl,'Position').*[1 0.3 1])

yl = ylabel('Cell #', 'Fontsize', AxisFontSize)
%set(yl,'Position',[-3 316.096 1.00011])
        a1 = sort(- (1:9)'*10.^(1:2)); 
        a2 =(1:9)'*10.^(1:5);
        a = [sort(a1(:)); 0; a2(:)];

        emptyStr = {''; ''; '';''; ''; '';''; ''};
        XTickLabel = [emptyStr; ''; emptyStr; {''}; '0'; {''}; emptyStr; ''; emptyStr; '   1'; emptyStr; '   10'; emptyStr; ''; emptyStr];
        XTicks = asinh(a/LRx);
          
        set(gca, 'XTick', XTicks, 'XTickLabel', XTickLabel,'TickLength', [0.03 0.1],'Ylim', [0 3300],'Ytick', [0 1000 2000 3000],'YtickLabel',[0 1 2 3]);
annotation('textbox',[0.07 0.86  0.3 0.04] ,'String','\times 10^3','LineStyle','none');

% ,'PlotGate',Foxp3Gate
axes('Position', [0.29 0.75  0.15 0.11])

[h,LRx, LRy] = ScatterPlotByTag_v1(CD4, { '<PE-Gr-A>: CD25'  '<APC-A>: Foxp3' },'Nbins',20,'Ylim',[-100 12000],'Xlim',[-100 30000],'MaxPointsToPlot',10000)
    %Foxp3Gate
    
        Xgate = [Foxp3Gate(:, 1); Foxp3Gate(1, 1)];
        Ygate = [Foxp3Gate(:, 2); Foxp3Gate(1, 2)];
        Xgate = asinh(Xgate/LRx);
        Ygate = asinh(Ygate/LRy);
        
        hline = refline(0, Ygate(1))
        set(hline,'color','k','linewidth', 1.5)
        hline = line([Xgate(1), Xgate(1)], get(gca,'ylim'));
        set(hline,'color','k','linewidth', 1.5)

        a1 = sort(- (1:9)'*10.^(1:2)); 
        a2 =(1:9)'*10.^(1:5);
        a = [sort(a1(:)); 0; a2(:)];

        emptyStr = {''; ''; '';''; ''; '';''; ''};
        XTickLabel = [emptyStr; ''; emptyStr; {''}; '0'; {''}; emptyStr; ''; emptyStr; '   1'; emptyStr; '   10'; emptyStr; ''; emptyStr];
        XTicks = asinh(a/LRx);
        YTicks = asinh(a/LRy);
          
        set(gca, 'XTick', XTicks, 'XTickLabel', XTickLabel, 'YTick', YTicks, 'YTickLabel', XTickLabel,'TickLength', [0.03 0.1],'Box','on');
xl = xlabel('IL-2R\alpha', 'Fontsize', AxisFontSize);
%set(xl,'Position',get(xl,'Position')+[0 0.3 0]);

yl = ylabel('FoxP3', 'Fontsize', AxisFontSize);
set(yl,'Position' ,[-2.5 1.68421 1.00011])
annotation('arrow', [0.23 0.29], [0.85 0.85])
       






xlim = [-0.5 7]

    axes('Position', [0.55, 0.8, 0.15 0.11])
 data = proc_Samples.LNs_Tcells;
 range=[2 4]
    H = data.CD25.H(:,range);
X = data.CD25.X;
Thresh = 3000;

h = plot(X,H./repmat(max(H),size(H,1),1),asinh([Thresh Thresh]./LinearRange), [0,1] ,'--k'); figure(gcf)
    set(h, 'LineWidth', 1.5);
    set(gca, 'Xlim', xlim , 'Ylim', [1E-5 1] , 'FontSize', AxisFontSize,'TickLength', [0.03 0.1])


    for i = 1:length(h)-1
        set(h(i), 'color', color(:,i)')
    end
    %        set(h(end), 'color', red)


        %a1 = - (1:9)'*10.^(1:3);
        a1 = sort(- (1:9)'*10.^(1:2)); 
        a2 =(1:9)'*10.^(1:5);
        a = [sort(a1(:)); 0; a2(:)];

        emptyStr = {''; ''; '';''; ''; '';''; ''};
        XTickLabel = [emptyStr; '   '; emptyStr; {''}; '0'; {''}; emptyStr; '   '; emptyStr; '1'; emptyStr; '10'; emptyStr; '100'; emptyStr];
        XTicks = asinh(a/LinearRange);

        set(gca, 'XTick', XTicks, 'XTickLabel', [],'ytick',[0 0.2 0.4 0.6 0.8 1],'ytickLabel',[0 0.2 0.4 0.6 0.8 1].*100);
  
    
    
    
    
        axes('Position', [0.55, 0.685, 0.15 0.11])
 data = proc_Samples.Spleen_Tcells;
 range=[2 4]
    H = data.CD25.H(:,range);
X = data.CD25.X;
Thresh = 3000;

h = plot(X,H./repmat(max(H),size(H,1),1),asinh([Thresh Thresh]./LinearRange), [0,1] ,'--k'); figure(gcf)
    set(h, 'LineWidth', 1.5);
    set(gca, 'Xlim', xlim , 'Ylim', [1E-5 1] , 'FontSize', AxisFontSize,'TickLength', [0.03 0.1])


    for i = 1:length(h)-1
        set(h(i), 'color', color(:,i)')
    end
    %        set(h(end), 'color', red)


        %a1 = - (1:9)'*10.^(1:3);
        a1 = sort(- (1:9)'*10.^(1:2)); 
        a2 =(1:9)'*10.^(1:5);
        a = [sort(a1(:)); 0; a2(:)];

        emptyStr = {''; ''; '';''; ''; '';''; ''};
        XTickLabel = [emptyStr; '   '; emptyStr; {''}; '0'; {''}; emptyStr; '   '; emptyStr; '1'; emptyStr; '10'; emptyStr; '100'; emptyStr];
        XTicks = asinh(a/LinearRange);

        set(gca, 'XTick', XTicks, 'XTickLabel',XTickLabel ,'ytick',[0 0.2 0.4 0.6 0.8 1],'ytickLabel',[0 0.2 0.4 0.6 0.8 1].*100);
        
        xl = xlabel('IL-2R\alpha (a.u.)', 'Fontsize', AxisFontSize)
set(xl,'Position',get(xl,'Position').*[1 0.7 1])

yl = ylabel('% of max', 'Fontsize', AxisFontSize)
    set(yl,'Position',get(yl,'Position').*[0.9 2 1])

    
    
    
    axes('Position', [0.8, 0.685, 0.18 0.225])
    TregFracLNs = (proc_Samples.LNs_Tregs.CD25.cellNo)./(proc_Samples.LNs_Tcells.CD25.cellNo);
    TregFracSpleen = (proc_Samples.Spleen_Tregs.CD25.cellNo)./(proc_Samples.Spleen_Tcells.CD25.cellNo);

    
    [h, herr] = barwitherr([std(TregFracSpleen(4:6)) std(TregFracSpleen(1:3)) ;std(TregFracLNs(4:6)) std(TregFracLNs(1:3))],[1 2], [mean(TregFracSpleen(4:6)) mean(TregFracSpleen(1:3)); mean(TregFracLNs(4:6)) mean(TregFracLNs(1:3))])
    set(h(1), 'FaceColor','r')
        set(h(2), 'FaceColor','b')
        set(herr,'Linewidth',1.5)
        BarTicklength(herr(1), 1)
BarTicklength(herr(2), 1)
yl = ylabel('%IL-2R\alpha +', 'Fontsize', AxisFontSize)
        set(gca,'xlim',[0.5 2.5],'XTick',[1 2],'XtickLabel',{'Spleen' ''},'Fontsize', AxisFontSize)
        
                x = [1.5 1.5];
        y = [0 0]; 
[annotationX1, annotationY1] = gcatogcf_v1(x,y);
annotation('textbox',[annotationX1(2) annotationY1(1) -diff(annotationX1) diff(annotationY1)],'String','Lymph nodes','LineStyle', 'none','Fontsize', AxisFontSize)


        set(gca,'ylim',[0 0.35],'Ytick',[0 0.1 0.2 0.3],'YtickLabel',[0 0.1 0.2 0.3].*100)

        
%         
%     axes('Position', [0.7, 0.685, 0.3 0.225])
%     TregFracLNs = (proc_Samples.LNs_Tregs.CD25.meanD);
%     TregFracSpleen = (proc_Samples.Spleen_Tregs.CD25.meanD);
% 
%     
%     [h, herr] = barwitherr([std(TregFracSpleen(4:6)) std(TregFracSpleen(1:3)) ;std(TregFracLNs(4:6)) std(TregFracLNs(1:3))],[1 2], [mean(TregFracSpleen(4:6)) mean(TregFracSpleen(1:3)); mean(TregFracLNs(4:6)) mean(TregFracLNs(1:3))])
%     set(h(1), 'FaceColor','r')
%         set(h(2), 'FaceColor','b')
%         set(herr,'Linewidth',1.5)
%         BarTicklength(herr(1), 1)
% BarTicklength(herr(2), 1)
% yl = ylabel('%IL-2R\alpha +', 'Fontsize', AxisFontSize)
%         set(gca,'xlim',[0.5 2.5],'XTick',[1 2],'XtickLabel',{'Spleen' 'Lymph nodes'})



%%
datanames = [{'LNs_Tregs_BG' 'LNs_Tcells_BG'}; {'LNs_Tregs_Hi' 'LNs_Tcells_Hi'}; {'LNs_Tregs_Lo' 'LNs_Tcells_Lo'}];
LNBoostFracs = [];
LNTFracs =[];
LNBoostMean = [];
LNWTMean = [];
for i=1:3

ix = cellfun('isempty',regexp(proc_Samples.(datanames{i,1}).pSTAT5.name,'Boost'))

LNBoostFracs = [LNBoostFracs proc_Samples.(datanames{i,1}).pSTAT5.cellNo(~ix)./proc_Samples.(datanames{i,2}).pSTAT5.cellNo(~ix)];
LNWTFracs = [LNTFracs proc_Samples.(datanames{i,1}).pSTAT5.cellNo(ix)./proc_Samples.(datanames{i,2}).pSTAT5.cellNo(ix)];


LNBoostMean = [LNBoostMean proc_Samples.(datanames{i,1}).CD25.meanD(~ix)];
LNWTMean = [LNWTMean proc_Samples.(datanames{i,1}).CD25.meanD(ix)];


end;


datanames = [{'Spleen_Tregs_BG' 'Spleen_Tcells_BG'}; {'Spleen_Tregs_Hi' 'Spleen_Tcells_Hi'}; {'Spleen_Tregs_Lo' 'Spleen_Tcells_Lo'}];
SpleenBoostFracs = [];
SpleenWTFracs =[];
SpleenBoostMean = [];
SpleenWTMean = [];
for i=1:3

ix = cellfun('isempty',regexp(proc_Samples.(datanames{i,1}).pSTAT5.name,'Boost'))

SpleenBoostFracs = [SpleenBoostFracs proc_Samples.(datanames{i,1}).pSTAT5.cellNo(~ix)./proc_Samples.(datanames{i,2}).pSTAT5.cellNo(~ix)];
SpleenWTFracs = [SpleenWTFracs proc_Samples.(datanames{i,1}).pSTAT5.cellNo(ix)./proc_Samples.(datanames{i,2}).pSTAT5.cellNo(ix)];

SpleenBoostMean = [SpleenBoostMean proc_Samples.(datanames{i,1}).CD25.meanD(~ix)];
SpleenWTMean = [SpleenWTMean proc_Samples.(datanames{i,1}).CD25.meanD(ix)];

end;
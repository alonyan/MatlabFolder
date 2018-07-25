function [lineplot_handle xout yout] = fca_lineplot(mainhandle, par1, type, EventsInROI)
% function lineplot_handle = fca_lineplot(fcsdat,fcshdr,par1,EventsInROI)
%

fcsdat = mainhandle.fcsdat;
fcshdr= mainhandle.fcshdr;
xout = [];
yout = [];
lineplot_handle = [];
NewPlot = 1;

% check whether new plot needed or not (only filtering on the events)  
if nargin == 4 
   NewPlot = 0;
elseif nargin < 3 | nargin > 5
    disp('The number of input parameter are 3 or 4!');
    return;
end

% if no ROI selected events, indxnr = []
if NewPlot
    EventsInROI = ':';
    lineplot_handle = figure('NumberTitle','off','DeleteFcn','fca_delete_histogram');
end

% setup the scales and calculate histogram 
Xlogdecade = fcshdr.par(par1).decade;
XChannelMax = fcshdr.par(par1).range;
Xlogvalatzero = fcshdr.par(par1).logzero;
% if XChannelMax > 1024
%     XChannelMax = max(fcsdat(EventsInROI,par1));
%     xlinscale = [1:XChannelMax/1024:XChannelMax];
% else
%     xlinscale = [1:XChannelMax];
% end
xlinscale = [1:XChannelMax];
y = hist(fcsdat(EventsInROI,par1),xlinscale);

% in case of filtering the data by ROI
if ~NewPlot
    if ~fcshdr.par(par1).log
        xout = xlinscale;
    else
        xout = Xlogvalatzero*10.^(xlinscale/XChannelMax*Xlogdecade);
    end
     yout = y;
     return;
end

% in case of defining a new lineplot
cut_fact = mainhandle.histcut_fact; 
if ~fcshdr.par(par1).log
    plot(xlinscale,y);
    set(gca,'Xlim',[1 XChannelMax]);
    set(gca,'XTick',[0 round(XChannelMax /4) round(XChannelMax /2) round(3*XChannelMax /4) XChannelMax ]);
else
    semilogx(Xlogvalatzero*10.^(xlinscale/XChannelMax*Xlogdecade),y);
    set(gca,'XLimMode','manual');set(gca,'Xlim',[Xlogvalatzero 10^Xlogdecade]);
end
ymax =  max( y(round(end*cut_fact):round(end*(1-cut_fact))) ) ;
if ymax == 0; ymax=max(y)/1.2;end
set(gca,'Ylim',[1 ymax*1.2]);

hxl = xlabel(fcshdr.par(par1).name);
set(hxl,'FontName','Arial');
set(hxl,'FontSize',14);
set(hxl,'FontWeight','bold');
set(hxl,'fontunits','normalized');
hyl = ylabel('Number of cells');
set(hyl,'FontName','Arial');
set(hyl,'FontSize',14);
set(hyl,'FontWeight','bold');
set(hyl,'fontunits','normalized');
set(gca,'FontName','Arial');
set(gca,'FontSize',14);
set(gca,'FontWeight','bold');
set(gca,'LineWidth',2);
set(gca,'fontunits','normalized');
set(gca,'ButtonDownFcn','fca_setymax');

% create buttons for xls export

drawbutton_h = uicontrol('Style','pushbutton','String','Export2xls', ...
    'units','normalized','Position',[0.8 0.94 0.15 0.05], 'Callback', 'fca_lineplot2xls', ...
    'TooltipString','Export the current histogram points (x,y) to Excel sheet');
drawbutton_h = uicontrol('Style','pushbutton','String','Export2hist', ...
    'units','normalized','Position',[0.6 0.94 0.15 0.05], 'Callback', 'fca_lineplot2hist', ...
    'TooltipString','Export the current histogram to FCS Histogram file');

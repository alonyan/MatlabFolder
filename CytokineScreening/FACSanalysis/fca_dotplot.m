function [dotplot_handle, xparout, yparout, histmatout] = ...
    fca_dotplot(mainhandle,par1,par2,type,EventsInROI)
% function [dotplot_handle, xparout, yparout, histmatout] = ...
%    fca_dotplot(mainhandle,par1,par2,type,EventsInROI)

fcsdat = mainhandle.fcsdat;
fcshdr= mainhandle.fcshdr;
chplotres = mainhandle.chplotres;

Xlogdecade = fcshdr.par(par1).decade;
XChannelMax = fcshdr.par(par1).range;
Xlogvalatzero = fcshdr.par(par1).logzero;
Ylogdecade = fcshdr.par(par2).decade;
YChannelMax = fcshdr.par(par2).range;
Ylogvalatzero = fcshdr.par(par2).logzero;
dotplot_handle = [];

% if no ROI selected events, indxnr = []
if nargin == 4 
    EventsInROI = ':';
    NewPlot = 1;
elseif nargin < 4 || nargin > 5
    disp('The number of input parameter is 4 or 5!');
    return;
elseif nargin == 5
    NewPlot = 0;
end
XScaleMin = 0;
YScaleMin = 0;
%
% generating the parametres to be plot or to send as output
%
xpar = double(fcsdat(EventsInROI,par1));
ypar = double(fcsdat(EventsInROI,par2));
if strcmp(type,'dotplot')
    xparout = xpar;
    yparout = ypar;
    histmatout = [];
else
    xedges = linspace(0,fcshdr.par(par1).range,chplotres); 
    yedges = linspace(0,fcshdr.par(par2).range,chplotres);
    histmat = fca_hist2(xpar, ypar, xedges, yedges);
    cmap = jet;
    cmap(1,:) = 1;
    if strcmp(type,'colordensity')
        histmat_toplot = histmat;
    elseif strcmp(type,'colordensity_smoothed')
        histmat_toplot = round(conv2(histmat,kernel(2,'gaussian'),'same'));
    end
    cut_fact = mainhandle.histcut_fact; 
    x1=round(chplotres*cut_fact);x2=round(chplotres*(1-cut_fact));
    histmax = max(max(histmat_toplot(x1:x2,x1:x2)));
    xparout = xpar*chplotres/XChannelMax;
    yparout = ypar*chplotres/YChannelMax;
    histmatout.histmat_toplot = histmat_toplot;
    histmatout.histmax = histmax;
end
if ~NewPlot
    return;
end
%
% creating the dotplot or the colordensity map
%
if mainhandle.newfigure 
    % if "fca_2dgraph_settype" was the calling function, there is no need to create new
    % figure. Only the type of the dotplot to be changed.
    dotplot_handle = figure('position',[200 300 500 350],'NumberTitle','off',...
        'DeleteFcn','fca_delete_histogram');
end    
if strcmp(type,'dotplot')
    plot(xpar,ypar,'.','markersize',3,'color','k');
else 
    imagesc(histmat_toplot,[0 histmax]);
    colormap(cmap);
    set(gca,'Ydir','normal');
end
%
% setup the ticks on the axes
%
if strcmp(type,'dotplot')
    YScaleMax = YChannelMax;
    XScaleMax = XChannelMax;
else
    YScaleMax = chplotres;
    XScaleMax = chplotres;
end

if fcshdr.par(par1).log
    Xlog = true;
    logvalatzero = Xlogvalatzero;
    logdecade = Xlogdecade;
    dotplotres = XScaleMax;
    decade0 = log10(logvalatzero);
    dectickdefs = logvalatzero;
    tickdefslabel = {logvalatzero};
    tickdefslabeltmp = cell(1,9);
    for i=decade0:logdecade-1
        tickdeftmp = linspace(10^i,10^(i+1),10);
        dectickdefs = [dectickdefs tickdeftmp(2:end)];
        tickdefslabeltmp{9} = ['10^',num2str(i+1)];
        tickdefslabel = [tickdefslabel tickdefslabeltmp];
    end
    tickdefs = dotplotres/logdecade*log10(dectickdefs/logvalatzero);
    Xtickdefs_main = dotplotres/logdecade*log10((10.^[decade0:1:logdecade])/logvalatzero)-dotplotres*0.02;
    Xtickdefs = tickdefs;
    Xtickdefslabel = tickdefslabel;
else
    XScaleMin = 0;
    Xlog = false;
end
if fcshdr.par(par2).log
    Ylog = true;
    logvalatzero = Ylogvalatzero;
    logdecade = Ylogdecade;
    dotplotres = YScaleMax;
    decade0 = log10(logvalatzero);
    dectickdefs = logvalatzero;
    tickdefslabel = {logvalatzero};
    tickdefslabeltmp = cell(1,9);
    for i=decade0:logdecade-1
        tickdeftmp = linspace(10^i,10^(i+1),10);
        dectickdefs = [dectickdefs tickdeftmp(2:end)];
        tickdefslabeltmp{9} = ['10^',num2str(i+1)];
        tickdefslabel = [tickdefslabel tickdefslabeltmp];
    end
    tickdefs = dotplotres/logdecade*log10(dectickdefs/logvalatzero);
    Ytickdefs_main = dotplotres/logdecade*log10((10.^[decade0:1:logdecade])/logvalatzero);
    Ytickdefs = tickdefs;
    Ytickdefslabel = tickdefslabel;
else
    Ylog = false;
    YScaleMin = 0;
end
%
% set up the xlabel, ylabel
%
set_font(gca,10);
set(gca,'Xlim',[XScaleMin XScaleMax ]);
set(gca,'Ylim',[YScaleMin YScaleMax]);
set(gca,'LineWidth',2);
hxl = xlabel(fcshdr.par(par1).name); 
set_font(hxl,12);
hyl = ylabel(fcshdr.par(par2).name); 
set_font(hyl,12);
daspect([XScaleMax YScaleMax 1]);
xlabelpos = get(hxl,'Position');
ylabelpos = get(hyl,'Position'); 
%
% set up the xtick and yticks
%
if ~Xlog && ~Ylog 
    set(gca,'XTick',[0 round(XScaleMax /4) round(XScaleMax /2) round(3*XScaleMax /4) XScaleMax ]);
    set(gca,'YTick',[0 round(YScaleMax/4) round(YScaleMax/2) round(3*YScaleMax/4) YScaleMax]);
    if ~strcmp(type,'dotplot')
        set(gca,'XtickLabel',[0; round(XChannelMax /4); round(XChannelMax /2); round(3*XChannelMax /4); XChannelMax ]); 
        set(gca,'YtickLabel',[0; round(YChannelMax/4); round(YChannelMax/2); round(3*YChannelMax/4); YChannelMax]);
    end
elseif Xlog && ~Ylog
    set(gca,'YTick',[0 round(YScaleMax/4) round(YScaleMax/2) round(3*YScaleMax/4) YScaleMax]);
    if ~strcmp(type,'dotplot')
        set(gca,'YtickLabel',[0; round(YChannelMax/4); round(YChannelMax/2); round(3*YChannelMax/4); YChannelMax]);
    end
    set(gca,'Xtick',tickdefs); set(gca,'XtickLabel','');
    for i=log10(Xlogvalatzero):Xlogdecade
        ht = text(Xtickdefs_main(i+1),xlabelpos(2)/2,['10^{',num2str(i),'}']);
        set_font(ht,10);
    end
elseif ~Xlog && Ylog
    set(gca,'XTick',[0 round(XScaleMax /4) round(XScaleMax /2) round(3*XScaleMax /4) XScaleMax ]);
    if ~strcmp(type,'dotplot')
        set(gca,'XtickLabel',[0; round(XChannelMax /4); round(XChannelMax /2); round(3*XChannelMax /4); XChannelMax ]); 
    end
    set(gca,'Ytick',tickdefs); set(gca,'YtickLabel','');
    for i=log10(Ylogvalatzero):Ylogdecade
        ht = text(ylabelpos(1)*0.8, Ytickdefs_main(i+1),['10^{',num2str(i),'}']);
        set_font(ht,10);
    end
elseif Xlog && Ylog
    set(gca,'Xtick',tickdefs); set(gca,'XtickLabel','');
    for i=log10(Xlogvalatzero):Xlogdecade
        ht = text(Xtickdefs_main(i+1),xlabelpos(2)/2,['10^{',num2str(i),'}']);
        set_font(ht,10);
    end
    set(gca,'Ytick',tickdefs); set(gca,'YtickLabel','');
    for i=log10(Ylogvalatzero):Ylogdecade
        ht = text(ylabelpos(1)*0.8, Ytickdefs_main(i+1),['10^{',num2str(i),'}']);
        set_font(ht,10);
    end
end
set(hxl,'Position',xlabelpos); 
set(hyl,'Position',ylabelpos); 

if mainhandle.newfigure
    % if "fca_2dgraph_settype" was the calling function, there is no need to create new
    % figure. Only the type of the dotplot to be changed.
    
    % create buttons for ROI manipulation
    % uicontrol('Style','pushbutton','String','Delete ROI', ...
    %     'units','normalized','Position',[0.4 0.94 0.15 0.05], 'Callback', 'fca_delete_roi', ...
    %     'TooltipString','Delete the current ROI and uncolor the filtered cells');
    uicontrol('Style','pushbutton','String','Delete ROI', ...
        'units','normalized','Position',[0.64 0.94 0.15 0.05], 'Callback', 'fca_delete_roi', ...
        'TooltipString','Delete the current ROI and uncolor the filtered cells');
    % uicontrol('Style','pushbutton','String','Replace ROI', ...
    %     'units','normalized','Position',[0.6 0.94 0.15 0.05], 'Callback', 'fca_replace_roi', ...
    %     'TooltipString','Delete the current ROI and initiate a new generation');
    uicontrol('Style','pushbutton','String','Draw ROI', ...
        'units','normalized','Position',[0.8 0.94 0.15 0.05], 'Callback', 'fca_draw_roi', ...
        'TooltipString','Draw ROI and color the filtered cells');
    uicontrol('Style', 'popup','String', {'colordensity_smoothed','dotplot','colordensity',},...
           'units','normalized', 'Position', [0.3 0.95 0.32 0.04],...
           'Callback', 'fca_2dgraph_settype','FontSize',10,'FontWeight','bold','fontunits','normalized', ...
           'TooltipString','Change the plottype of the 2D graph','tag','plottype_popup');
end

return;

%etc
tt = surf(histmat_toplot);
set(tt,'linestyle','none');
set(gca,'zlim',[0 1.2*histmax]);
set(gca,'Clim',[0 1.2*histmax]);
set(gca,'xlim',[0 XScaleMax]);
set(gca,'ylim',[0 YScaleMax]);
hxl = xlabel(fcshdr.par(par1).name); 
set_font(hxl,12);
hyl = ylabel(fcshdr.par(par2).name); 
set_font(hyl,12);
colormap(cmap);
axis vis3d;

function set_font(objhandle,fontsize)

set(objhandle,'FontName','Arial');
set(objhandle,'FontSize',fontsize);
set(objhandle,'FontWeight','bold');
set(objhandle,'fontunits','normalized');

function krn = kernel (fwhm, style)
% KERNEL   Create a 2D kernel with the specified full-width half-maximum
%
%  kern = kernel (fwhm [, style])
% 
% generates a square matrix containing a 2-D function with the 
% full-width half-maximum FWHM.  Currently the only available
% kernel style is 'gaussian'.  Note that the FWHM is specified
% with respect to matrix coordinates, rather than any physical
% system.  Thus, if you wish to generate a blurring kernel with
% FWHM of (say) 20 mm, you must first find out what physical size
% each pixel in your image corresponds to, and divide the desired
% FWHM by the pixel size to get the FWHM in pixel coordinates.
% 
% For a gaussian kernel, the size of the matrix is such that three
% standard deviations will fit in the kernel on either side of the
% origin (the centre of the matrix).  The kernel matrix will always
% have an odd number of rows/columns so that the Gaussian function
% is centred in the kernel.
%
% The kernel is always normalised such that convolving with it 
% (using conv2) preserves the magnitude of the other function
% (ie. the image).
% $Id: kernel.m,v 1.3 1997/10/20 18:23:23 greg Rel $


error (nargchk (1, 2, nargin));

if (nargin < 2)
   style = 'gaussian';
end;

if (strcmp (style, 'gaussian'))

   sigma = (0.72134752044448) * (fwhm/2)^2;   % N.B. magic # is 1/(2 ln 2)
   k = 6 * sqrt(sigma);
   k = ( ceil((k-1)/2) * 2)+1; 		% round to next odd integer

   % Find parameters to make the Gaussian fit the kernel: peak at k/2,
   % range -3 .. +3 std dev's from 1..k

   x = (-floor(k/2)):(floor(k/2));
   y = exp (-x.^2 / 2 / sigma);

   krn = zeros (k, k);
   for i = 1:k
      krn (i, :) = y * y (i);
   end

else
   error (['Invalid kernel type: ' style]);
end

krn = krn / sum(sum(krn));

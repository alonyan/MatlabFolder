function [plot3d_handle, xpar, ypar, zpar]= fca_plot3d(fcsdat, fcshdr, par1, par2, par3, indexnr)
% function plot3d_handle = fca_plot3d(fcsdat,fcshdr,par1,par2,par3,indexnr)

plot3d_handle = []; xpar = []; ypar = []; zpar = [];

% if no ROI selected events, indxnr = []
if nargin == 5 
    plot3d_handle = figure('NumberTitle','off','DeleteFcn','fca_delete_histogram');
    plot3( fcsdat(:,par1), fcsdat(:,par2), fcsdat(:,par3), ...
                '.','markersize',3,'color','k');
    drawnow;
    set(gca,'box','on','ZGrid','on','YGrid','on','XGrid','on');
    hxl = xlabel(fcshdr.par(par1).name);
    set(hxl,'FontName','Arial');
    set(hxl,'FontSize',14);
    set(hxl,'FontWeight','bold');
    set(hxl,'fontunits','normalized');
    hyl = ylabel(fcshdr.par(par2).name);
    set(hyl,'FontName','Arial');
    set(hyl,'FontSize',14);
    set(hyl,'FontWeight','bold');
    set(hyl,'fontunits','normalized');
    hzl = zlabel(fcshdr.par(par3).name);
    set(hzl,'FontName','Arial');
    set(hzl,'FontSize',14);
    set(hzl,'FontWeight','bold');
    set(hzl,'fontunits','normalized');
    cameratoolbar2('NoReset');
    axis vis3d;
elseif nargin < 5 | nargin > 6
    disp('The number of input parameter is 4 or 5!');
    return;
elseif nargin == 6
    disp('Currently is not supported.');
    return;
end

function fca_2dgraph_settype

current_fig_h = gcf;
popup_h = findobj(current_fig_h,'tag','plottype_popup');
dotplottypes = get(popup_h,'string');
dotplottype = dotplottypes(get(popup_h,'value'),:);
roi_color = 'red';

% loading the main gui handle
fca_main_h = findobj('tag','fca_main_figure');
main_gui_handles = guidata(fca_main_h);
% looking for the dotplot serial number for the current figure 
current_fig_name = get(current_fig_h,'name');
dotplot_found = 0;
serial_i = 0;
while dotplot_found == 0
    serial_i = serial_i + 1;
    dotplot_name = get(main_gui_handles.dotplots(serial_i).dotplot_handle,'name');
    dotplot_found = strcmp(dotplot_name,current_fig_name);
end
dotplottype0 = main_gui_handles.dotplots(serial_i).type;
if strcmp(dotplottype0,dotplottype)
    % exit if the selected type is same as the current type 
    return;
end

par1 = main_gui_handles.dotplots(serial_i).lm_parameters(1);
par2 = main_gui_handles.dotplots(serial_i).lm_parameters(2);
roi_handler = main_gui_handles.dotplots(serial_i).roi_handler;
XChannelMax = main_gui_handles.fcshdr.par(par1).range;
YChannelMax = main_gui_handles.fcshdr.par(par2).range;
if ~isempty(roi_handler)
    roi_x0 = get(roi_handler,'XData'); 
    roi_y0 = get(roi_handler,'YData');
    if strcmp(dotplottype,'dotplot') && (strcmp(dotplottype0,'colordensity') || ...
            strcmp(dotplottype0,'colordensity_smoothed'))
        roi_x = roi_x0*XChannelMax/main_gui_handles.chplotres;
        roi_y = roi_y0*YChannelMax/main_gui_handles.chplotres;
    elseif (strcmp(dotplottype,'colordensity') || ...
            strcmp(dotplottype,'colordensity_smoothed')) && strcmp(dotplottype0,'dotplot')
        roi_x = roi_x0*main_gui_handles.chplotres/XChannelMax;
        roi_y = roi_y0*main_gui_handles.chplotres/YChannelMax;
    else
        roi_x = roi_x0;
        roi_y = roi_y0;
    end
end
% draw the new graph
delete(gca);
main_gui_handles.newfigure = 0;
fca_dotplot(main_gui_handles,par1,par2,dotplottype);
main_gui_handles.newfigure = 1;
main_gui_handles.dotplots(serial_i).type = dotplottype;
% redraw the roi if existed
if ~isempty(roi_handler)
    roi_h = line(roi_x,roi_y,'color',roi_color,'linewidth',3);
    blackline_handle = findobj(gca,'type','line','LineStyle','none','color','black');
    % if the current plot is 'dotplot' the ROI related events have to
    % color to roi_color
    if ~isempty(blackline_handle) % if the current plot is 'dotplot'
        x = get(blackline_handle,'xdata');
        y = get(blackline_handle,'ydata');
        xyrange = inpolygon(x,y,roi_x,roi_y);
        EventsInROI = find(xyrange > 0);
        selected_x = x(EventsInROI);
        selected_y = y(EventsInROI);
        hold on;
        plot(selected_x,selected_y,'.','markersize',3,'color',roi_color);
    end
    main_gui_handles.dotplots(serial_i).roi_x = roi_x;
    main_gui_handles.dotplots(serial_i).roi_y = roi_y;
    main_gui_handles.dotplots(serial_i).roi_handler = roi_h;
    % set up the "draggable" function to the roihandler
    draggable(roi_h,@fca_refresh_roi);
end
guidata(fca_main_h, main_gui_handles);

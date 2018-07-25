function fca_draw_roi;
% function [EventsInROI, roi_h]  = draw_roi;

%
% setup the scales
%
current_fig_h = gcf;
roi_x=[];
roi_y=[];
roi_color = 'red';

ButtonPressed = 1;
i = 1;
drawnow;pause(0.5);
while ButtonPressed == 1 
    [xtmp, ytmp, ButtonPressed] = ginput(1);
    roi_x = [roi_x; xtmp]; 
    roi_y = [roi_y; ytmp];
    line_h(i) = line(roi_x,roi_y,'color',roi_color,'LineWidth',2);
    i = i + 1;
end;
% delete the temporary lines
delete(line_h);

roi_x(length(roi_x)+1)=roi_x(1);
roi_y(length(roi_y)+1)=roi_y(1);
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

% saving the roi related data to the main handle
%main_gui_handles.dotplots(serial_i).events_in_roi = EventsInROI;
main_gui_handles.dotplots(serial_i).roi_x = roi_x;
main_gui_handles.dotplots(serial_i).roi_y = roi_y;
main_gui_handles.dotplots(serial_i).roi_handler = roi_h;
guidata(fca_main_h, main_gui_handles);

% disable the DrawROI button preventing to create additional ROI
DrawROI_button_h = findobj(current_fig_h,'Style','pushbutton','String','Draw ROI');
set(DrawROI_button_h,'enable','off');

% set up the "draggable" function to the roihandler
%fun_h = @(x)roitool(x,'roi_drag');
%draggable(roi_h, fun_h);
draggable(roi_h,@fca_refresh_roi);


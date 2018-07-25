function fca_refresh_roi(roi_handler)

current_fig_h = gcf;
roi_x = get(roi_handler,'XData'); 
roi_y = get(roi_handler,'YData');
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
main_gui_handles.dotplots(serial_i).events_in_roi = [];
main_gui_handles.dotplots(serial_i).roi_x = roi_x;
main_gui_handles.dotplots(serial_i).roi_y = roi_y;
guidata(fca_main_h, main_gui_handles);

% refresh the histograms
%fca_gui('DataRefreshOnHistograms',main_gui_handles);



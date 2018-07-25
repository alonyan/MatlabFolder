function fca_delete_roi

current_fig_h = gcf;
% delete the roi related objects
delete(findobj(current_fig_h,'color','red'));

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

% deleteing the roi related data in the main handle
main_gui_handles.dotplots(serial_i).events_in_roi = [];
main_gui_handles.dotplots(serial_i).roi_x = [];
main_gui_handles.dotplots(serial_i).roi_y = [];
main_gui_handles.dotplots(serial_i).roi_handler = [];
guidata(fca_main_h, main_gui_handles); 

% enable the DrawROI button
DrawROI_button_h = findobj(current_fig_h,'Style','pushbutton','String','Draw ROI');
set(DrawROI_button_h,'enable','on');

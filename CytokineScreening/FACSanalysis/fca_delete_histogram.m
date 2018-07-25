function fca_delete_histogram()

figureHandle = gcbo;
current_fig_name = get(figureHandle,'name');
double_dash_found = strfind(current_fig_name,'--');
islineplot = isempty(double_dash_found);
isdotplot = length(double_dash_found) == 1;
isplot3d = length(double_dash_found) == 2;

% loading the "main" and the "defhistograms" gui handle
fca_main_h = findobj('tag','fca_main_figure');
main_gui_handles = guidata(fca_main_h);
fca_createhist_h = findobj('tag','fca_defhistograms_figure');
createhist_gui_handles = guidata(fca_createhist_h);

if islineplot
    % looking for the lineplot serial number for the current figure 
    lineplot_found = 0;
    serial_i = 0;
    while lineplot_found == 0
        serial_i = serial_i + 1;
        lineplot_name = get(main_gui_handles.lineplots(serial_i).lineplot_handle,'name');
        lineplot_found = strcmp(lineplot_name,current_fig_name);
    end
    
    % clear the lineplot name from the LinePlotsListbox in HistDef GUI
    selected_lpname = main_gui_handles.lineplots(serial_i).name_inlistbox;
    lpnames = get(createhist_gui_handles.LinePlotsListbox,'String');
    comp_res = strcmp(lpnames,selected_lpname);
    lpnames = lpnames(find(~comp_res));
    set(createhist_gui_handles.LinePlotsListbox,'String',lpnames);
    % Update the handles for the fca_defhistograms_figure gui
    guidata(fca_createhist_h, createhist_gui_handles); 
    
    % clear the handle from the main_gui_handles 
    main_gui_handles.lineplots(serial_i) = [];  
elseif isdotplot
    % looking for the dotplot serial number for the current figure 
    dotplot_found = 0;
    serial_i = 0;
    while dotplot_found == 0
        serial_i = serial_i + 1;
        dotplot_name = get(main_gui_handles.dotplots(serial_i).dotplot_handle,'name');
        dotplot_found = strcmp(dotplot_name,current_fig_name);
    end
    
    % clear the dotplot name from the DotPlotsListbox in HistDef GUI
    selected_dpname = main_gui_handles.dotplots(serial_i).name_inlistbox;
    dpnames = get(createhist_gui_handles.DotPlotsListbox,'String');
    comp_res = strcmp(dpnames,selected_dpname);
    dpnames = dpnames(find(~comp_res));
    set(createhist_gui_handles.DotPlotsListbox,'String',dpnames);
    % Update the handles for the fca_defhistograms_figure gui
    guidata(fca_createhist_h, createhist_gui_handles); 
    
    % clear the handle from the main_gui_handles 
    main_gui_handles.dotplots(serial_i) = [];
elseif isplot3d
    % looking for the dotplot serial number for the current figure 
    plot3d_found = 0;
    serial_i = 0;
    while plot3d_found == 0
        serial_i = serial_i + 1;
        plot3d_name = get(main_gui_handles.plot3ds(serial_i).plot3d_handle,'name');
        plot3d_found = strcmp(plot3d_name, current_fig_name);
    end
    
    % clear the dotplot name from the DotPlotsListbox in HistDef GUI
    selected_dp3dname = main_gui_handles.plot3ds(serial_i).name_inlistbox;
    dp3dnames = get(createhist_gui_handles.Plots3DListbox,'String');
    comp_res = strcmp(dp3dnames,selected_dp3dname);
    dp3dnames = dp3dnames(find(~comp_res));
    set(createhist_gui_handles.Plots3DListbox,'String',dp3dnames);
    % Update the handles for the fca_defhistograms_figure gui
    guidata(fca_createhist_h, createhist_gui_handles); 
    
    % clear the handle from the main_gui_handles 
    main_gui_handles.plot3ds(serial_i) = [];
end

% Update the handles for the main gui 
guidata(fca_main_h, main_gui_handles); 


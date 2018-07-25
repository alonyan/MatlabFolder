function varargout = fca_defhistograms_gui(varargin)
% FCA_DEFHISTOGRAMS_GUI M-file for fca_defhistograms_gui.fig
%      FCA_DEFHISTOGRAMS_GUI, by itself, creates a new FCA_DEFHISTOGRAMS_GUI or raises the existing
%      singleton*.
%
%      H = FCA_DEFHISTOGRAMS_GUI returns the handle to a new FCA_DEFHISTOGRAMS_GUI or the handle to
%      the existing singleton*.
%
%      FCA_DEFHISTOGRAMS_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FCA_DEFHISTOGRAMS_GUI.M with the given input arguments.
%
%      FCA_DEFHISTOGRAMS_GUI('Property','Value',...) creates a new FCA_DEFHISTOGRAMS_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before fca_defhistograms_gui_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to fca_defhistograms_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help fca_defhistograms_gui

% Last Modified by GUIDE v2.5 14-Sep-2005 15:21:01

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @fca_defhistograms_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @fca_defhistograms_gui_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin & isstr(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before fca_defhistograms_gui is made visible.
function fca_defhistograms_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to fca_defhistograms_gui (see VARARGIN)

% Choose default command line output for fca_defhistograms_gui
handles.output = hObject;

if ishandle(varargin{1}) % figure handle 
        % store the handle to main_gui figure 
        handles.fca_defhistograms_figure_gui = varargin{1};
else % handles structure 
        % save the handle for MainGUI's figure in the handles 
        %structure. 
        % get it from the handles structure that was used as input% 
       
        % Update handles structure
        guidata(hObject, handles);
        return;
       %main_gui_handles = varargin{1}; 
       %handles.fca_defhistograms_figure_gui = main_gui_handles.main_gui; 
end 
set(handles.fca_defhistograms_figure,'WindowButtonUpFcn','fca_defhistograms_gui(''SetWindowButtonUpFcn'',gcbo,[],guidata(gcbo))');
handles.activelistbox='';
handles.clickorder_on_parlistbox = [];
main_gui_handles = guidata(handles.fca_defhistograms_figure_gui);
set(handles.ListOfParametersListbox, 'String', main_gui_handles.parnames_long);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes fca_defhistograms_gui wait for user response (see UIRESUME)
% uiwait(handles.fca_defhistograms_figure);


% --- Outputs from this function are returned to the command line.
function varargout = fca_defhistograms_gui_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes during object creation, after setting all properties.
function ListOfParametersListbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ListOfParametersListbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



% --- Executes on selection change in ListOfParametersListbox.
 function ListOfParametersListbox_Callback(hObject, eventdata, handles)
% hObject    handle to ListOfParametersListbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: contents = get(hObject,'String') returns ListOfParametersListbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ListOfParametersListbox
set(handles.DotPlotsListbox,'value',[]);
set(handles.LinePlotsListbox,'value',[]);
set(handles.Plots3DListbox,'value',[]);
handles.activelistbox='ListOfParameters';

mouseclick = get(handles.fca_defhistograms_figure,'SelectionType');
if strcmp(mouseclick,'normal')
    selected_parindex = get(handles.ListOfParametersListbox,'value');
    if length(selected_parindex) == 1
        handles.clickorder_on_parlistbox = selected_parindex;  
    else
        for i = 1 : length(handles.clickorder_on_parlistbox)
            findindex = find(selected_parindex == handles.clickorder_on_parlistbox(i));
            selected_parindex(findindex) = [];
        end
        handles.clickorder_on_parlistbox = [handles.clickorder_on_parlistbox selected_parindex];
    end
end

% Update handles structure
guidata(hObject, handles);




% --- Executes during object creation, after setting all properties.
function LinePlotsListbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to LinePlotsListbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


% --- Executes on selection change in LinePlotsListbox.
function LinePlotsListbox_Callback(hObject, eventdata, handles)
% hObject    handle to LinePlotsListbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns LinePlotsListbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from LinePlotsListbox

handles.activelistbox='LinePlots';
set(handles.ListOfParametersListbox,'value',[]);
handles.clickorder_on_parlistbox = [];
set(handles.DotPlotsListbox,'value',[]);
set(handles.Plots3DListbox,'value',[]);

% Update handles structure
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function DotPlotsListbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DotPlotsListbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


% --- Executes on selection change in DotPlotsListbox.
function DotPlotsListbox_Callback(hObject, eventdata, handles)
% hObject    handle to DotPlotsListbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns DotPlotsListbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from DotPlotsListbox

handles.activelistbox='DotPlots';
set(handles.ListOfParametersListbox,'value',[]);
handles.clickorder_on_parlistbox = [];
set(handles.LinePlotsListbox,'value',[]);
set(handles.Plots3DListbox,'value',[]);

% Update handles structure
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function Plots3DListbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Plots3DListbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


% --- Executes on selection change in Plots3DListbox.
function Plots3DListbox_Callback(hObject, eventdata, handles)
% hObject    handle to Plots3DListbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns Plots3DListbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Plots3DListbox
handles.activelistbox='Plots3D';
set(handles.ListOfParametersListbox,'value',[]);
handles.clickorder_on_parlistbox = [];
set(handles.DotPlotsListbox,'value',[]);
set(handles.LinePlotsListbox,'value',[]);

% Update handles structure
guidata(hObject, handles);


function SetWindowButtonUpFcn(hObject, eventdata,handles)
% hObject    handle to ListOfParametersListbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns ListOfParametersListbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ListOfParametersListbox
%global fcsguipar;

mouseclick = get(handles.fca_defhistograms_figure,'SelectionType');
%handles.alt = 0;
if strcmp(handles.activelistbox,'ListOfParameters')
%    
% right click on ListOfParametersListbox copies the selected items to
% the LinePlotsListbox (in case of 1 selected item), DotPlotsListbox
% (in case of 2 selected items) or to the 3DPlotsListbox (in case of 3
% selected items). 
%
	if strcmp(mouseclick,'alt')
        selected_parindex = get(handles.ListOfParametersListbox,'value');
        if length(selected_parindex) == 1; %(in case of 1 selected item)
            parnames = get(handles.ListOfParametersListbox,'String');
            selected_parnames = parnames(selected_parindex);
            current_numberoflineplot = size(get(handles.LinePlotsListbox,'string'),1);
            if isempty(get(handles.LinePlotsListbox,'string'))% no line plots has been selected
                set(handles.LinePlotsListbox,'String',selected_parnames);
            else
                current_lineplots = get(handles.LinePlotsListbox,'string');
                if find(strcmp(current_lineplots,selected_parnames))
                    return;%the selected par. has been selected to the LinePlotsListBox
                else
                    current_lineplots(current_numberoflineplot + 1) = selected_parnames;
                    set(handles.LinePlotsListbox,'String',current_lineplots);
                end
            end
           
            % +++line plot def to handles !!!!
        elseif length(selected_parindex) == 2; %(in case of 2 selected items)
            main_gui_handles = guidata(handles.fca_defhistograms_figure_gui);
            if length(handles.clickorder_on_parlistbox) == 1
                warndlg('You should use the CTRL key + mouse click to select more than one parameter!','FCA Warning');
                return;
            end
            lastindex = handles.clickorder_on_parlistbox(end);
            beflastindex = handles.clickorder_on_parlistbox(end-1);
            new_dotplotnames = {[main_gui_handles.fcshdr.par(beflastindex).name, ...
                        ' - ', ...
                        main_gui_handles.fcshdr.par(lastindex).name]};
            current_numberofdotplot = size(get(handles.DotPlotsListbox,'string'),1);
            if isempty(get(handles.DotPlotsListbox,'string'))% no dotplots has been selected
                set(handles.DotPlotsListbox,'String',new_dotplotnames);
            else
                current_dotplots = get(handles.DotPlotsListbox,'string');
                if find(strcmp(current_dotplots,new_dotplotnames))
                    return;%the selected par. has been selected to the DotPlotsListBox
                else
                    current_dotplots(current_numberofdotplot + 1) = new_dotplotnames;
                    set(handles.DotPlotsListbox,'String',current_dotplots);
                end
            end
        elseif length(selected_parindex) == 3; %(in case of 3 selected items)
            main_gui_handles = guidata(handles.fca_defhistograms_figure_gui);
            if length(handles.clickorder_on_parlistbox) == 1
                warndlg('You should use the CTRL key + mouse click to select more than one parameter!','FCA Warning');
                return;
            end
            lastindex = handles.clickorder_on_parlistbox(end);
            beflastindex = handles.clickorder_on_parlistbox(end-1);
            befbeflastindex = handles.clickorder_on_parlistbox(end-2);
            new_plot3dnames = {[main_gui_handles.fcshdr.par(befbeflastindex).name, ...
                        ' - ', ...
                        main_gui_handles.fcshdr.par(beflastindex).name, ...
                        ' - ', ...
                        main_gui_handles.fcshdr.par(lastindex).name]};
            current_numberof3dotplot = size(get(handles.Plots3DListbox,'string'),1);
            if isempty(get(handles.Plots3DListbox,'string'))% no dotplots has been selected
                set(handles.Plots3DListbox,'String',new_plot3dnames);
            else
                current_plots3d = get(handles.Plots3DListbox,'string');
                if find(strcmp(current_plots3d,new_plot3dnames))
                    return;%the selected par. has been selected to the Plots3DListBox
                else
                    current_plots3d(current_numberof3dotplot + 1) = new_plot3dnames;
                    set(handles.Plots3DListbox,'String',current_plots3d);
                end
            end
        end
        set(handles.ListOfParametersListbox,'value',[]);
        handles.clickorder_on_parlistbox = [];
	end
elseif strcmp(handles.activelistbox,'LinePlots')
%    
% right click on LinePlotsListbox remove the selected items 
%
    if strcmp(mouseclick,'alt')
        if isempty(get(handles.LinePlotsListbox,'String'))
            return;%no items in the LinePlotsListbox
        end
        selected_index = get(handles.LinePlotsListbox,'value');
        if find(selected_index)
            set(handles.LinePlotsListbox,'value',[]); % set noselection to avoid
            % delete the current selected line. It would generate warning
            % and destroy the listbox
            lpnames = get(handles.LinePlotsListbox,'String');
            selected_lpnames = lpnames(selected_index);
            for i = 1 : size(selected_lpnames,1) 
                comp_res = strcmp(lpnames,selected_lpnames(i));
                lpnames = lpnames(find(~comp_res));
            end
            set(handles.LinePlotsListbox,'String',lpnames);
        end
    end
elseif strcmp(handles.activelistbox,'DotPlots')
%    
% right click on DotPlotsListbox remove the selected items 
%
    if strcmp(mouseclick,'alt')
        if isempty(get(handles.DotPlotsListbox,'String'))
            return;%no items in the LinePlotsListbox
        end
        selected_index = get(handles.DotPlotsListbox,'value');
        if find(selected_index)
            set(handles.DotPlotsListbox,'value',[]); % set noselection to avoid
            % delete the current selected line. It would generate warning
            % and destroy the listbox
            dpnames = get(handles.DotPlotsListbox,'String');
            selected_dpnames = dpnames(selected_index);
            for i = 1 : size(selected_dpnames,1) 
                comp_res = strcmp(dpnames,selected_dpnames(i));
                dpnames = dpnames(find(~comp_res));
            end
            set(handles.DotPlotsListbox,'String',dpnames);
        end
    end
elseif strcmp(handles.activelistbox,'Plots3D')
%    
% right click on Plots3DListbox remove the selected items 
%
    if strcmp(mouseclick,'alt')
        if isempty(get(handles.Plots3DListbox,'String'))
            return;%no items in the Plots3DListbox
        end
        selected_index = get(handles.Plots3DListbox,'value');
        if find(selected_index)
            set(handles.Plots3DListbox,'value',[]); % set noselection to avoid
            % delete the current selected line. It would generate warning
            % and destroy the listbox
            dp3dnames = get(handles.Plots3DListbox,'String');
            selected_dp3dnames = dp3dnames(selected_index);
            for i = 1 : size(selected_dp3dnames,1) 
                comp_res = strcmp(dp3dnames,selected_dp3dnames(i));
                dp3dnames = dp3dnames(find(~comp_res));
            end
            set(handles.Plots3DListbox,'String',dp3dnames);
        end
    end
end

% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in Close_pushbutton.
function Close_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to Close_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(findobj('name','Create Histograms'),'visible','off');

% scrsz = get(0,'ScreenSize');
% delete(handles.fca_defhistograms_figure);


% --- Executes on button press in DrawHistograms_pushbutton.
function DrawHistograms_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to DrawHistograms_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global Hsetup
% loading the "main" and the "defhistograms" gui handle
WinSize=[420,280];
fca_main_h = findobj('tag','fca_main_figure');
main_gui_handles = guidata(fca_main_h);
Position0 = get(fca_main_h,'Position');
main_gui_handles.NextUpperLeftPositions = [Position0(1), Position0(2)-WinSize(2)-30];
disp('');

% show the lineplots
if ~isempty(get(handles.LinePlotsListbox,'string'))
    lpnames = get(handles.LinePlotsListbox,'String');
    current_numberoflineplot = size(get(handles.LinePlotsListbox,'string'),1);
    DefinitionOfLineplots = zeros(1,current_numberoflineplot);
    for i=1:current_numberoflineplot
        for j=1 : size(main_gui_handles.parnames,2)
            fres = strfind(char(lpnames(i)), char(main_gui_handles.parnames(j)));
            if ~isempty(fres)
                DefinitionOfLineplots(i) = j;
                break;
            end
        end
        LinePlotName = char(main_gui_handles.parnames_long(DefinitionOfLineplots(i)));
        if isempty(findobj('name',LinePlotName))
            lineplot_handle(i) = fca_lineplot(main_gui_handles,DefinitionOfLineplots(i),'');
            set(lineplot_handle(i),'name',LinePlotName);
            main_gui_handles.lineplots(i).lineplot_handle = lineplot_handle(i);
            main_gui_handles.lineplots(i).lm_parameter = DefinitionOfLineplots(i);
            main_gui_handles.lineplots(i).figure_name = LinePlotName;
            main_gui_handles.lineplots(i).name_inlistbox = char(lpnames(i));
            % calculate the stat. parameteres
            lmpar = DefinitionOfLineplots(i);
            current_lineplot_events = main_gui_handles.fcsdat(:,lmpar);
            logdecade = main_gui_handles.fcshdr.par(lmpar).decade;
            logval_at_zero = main_gui_handles.fcshdr.par(lmpar).logzero;
            ChannelMax = main_gui_handles.fcshdr.par(lmpar).range;
            if ~main_gui_handles.fcshdr.par(lmpar).log
                main_gui_handles.lineplots(i).mean = round(100*mean(current_lineplot_events))/100;
                main_gui_handles.lineplots(i).std = round(100*std(current_lineplot_events))/100;
            else
                current_lineplot_events_log = ...
                    logval_at_zero*10.^(double(current_lineplot_events)/ChannelMax*logdecade);
                main_gui_handles.lineplots(i).mean = round(100*mean(current_lineplot_events_log))/100;
                main_gui_handles.lineplots(i).std = round(100*std(current_lineplot_events_log))/100;
            end
            statdatatext = {['mean = ',num2str(main_gui_handles.lineplots(i).mean)],...
                ['std = ',num2str(main_gui_handles.lineplots(i).std)]};
            % create text for stat. data
            statdatatext_handle = text('units','normalized','position',[0.6 0.9],...
                'LineStyle','none','String',statdatatext, ...
                'FontUnits', 'normalized','fontsize',0.06,'fontWeight','bold');
            pause(0.1);
            %set(main_gui_handles.lineplots(i).lineplot_handle,'WindowStyle','docked');
            
            main_gui_handles.NextUpperLeftPositions = main_gui_handles.NextUpperLeftPositions  + [30,-30];
            set(main_gui_handles.lineplots(i).lineplot_handle,'Position', ...
                [main_gui_handles.NextUpperLeftPositions(1) main_gui_handles.NextUpperLeftPositions(2) WinSize(1) WinSize(2)]);
            
            pause(0.1);
            main_gui_handles.lineplots(i).statdatatext_handle = statdatatext_handle;
        end
    end
    Hsetup.lineplots = main_gui_handles.lineplots;
end

% show the dotplots
if ~isempty(get(handles.DotPlotsListbox,'string'))
    dpnames = get(handles.DotPlotsListbox,'String');
    current_numberofdotplot = size(get(handles.DotPlotsListbox,'string'),1);
    DefinitionOfdotplots = zeros(2,current_numberofdotplot);
    for i=1:current_numberofdotplot
        for j=1 : size(main_gui_handles.parnames,2)
            fres = strfind(char(dpnames(i)), char(main_gui_handles.parnames(j)));
            if ~isempty(fres)
                posres(j) = fres;
            else
                posres(j) = 0;
            end
        end
        [possortedres xi] = sort(posres);
        DefinitionOfdotplots(1,i) = xi(end-1);
        DefinitionOfdotplots(2,i) = xi(end);
        DotPlotName = [char(main_gui_handles.parnames_long(DefinitionOfdotplots(1,i))),' -- ',...
            char(main_gui_handles.parnames_long(DefinitionOfdotplots(2,i)))];
        if isempty(findobj('name',DotPlotName))
            dotplottype = main_gui_handles.dotplottype;
            main_gui_handles.dotplots(i).type = dotplottype;
            dotplot_handle(i) = fca_dotplot(main_gui_handles, ...
                DefinitionOfdotplots(1,i),DefinitionOfdotplots(2,i),dotplottype);    
            set(dotplot_handle(i),'name', DotPlotName);
            main_gui_handles.dotplots(i).dotplot_handle = dotplot_handle(i);
            main_gui_handles.dotplots(i).lm_parameters = DefinitionOfdotplots(:,i);
            main_gui_handles.dotplots(i).figure_name = DotPlotName;
            main_gui_handles.dotplots(i).name_inlistbox = char(dpnames(i));
            main_gui_handles.dotplots(i).events_in_roi = [];
            main_gui_handles.dotplots(i).roi_x = [];
            main_gui_handles.dotplots(i).roi_y = [];
            main_gui_handles.dotplots(i).roi_handler = [];
            pause(0.02);
            %set(dotplot_handle(i),'WindowStyle','docked');
            main_gui_handles.NextUpperLeftPositions = main_gui_handles.NextUpperLeftPositions  + [30,-30];
            set(dotplot_handle(i),'Position', ...
                [main_gui_handles.NextUpperLeftPositions(1) main_gui_handles.NextUpperLeftPositions(2) WinSize(1) WinSize(2)]);
            
        end
    end
    Hsetup.dotplots = main_gui_handles.dotplots;
end
pause(1);
% show the 3D plots
if ~isempty(get(handles.Plots3DListbox,'string'))
    dp3dnames = get(handles.Plots3DListbox,'String');
    current_numberof3Ddotplot = size(get(handles.Plots3DListbox,'string'),1);
    DefinitionOf3Ddotplots = zeros(3,current_numberof3Ddotplot);
    for i=1:current_numberof3Ddotplot
        for j=1 : size(main_gui_handles.parnames,2)
            fres = strfind(char(dp3dnames(i)), char(main_gui_handles.parnames(j)));
            if ~isempty(fres)
                posres(j) = fres;
            else
                posres(j) = 0;
            end
        end
        [possortedres xi] = sort(posres);
        DefinitionOf3Ddotplots(1,i) = xi(end-2);
        DefinitionOf3Ddotplots(2,i) = xi(end-1);
        DefinitionOf3Ddotplots(3,i) = xi(end);
        Plot3dName = [char(main_gui_handles.parnames(DefinitionOf3Ddotplots(1,i))),' -- ',...
            char(main_gui_handles.parnames(DefinitionOf3Ddotplots(2,i))),' -- ', ...
            char(main_gui_handles.parnames(DefinitionOf3Ddotplots(3,i)))];
        if isempty(findobj('name',Plot3dName))
            plot3d_handle(i) = fca_plot3d( main_gui_handles.fcsdat, main_gui_handles.fcshdr, ... 
                DefinitionOf3Ddotplots(1,i), DefinitionOf3Ddotplots(2,i), DefinitionOf3Ddotplots(3,i));
            set(plot3d_handle(i),'name', Plot3dName);
            main_gui_handles.plot3ds(i).plot3d_handle = plot3d_handle(i);
            main_gui_handles.plot3ds(i).lm_parameters = DefinitionOf3Ddotplots(:,i);
            main_gui_handles.plot3ds(i).figure_name = Plot3dName;
            main_gui_handles.plot3ds(i).name_inlistbox = char(dp3dnames);
        end
    end
    Hsetup.plot3ds = main_gui_handles.plot3ds;
    % default camera rotating theabout the object 
%     for i=1:180
%         camorbit(gca,2,2,'data',[0 0 1]);
%         drawnow;
%     end
end

% Update the handles for the main gui 
% (but this does not work when the code was started by "LoadHistogramSetup_pushbutton_Callback" 
% from the fca_gui.m) 
guidata(fca_main_h, main_gui_handles); 

% the Hsetup global variable pass the new values of lineplots, dotplots,
% plot3ds variables from "fca_defhistograms_gui" to this code. The guidata(hObject, handles) syntax
% does not work in "fca_defhistograms_gui" code (see the related message there) in that case,
% the reason is unknown.


if strcmp(get(findobj('name','Create Histograms'),'visible'),'on')
    set(findobj('name','Create Histograms'),'visible','off');
end



% --- Executes on button press in help_pushbutton.
function help_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to help_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[pathstr, name, ext, versn] = fileparts(which('fca.m'));
web(['file:///',pathstr,filesep,'html',filesep,'HistogramSetup.htm']);
%web(['file:///' which('HistogramSetup.htm')]);


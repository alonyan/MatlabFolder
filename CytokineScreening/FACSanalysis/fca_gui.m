function varargout = fca_gui(varargin)
% FCA_GUI M-file for fca_gui.fig
%      FCA_GUI, by itself, creates a new FCA_GUI or raises the existing
%      singleton*.
%
%      H = FCA_GUI returns the handle to a new FCA_GUI or the handle to
%      the existing singleton*.
%
%      FCA_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FCA_GUI.M with the given input arguments.
%
%      FCA_GUI('Property','Value',...) creates a new FCA_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before fca_gui_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to fca_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help fca_gui

% Last Modified by GUIDE v2.5 16-May-2006 11:08:49

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @fca_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @fca_gui_OutputFcn, ...
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


% --- Executes just before fca_gui is made visible.
function fca_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to fca_gui (see VARARGIN)

% Choose default command line output for fca_gui
handles.output = hObject;

ScreenSize = get(0,'screenSize');
Position0 = get(handles.fca_main_figure,'Position');

set(handles.fca_main_figure,'Position',[Position0(1),  ... 
    ScreenSize(4)-Position0(4)*1.5 , Position0(3), Position0(4)]);
Position0 = get(handles.fca_main_figure,'Position');
handles.NextUpperLeftPositions = [Position0(1), Position0(2)-Position0(4)];
handles.previous_path = [];
handles.chplotres = 256; % bin resolution for generating colored histogram plot
handles.global_xlinmax = 1024; 
handles.global_logdecade = 6;
handles.excelinfo.selected_filename = [];
handles.filtered_events = ':';
handles.histcut_fact= 0.05; % scale factor for discarding events when calculating histogram max
handles.dotplottype = 'colordensity_smoothed';%'dotplot';'colordensity_smoothed';'colordensity';
handles.newfigure = 1; %tmp var for fca_dotplot function
% Update handles structure
guidata(hObject, handles);

% % Open the Figures Main Window if matlab desktop exists
% isdesktop = desktop('-inuse');
% 
% if isdesktop
%     figure_h=figure;plot([1:10],[1:10]);
%     set(figure_h,'WindowStyle','docked');
%     pause(0.2);
%     delete(figure_h);  
% end
if str2double(license) == (206212) & ispc
    tmp = userinfo;
end

% UIWAIT makes fca_gui wait for user response (see UIRESUME)
% uiwait(handles.fca_main_figure);


% --- Outputs from this function are returned to the command line.
function varargout = fca_gui_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes during object creation, after setting all properties.
function fcs_filename_editbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fcs_filename_editbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function fcs_filename_editbox_Callback(hObject, eventdata, handles)
% hObject    handle to fcs_filename_editbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fcs_filename_editbox as text
%        str2double(get(hObject,'String')) returns contents of fcs_filename_editbox as a double


% --------------------------------------------------------------------
function FileMenu_Callback(hObject, eventdata, handles)
% hObject    handle to FileMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Open_fcs_fileMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to Open_fcs_file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

currend_dir = cd;
if ~isempty(handles.previous_path)
    cd(handles.previous_path);
end
[FilesSelected, FilePath] = uigetfile('*.*','Select FCS files','MultiSelect', 'on');
cd(currend_dir);
if isempty(FilesSelected) || isnumeric(FilesSelected); % no files were selected
    warndlg('There were no files selected!','!! FCA warning !!')
    return; 
end
handles.previous_path = FilePath;
if iscell(FilesSelected) 
    % if filelist was selected the 1st file will be opened
    FileNames = sortrows(FilesSelected');
    [fpath,fname,fextension,fversion] = fileparts(char(FileNames(1)));
    filename = [FilePath fname fextension];
else
    filename = [FilePath, FilesSelected];
end
if isfield(handles,'fcshdr')
   fcshdr_previous =  handles.fcshdr;
else
   fcshdr_previous = [];
end
[handles.fcsdat, handles.fcshdr] = fca_readfcs(filename);
if isempty(handles.fcshdr)
    return;
end
handles.fcshdr.fcsdat =  handles.fcsdat; 
%
% if previous histogram displays exist, the LM parameters
% should be check. If the opened file params. setup different 
% than the previous the histogram figures have to delete
%
if ~isempty(fcshdr_previous)
    if handles.fcshdr.NumOfPar ~= fcshdr_previous.NumOfPar
        handles = DeleteHistograms(handles);
    else
        for i=1:handles.fcshdr.NumOfPar
            if ~strcmp(handles.fcshdr.par(i).name, fcshdr_previous.par(i).name)
                handles = DeleteHistograms(handles);
                break;
            end
        end
    end
end
%
% In case of FCS3 or divaFCS2 (float) type file the fcsdat matrix need to
% rescale (to logarithm) enabling to use the fca_lineplot, fca_dotplot
% function developed for the standard FCS 2.0 file type
% 
handles.fcsdatrescaled = 0;
if (strcmp(handles.fcshdr.fcstype,'FCS3.0') && strcmp(handles.fcshdr.datatype,'F')  )  || ...
        (strcmp(handles.fcshdr.fcstype,'FCS2.0') && handles.fcshdr.par(1).bit == 32)
    % set up the fcsdata marix to log10(fcsdata) enabling to use lineplots
    % and dotplots developed to FCS 2.0 ordinary formatted files
%     if strcmp(handles.fcshdr.datatype,'I') && strcmp(handles.fcshdr.fcstype,'FCS3.0') 
%        handles.global_logdecade = 5; % CyAn Summit FCS3.0 where databit = 16;
%        handles.global_xlinmax = 1024;
%     end
    handles.fcshdr.original = handles.fcshdr;
    fcsdat = zeros(size(handles.fcsdat));
    handles.fcsdat(find(handles.fcsdat <= 0)) = 1;
    fcsdat = handles.global_xlinmax/handles.global_logdecade*log10(handles.fcsdat);
    for i = 1 :handles.fcshdr.NumOfPar
        if ~strcmp(handles.fcshdr.par(i).name,'Time')
             handles.fcshdr.par(i).range = handles.global_xlinmax;
             if handles.fcshdr.par(i).decade == 0
                handles.fcshdr.par(i).log = 1;
                handles.fcshdr.par(i).decade = handles.global_logdecade;
                handles.fcshdr.par(i).logzero = 1;
                handles.fcshdr.par(i).log_original = 0;
                handles.fcshdr.par(i).decade_original = 0;
            else
                handles.fcshdr.par(i).log = 1;
                handles.fcshdr.par(i).log_original = 1;
             end
        else % the time parameter does not need to log 
            fcsdat(:,i) = handles.fcsdat(:,i);
            handles.fcshdr.par(i).range = max(fcsdat(:,4));
        end
    end
    handles.fcsdat = fcsdat;
    handles.fcsdatrescaled = 1;
end
% 
% define the parameter names
%
set(handles.fcs_filename_editbox,'String',handles.fcshdr.filename);
parnames_long = cell(1,handles.fcshdr.NumOfPar);
parnames = cell(1,handles.fcshdr.NumOfPar);
for i=1:handles.fcshdr.NumOfPar
    if handles.fcsdatrescaled;
        if handles.fcshdr.par(i).log & handles.fcshdr.par(i).log_original
            logflag = 'log.scale';
        else
            logflag = 'lin.scale';
        end
    else
        if handles.fcshdr.par(i).log
            logflag = 'log.scale';
        else
            logflag = 'lin.scale';
        end
    end
    parnames(i) = {handles.fcshdr.par(i).name};
    parnames_long(i) = {[handles.fcshdr.par(i).name,' - ',logflag]};
end
handles.parnames = parnames;
handles.parnames_long = parnames_long;
handles.excelinfo.first_raw = [];
%
% create the whole list of the related LM files
% and identify the current file serial number
%
if isfield(handles,'LMfilesInDir')
    handles = rmfield(handles,'LMfilesInDir');
end
if iscell(FilesSelected) % if filelist was selected
    for i =1: size(FileNames,1)
        handles.LMfilesInDir(i) = dir([FilePath char(FileNames(i))]);
    end
    current_serial_number = 1;
else % if single file was selected
    [pathstr, fmainname, fext, versn]  = fileparts(handles.fcshdr.filename);
    fpath = handles.fcshdr.filepath;
    handles.LMfilesInDir = dir([fpath, fmainname,'*']);
    for current_serial_number =1: length(handles.LMfilesInDir);
        if strcmp(handles.LMfilesInDir(current_serial_number).name,handles.fcshdr.filename);break,end
    end
end
handles.LMfileSerialNumber = current_serial_number;
set(handles.NumOfEvent_edit,'String',handles.fcshdr.TotalEvents);
set(handles.NumOfEventInROI_edit,'String',handles.fcshdr.TotalEvents);

% Update handles structure
guidata(hObject, handles);

% --------------------------------------------------------------------
function ExitMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to ExitMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
selection = questdlg(['Close ' get(handles.fca_main_figure,'Name') '?'],...
                     ['Close ' get(handles.fca_main_figure,'Name') '...'],...
                     'Yes','No','Yes');
if strcmp(selection,'No')
    return;
end
% delete the created objects
delete(findobj('name','Create Histograms'));
if isfield(handles,'lineplots');
    for i = 1: size(handles.lineplots,2)
        tmphandle = handles.lineplots(i).lineplot_handle;
        if ishandle(tmphandle); 
            set(tmphandle,'DeleteFcn','');%clear the DeleteFcn callback 
            % before destroying the figures
            delete(tmphandle);
        end
    end
end
if isfield(handles,'dotplots');
    for i = 1: size(handles.dotplots,2)
        tmphandle = handles.dotplots(i).dotplot_handle;
        if ishandle(tmphandle); 
            set(tmphandle,'DeleteFcn','');%clear the DeleteFcn callback 
            % before destroying the figures
            delete(tmphandle);
        end
    end
end
if isfield(handles,'plot3ds');
    for i = 1: size(handles.plot3ds,2)
        tmphandle = handles.plot3ds(i).plot3d_handle;
        if ishandle(tmphandle); delete(tmphandle);end
    end
end
delete(handles.fca_main_figure);


% --------------------------------------------------------------------
function HistogramsMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to HistogramsMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in CreateHistograms_pushbutton.
function CreateHistograms_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to CreateHistograms_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isfield(handles,'fcsdat');return;end

if isempty(findobj('name','Create Histograms'))
    fca_defhistograms_gui(handles.fca_main_figure);
else
    set(findobj('name','Create Histograms'),'visible','on');
end


% --- Executes on button press in Recalculate_Histograms_pushbutton.
function Recalculate_Histograms_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to Recalculate_Histograms_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isfield(handles,'fcshdr');return;end
DataRefreshOnHistograms(handles)


% --- Executes on button press in NextLmFile_pushbutton.
function NextLmFile_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to NextLmFile_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isfield(handles,'fcsdat');return;end

fpath = handles.fcshdr.filepath;
next_serial_number = handles.LMfileSerialNumber + 1;
if next_serial_number > length(handles.LMfilesInDir)
    msgbox('The current file is the last in the list!','FCA info','warn');
    return;
end
next_fname = handles.LMfilesInDir(next_serial_number).name;

[handles.fcsdat, handles.fcshdr] = fca_readfcs([fpath, next_fname]);
if isempty(handles.fcsdat)
    msgbox('The current file is the last in the list!','FCA info','warn');
    return;
end

if handles.fcsdatrescaled
    % set up the fcsdata marix to log10(fcsdata) enabling to use lineplots
    % and dotplots developed to FCS 2.0 ordinary formatted files
    fcsdat = zeros(size(handles.fcsdat));
    handles.fcsdat(find(handles.fcsdat <= 0)) = 1;
    fcsdat = handles.global_xlinmax/handles.global_logdecade*log10(handles.fcsdat);
    for i = 1 :handles.fcshdr.NumOfPar
         handles.fcshdr.par(i).range = handles.global_xlinmax;
         if handles.fcshdr.par(i).decade == 0
            handles.fcshdr.par(i).log = 1;
            handles.fcshdr.par(i).decade = 6;
            handles.fcshdr.par(i).log_original = 0;
            handles.fcshdr.par(i).decade_original = 0;
        else
            handles.fcshdr.par(i).log = 1;
            handles.fcshdr.par(i).log_original = 1;
        end
    end
    handles.fcsdat = fcsdat;
end

set(handles.fcs_filename_editbox,'String',handles.fcshdr.filename);
handles.LMfileSerialNumber = next_serial_number;
set(handles.NumOfEvent_edit,'String',handles.fcshdr.TotalEvents);

% Update handles structure
guidata(hObject, handles);

DataRefreshOnHistograms(handles);


% --- Executes on button press in PrevioustLmFile_pushbutton.
function PrevioustLmFile_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to PrevioustLmFile_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isfield(handles,'fcsdat');return;end

fpath = handles.fcshdr.filepath;
previous_serial_number = handles.LMfileSerialNumber - 1;
if previous_serial_number == 0
    msgbox('The current file is the first in the list!','FCA info','warn');
    return;
end
next_fname = handles.LMfilesInDir(previous_serial_number).name;

[handles.fcsdat, handles.fcshdr] = fca_readfcs([fpath, next_fname]);
[handles.fcsdat, handles.fcshdr] = fca_readfcs([fpath, next_fname]);
if isempty(handles.fcsdat)
    msgbox('The current file is the first in the list!','FCA info','warn');
    return;
end

if handles.fcsdatrescaled
    % set up the fcsdata marix to log10(fcsdata) enabling to use lineplots
    % and dotplots developed to FCS 2.0 ordinary formatted files
    fcsdat = zeros(size(handles.fcsdat));
    handles.fcsdat(find(handles.fcsdat <= 0)) = 1;
    fcsdat = handles.global_xlinmax/handles.global_logdecade*log10(handles.fcsdat);
    for i = 1 :handles.fcshdr.NumOfPar
         handles.fcshdr.par(i).range = handles.global_xlinmax;
         if handles.fcshdr.par(i).decade == 0
            handles.fcshdr.par(i).log = 1;
            handles.fcshdr.par(i).decade = 6;
            handles.fcshdr.par(i).log_original = 0;
            handles.fcshdr.par(i).decade_original = 0;
        else
            handles.fcshdr.par(i).log = 1;
            handles.fcshdr.par(i).log_original = 1;
        end
    end
    handles.fcsdat = fcsdat;
end

set(handles.fcs_filename_editbox,'String',handles.fcshdr.filename);
handles.LMfileSerialNumber = previous_serial_number;
set(handles.NumOfEvent_edit,'String',handles.fcshdr.TotalEvents);

% Update handles structure
guidata(hObject, handles);

DataRefreshOnHistograms(handles);

% --- Executes on button press in LoadHistogramSetup_pushbutton.
function LoadHistogramSetup_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to LoadHistogramSetup_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global Hsetup
Hsetup = [];

if ~isfield(handles,'fcsdat');return;end

Hsetup = [];
% start loading
currend_dir = cd;
cd(handles.fcshdr.filepath);
[hsetupfilename, pathname] = uigetfile('*.mat', 'Load histogram setup as');
if isequal(hsetupfilename,0) | isequal(pathname,0)
    return;
end
cd(currend_dir);
load([pathname,hsetupfilename]);

% test whether the parameters in the HistSetup 
% match to the opened LM file
if length(handles.parnames_long) ~= length(HistSetup.parnames_long)
    msgbox('The saved Histogram setup does not match to the opened LM file!','FCA info','warn');
    return;
end
for i = 1 : length(handles.parnames_long);
    if ~strcmp(HistSetup.parnames_long(i), handles.parnames_long(i));
        msgbox('The saved Histogram setup does not match to the opened LM file!','FCA info','warn');
        return;
    end
end

% clear the current figures if they exists
if isfield(handles,'lineplots');
    for i = 1: size(handles.lineplots,2)
        tmphandle = handles.lineplots(i).lineplot_handle;
        if ishandle(tmphandle); 
            set(tmphandle,'DeleteFcn','');%clear the DeleteFcn callback 
            % before destroying the figures
            delete(tmphandle);
        end
    end
    handles = rmfield(handles,'lineplots');
end
if isfield(handles,'dotplots');
    for i = 1: size(handles.dotplots,2)
        tmphandle = handles.dotplots(i).dotplot_handle;
        if ishandle(tmphandle); 
            set(tmphandle,'DeleteFcn','');%clear the DeleteFcn callback 
            % before destroying the figures
            delete(tmphandle);
        end
    end
    handles = rmfield(handles,'dotplots');
end
if isfield(handles,'plot3ds');
    for i = 1: size(handles.plot3ds,2)
        tmphandle = handles.plot3ds(i).plot3d_handle;
        if ishandle(tmphandle); 
            set(tmphandle,'DeleteFcn','');%clear the DeleteFcn callback 
            % before destroying the figures
            delete(tmphandle);
        end
    end
    handles =  rmfield(handles,'plot3ds');
end

% open unvisible the "Create Histograms" if still does not exists
if isempty(findobj('name','Create Histograms'))
    fca_defhistograms_gui(handles.fca_main_figure);
    set(findobj('name','Create Histograms'),'visible','off');
end

% loading the "Create Histograms" gui handle
fca_createhist_h = findobj('tag','fca_defhistograms_figure');
createhist_gui_handles = guidata(fca_createhist_h);
set(createhist_gui_handles.ListOfParametersListbox, 'String', handles.parnames_long);

% set up the plot definitions
handles.lineplots = HistSetup.lineplots;
current_numberoflineplot = size(handles.lineplots,2);
lpnames = cell(current_numberoflineplot,1);
for i=1:current_numberoflineplot
    lpnames(i) =  {handles.lineplots(i).name_inlistbox};
end
set(createhist_gui_handles.LinePlotsListbox,'String',lpnames);

if isfield(HistSetup,'dotplots')
    handles.dotplots = HistSetup.dotplots;
    current_numberofdotplot = size(handles.dotplots,2);
    dpnames = cell(current_numberofdotplot,1);
    for i = 1: current_numberofdotplot
        dpnames(i) = {handles.dotplots(i).name_inlistbox};
    end
    set(createhist_gui_handles.DotPlotsListbox,'String',dpnames);
end
if isfield(HistSetup,'plot3ds')
    handles.plot3ds = HistSetup.plot3ds;
    current_numberof3Ddotplot = size(handles.plot3ds,2);
    dp3dnames = cell(current_numberof3Ddotplot,1);
    for i = 1: current_numberof3Ddotplot
        dp3dnames(i) = {handles.plot3ds(i).name_inlistbox};
    end
    set(createhist_gui_handles.Plots3DListbox,'String',dp3dnames);
end

% Update the handles for the fca_defhistograms_figure gui
guidata(fca_createhist_h, createhist_gui_handles); 
    
% Update handles structure
guidata(hObject, handles);

% draw the histograms
fca_defhistograms_gui('DrawHistograms_pushbutton_Callback',createhist_gui_handles.DrawHistograms_pushbutton,[],createhist_gui_handles);

% the Hsetup global variable pass the new values of lineplots, dotplots,
% plot3ds variables from "fca_defhistograms_gui" to this code. The guidata(hObject, handles) syntax
% does not work in "fca_defhistograms_gui" code (see the related message there) in that case,
% the reason is unknown.
handles.lineplots   = Hsetup.lineplots;
if isfield(Hsetup,'dotplots')
    handles.dotplots    = Hsetup.dotplots; 
end
if isfield(Hsetup,'plot3ds')
    handles.plot3ds   = Hsetup.plot3ds;
end

% draw the ROIs
roicolor = 'red';
if isfield(handles,'dotplots')
    current_numberofdotplot = size(handles.dotplots,2);
    for i = 1 : current_numberofdotplot
        if ~isempty(HistSetup.dotplots(i).roi_x) 
            % if roi exists on current dotplot
            handles.dotplots(i).roi_x = HistSetup.dotplots(i).roi_x;
            handles.dotplots(i).roi_y = HistSetup.dotplots(i).roi_y;
            dotplot_handle = handles.dotplots(i).dotplot_handle;
            figure(dotplot_handle);
            roi_h = line(handles.dotplots(i).roi_x, handles.dotplots(i).roi_y,'color',roicolor,'linewidth',3);
        end
    end
end
% Update handles structure
guidata(hObject, handles);

% Refresh the histograms
DataRefreshOnHistograms(handles);

% --- Executes on button press in SaveHistogramSetup_pushbutton.
function SaveHistogramSetup_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to SaveHistogramSetup_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isfield(handles,'fcshdr');return;end

%Creates the structure of HistSetup to be saved as mat file  
if ~isfield(handles,'lineplots');return;end
HistSetup.lineplots = handles.lineplots;
if isfield(handles,'dotplots')
    HistSetup.dotplots = handles.dotplots;
end
if isfield(handles,'plot3ds')
    HistSetup.plot3ds = handles.plot3ds;
end
HistSetup.parnames_long = handles.parnames_long;

% start saving
currend_dir = cd;
cd(handles.fcshdr.filepath);
[hsetupfilename, pathname] = uiputfile('*.mat', 'Save histogram setup as');
if isequal(hsetupfilename,0) | isequal(pathname,0)
    return;
end
cd(currend_dir);
[pathstr,filemainname,ext,vers] = fileparts(hsetupfilename);
save([pathname,filemainname,'.mat'],'HistSetup');


% --- Executes on button press in Save2xls_pushbutton.
function Save2xls_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to Save2xls_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if ~isfield(handles,'fcshdr');return;end
if ~isfield(handles,'lineplots');return;end
current_numberoflineplot = size(handles.lineplots,2);
dataout = cell(1, 2*current_numberoflineplot+3);
dataout(1,1) = {handles.fcshdr.filename};
dataout(1,2) = num2cell(str2num(char(get(handles.NumOfEvent_edit,'String'))));
dataout(1,3) = num2cell(str2num(char(get(handles.NumOfEventInROI_edit,'String'))));
for i = 1 : current_numberoflineplot
    dataout(1, 2*i + 2 : 2*i + 3) = num2cell([handles.lineplots(i).mean, handles.lineplots(i).std ]);
end

hm = msgbox('Exporting data to Excel ...','Fca Info' );
SetData=setptr('watch');set(hm,SetData{:});
hmc = (get(hm,'children'));
set(hmc(2),'enable','inactive');
pause(0.2);

% get the file name of the lm. files(without extension) to create
% the xls file name
current_filename = handles.fcshdr.filename;
current_path = handles.fcshdr.filepath;
[pathstr, name, ext, versn] = fileparts(current_filename);
xlsoutname = [current_path,'fca_',name,'.xls'];
if isempty(handles.excelinfo.selected_filename)
    current_filename = handles.fcshdr.filename;
    current_path = handles.fcshdr.filepath;
    [pathstr, name, ext, versn] = fileparts(current_filename);
    xlsoutname = [current_path,'fca_',name,'.xls'];
else
    xlsoutname = handles.excelinfo.selected_filename;
end
sheetoutname = 'results';
if isempty(handles.excelinfo.first_raw)
    % test wheter the file still exists or not
    first_raw = 1;
    xlsfile = dir(xlsoutname);
    if size(xlsfile,1)
        % check whether the excel file has a "result" sheet
        [type, sheets] = xlsfinfo(xlsoutname);
        if any(strcmp(sheets,'results'))
            % figure out the first empty raw in the "results" sheet
            [num_xls, txt_xls, raw_xls] = xlsread(xlsoutname,'results');
            first_raw = size(raw_xls,1) + 1;
        end
    end
    handles.excelinfo.first_raw = first_raw;
else
    first_raw = handles.excelinfo.first_raw;
end


% write the data to the excel file
range_xls = ['A',num2str(first_raw)];
[xls_status, xls_message] = xlswrite(xlsoutname, dataout, sheetoutname,range_xls);
if xls_status
    handles.excelinfo.first_raw = handles.excelinfo.first_raw + 1;
    set(handles.excel_filename_editbox,'String',xlsoutname);
    drawnow;
else
    msgbox(xls_message.message,'fca info: The excel file might be opened!','error');
end

% Update handles structure
guidata(hObject, handles);
delete(hm);

% --- Executes on button press in Header2xls_pushbutton.
function Header2xls_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to Header2xls_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isfield(handles,'fcshdr');return;end
if ~isfield(handles,'lineplots');return;end

current_numberoflineplot = size(handles.lineplots,2);
dataout = cell(2, 2*current_numberoflineplot+3);
dataout(1,1) = {'FileName'};
dataout(1,2) = {'TotEvents'};
dataout(1,3) = {'EventsInROI'};
for i = 1 : current_numberoflineplot
    dataout(1, 2*i + 2 : 2*i + 3) = {handles.lineplots(i).name_inlistbox, ' '};
    dataout(2, 2*i + 2 : 2*i + 3) = {'mean', 'std'};
end

hm = msgbox('Exporting header to Excel ...','Fca Info' );
SetData=setptr('watch');set(hm,SetData{:});
hmc = (get(hm,'children'));
set(hmc(2),'enable','inactive');
pause(0.2);

% get the file name of the lm. files(without extension) to create
% the xls file name
if isempty(handles.excelinfo.selected_filename)
    current_filename = handles.fcshdr.filename;
    current_path = handles.fcshdr.filepath;
    [pathstr, name, ext, versn] = fileparts(current_filename);
    xlsoutname = [current_path,'fca_',name,'.xls'];
else
    xlsoutname = handles.excelinfo.selected_filename;
end
sheetoutname = 'results';
if isempty(handles.excelinfo.first_raw)
    % test wheter the file still exists or not
    first_raw = 1;
    xlsfile = dir(xlsoutname);
    if size(xlsfile,1)
        % check whether the excel file has a "result" sheet
        [type, sheets] = xlsfinfo(xlsoutname);
        if ~all(strcmp(sheets,'results'))
            % figure out the first empty raw in the "results" sheet
            [num_xls, txt_xls, raw_xls] = xlsread(xlsoutname,'results');
            first_raw = size(raw_xls,1) + 1;
        end
    end
    handles.excelinfo.first_raw = first_raw;
else
    first_raw = handles.excelinfo.first_raw;
end


% write the data to the excel file
range_xls = ['A',num2str(first_raw)];
[xls_status, xls_message] = xlswrite(xlsoutname, dataout, sheetoutname,range_xls);
if xls_status
    handles.excelinfo.first_raw = handles.excelinfo.first_raw + 2;
    set(handles.excel_filename_editbox,'String',xlsoutname);
else
    msgbox(xls_message.message,'fca info: The excel file might be opened!','error');
end

% Update handles structure
guidata(hObject, handles);
delete(hm);


function DataRefreshOnHistograms(handles)
% After loading new LM file or HistSetup refresh the data on all axis

if ~isfield(handles,'lineplots');return;end
current_numberoflineplot = size(handles.lineplots,2);

EventsInROI = [1:handles.fcshdr.TotalEvents];
handles.filtered_events = 0;

%calculate the filtered events (EventsInROI) based on the ROIs of dotplots
if isfield(handles,'dotplots')
    current_numberofdotplot = size(handles.dotplots,2);
    for i = 1: current_numberofdotplot
        if ~isempty(handles.dotplots(i).roi_x)
            % calculate the new x,y values without drawing new plot
            par1 = handles.dotplots(i).lm_parameters(1);
            par2 = handles.dotplots(i).lm_parameters(2);
            dotplottype = handles.dotplots(i).type;
            [dotplot_handle_tmp, x, y] = fca_dotplot(handles, par1, par2, dotplottype, ':');
            xyrange = inpolygon(double(x), double(y), handles.dotplots(i).roi_x, handles.dotplots(i).roi_y);
            EventsInROI_currentdotplot = find(xyrange > 0);
            handles.dotplots(i).events_in_roi = EventsInROI_currentdotplot;
            EventsInROI = intersect(EventsInROI, EventsInROI_currentdotplot);
            handles.filtered_events = EventsInROI;
        end
    end
end
set(handles.NumOfEventInROI_edit,'String',length(EventsInROI));
roi_EventsInROI = handles.dotplots(i).events_in_roi;
EventsInROI_dotplot = [];
if ~isempty(roi_EventsInROI) 
    % if roi exists on current dotplot
    EventsInROI_dotplot = intersect(EventsInROI,roi_EventsInROI);
elseif (length(EventsInROI) < handles.fcshdr.TotalEvents) & isempty(roi_EventsInROI) 
    % if roi exists on different dotplot  
    EventsInROI_dotplot = EventsInROI;
elseif (length(EventsInROI) == handles.fcshdr.TotalEvents) &  isempty(roi_EventsInROI)
    % if roi does not exists at all  
    EventsInROI_dotplot = [];
end

% redraw the filtered lineplots
for i = 1 : current_numberoflineplot
    lmpar = handles.lineplots(i).lm_parameter;
    lineplot_handle = handles.lineplots(i).lineplot_handle;
    [lineplot_handle_tmp xout yout] = fca_lineplot(handles, lmpar,'',EventsInROI);
    current_line_handle = findobj(lineplot_handle,'type','line');
    set(current_line_handle,'XData',xout,'YData',yout);
    % calculate the stat. parameteres
    current_lineplot_events = handles.fcsdat(EventsInROI,lmpar);
    logdecade = handles.fcshdr.par(lmpar).decade;
    logval_at_zero = handles.fcshdr.par(lmpar).logzero;
    ChannelMax = handles.fcshdr.par(lmpar).range;
    if ~handles.fcshdr.par(lmpar).log
        handles.lineplots(i).mean = round(100*mean(current_lineplot_events))/100;
        handles.lineplots(i).std = round(100*std(double(current_lineplot_events)))/100;
    else
        current_lineplot_events_log =  ...
            logval_at_zero*10.^(double(current_lineplot_events)/ChannelMax*logdecade);
        handles.lineplots(i).mean = round(100*mean(current_lineplot_events_log))/100;
        handles.lineplots(i).std = round(100*std(current_lineplot_events_log))/100;
    end
    statdatatext = {['mean = ',num2str(handles.lineplots(i).mean)],...
                ['std = ',num2str(handles.lineplots(i).std)]};
    % change text for statistical data
    set(handles.lineplots(i).statdatatext_handle,'String',statdatatext);
    
    figure(lineplot_handle); refresh;
    guidata(handles.fca_main_figure, handles); 
end


% redraw the filtered dotplots
roicolor2 = 'red';
if isfield(handles,'dotplots')
    current_numberofdotplot = size(handles.dotplots,2);
    for i = 1 : current_numberofdotplot
        dotplot_handle = handles.dotplots(i).dotplot_handle;
        par1 = handles.dotplots(i).lm_parameters(1);
        par2 = handles.dotplots(i).lm_parameters(2);
        dotplottype = handles.dotplots(i).type;
        % calculate the new x,y values without drawing new plot
        [dotplot_handle_tmp, xpar, ypar, histmatout] = fca_dotplot(handles, par1, par2, dotplottype, ':');
        
        if ~strcmp(dotplottype,'dotplot')
            figure(dotplot_handle);
            image_handles = findobj(gca,'type','image');
            set(image_handles,'Cdata',histmatout.histmat_toplot);
            set(gca,'Clim',[0 histmatout.histmax]);
            continue;
        end
        % delete the roi related points in the dotplot
        delete(findobj(dotplot_handle,'color',roicolor2,'type','line','LineStyle','none'));

        % redraw the new points 
        figure(dotplot_handle);
        line_handles = findobj(gca,'type','line','LineStyle','none','color','black');
        set(line_handles,'xdata',xpar,'ydata',ypar);

        % color the roi related events
        if ~isempty(EventsInROI_dotplot)
            selected_x = xpar(EventsInROI_dotplot);
            selected_y = ypar(EventsInROI_dotplot);
            hold on;
            plot(selected_x,selected_y,'.','markersize',3,'color',roicolor2);
        end
        refresh;
    end
    guidata(handles.fca_main_figure, handles); 
end


% redraw the filtered plot3ds
if ~isfield(handles,'plot3ds');return;end
current_numberof3Ddotplot = size(handles.plot3ds,2);
for i = 1 : current_numberof3Ddotplot
    plot3d_handle = handles.plot3ds(i).plot3d_handle;
    par1 = handles.plot3ds(i).lm_parameters(1);
    par2 = handles.plot3ds(i).lm_parameters(2);
    par3 = handles.plot3ds(i).lm_parameters(3);

    % delete the roi related points in the dotplot
    delete(findobj(plot3d_handle,'color',roicolor2,'type','line','LineStyle','none'));

    % calculate the new x,y values without drawing new plot
    xpar = handles.fcsdat(:,par1); ypar = handles.fcsdat(:,par2); zpar = handles.fcsdat(:,par3);

    % redraw the new points 
    figure(plot3d_handle);
    line_handles = findobj(gca,'type','line','LineStyle','none','color','black');
    set(line_handles,'xdata',xpar,'ydata',ypar,'zdata',zpar);

    % color the roi related events
    if ~isempty(EventsInROI_dotplot)
        selected_x = xpar(EventsInROI_dotplot);
        selected_y = ypar(EventsInROI_dotplot);
        selected_z = zpar(EventsInROI_dotplot);
        hold on;
        plot3( selected_x, selected_y, selected_z, ...
                    '.','markersize',3,'color',roicolor2);
        refresh;
    end
end 


function NumOfEvent_edit_Callback(hObject, eventdata, handles)
% hObject    handle to NumOfEvent_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NumOfEvent_edit as text
%        str2double(get(hObject,'String')) returns contents of NumOfEvent_edit as a double


% --- Executes during object creation, after setting all properties.
function NumOfEvent_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NumOfEvent_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function NumOfEventInROI_edit_Callback(hObject, eventdata, handles)
% hObject    handle to NumOfEventInROI_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NumOfEventInROI_edit as text
%        str2double(get(hObject,'String')) returns contents of NumOfEventInROI_edit as a double


% --- Executes during object creation, after setting all properties.
function NumOfEventInROI_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NumOfEventInROI_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function HelpMenu_Callback(hObject, eventdata, handles)
% hObject    handle to HelpMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function status = userinfo;

fcafullpath = which('fca_gui.m');
[fcapath, name, ext, versn] = fileparts(fcafullpath);
inf_filename = [fcapath,filesep,'private',filesep,'userinf.txt'];
fid = fopen(inf_filename,'a+');

if fid == -1;
    status = -2
    return;
end

fprintf( fid, '%s', datestr(now));
[status ,cname] = dos('set computername');
[status ,uname] = dos('set username');
fprintf( fid, '%s', '; ');
fprintf( fid, '%s', uname);
fprintf( fid, '%s', '; ');
fprintf( fid, '%s\n', cname);
fclose(fid);


% --------------------------------------------------------------------
function ExcelOptionsMenu_Callback(hObject, eventdata, handles)
% hObject    handle to ExcelOptionsMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function OpenExcelFile_Callback(hObject, eventdata, handles)
% hObject    handle to OpenExcelFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isfield(handles,'fcshdr');return;end

excelobj = actxserver('Excel.Application');
% get the file name of the lm. files(without extension) to define
% the xls file name
if isempty(handles.excelinfo.selected_filename)
    current_filename = handles.fcshdr.filename;
    current_path = handles.fcshdr.filepath;
    [pathstr, name, ext, versn] = fileparts(current_filename);
    xlsoutname = [current_path,'fca_',name,'.xls'];
else
    xlsoutname = handles.excelinfo.selected_filename;
end
xlsfile = dir(xlsoutname);
if size(xlsfile,1)
    excelobj.Workbooks.Open(xlsoutname);
    excelobj.Visible=true;
    handles.excelobj = excelobj;
    excelobj.WindowState='xlNormal';
    for i=1 : excelobj.Sheets.Count
        if strcmp(excelobj.Sheets.Item(i).Name,'results')
            excelobj.Sheets.Item(i).Activate;
            break;
        end
    end
    if isempty(handles.excelinfo.selected_filename)
        handles.excelinfo.selected_filename = xlsoutname;
        set(handles.excel_filename_editbox,'String',handles.excelinfo.selected_filename);
    end
    % Update handles structure
    guidata(hObject, handles);
end



% --------------------------------------------------------------------
function SetFirstRowinExcel_Callback(hObject, eventdata, handles)
% hObject    handle to SetFirstRowinExcel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isfield(handles,'fcshdr');return;end

inputcell = inputdlg('Enter the row number','FCA Excel output setup',1,{num2str(handles.excelinfo.first_raw)});
if ~isempty(inputcell)
    handles.excelinfo.first_raw =  str2num(cell2mat(inputcell));
    % Update handles structure
    guidata(hObject, handles);
end




% --------------------------------------------------------------------
function Show_fcs_hdrMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to Show_fcs_hdrMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isfield(handles,'fcshdr');return;end

global fca_fcahdrinfo;
if (strcmp(handles.fcshdr.fcstype,'FCS3.0') && strcmp(handles.fcshdr.datatype,'F')  ) || ...
        strcmp(handles.fcshdr.fcstype,'FCS2.0') && handles.fcshdr.par(1).bit == 32
    fca_fcahdrinfo = handles.fcshdr.original;
else
    fca_fcahdrinfo = handles.fcshdr;
end
if isvarname('ans')
    openvar('ans');
end
workspace;


% --------------------------------------------------------------------
function Close_FCS_fileMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to Close_FCS_fileMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isfield(handles,'fcshdr');return;end

% delete the created objects
handles = DeleteHistograms(handles);
handles = rmfield(handles,'fcshdr');
handles = rmfield(handles,'fcsdat');
set(handles.fcs_filename_editbox,'String','');

% Update handles structure
guidata(hObject, handles);


% --------------------------------------------------------------------
function handles = DeleteHistograms(handles)
% handles    structure with handles and user data (see GUIDATA)

delete(findobj('name','Create Histograms'));
handles = rmfield(handles,'parnames_long');
handles = rmfield(handles,'parnames');
handles.excelinfo.selected_filename = [];
set(handles.excel_filename_editbox,'String',handles.excelinfo.selected_filename);
set(handles.NumOfEventInROI_edit,'String','');
set(handles.NumOfEvent_edit,'String','');
if isfield(handles,'lineplots');
    for i = 1: size(handles.lineplots,2)
        tmphandle = handles.lineplots(i).lineplot_handle;
        if ishandle(tmphandle); 
            set(tmphandle,'DeleteFcn','');%clear the DeleteFcn callback 
            % before destroying the figures
            delete(tmphandle);
        end
    end
    handles = rmfield(handles,'lineplots');
end
if isfield(handles,'dotplots');
    for i = 1: size(handles.dotplots,2)
        tmphandle = handles.dotplots(i).dotplot_handle;
        if ishandle(tmphandle); 
            set(tmphandle,'DeleteFcn','');%clear the DeleteFcn callback 
            % before destroying the figures
            delete(tmphandle);
        end
    end
    handles = rmfield(handles,'dotplots');
end
if isfield(handles,'plot3ds');
    for i = 1: size(handles.plot3ds,2)
        tmphandle = handles.plot3ds(i).plot3d_handle;
        if ishandle(tmphandle); delete(tmphandle);end
    end
    handles = rmfield(handles,'plot3ds');
end



% --------------------------------------------------------------------
function SelectExcelFile_Callback(hObject, eventdata, handles)
% hObject    handle to SelectExcelFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isfield(handles,'fcshdr');return;end

curdir = pwd;
cd(handles.fcshdr.filepath);
[xlsfilename, pathname] = uiputfile('*.xls', 'Select xls file for results');
if isequal(xlsfilename,0) | isequal(pathname,0)
   return;
end
handles.excelinfo.selected_filename = [pathname, xlsfilename];
set(handles.excel_filename_editbox,'String',handles.excelinfo.selected_filename);
% Update handles structure
guidata(hObject, handles);



% --------------------------------------------------------------------
function Save_FCS_as_txtMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to Save_FCS_as_txtMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isfield(handles,'fcshdr');return;end

curdir = pwd;
cd(handles.fcshdr.filepath);
[txtfilename, pathname] = uiputfile('*.txt', 'Save FCS data as txt file');
if isequal(txtfilename,0) | isequal(pathname,0)
   return;
end
dataout = handles.fcshdr.fcsdat(handles.filtered_events,:);
save([pathname txtfilename],'dataout','-ascii','-tabs');
cd(curdir);


function excel_filename_editbox_Callback(hObject, eventdata, handles)
% hObject    handle to excel_filename_editbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of excel_filename_editbox as text
%        str2double(get(hObject,'String')) returns contents of excel_filename_editbox as a double


% --- Executes during object creation, after setting all properties.
function excel_filename_editbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to excel_filename_editbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during mouse clicking, after setting all properties.
function excel_filename_editbox_ButtonDownFcn(hObject, eventdata, handles)

if ~isfield(handles,'fcshdr');return;end
fca_gui('OpenExcelFile_Callback',gcbo,[],guidata(gcbo));




% --------------------------------------------------------------------
function List_of_FeaturesMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to List_of_FeaturesMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[pathstr, name, ext, versn] = fileparts(which('fca.m'));
web(['file:///',pathstr,filesep,'html',filesep,'fca.html']);

% --------------------------------------------------------------------
function Histogram_SetupMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to Histogram_SetupMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[pathstr, name, ext, versn] = fileparts(which('fca.m'));
web(['file:///',pathstr,filesep,'html',filesep,'HistogramSetup.htm']);


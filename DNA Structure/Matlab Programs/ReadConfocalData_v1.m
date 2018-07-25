function varargout = ReadConfocalData_v1(varargin)
% READCONFOCALDATA_V1 M-file for ReadConfocalData_v1.fig
%      READCONFOCALDATA_V1, by itself, creates a new READCONFOCALDATA_V1 or raises the existing
%      singleton*.
%
%      H = READCONFOCALDATA_V1 returns the handle to a new READCONFOCALDATA_V1 or the handle to
%      the existing singleton*.
%
%      READCONFOCALDATA_V1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in READCONFOCALDATA_V1.M with the given input arguments.
%
%      READCONFOCALDATA_V1('Property','Value',...) creates a new READCONFOCALDATA_V1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ReadConfocalData_v1_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ReadConfocalData_v1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ReadConfocalData_v1

% Last Modified by GUIDE v2.5 26-Jul-2004 01:48:54

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ReadConfocalData_v1_OpeningFcn, ...
                   'gui_OutputFcn',  @ReadConfocalData_v1_OutputFcn, ...
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


% --- Executes just before ReadConfocalData_v1 is made visible.
function ReadConfocalData_v1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ReadConfocalData_v1 (see VARARGIN)

% Choose default command line output for ReadConfocalData_v1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ReadConfocalData_v1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ReadConfocalData_v1_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes during object creation, after setting all properties.
function Contrast_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Contrast_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background, change
%       'usewhitebg' to 0 to use default.  See ISPC and COMPUTER.
usewhitebg = 1;
if usewhitebg
    set(hObject,'BackgroundColor',[.9 .9 .9]);
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


% --- Executes on slider movement.
function Contrast_slider_Callback(hObject, eventdata, handles)
% hObject    handle to Contrast_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

Contrast = get(handles.Contrast_slider, 'Value');
Brightness = get(handles.Brightness_slider, 'Value');
PicNum = get(handles.Picture_listbox, 'Value');
EntryNum = get(handles.Layers_listbox, 'Value');

FigureHandle = handles.MyFigures(PicNum).FigureHandle;
IntensityArray = handles.data(EntryNum).Picture(PicNum).Picture; 
DrawPicture(FigureHandle, IntensityArray, Contrast, Brightness, handles.myColormap);

handles.MyFigures(PicNum).Contrast = Contrast;
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function Brightness_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Brightness_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background, change
%       'usewhitebg' to 0 to use default.  See ISPC and COMPUTER.
usewhitebg = 1;
if usewhitebg
    set(hObject,'BackgroundColor',[.9 .9 .9]);
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


% --- Executes on slider movement.
function Brightness_slider_Callback(hObject, eventdata, handles)
% hObject    handle to Brightness_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

Contrast = get(handles.Contrast_slider, 'Value');
Brightness = get(handles.Brightness_slider, 'Value');
PicNum = get(handles.Picture_listbox, 'Value');
EntryNum = get(handles.Layers_listbox, 'Value');

FigureHandle = handles.MyFigures(PicNum).FigureHandle;
IntensityArray = handles.data(EntryNum).Picture(PicNum).Picture; 
DrawPicture(FigureHandle, IntensityArray, Contrast, Brightness, handles.myColormap);

handles.MyFigures(PicNum).Brightness = Brightness;
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function Layers_listbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Layers_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


% --- Executes on selection change in Layers_listbox.
function Layers_listbox_Callback(hObject, eventdata, handles)
% hObject    handle to Layers_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns Layers_listbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Layers_listbox

EntryNum = get(hObject, 'Value');
data = handles.data;

if (isfield(handles, 'MyFigures')) & not(isempty(handles.MyFigures)) ,
    close(handles.MyFigures.FigureHandle);
    handles.MyFigures = [];
end;
       
MarkerSize = get(handles.MarkerSize_popup, 'Value')-1;
if (not(isempty(data(EntryNum).CorrelationData)) & (MarkerSize>0)),
    ScanSettings = data(EntryNum).ScanSettings;
    Coordinates.X = [data(EntryNum).CorrelationData.CoordinatesX];
    Coordinates.Y = [data(EntryNum).CorrelationData.CoordinatesY];
end;


for i=1:length(data(EntryNum).Picture),
    PictureList{i} = int2str(i);
    handles.MyFigures(i).FigureHandle =figure;
    handles.MyFigures(i).Contrast = 0.5;
    handles.MyFigures(i).Brightness = 0.5;
    if (isempty(data(EntryNum).CorrelationData) | (MarkerSize==0)),
        DrawPicture(handles.MyFigures(i).FigureHandle, data(EntryNum).Picture(i).Picture, handles.MyFigures(i).Contrast, handles.MyFigures(i).Brightness, handles.myColormap)
    else
        DrawPicture(handles.MyFigures(i).FigureHandle, data(EntryNum).Picture(i).Picture, handles.MyFigures(i).Contrast, handles.MyFigures(i).Brightness, handles.myColormap, ScanSettings, Coordinates, MarkerSize);
    end;
end;

set(handles.Picture_listbox, 'String', PictureList);
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function Filename_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Filename_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function Filename_text_Callback(hObject, eventdata, handles)
% hObject    handle to Filename_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Filename_text as text
%        str2double(get(hObject,'String')) returns contents of Filename_text as a double


% --- Executes on button press in Load_button.
function Load_button_Callback(hObject, eventdata, handles)
% hObject    handle to Load_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

myColormap = [(0:253)' (0:253)' (0:253)'; 255 0 0; 0 255 0]/255;
handles.myColormap = myColormap;
guidata(hObject,handles);

filename = get(handles.Filename_text,'string');
if length(filename) == 0,
    [filename, path, FILTERINDEX] = uigetfile('*.*', 'Pick binary correlation file');
    filename = strcat(path, filename);
end;

temp1 = load(filename);
temp2 = fieldnames(temp1);
data = temp1.(temp2{1});

set(handles.Filename_text, 'string', filename);
NofLayers = length(data);

for i=1:NofLayers,
    LayersList{i} = int2str(i);
end;
set(handles.Layers_listbox, 'String', LayersList);

if (isfield(handles, 'MyFigures')) & not(isempty(handles.MyFigures)) ,
    close(handles.MyFigures.FigureHandle);
    handles.MyFigures = [];
end;

MarkerSize = get(handles.MarkerSize_popup, 'Value')-1;
if (not(isempty(data(1).CorrelationData)) & (MarkerSize>0)),
    ScanSettings = data(1).ScanSettings;
    Coordinates.X = [data(1).CorrelationData.CoordinatesX];
    Coordinates.Y = [data(1).CorrelationData.CoordinatesY];
end;


for i=1:length(data(1).Picture),
    PictureList{i} = int2str(i);
    handles.MyFigures(i).FigureHandle =figure;
    handles.MyFigures(i).Contrast = 0.5;
    handles.MyFigures(i).Brightness = 0.5;
    if (isempty(data(1).CorrelationData) | (MarkerSize==0)),
        DrawPicture(handles.MyFigures(i).FigureHandle, data(1).Picture(i).Picture, handles.MyFigures(i).Contrast, handles.MyFigures(i).Brightness, myColormap);
    else
        DrawPicture(handles.MyFigures(i).FigureHandle, data(1).Picture(i).Picture, handles.MyFigures(i).Contrast, handles.MyFigures(i).Brightness, myColormap, ScanSettings, Coordinates, MarkerSize);
    end;
end;
set(handles.Picture_listbox, 'String', PictureList);


handles.data = data;
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function Picture_listbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Picture_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


% --- Executes on selection change in Picture_listbox.
function Picture_listbox_Callback(hObject, eventdata, handles)
% hObject    handle to Picture_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns Picture_listbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Picture_listbox

PicNum = get(handles.Picture_listbox, 'Value');
figure(handles.MyFigures(PicNum).FigureHandle);
set(handles.Contrast_slider, 'Value', handles.MyFigures(PicNum).Contrast);
set(handles.Brightness_slider, 'Value', handles.MyFigures(PicNum).Brightness);


% --- Executes during object creation, after setting all properties.
function Correlation_listbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Correlation_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


% --- Executes on selection change in Correlation_listbox.
function Correlation_listbox_Callback(hObject, eventdata, handles)
% hObject    handle to Correlation_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns Correlation_listbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Correlation_listbox


% --- Executes on button press in ShowCF_CR_checkbox.
function ShowCF_CR_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to ShowCF_CR_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of ShowCF_CR_checkbox


% --- Executes on button press in ShowAverage_checkbox.
function ShowAverage_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to ShowAverage_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of ShowAverage_checkbox


% --- Executes during object creation, after setting all properties.
function Rejection_textbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Rejection_textbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function Rejection_textbox_Callback(hObject, eventdata, handles)
% hObject    handle to Rejection_textbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Rejection_textbox as text
%        str2double(get(hObject,'String')) returns contents of Rejection_textbox as a double


% --- Executes on button press in Recalculate_pushbutton.
function Recalculate_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to Recalculate_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Plot_Trace_checkbox.
function Plot_Trace_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to Plot_Trace_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Plot_Trace_checkbox





% --- Executes during object creation, after setting all properties.
function MarkerSize_popup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MarkerSize_popup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


% --- Executes on selection change in MarkerSize_popup.
function MarkerSize_popup_Callback(hObject, eventdata, handles)
% hObject    handle to MarkerSize_popup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns MarkerSize_popup contents as cell array
%        contents{get(hObject,'Value')} returns selected item from MarkerSize_popup


%--- Draw picture in a given window with a given contrast and brightness
function DrawPicture(FigureHandle, IntensityArray, Contrast, Brightness, myColormap, varargin)
Expansion = 3;

mi = min(min(IntensityArray));
ma=max(max(IntensityArray));
Inorm=(IntensityArray - mi)/(ma-mi);
RescaledArray=253*(0.5+(Inorm-(1-Brightness))*tan(Contrast*pi/2))+1;
RescaledArray(find(RescaledArray>253))=253;
RescaledArray(find(RescaledArray<0))=0;
RA=interp2(RescaledArray, Expansion);


% show markers
if (size(varargin, 2) > 0),
    ScanSettings = varargin{1};
    MarkerCoordinates =varargin{2};
    MarkerSize = varargin{3};
    
    Xexp = ScanSettings.StratX : (ScanSettings.StepX/2^Expansion) : (ScanSettings.StratX + (ScanSettings.NstepX-1)*ScanSettings.StepX);
    Yexp = ScanSettings.StratY : (ScanSettings.StepY/2^Expansion) : (ScanSettings.StratY + (ScanSettings.NstepY-1)*ScanSettings.StepY);
    
    for i=1:length(MarkerCoordinates.X),
        [temp, MC.indX(i)] = min(abs(Xexp-MarkerCoordinates.X(i)));  
        [temp, MC.indY(i)] = min(abs(Yexp-MarkerCoordinates.Y(i)));
        IndX = (MC.indX(i)-MarkerSize+1):(MC.indX(i)+MarkerSize-1);
        IndY = (MC.indY(i)-MarkerSize+1):(MC.indY(i)+MarkerSize-1);
        
        IndX(find(IndX<1))=1;
        IndX(find(IndX>length(Xexp)))=length(Xexp);
        IndY(find(IndY<1))=1;
        IndY(find(IndY>length(Yexp)))=length(Yexp);
        
        RA(IndX, IndY) = 256;
    end;
end;

%ps = 0:0.001:1
%px= mi + (ma-mi)*ps;
%py=255*(0.5+(ps-b)*tan(c*pi/2));
figure(FigureHandle);
image(RA);
colormap(myColormap);
axis image;
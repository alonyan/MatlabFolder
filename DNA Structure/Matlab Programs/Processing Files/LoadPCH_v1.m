function A=LoadPCH_v1(varargin)  %(path, filename)
% a variant of LoadAutoCorrelation_v3, where averaging data was removed
% only the data in the file are loaded into the correlation structure
% all of the postprocessing will be done separately

%rejection=1;
if length(varargin)==0,
    [filename, path, FILTERINDEX] = uigetfile('*.*', 'Pick binary correlation file');
    deleteList = [];
elseif length(varargin)==1,
    fullFileName = varargin{1};
elseif length(varargin)==2,
    path = varargin{1};
    filename=varargin{2};
else
    errordlg('too many parameters')
end;

fullFileName = strcat(path, filename);
fid = fopen(fullFileName, 'r');

%read version
version = fread(fid, 1, 'uint16');

if version == 1,
    DataType = fread(fid, 1, 'int32');
    if DataType ~= 110,
        error('Data type does not correspond to Correlation Function!');
    end;
    
    A.TotalSaves = fread(fid, 1, 'int32');
    A.dt = fread(fid, 1, 'double');
    LogBookSize=fread(fid, 1, 'int32');
    A.LogBook = fscanf(fid, '%c', LogBookSize);
    A.count =  fread(fid, inf , 'uint8');
%    A.trace=A.trace';

     A.version =1;
 %   B = AverageCorr_v2(A, rejection, filter);
end;

fclose(fid);




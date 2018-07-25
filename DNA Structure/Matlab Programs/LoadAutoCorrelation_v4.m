function A=LoadAutoCorrelation_v4(varargin)  %(path, filename)
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

if version ==0,
    NrunsDemanded = fread(fid, 1, 'uint32')
    NrunsPerformed = fread(fid, 1, 'uint32')
    RunTime= fread(fid, 1, 'double')
    CorrFuncLength = fread(fid, 1, 'int32')
    CountRateLength = fread(fid, 1, 'int32')
    
    Lag=fread(fid, CorrFuncLength, 'double');
    CorrFuncArray = fread(fid, [ CorrFuncLength, NrunsPerformed], 'double');
    CountRateArray = fread(fid, [CountRateLength,  NrunsPerformed], 'double');
    A.lag=Lag;
    A.corrfunc=CorrFuncArray;
    A.CR= CountRateArray;

   
    
%    A=AverageBinary1(A);
end;

if version == 1,
    DataType = fread(fid, 1, 'int32');
    if DataType ~= 100,
        error('Data type does not correspond to Correlation Function!');
    end;
    
    LogBookSize=fread(fid, 1, 'int32');
    A.LogBook = fscanf(fid, '%c', LogBookSize);
    A.NrunsDemanded = fread(fid, 1, 'uint32');
    A.NrunsPerformed = fread(fid, 1, 'uint32');
    A.RunTime= fread(fid, 1, 'double');
    ArraysLength=fread(fid, 4, 'int32');
    
    CorrArrays=fread(fid, [ ArraysLength(2), ArraysLength(1)], 'double');
%    CorrArrays=CorrArrays';
%    A.CorrArrays=CorrArrays;
    A.lag=CorrArrays(:,1)*1000;%ms
  
%    A.lag=A.lag(:);
    
    A.AfterPulse=CorrArrays(:,2);
%    A.AfterPulse = A.AfterPulse';
    
    A.corrfunc=CorrArrays(:, 3:(ArraysLength(1)/2+1));
 %   A.corrfunc=A.corrfunc';
    
    A.CF_CR=CorrArrays(:, (ArraysLength(1)/2+2):ArraysLength(1));
%    A.CF_CR=A.CF_CR';
    
    A.trace=fread(fid, [ ArraysLength(4), ArraysLength(3)], 'double');
%    A.trace=A.trace';

      
 %   B = AverageCorr_v2(A, rejection, filter);
end;

if version == 2,
    DataType = fread(fid, 1, 'int32')
    if DataType ~= 100,
        error('Data type does not correspond to Correlation Function!');
    end;
    
    B.TotalScans =fread(fid, 1, 'int32');
    SpeedArrayLength = fread(fid, 1, 'int32');
    B.SpeedArray = fread(fid, SpeedArrayLength, 'int32');
    LogBookSize=fread(fid, 1, 'int32');
    B.LogBook = fscanf(fid, '%c', LogBookSize);
    B.version = 3;
   %B.CorrStuct(1:SpeedArrayLength).Speed = B.SpeedArray(1:SpeedArrayLength);
    B.CorrStuctArray =cell(SpeedArrayLength, 1);
     
    for i = 1:B.TotalScans,
        A.Speed = fread(fid, 1, 'uint32');
        A.NrunsDemanded = fread(fid, 1, 'uint32');
        A.NrunsPerformed = fread(fid, 1, 'uint32');
        A.RunTime= fread(fid, 1, 'double');
        ArraysLength=fread(fid, 4, 'int32');
        A.LogBook = B.LogBook;
    
        CorrArrays=fread(fid, [ ArraysLength(2), ArraysLength(1)], 'double');
        %size(CorrArrays)

        A.lag=CorrArrays(:,1)*1000; %ms
    
        A.AfterPulse=CorrArrays(:,2);
    
        %A.corrfunc=CorrArrays(:, 3:(ArraysLength(1)/2+1));
        A.corrfunc=CorrArrays(:, 4:(ArraysLength(1)+3)/2);
   
        A.CF_CR=CorrArrays(:, ((ArraysLength(1)+5)/2):ArraysLength(1));
    
        A.trace=fread(fid, [ ArraysLength(4), ArraysLength(3)], 'double');
        
        J=find(B.SpeedArray == A.Speed);
        Len = length(B.CorrStuctArray{J});
        B.CorrStuctArray{J}{Len+1} = A;

    end; %for i = 1:TotalScans,
    
    A = B;

end;

fclose(fid);




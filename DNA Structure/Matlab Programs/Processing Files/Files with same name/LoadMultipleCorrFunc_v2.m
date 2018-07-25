function L = LoadMultipleCorrFunc_v2(varargin);
% created on 19.04.06: stript down version of FullExtractBinary_v3
% opening files or joining existing structures
% primary postprocessing + averaging
%
% 
% y = LoadMultipleCorrFunc_v1(folderPath,  {FileName1 FileName2 ...}, ...);
% or as
% y = LoadMultipleCorrFunc_v1({CFstructure1 CFstructure2 ...},...);
% other parameters come in pairs
% 'Rejection' --------- rejection (2 by default)
% 'Filter' ------------- filter ('CF_CR Variance'- default, 'dIdI Variance', 'LowCountTrace', 'HighCountTrace', or 'Norm one'- required 'Range' parameter )
% 'DeleteList' ---------- deleteList ([])
% 'ErrorEstimateType' ----- errorEstimate ('Standard' - default or 'Ratio to plateau' - then required 'Range' parameter)
%  
%  Modifications on 27.04.06
% 'AfterPulse'  -------- AfterPulse CF_CR
%  Modification on 28.04.06
% change AfterPulse into 'deltaAfterPulse'   -----------  deltaAP : the
% difference between the calculated afterpulse and real afterpulse
%
% Modifications on 08.03.07. 
% added processing of different speeds
% 'Speed' ----------- speed as a number
%
%Example of use
%  L48_static = LoadMultipleCorrFunc_v2('\\Eligal-lior\F$\Oleg\TTTTa\231007\', {'L48_static'}, 'Rejection', 2, 'DeleteList', [])
% L48_static = LoadMultipleCorrFunc_v2('\\Eligal-lior\F$\Oleg\TTTTa\231007\', {'L48_static' 'L48_dynamic160_0' 'L48_dynamic185_1'}, 'Rejection', 1, 'DeleteList', [])


if ischar(varargin{1}),
    'opening files'
    LoadingCorrelatorFiles = 1;
    
    folderPath = varargin{1}
    FileNames = varargin{2}
    
    NofFiles = length(FileNames);
    for i = 1: NofFiles,    
        Ls{i}=LoadAutoCorrelation_v5(folderPath, FileNames{i});
    end;
    
    if (NofFiles ==1) & isfield(Ls{1}, 'version'),
        if (Ls{1}.version == 3),
            j1=find(strcmp(varargin, 'Speed'));
            if length(j1)>1,
                error('Too many Speed inputs!')
            elseif length(j1)==1,
                Speed = varargin{j1+1};
            else %default
                Speed = 0;
            end;
            
            J = find(Ls{1}.SpeedArray == Speed);
            if isempty(J),
                error('No appropriate speed found. Check your Speed input.')
            else
                Ls = Ls{1}.CorrStuctArray{J}
                NofFiles = length(Ls)
            end;
        end;
    end;
    
elseif iscell(varargin{1}),
    'processing structures'
    LoadingCorrelatorFiles = 0;
    CFStructures = varargin{1};
    
    NofFiles = length(CFStructures);
    for i = 1: NofFiles,    
        Ls{i}=CFStructures{i};
    end;

else error('bad first argument')
end;

j1=find(strcmp(varargin, 'Rejection'));
if length(j1)>1,
    error('Too many Rejection inputs!')
elseif length(j1)==1,
    rejection = varargin{j1+1};
else %default
    rejection = 2;
end;

j1=find(strcmp(varargin, 'Filter'));
if length(j1)>1,
    error('Too many Filter inputs!')
elseif length(j1)==1,
    filter = varargin{j1+1};
else %default
    filter = 'CF_CR Variance';
end;

j1=find(strcmp(varargin, 'DeleteList'));
if length(j1)>1,
    error('Too many DeleteList inputs!')
elseif length(j1)==1,
    deleteList = varargin{j1+1};
else %default
    deleteList = [];
end;

j1=find(strcmp(varargin, 'ErrorEstimateType'));
if length(j1)>1,
    error('Too many ErrorEstimateType inputs!')
elseif length(j1)==1,
    errorEstimate = varargin{j1+1};
else %default
    errorEstimate = 'Standard';
end;

if (strcmp(errorEstimate, 'Ratio to plateau') | strcmp(filter, 'Norm one')),
    j1=find(strcmp(varargin, 'Range'));
    if length(j1)>1,
        error('Too many Range inputs!')
    elseif length(j1)==1,
        range = varargin{j1+1};
    else %default
        errordlg('Range parameter required');
    end;
else
    range=[];
end;

L.corrfunc =[];
L.CF_CR =[];
L.trace = [];


for i = 1: NofFiles, 
    %size(L.CF_CR);
    L.corrfunc = [L.corrfunc Ls{i}.corrfunc];
    L.CF_CR = [L.CF_CR Ls{i}.CF_CR];
    %size(L.CF_CR)
    
    if size(L.trace, 1) > size(Ls{i}.trace, 1),
        zeroPad = zeros(size(L.trace, 1) - size(Ls{i}.trace, 1), size(Ls{i}.trace, 2));
        Ls{i}.trace = [Ls{i}.trace; zeroPad];
    elseif size(L.trace, 1) < size(Ls{i}.trace, 1),
        zeroPad = zeros(size(Ls{i}.trace, 1) - size(L.trace, 1), size(L.trace, 2));
        L.trace = [L.trace; zeroPad];
    end;
    L.trace =[L.trace Ls{i}.trace];
end;


%L.corrfunc(:, deleteList)=[];
%L.CF_CR(:, deleteList)=[];
%L.trace(:, deleteList)=[];
   
L.NrunsPerformed = size(L.corrfunc, 2);
L.lag = Ls{1}.lag;
L.LogBook = Ls{1}.LogBook;
L.AfterPulse=Ls{1}.AfterPulse;
if isfield(Ls{1}, 'version'),
    L.version = Ls{1}.version;
else 
    L.version = 1;
end;


%if isfield(Ls{1}, 'AfterPulseCalcutated'),
%    L.AfterPulseCalculated = Ls{1}.AfterPulseCalculated;
%end;

j1=find(strcmp(varargin, 'Use measured AfterPulse'));
if length(j1)>1,
    error('Too many Use measured AfterPulse inputs!')
elseif length(j1)==1,
        L.AfterPulseCalculated = L.AfterPulse;
 end;

j1=find(strcmp(varargin, 'deltaAfterPulse'));
if length(j1)>1,
    error('Too many deltaAfterPulse inputs!')
elseif length(j1)==1,
    deltaAP = varargin{j1+1};
  
    L = AverageCorr_v3(L, LoadingCorrelatorFiles, rejection, filter, deleteList, deltaAP, errorEstimate, range);
else %default
    L = AverageCorr_v3(L, LoadingCorrelatorFiles, rejection, filter, deleteList,[], errorEstimate, range);
end;

j1=find(strcmp(varargin, 'NormalizationRange'));
if length(j1)>1,
    error('Too many NormalizationRange inputs!')
elseif length(j1)==1,
    normRange = varargin{j1+1};
else 
    normRange = [1e-3 1e-2];
end;
    
if (L.version ==4) | (L.version ==5) ,
    L.Xcoord = Ls{1}.Xcoord;
    L.Ycoord = Ls{1}.Ycoord;
     L.Zcoord = Ls{1}.Zcoord;
     L.dt = Ls{1}.dt;
     
     L.v_um_s = sqrt(diff(L.Xcoord).^2+diff(L.Ycoord).^2)*8/(L.dt);
     L.t_v = L.dt*(1:length(L.v_um_s));
     L.median_speed_um_s = median(L.v_um_s);
     L.std_speed_um_s = std(L.v_um_s);     
     L.vt_um  = L.lag *L.median_speed_um_s/1000; 
      
     j = find((L.lag > normRange(1)) & (L.lag < normRange(2)));
     L.G0 = mean(L.AverageCF_CR(j));
     L.Normalized = L.AverageCF_CR./L.G0;
     L.errorNormalized = L.errorCF_CR./mean(L.AverageCF_CR(j));
     
end;


j=find(L.lag > 1e-4); % to avoid zooming
figure;

if isfield(L, 'CF_CRbad'),
    semilogx(L.lag(j), L.CF_CRgood(j, :), L.lag(j), L.CF_CRbad(j, :), '-k');
else 
    semilogx(L.lag(j), L.CF_CRgood(j, :))
end;

figure;

semilogx(L.lag(j), L.AverageAllCF_CR(j), L.lag(j), L.AverageCF_CR(j));

%L.CreatingString = varargin;
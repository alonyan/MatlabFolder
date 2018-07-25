%% Variables - please set filepath & filehead for your FCS files data
clear ;
filepath = ['G:\TTTTa\140109\'];
filehead = 'L8expbuf_V';
nameTemplate = filehead;
RhFileNames = {'Rh6Ga'};
Static = {'L8expbuf_st'};
Rejection = 1;
NormRange = [1e-3 3e-3];
%% Variables - processing
RETPATH = pwd();
cd (filepath);
FILEHEAD=[filehead,'*'];
files = dir(FILEHEAD);
names = {files.name};
i=0;
j=0;
FALSE ='false';
NAMES = FALSE;
cd (RETPATH);
%% File Names Processing
while (i < length(names) );
    i=i+1;
    MARK = length(filehead);%strfind(names{i}, filehead);
    tempstr = names{i}((MARK+1):length(names{i}));
    tempmatch = strfind(tempstr, '_');
    tempV = tempstr(1:tempmatch(length(tempmatch))-1);
    FLAG = 0;

    if (strcmp(NAMES,FALSE));
          NAMES = names(i);
     else;
          NAMES = [NAMES,names(i)];
    end
    if (i == length(names));
        FLAG=1;
    else
        MARKVV = MARK;%strfind(names{i+1}, filehead) ;
        tempstrVV = names{i+1}((MARKVV+1):length(names{i+1}));
        tempmatchVV = strfind(tempstrVV, '_');
        tempVV = tempstrVV(1:tempmatchVV(length(tempmatchVV))-1);
        if(strcmp(tempV,tempVV));
            FLAG = 0;
        else
            FLAG = 1;
        end
    end
    if( FLAG == 1);
        j=j+1;
        Names{j} = NAMES;
        Speed{j}=tempV;
        NAMES = FALSE;
    end
end
Names'
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Clear unneeded Vars
clear FLAG FILEHEAD tempstrVV tempstr tempmatchVV tempmatch tempVV tempV  i ans RETPATH MARKVV MARK FALSE;
m=0
%% Section A - please repeat this section for every speed - 
%% the end will be marked as "end of section A".
m=m+1
%%% Group analysis - please set the appropriate rejection rate below
           Rejection = 2;
           NormRange = [1e-3 3e-3];
           S = LoadMultipleCorrFunc_v2(filepath, Names{m}, 'Rejection', Rejection, 'NormalizationRange', NormRange,  'DeleteList', []);
           %pause;

%%% remove fields which are not needed for futher processing
           fields_to_remove = {
           'corrfunc' 
           'AfterPulseCalculated'
           'trace'
           'CR'
           'CF_CR'
           'dIdI'
           'corrfuncgood'
           'tracegood'
           'CF_CRgood'
           'dIdIgood'
           'corrfuncbad'
           'tracebad'
           'CF_CRbad'
           'dIdIbad'
           'AveragedIdI'
           'AverageAlldIdI'
           'errordIdI'
           'errorAlldIdI'
           'WeightAverageCF'
           'WeightAverageAllCF'
           'errorWA_CF'
           'errorAllWA_CF'
           'score'
           'AfterPulse'
           'Xcoord'
           'Ycoord'
           'Zcoord'
           'v_um_s'
           't_v'
           };
       %S = rmfield(S, fields_to_remove);
       
%%% Create Data Structure - please change Var name.
%%% examle
        SPEED = strtrim(Speed{m});
        HEADDD = strtrim(filehead);
        KEEPNAME=[HEADDD,SPEED];
        TTT = [KEEPNAME '  =  S'];
        
        eval([TTT])
        %L24_v1p1 = S;
        KEEPNAME
        m
%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%


%% Extract displacement for zero speed
%RhFileNames = {'Rh6Ga'};
%filepath = ['C:\Documents and Settings\Administrator\Desktop\170108\'];
%filehead = 'L24_V';
 %NormRange = [1e-3 3e-3];
%%
 S = LoadMultipleCorrFunc_v2(filepath, Static, 'Rejection', Rejection, 'DeleteList', []);
%%
 Rh6G = LoadMultipleCorrFunc_v2(filepath, RhFileNames, 'Rejection', 2, 'NormalizationRange', NormRange,  'DeleteList', []);
%%
 S_ext = ExtractWithoutNoiseStructures_v3_1(S,  [], 'Average', [1e-3 2e-3], 'Rh6G calibration',  {Rh6G Rh6G 30000 0.002 'All'}, 'Create Model', {'diff3D'})

%% List data structure names
clear B;
%filename = 'L48_sd1_260807'
%nameTemplate = 'Pik2_PR_PBS_vv';
clear vel;
%strucNames = who( '-file', filename, [nameTemplate '*']);
strucNames = who([nameTemplate '*']);
for i = 1:length(strucNames),
    vel(i) = sscanf(strucNames{i}, [nameTemplate '%d']);
end;
[temp, I] = sort(vel);

strucNames = strucNames(I) %check the strucNames and delete/add!!!! 

%% Construct combined array
 arrayName = input('What is the name of the combined array?','s') 
 minLength=217;
 J=1:minLength;
 
for i=1:length(strucNames),
    eval(['A=' strucNames{i}  ';']);

   if i ==1,
       B.lag = A.lag(J);
       B.AverageCF_CR = A.AverageCF_CR(J);
       B.errorCF_CR = A.errorCF_CR(J);
       B.vt_um = A.vt_um(J);
   else
        B.AverageCF_CR =  [B.AverageCF_CR A.AverageCF_CR(J)];
       B.errorCF_CR = [B.errorCF_CR A.errorCF_CR(J)];
       B.vt_um = [B.vt_um A.vt_um(J)];
   end;
    eval([arrayName '= B;']);
end;

semilogx(B.lag, B.AverageCF_CR);
%figure(h)

%% Normalization
%range of lags for plateau normalization - 
range = [1e-3 3e-3];

plateau_indexes = find((B.lag>range(1))&(B.lag < range(2)));

%find range of vt_us for baseline subtraction
semilogx(B.vt_um, B.AverageCF_CR);
title('find the range to remove baseline and hit any key then')
pause;
v = axis;

for i=1:size(B.vt_um, 2),
    baseline_indexes= find((B.vt_um(:, i)>v(1))&(B.vt_um(:, i) < v(2)));
    
    %take weighted average
     G0=sum(B.AverageCF_CR(plateau_indexes, i)./B.errorCF_CR(plateau_indexes, i).^2)/sum(B.errorCF_CR(plateau_indexes, i).^(-2));
    if ~isreal(G0),
        'not real G0'
        G0=mean(B.AverageCF_CR(plateau_indexes, i)), 
    end;
    
    if vel(i) ~= 0,
        baseline=sum(B.AverageCF_CR(baseline_indexes, i)./B.errorCF_CR(baseline_indexes, i).^2)/sum(B.errorCF_CR(baseline_indexes, i).^(-2));
        if ~isreal(baseline),
            'not real baseline'
            baseline =mean(B.AverageCF_CR(baseline_indexes, i)), 
        end;
    else
        baseline = 0;
    end;
    
    B.Normalized(:, i) = (B.AverageCF_CR(:, i) - baseline)/(G0 - baseline);
    B.errorNormalized(:, i) = B.errorCF_CR(:, i)/(G0 - baseline);
end;
semilogx(B.lag, B.Normalized);
eval([arrayName '= B;']);
    
%% Possible another normalization to bring the curves together
% range = [200e-3 500e-3];
% 
% plateau_indexes = find((B.lag>range(1))&(B.lag < range(2)));
% 
% G0=sum(B.Normalized(plateau_indexes, :)./B.errorNormalized(plateau_indexes, :).^2)./sum(B.errorNormalized(plateau_indexes, :).^(-2));
% 
%  B.ReNormalized = B.Normalized./repmat(G0, minLength, 1)*mean(G0);
%  B.errorReNormalized = B.errorNormalized ./repmat(G0, minLength, 1)*mean(G0);
% 
% semilogx(B.lag, B.ReNormalized);
% eval([arrayName '= B;']);

%% Renormalizing


NormRange = [1e-3 3e-3];
%NormRange = [10e-3 20e-3];
%arrayName = input('What is the name of the combined array?','s') 
%eval(['B=' arrayName ';']);

j1 = find((B.lag > NormRange(1)) & (B.lag < NormRange(2)));
for i =1:size(B.Normalized, 2),
    B.ReNormalized(:, i) = B.Normalized(:, i)/robmean(B.Normalized(j1, i), B.errorNormalized(j1, i));          
end;
B.errorReNormalized = B.errorNormalized;
semilogx(B.lag, B. ReNormalized, NormRange(1)*[1 1], [0 1.5], '--k', NormRange(2)*[1 1], [0 1.5], '--k');
axis([1e-4 1e4 -0.1 1.5])
figure(gcf);

%%  evaluate diplacements from  slowest run
slow = 1;
wSq = S_ext.SamplingVolume.wSq;
model.hSq =  10.^(-3:0.01:3);
model.G = 1./(1+2/3*model.hSq)./sqrt(1+2/3*model.hSq/wSq);
model.hSq =  10.^(-3:0.01:3);
B.hSq_slow = interp1(model.G, model.hSq, B.ReNormalized(:, slow));
B.model = model;
loglog(S_ext.displacement.lag, S_ext.displacement.hSq, B.lag, B.hSq_slow, B.lag, 1.5*B.lag.^0.5); %, B.lagHsq, B.hSq_intercept, B.lagHsq,  1.5*B.lagHsq.^0.55)
figure(gcf);
%% Fit Field 
minVt = 0.05; % um
dynRange  = 5;
lowestG = 1e-2;
calc_range=[0.05 100];
showRange =20;

FigHdl2 = FitField_GUI_v3(B, minVt,  dynRange,  showRange, lowestG, wSq, NormRange*1e3)

%% Extract field 
B = guidata(FigHdl2);
close(FigHdl2);

%% calculate displacement from slow run according to UniformSum and
%UniformField models
model.Rsq = 10.^(-3:0.01:1);
model.wSq = wSq;
[RSQ, W] = meshgrid(model.Rsq, B.field(1).paramUniformField.w);
[RSQ, Bp] = meshgrid(model.Rsq, B.field(1).paramUniformField.b);
model.UniformField = sum(Bp./(1+ 2/3* RSQ./W.^2)./sqrt(1+ 2/3* RSQ./W.^2/wSq) );
B.Rsq_slow_UniformField = interp1(model.UniformField, model.Rsq, B.ReNormalized(:, slow));

[RSQ, W] = meshgrid(model.Rsq, B.field(1).paramUniformSum.w);
[RSQ, Bp] = meshgrid(model.Rsq, B.field(1).paramUniformSum.b);
model.UniformSum = sum(Bp./(1+ 2/3* RSQ./W.^2) );
B.Rsq_slow_UniformSum = interp1(model.UniformSum, model.Rsq, B.ReNormalized(:, slow));

%%  start fits to data
FigHdl = FitCF_GUI_v2(B,  minVt, dynRange, showRange, lowestG, calc_range);
 
%% Extracting data
B = guidata(FigHdl);
close(FigHdl);
%%
eval([arrayName '= B;']);
%%  Constants
filepath = 'F:\Alon\280708\';
dataname = 'data280708';

 fields_to_removeGood = {
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
       
  fields_to_removeBad = {
            'corrfuncbad'
           'tracebad'
           'CF_CRbad'
           'dIdIbad'
      };
  
warning('off', 'MATLAB:Axes:NegativeDataInLogAxis')
%% Static and dynamic Rh6G measurements to evaluate field size
RhName = {'Rh6G'} % define static rh file name
RhNameV = {'Rh6G_v'} %dynamic
Rh = LoadMultipleCorrFunc_v2(filepath, RhName, 'Rejection', 2, 'NormalizationRange', [1e-3 2e-3],  'DeleteList', []);
RhV = LoadMultipleCorrFunc_v2(filepath, RhNameV, 'Rejection', 2, 'NormalizationRange', [1e-3 2e-3],  'DeleteList', []);
FitParam = PlotFitCF(Rh, [0.002 1000], @Diffusion3D, [20000 0.05 30]);
wSq = FitParam.beta(3, 1);
if isfield(RhV,  'corrfuncbad')
        RhV = rmfield(RhV, [fields_to_removeGood; fields_to_removeBad]);
else 
        RhV = rmfield(RhV, fields_to_removeGood);
end;

%% make field and fit it
minVt = 0.05; % um
dynRange  = 5;
lowestG = 1e-2;
showRange =20;
NormRange = [1 2]*1e-3;
B.lag = Rh.lag;
B.vt_um = [RhV.vt_um RhV.vt_um];
B.Normalized = [Rh.Normalized RhV.Normalized];
B.errorNormalized = [Rh.errorNormalized RhV.errorNormalized];

FigHdl = FitField_GUI_twoCF(B, minVt, dynRange, showRange, lowestG, wSq, NormRange*1e3)
%% Extract field 
B = guidata(FigHdl);
close(FigHdl);
wXY = B.field.paramGauss(2)
B.wXY= wXY;
B.wSq = wSq;
eval([dataname '.field_Rh = B;']);



%% Load data%
%%%%%%%%%%%
fnametmpl = 'DDN9_6b_v';
fnames = dir([filepath fnametmpl '2857*']);
%filenames = { 'L10dil2_v2857p00_1'  'L10dil2_v2857p00_3'};
filenames =  {fnames.name}
Rejection = 2;
NormRange = [1e-3 3e-3];
S = LoadMultipleCorrFunc_v2(filepath, filenames, 'Rejection', Rejection, 'NormalizationRange', NormRange,  'DeleteList', []);

%%% Cluster analysis
%Nclust = 10;
%LinkageType ='single'% 'single', 'average', 'weighted'
%Range = [1e-2 100]; % range of decay of the correlation function
%[T, j, DeleteList] = ClusterizeCF_CR_v1(S, 'No of Clusters', Nclust, 'Normalization range', NormRange, 'Distance range', Range, 'Linkage', LinkageType);

%%% Reload if needed
%Rejection = 10;
 %S = LoadMultipleCorrFunc_v2(filepath, filenames, 'Rejection', Rejection, 'DeleteList', DeleteList);
 
%%% Plot Speed
%plot(S.v_um_s)
%figure(gcf)
%% remove fields which are not needed for futher processing
if isfield(S,  'corrfuncbad')
        S = rmfield(S, [fields_to_removeGood; fields_to_removeBad]);
else 
        S = rmfield(S, fields_to_removeGood);
end;

%% Find range for baseline subtraction
semilogx(S.lag, S. Normalized);
axis([1e-3 10000 -0.1 0.1])
figure(gcf)
title('find range for baseline subtraction');
pause;
S.rangeBL = InAxes;
S.Normalized = (S.Normalized - mean(S.Normalized(InAxes)))/(1 - mean(S.Normalized(InAxes)));
semilogx(S.lag, S. Normalized);

title('find plateau for normalization');
axis([1e-3 1e-2 0.8 1.2])
figure(gcf);
pause;
S.rangeNorm = InAxes;
S.Normalized = S.Normalized /mean(S.Normalized(InAxes));
S.G0 = mean(S.AverageCF_CR(S.rangeNorm)) - mean(S.AverageCF_CR(S.rangeBL));
semilogx(S.lag, S. Normalized);
figure(gcf);

%% Load static data%
%%%%%%%%%%%
%Stfilenames = { 'L10dil2_v160p00_0'  'L10dil2_v160p00_2'};
fnames = dir([filepath fnametmpl '160*']);
%filenames = { 'L10dil2_v2857p00_1'  'L10dil2_v2857p00_3'};
Stfilenames =  {fnames.name}
Rejection = 2;
NormRange = [1e-3 3e-3];
St = LoadMultipleCorrFunc_v2(filepath, Stfilenames, 'Rejection', Rejection, 'NormalizationRange', NormRange,  'DeleteList', []);

%%% Cluster analysis
%Nclust = 10;
%LinkageType ='single'% 'single', 'average', 'weighted'
%Range = [1e-2 100]; % range of decay of the correlation function
%[T, j, DeleteList] = ClusterizeCF_CR_v1(St, 'No of Clusters', Nclust, 'Normalization range', NormRange, 'Distance range', Range, 'Linkage', LinkageType);

%%% Reload if needed
%Rejection = 10;
 %St = LoadMultipleCorrFunc_v2(filepath, Stfilenames, 'Rejection', Rejection, 'DeleteList', DeleteList);
 
%%% Plot Speed
%plot(S.v_um_s)
%figure(gcf)
%% remove fields which are not needed for futher processing
if isfield(St,  'corrfuncbad')
        St = rmfield(St, [fields_to_removeGood; fields_to_removeBad]);
else 
        St= rmfield(St, fields_to_removeGood);
end;

%% Find range for baseline subtraction
semilogx(St.lag, St. Normalized);
axis([1e-3 10000 -0.1 0.1])
figure(gcf)
title('find range for baseline subtraction');
pause;
St.rangeBL = InAxes;
St.Normalized = (St.Normalized - mean(St.Normalized(InAxes)))/(1 - mean(St.Normalized(InAxes)));
semilogx(St.lag, St. Normalized);

title('find plateau for normalization');
axis([1e-3 1e-2 0.8 1.2])
figure(gcf);
pause;
St.rangeNorm = InAxes;
St.Normalized = St.Normalized /mean(St.Normalized(InAxes));
St.G0 = mean(St.AverageCF_CR(St.rangeNorm)) - mean(St.AverageCF_CR(St.rangeBL));
semilogx(St.lag, St. Normalized);
jt = 1:min(length(S.lag), length(St.lag));
S.Corrected = S.Normalized;
S.Corrected(jt) = (S.Normalized(jt)./St.Normalized(jt)).^(1./St.Normalized(jt));
figure(gcf);

%% preparing for Fourier Transform
N = 512; % number of interpolation points
Rm = 10; %upper limit of corrfunc confidence

%load 'C:\Oleg\Matlab Programming\General Utilities\c.mat';  %for Hankel Transform
load 'F:\Oleg\Matlab Programs\Processing Files\c.mat';  %for Hankel Transform
c = c(1, 1:N+1);    %Bessel function zeros;
S.r = c(1:N)'*Rm/c(N+1);   % Radius vector
 
S.fr = exp(interp1(S.vt_um.^2, log(S.Corrected), S.r.^2, 'linear'));
%zero-padding from the first zero encountered
S.fr = real(S.fr);
S.fr(find(S.fr< 0)) = 0;

semilogy(S.vt_um.^2, S.Corrected, '-o', S.r.^2, S.fr);
title('Find lower range for interpolation');
axis([0 5 1e-3 1.2]);
figure(gcf)
pause;
ax = axis;
%j1 = InAxes; %
j1 =find( (S.vt_um.^2 > ax(1)) & (S.vt_um.^2 < ax(2)) & (S.Corrected > ax(3)) & (S.Corrected < ax(4)));
p1 = polyfit(S.vt_um(j1).^2, log(S.Corrected(j1)), 1);

S.fr_int = S.fr;
j2 = find(S.r.^2 >  ax(2));
S.fr_int(j2) = exp(polyval(p1, S.r(j2).^2));
semilogy(S.vt_um.^2, S.Corrected, '-o', S.r(j2).^2, S.fr_int(j2));
axis([0 5 1e-3 1.2]);
 %%
semilogy(S.vt_um.^2, S.Corrected, '-o', S.r.^2, S.fr_int);
title('Find upper range for interpolation');
axis([0 5 1e-3 1.2]);
figure(gcf)
pause;
ax = axis;
%j3 = InAxes; % 
j3 = find((S.vt_um.^2 > ax(1)) & (S.vt_um.^2 < ax(2)) );
p2 = polyfit(S.vt_um(j3).^2, log(S.Corrected(j3)), 1);

j4 = find(S.r.^2  <  ax(2));
S.fr_int(j4) = exp(polyval(p2, S.r(j4).^2));
semilogy(S.vt_um.^2, S.Corrected, '-o', S.r.^2, S.fr_int);
axis(ax);
figure(gcf);

%% "Honest" Fourier Transform
%wXY = B.field.paramGauss(2)
FY = FourierTransform(S, '2D');
S.q = FY.q;
S.fq = FY.fq;

%interpolated Fourier Transform
Y.r = S.r;
Y.fr = S.fr_int;
FY = FourierTransform(Y, '2D');
S.fq_int = FY.fq;

semilogy(S.q.^2, S.fq, S.q.^2, S.fq_int)
figure(gcf)
%S.Sq = S.fq.*exp(wXY^2*S.q.^2/4);
%S.Sq_int = S.fq_int.*exp(wXY^2*S.q.^2/4);

%% Add to Data Structure
%fieldname = 'Lambda_5_4uMb';
S.conc = input('what concentration? (uM bp)')
fldname = fnametmpl; %filenames{1};
eval([dataname '.' fldname ' = S;']); %input structure

%% arrange fieldnames
nameTemplate = 'DDN'
clear vt_um  Normalized countrate conc;

fnamesData ={};
fnamesSuppl ={};
eval(['fnames = fieldnames(' dataname ')']);
for j = 1:length(fnames),
    if findstr(fnames{j}, nameTemplate),
        fnamesData = [fnamesData; fnames{j}];
    else
        fnamesSuppl = [fnamesSuppl; fnames{j}];
    end;
end;

for j = 1:length(fnamesData),
    eval(['conc(j) = ' dataname '.' fnamesData{j} '.conc']);
end;
[concSorted, Isrt] = sort(conc);
eval([dataname '=orderfields(' dataname ', [fnamesData(Isrt);fnamesSuppl])']);

vt_um = [];
Normalized = [];
countrate = [];
for j=1:length(fnamesData),
   eval(['vt_um = [vt_um ' dataname '.' fnamesData{Isrt(j)} '.vt_um];']);
   eval(['Normalized = [Normalized ' dataname '.' fnamesData{Isrt(j)} '.Normalized];']);
   eval(['countrate = [countrate ' dataname '.' fnamesData{Isrt(j)} '.countrateGood];']);
end;

semilogy(vt_um.^2, Normalized);
axis([0 4 1e-2 1.2]);
figure(gcf);
legend(fnamesData(Isrt))

figure;
plot(concSorted, countrate, 'o')

%%  Field estimation from short DNA measurement (L500)
shortDNAlength_bp = 500;
sDNAfieldname = 'L500b_v';

eval(['sDNA =' dataname '.'  sDNAfieldname]);
b = 0.1;
L = 1.5*shortDNAlength_bp*0.34e-3
Rg = sqrt(L*b/6 -b^2/4 + b^3./(4*L) - b^4./(8*L.^2).*(1 - exp(-2*L/b)))
SB = SharpBloomfieldStucFactor(sDNA.q, Rg, L);
eval([dataname '.field_sDNA.q =sDNA.q']);
eval([dataname '.field_sDNA.fq = sDNA.fq./SB.Sq']);
eval([dataname '.field_sDNA.fq_int = sDNA.fq_int./SB.Sq']);
eval(['semilogy(' dataname '.field_sDNA.q.^2, [' dataname '.field_sDNA.fq ' dataname '.field_sDNA.fq_int']); 
%axis([0 1 1e-3 1.2]);
figure(gcf)
%pause;
%semilogy(data160708.field500.q.^2, [data160708.field200.fq data160708.field200.fq_int data160708.field500.fq data160708.field500.fq_int]);

%% Pick the estimation of the field from L500
%  fit field with Gaussian just in case 
minVt = 0.05; % um
dynRange  = 5;
lowestG = 1e-2;
showRange =20;
NormRange = [1 4]*1e-3;
B1.lag = sDNA.lag;
B1.vt_um = [sDNA.vt_um sDNA.vt_um];
B1.Normalized = [ones(size(sDNA.Corrected))   sDNA.Corrected];
B1.errorNormalized = [sDNA.errorNormalized sDNA.errorNormalized];

FigHdl = FitField_GUI_twoCF(B1, minVt, dynRange, showRange, lowestG, 30, NormRange*1e3)
%% Extract field 
B1 = guidata(FigHdl);
close(FigHdl);
eval([dataname '.field_sDNA.wS = B1.field.paramGauss(2)']);
b = 0.1;
L = 1.5*shortDNAlength_bp*0.34e-3
Rg = sqrt(L*b/6 -b^2/4 + b^3./(4*L) - b^4./(8*L.^2).*(1 - exp(-2*L/b)))
eval([dataname '.field_sDNA.wXY = sqrt(B1.field.paramGauss(2)^2 - 2/3*Rg^2)']);






%% Fit with measured Structure factor in dilute solutions (modified Pincus theory)
%dataname = 'data251207'
DiluteFieldName = 'DD_2uM_v2857';
eval([dataname '. ' DiluteFieldName '.ksi = inf;' ]);
SQ0 = eval([dataname '.'  DiluteFieldName]);
%%
%SQ0 = Lambda_sim;
%normalizing to 1
plot(SQ0.q.^2, SQ0.Sq_int, 'o');

title('Find upper range for extrapolation to 0-q');
axis([0 5 0 1.2]);
figure(gcf)
pause;
ax = axis;
j4 = find( (SQ0.q.^2 > ax(1)) & (SQ0.q.^2 < ax(2)));
SQ0.p = polyfit(SQ0.q(j4).^2, SQ0.Sq_int(j4), 1)

plot(SQ0.q.^2, SQ0.Sq_int, 'o', SQ0.q.^2, polyval(SQ0.p, SQ0.q.^2));
axis([0 5 0 1.2]);
eval([dataname '.SQ0 = ' SQ0 ';']);
%% Fits
fieldToFit =  'DD_3uM_v2857';
S = eval([dataname '.'  fieldToFit]);
%%
loglog(S.q, S.Sq_int)
title('Find  range for fit');
axis([0 20 1e-3 1.2]);
figure(gcf)
pause;
ax = axis;
j4 = find( (S.q > ax(1)) & (S.q < ax(2)));
beta = nlinfitWeight1(S.q(j4), S.Sq_int(j4), @FitSemidiluteStructureFactor, [1 1], ones(size(j4)), [SQ0.q SQ0.Sq_int/SQ0.p(2)])

loglog(S.q, S.Sq_int, S.q(j4), FitSemidiluteStructureFactor(beta, S.q(j4), [SQ0.q SQ0.Sq_int/SQ0.p(2)]))
axis([0 20 1e-3 1.2]);
S.ksi = sqrt(beta(2))
eval([dataname '.'  fieldToFit '=S;']);

%% 
for j=1:length(fnamesData),
   eval([dataname '.conc(j) = ' dataname '.' fnamesData{Isrt(j)} '.conc;']);
   eval([dataname '.ksi(j) =' dataname '.' fnamesData{Isrt(j)} '.ksi;']);
   eval([dataname '.countrate(j) =' dataname '.' fnamesData{Isrt(j)} '.countrateGood;']);
   eval([dataname '.G0(j) =' dataname '.' fnamesData{Isrt(j)} '.G0;']);
end;

%% Gyration radius of semiflexible polymer (from Yamakawa)
b = 0.1;
L= 1.5*48600*0.34e-3
Rg=sqrt(L*b/6 -b^2/4 + b^3./(4*L) - b^4./(8*L.^2).*(1 - exp(-2*L/b)))


%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Different lengths
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Add to Data Structure
%fieldname = 'Lambda_5_4uMb';
S.length = input('what DNA length? (bp)')
fldname = filenames{1};
eval([dataname '.len' fldname ' = S;']); %input structure

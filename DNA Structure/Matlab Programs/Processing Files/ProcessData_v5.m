                                             
% %% List data structure names
% nameTemplate = 'L48_V_';
% clear vel;
% strucNames = who([nameTemplate '*'])
% for i = 1:length(strucNames),
%     vel(i) = sscanf(strucNames{i}, [nameTemplate '%d']);
% end;
% [temp, I] = sort(vel);
% 
% strucNames = strucNames(I) %check the strucNames and delete/add!!!! 
%% 1) Constants
filepath = 'G:\Experiments\Scanning_FCS_MSD\Eyal\061008\';
dataname = 'data061008_proc0710';

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
%% 2) Static and dynamic Rh6G measurements to evaluate field size
RhName = {'Rh6G_v53p12_1' } % define static rh file name
RhNameV = {'Rh6G_v4111p13_1'} %dynamic
Rh = LoadMultipleCorrFunc_v2(filepath, RhName, 'Rejection', 2, 'NormalizationRange', [1e-3 2e-3],  'DeleteList', []);
RhV = LoadMultipleCorrFunc_v2(filepath, RhNameV, 'Rejection', 2, 'NormalizationRange', [1e-3 2e-3],  'DeleteList', []);
FitParam = PlotFitCF(Rh, [0.002 1000], @Diffusion3D, [20000 0.05 30]);
wSq = FitParam.beta(3, 1);
if isfield(RhV,  'corrfuncbad')
        RhV = rmfield(RhV, [fields_to_removeGood; fields_to_removeBad]);
else 
        RhV = rmfield(RhV, fields_to_removeGood);
end;

%% 3)  make field and fit it
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
%%  4) Extract field 
B = guidata(FigHdl);
close(FigHdl);
wXY = B.field.paramGauss(2)
eval([dataname '.B = B;']);
B.field.wXY = wXY;
B.field.wSq = wSq;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 5) Load data%
%%%%%%%%%%%
fnametmpl = 'L4_v';
fnames = dir([filepath fnametmpl '4111*']);
%filenames = { 'L10dil2_v2857p00_1'  'L10dil2_v2857p00_3'};
filenames =  {fnames.name}
Rejection = 2;
NormRange = [1e-3 3e-3];
S = LoadMultipleCorrFunc_v2(filepath, filenames, 'Rejection', Rejection, 'NormalizationRange', NormRange,  'DeleteList', []);

%% 9) remove fields which are not needed for futher processing
if isfield(S,  'corrfuncbad')
        S = rmfield(S, [fields_to_removeGood; fields_to_removeBad]);
else 
        S = rmfield(S, fields_to_removeGood);
end;

%% 10) Find range for baseline subtraction
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

%% 11) Load static data%
%%%%%%%%%%%
%Stfilenames = { 'L10dil2_v160p00_0'  'L10dil2_v160p00_2'};
fnames = dir([filepath fnametmpl '53*']);
%filenames = { 'L10dil2_v2857p00_1'  'L10dil2_v2857p00_3'};
Stfilenames =  {fnames.name}
Rejection = 2;
NormRange = [1e-3 3e-3];
St = LoadMultipleCorrFunc_v2(filepath, Stfilenames, 'Rejection', Rejection, 'NormalizationRange', NormRange,  'DeleteList', []);

%% 15) remove fields which are not needed for futher processing
if isfield(St,  'corrfuncbad')
        St = rmfield(St, [fields_to_removeGood; fields_to_removeBad]);
else 
        St= rmfield(St, fields_to_removeGood);
end;

%% 16) Find range for baseline subtraction
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

%% 17) preparing for Fourier Transform
N = 512; % number of interpolation points
Rm = 10; %upper limit of corrfunc confidence

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

%% 18) "Honest" Fourier Transform
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
S.Sq = S.fq.*exp(wXY^2*S.q.^2/4);
S.Sq_int = S.fq_int.*exp(wXY^2*S.q.^2/4);

%% 19) Estimating error of Fourier transform
%Corrected(find(isnan(Corrected)))
S.fq_allfunc =[];
jp=find((S.vt_um > S.r(1)) &(S.vt_um < S.r(512)));
jp1 = min(jp)-1;
jp2= max(jp)+1;
jp= jp1:jp2;
for i=1:size(S.NormCorrFuncGood, 2),
    i
    Corrected = S.NormCorrFuncGood(jp, i);
    Corrected = (Corrected./St.Normalized(jp)).^(1./St.Normalized(jp));
    Y.fr = exp(interp1(S.vt_um(jp).^2, log(Corrected), S.r.^2, 'linear'));
    Y.fr = real(Y.fr);
    Y.fr(find(Y.fr< 0)) = 0;
    FY = FourierTransform(Y, '2D');
    S.fq_allfunc(:, i) = FY.fq;
end;

meanFq =  mean(S.fq_allfunc.*repmat(S.G0_good, size( S.fq_allfunc, 1), 1), 2)./mean(repmat(S.G0_good, size( S.fq_allfunc, 1), 1), 2);
meanSqFq =  mean(S.fq_allfunc.^2.*repmat(S.G0_good, size( S.fq_allfunc, 1), 1), 2)./mean(repmat(S.G0_good, size( S.fq_allfunc, 1), 1), 2);
S.errorFq = sqrt(meanSqFq - meanFq.^2)/sqrt(length(S.G0_good));
loglogErBar(S.q, S.fq, S.errorFq);
figure(gcf);
%% Processing  data of 230908: semidilute solutions of linear DNA

% Field normalization by Rh6G: repeat for each loaded data

S.Sq = S.fq.*exp(wXY^2*S.q.^2/4);
S.Sq_int = S.fq_int.*exp(wXY^2*S.q.^2/4);
S.errorSq = S.errorFq.*exp(wXY^2*S.q.^2/4);

%% Fit Debye and Ornstein-Zernicke structure factors
loglog(S.q, S.Sq_int);
figure(gcf);
pause;

J= InAxes;
curAx = axis;

[BETA, temp, temp] = nlinfitWeight1(S.q(J), S.Sq_int(J), @FitDebyeStucFactor, [0.2 1], S.errorSq(J));
%[BETA, temp, temp] = nlinfitWeight1(S.q(J), S.Sq_int(J), @FitSharpBloomfieldStucFactor, [0.2 1], 0.001*S.Sq_int(J), L);
S.fitDebye = BETA;

[BETA, temp, temp] = nlinfitWeight1(S.q(J), S.Sq_int(J), @FitOrnsteinZernickeStrucFactor, [0.2 1], S.errorSq(J));
%loglog(S.q, S.Sq_int, S.q(J), FitDebyeStucFactor(S.fitDebye, S.q(J)));
S.fitOrnZern = BETA;
loglog(S.q, S.Sq_int, S.q(J), [FitDebyeStucFactor(S.fitDebye, S.q(J))  FitOrnsteinZernickeStrucFactor(S.fitOrnZern, S.q(J)) ] );
axis(curAx);
figure(gcf);
BETA(1)

%% Add to Data Structure
%fieldname = 'Lambda_5_4uMb';
S.conc = input('what concentration? (uM bp)')
fldname = filenames{1};
eval([dataname '.' fldname ' = S;']); %input structure

%% arrange fieldnames
nameTemplate = 'L';

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
Rg_Deb = [];
Rg_OZ = [];
for j=1:length(fnamesData),
   eval(['vt_um = [vt_um ' dataname '.' fnamesData{Isrt(j)} '.vt_um];']);
   eval(['Normalized = [Normalized ' dataname '.' fnamesData{Isrt(j)} '.Normalized];']);
   eval(['countrate = [countrate ' dataname '.' fnamesData{Isrt(j)} '.countrateGood];']);
   eval(['Rg_Deb = [Rg_Deb ' dataname '.' fnamesData{Isrt(j)} '.fitDebye(1)];']);
   eval(['Rg_OZ = [Rg_OZ ' dataname '.' fnamesData{Isrt(j)} '.fitOrnZern(1)];']);
end;

semilogy(vt_um.^2, Normalized);
axis([0 4 1e-2 1.2]);
figure(gcf);
legend(fnamesData(Isrt))

figure;
plot(concSorted, countrate, 'o')
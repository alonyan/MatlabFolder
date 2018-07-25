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
%%  Constants
filepath = 'G:\Experiments\Scanning_FCS_MSD\Eyal\250908\';
dataname = 'data250908';

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


%% Load data%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%
fnametmpl = 'L195uM_v';
fnames = dir([filepath fnametmpl '4111*']);
%filenames = { 'L10dil2_v2857p00_1'  'L10dil2_v2857p00_3'};
filenames =  {fnames.name}
Rejection = 2;
NormRange = [1e-3 3e-3];
S = LoadMultipleCorrFunc_v2(filepath, filenames, 'Rejection', Rejection, 'NormalizationRange', NormRange,  'DeleteList', []);


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

%% Load static data%
%%%%%%%%%%%
%Stfilenames = { 'L10dil2_v160p00_0'  'L10dil2_v160p00_2'};
fnames = dir([filepath fnametmpl '53*']);
%filenames = { 'L10dil2_v2857p00_1'  'L10dil2_v2857p00_3'};
Stfilenames =  {fnames.name}
Rejection = 2;
NormRange = [1e-3 3e-3];
St = LoadMultipleCorrFunc_v2(filepath, Stfilenames, 'Rejection', Rejection, 'NormalizationRange', NormRange,  'DeleteList', []);


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

%% preparing for Fourier Transform
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

%% "Honest" Fourier Transform
wXY = B.field.paramGauss(2)
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


%% Add to Data Structure
%fieldname = 'Lambda_5_4uMb';
S.conc = input('what concentration? (uM bp)')
fldname = filenames{1};
eval([dataname '.' fldname ' = S;']); %input structure

%% arrange fieldnames
nameTemplate = 'L'

fnamesData ={};
fnamesSuppl ={};
eval(['fnames = fieldnames(' dataname ')']);
for j = 1:length(fnames),
    if (findstr(fnames{j}, nameTemplate)==1), %% Changed from if findstr(fnames{j}, nameTemplate). Consider changing the field name from B -> Field
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

%% Processing  data of 061008: semidilute solutions of linear DNA

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
conc = [];
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

minLen = 500;
for j = 1:length(fnamesData),
    eval(['conc(j) = ' dataname '.' fnamesData{j} '.conc']);
    eval(['len = length(' dataname '.' fnamesData{j} '.Normalized);']);
    if len < minLen,
        minLen = len;
    end;
end;
[concSorted, Isrt] = sort(conc);
eval([dataname '=orderfields(' dataname ', [fnamesData(Isrt);fnamesSuppl])']);

vt_um = [];
Normalized = [];
countrate = [];
Rg_Deb = [];
Rg_OZ = [];
J = 1:minLen;
for j=1:length(fnamesData),
   eval(['vt_um = [vt_um ' dataname '.' fnamesData{Isrt(j)} '.vt_um(J)];']);
   eval(['Normalized = [Normalized ' dataname '.' fnamesData{Isrt(j)} '.Normalized(J)];']);
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

%% After all data are loaded into structure
%Fit with measured Structure factor in dilute solutions (modified Pincus theory)
%Take concentration of 3.2 uM as dilute 
DiluteFieldName = 'L1_6_v4111p13_1';
eval([dataname '. ' DiluteFieldName '.ksi_Rh = inf;' ]);
SQ0 = eval([dataname '.'  DiluteFieldName]);
%%
%SQ0 = Lambda_sim;
%normalizing to 1
plot(SQ0.q.^2, SQ0.Sq_int, 'o');

title('Find upper range for extrapolation to 0-q');
axis([0 5 0 SQ0.Sq(1)*1.2]);
figure(gcf)
pause;
ax = axis;
j4 =  find( (SQ0.q.^2 > ax(1)) & (SQ0.q.^2 < ax(2)));

SQ0.p = polyfit(SQ0.q(j4).^2, SQ0.Sq_int(j4), 1)

plot(SQ0.q.^2, SQ0.Sq_int, 'o', SQ0.q.^2, polyval(SQ0.p, SQ0.q.^2));
axis(ax);
SQ0.Sq_int = SQ0.Sq_int/SQ0.p(2);
eval([dataname '.SQ0 = SQ0 ;']);

%% Fits
fieldToFit =  'L7_v4111p13_1';
S = eval([dataname '.'  fieldToFit]);

loglog(S.q, S.Sq_int)
title('Find  range for fit');
axis([0 20 1e-3 S.Sq_int(1)*1.2]);
figure(gcf)
pause;
ax = axis;
j4 = find( (S.q > ax(1)) & (S.q < ax(2)));
beta = nlinfitWeight1(S.q(j4), S.Sq_int(j4), @FitSemidiluteStructureFactor, [S.Sq_int(1) 1], S.errorSq(j4), [SQ0.q SQ0.Sq_int])

loglog(S.q, S.Sq_int, S.q(j4), FitSemidiluteStructureFactor(beta, S.q(j4), [SQ0.q SQ0.Sq_int]))
axis(ax);
S.ksi_Rh = sqrt(beta(2));
eval([dataname '.'  fieldToFit '=S;']);
%% Summarize
 
for j=1:length(fnamesData),
   eval([dataname '.conc(j) = ' dataname '.' fnamesData{Isrt(j)} '.conc;']);
   eval([dataname '.ksi_Rh(j) =' dataname '.' fnamesData{Isrt(j)} '.ksi_Rh;']);
   eval([dataname '.countrate(j) =' dataname '.' fnamesData{Isrt(j)} '.countrateGood;']);
   eval([dataname '.G0(j) =' dataname '.' fnamesData{Isrt(j)} '.G0;']);
end;

%converting ksi_Rh into dimensional units:
eval([dataname '.ksi_Rh_um =' dataname '.ksi_Rh*' dataname '.SQ0.fitDebye(1)/sqrt(2);']);

%%  Now switch to the estimation of the field from 500 bp DNA
% first add 500bp data to the structure:
data061008.DNA500 = S;
b = 0.1;
L = 1.5*500*0.34e-3
Rg = sqrt(L*b/6 -b^2/4 + b^3./(4*L) - b^4./(8*L.^2).*(1 - exp(-2*L/b)))
SB500 = SharpBloomfieldStucFactor(S.q, Rg, L);
data061008.field500.q = data061008.DNA500.q;
data061008.field500.fq = data061008.DNA500.fq./SB500.Sq;
data061008.field500.fq_int = data061008.DNA500.fq_int./SB500.Sq;
data061008.field500.errorFq = data061008.DNA500.errorFq./SB500.Sq;
semilogy(data061008.field500.q.^2, [data061008.field500.fq data061008.field500.fq_int]); 
%axis([0 1 1e-3 1.2]);
figure(gcf)
%% 2) Pick the estimation of the field from L500
%  fit with Gaussian just in case field and fit it
minVt = 0.05; % um
dynRange  = 5;
lowestG = 1e-2;
showRange =20;
NormRange = [1 4]*1e-3;
B1.lag = data061008.DNA500.lag;
B1.vt_um = [data061008.DNA500.vt_um  data061008.DNA500.vt_um];
B1.Normalized = [ones(size(data061008.DNA500.Corrected))   data061008.DNA500.Corrected];
B1.errorNormalized = [data061008.DNA500.errorNormalized data061008.DNA500.errorNormalized];

FigHdl = FitField_GUI_twoCF(B1, minVt, dynRange, showRange, lowestG, 30, NormRange*1e3)
%% 3) Extract field 
B1 = guidata(FigHdl);
close(FigHdl);
data061008.field500.wS = B1.field.paramGauss(2)
b = 0.1;
L = 1.5*500*0.34e-3
Rg = sqrt(L*b/6 -b^2/4 + b^3./(4*L) - b^4./(8*L.^2).*(1 - exp(-2*L/b)))
data061008.field500.wXY = sqrt(data061008.field500.wS^2 - 2/3*Rg^2)
%% Now change to L500 field 
%Fit with measured Structure factor in dilute solutions (modified Pincus
%theory)

for i=1:length(fnamesData),
    S = eval([dataname '.'  fnamesData{i}]);
    S.Sq = S.fq./data061008.field500.fq;
    S.Sq_int =S.fq_int./data061008.field500.fq_int;
    S.errorSq = sqrt((S.errorFq./S.fq_int).^2 +(data061008.field500.errorFq./data061008.field500.fq_int).^2).*S.Sq_int;
    loglogErBar(S.q, S.Sq_int, S.errorSq);
    figure(gcf);
    pause;
    eval([dataname '.'  fnamesData{i} '=S;']);
end;

%% Take concentration of 3.2 uM as dilute 
DiluteFieldName = 'L4_v4111p13_1';
eval([dataname '. ' DiluteFieldName '.ksi = inf;' ]);
SQ0 = eval([dataname '.'  DiluteFieldName]);


%%
%SQ0 = Lambda_sim;
%normalizing to 1
plot(SQ0.q.^2, SQ0.Sq_int, 'o');

title('Find upper range for extrapolation to 0-q');
axis([0 5 0 SQ0.Sq(1)*1.2]);
figure(gcf)
pause;
ax = axis;
j4 =  find( (SQ0.q.^2 > ax(1)) & (SQ0.q.^2 < ax(2)));

SQ0.p = polyfit(SQ0.q(j4).^2, SQ0.Sq_int(j4), 1)

plot(SQ0.q.^2, SQ0.Sq_int, 'o', SQ0.q.^2, polyval(SQ0.p, SQ0.q.^2));
axis(ax);
SQ0.Sq_int = SQ0.Sq_int/SQ0.p(2);
eval([dataname '.SQ0 = SQ0 ;']);

%%  Fit dilute structure factor with Debye function to get Rg of free DNA

loglog(SQ0.q, SQ0.Sq_int);
figure(gcf);
pause;

J= InAxes;
curAx = axis;

[BETA, temp, temp] = nlinfitWeight1(SQ0.q(J), SQ0.Sq_int(J), @FitDebyeStucFactor, [0.2 1], SQ0.errorSq(J));
%[BETA, temp, temp] = nlinfitWeight1(S.q(J), S.Sq_int(J), @FitSharpBloomfieldStucFactor, [0.2 1], 0.001*S.Sq_int(J), L);
SQ0.fitDebye = BETA;

loglog(SQ0.q, SQ0.Sq_int, SQ0.q(J), [FitDebyeStucFactor(SQ0.fitDebye, SQ0.q(J))  FitDebyeStucFactor(SQ0.fitDebye, SQ0.q(J)) ] );
axis(curAx);
figure(gcf);
BETA(1)
eval([dataname '.SQ0 = SQ0 ;']);

%% Fits

fieldToFit =  'L7_v4111p13_1  ';
S = eval([dataname '.'  fieldToFit]);

loglog(S.q, S.Sq_int)
title('Find  range for fit');
axis([0 20 1e-3 S.Sq_int(1)*1.2]);
figure(gcf)
pause;
ax = axis;
j4 = find( (S.q > ax(1)) & (S.q < ax(2)));
beta = nlinfitWeight1(S.q(j4), S.Sq_int(j4), @FitSemidiluteStructureFactor, [S.Sq_int(1) 1], S.errorSq(j4), [SQ0.q SQ0.Sq_int])

loglog(S.q, S.Sq_int, S.q(j4), FitSemidiluteStructureFactor(beta, S.q(j4), [SQ0.q SQ0.Sq_int]))
axis(ax);
S.ksi = sqrt(beta(2));
eval([dataname '.'  fieldToFit '=S;']);

%% %% Summarize
 
for j=1:length(fnamesData),
   eval([dataname '.conc(j) = ' dataname '.' fnamesData{Isrt(j)} '.conc;']);
   eval([dataname '.ksi(j) =' dataname '.' fnamesData{Isrt(j)} '.ksi;']);
    eval([dataname '.ksi_Rh(j) =' dataname '.' fnamesData{Isrt(j)} '.ksi_Rh;']);
   eval([dataname '.countrate(j) =' dataname '.' fnamesData{Isrt(j)} '.countrateGood;']);
   eval([dataname '.G0(j) =' dataname '.' fnamesData{Isrt(j)} '.G0;']);
end;

% Converting ksi into dimensional ksi (in um)
data061008.ksi_um = data061008.ksi*data061008.SQ0.fitDebye(1)/sqrt(2);

%% Try fitting with theoretical Debye function - conclusion: no need
eval([dataname '. ' DiluteFieldName '.ksi_th = inf;' ]);

fieldToFit =  'L546_v4111p13_1';
S = eval([dataname '.'  fieldToFit]);

loglog(S.q, S.Sq_int)
title('Find  range for fit');
axis([0 20 1e-3 S.Sq_int(1)*1.2]);
figure(gcf)
pause;
ax = axis;
j4 = find( (S.q > ax(1)) & (S.q < ax(2)));
beta = nlinfitWeight1(S.q(j4), S.Sq_int(j4), @FitSemidiluteStructureFactor, [S.Sq_int(1) 1], S.errorSq(j4), [SQ0.q FitDebyeStucFactor(SQ0.fitDebye, SQ0.q)])

loglog(S.q, S.Sq_int, S.q(j4), FitSemidiluteStructureFactor(beta, S.q(j4), [SQ0.q SQ0.Sq_int]))
axis(ax);
S.ksi_th = sqrt(beta(2));
eval([dataname '.'  fieldToFit '=S;']);

%% %% Summarize
 
for j=1:length(fnamesData),
   eval([dataname '.ksi_th(j) =' dataname '.' fnamesData{Isrt(j)} '.ksi_th;']);
end;

% Converting ksi into dimensional ksi (in um)
data061008.ksi_th_um = data061008.ksi_th*data061008.SQ0.fitDebye(1)/sqrt(2);


%% Combine and fit data
load process051008 data230908_proc0510 data250908_proc0510
load process201008 data131008
load process211008 data161008 data201008
load process261008 data061008
conc = [data230908_proc0510.conc data250908_proc0510.conc data131008.conc data161008.conc data201008.conc data061008.conc];
ksi_um =  [data230908_proc0510.ksi_um data250908_proc0510.ksi_um data131008.ksi_um data161008.ksi_um data201008.ksi_um data061008.ksi_um];

%without data of 061008
conc = [data230908_proc0510.conc data250908_proc0510.conc data131008.conc data161008.conc data201008.conc] 
ksi_um =  [data230908_proc0510.ksi_um data250908_proc0510.ksi_um data131008.ksi_um data161008.ksi_um data201008.ksi_um]; 

loglog(conc, ksi_um, 'o');
title('find the range to fit power law')
figure(gcf)
pause;
ax = axis;
jr =  InAxes;

p = polyfit(log(conc(jr)), log(ksi_um(jr)), 1)
loglog(conc, ksi_um, 'o', conc, exp(polyval(p, log(conc))));
figure(gcf)
scalingExp = p(1)
%% to find DNA hard core diameter

plot(conc, ksi_um.^-2, 'o')
title('find the range to fit a straight line')
figure(gcf)
pause;
ax = axis;
jr =  InAxes;

p = polyfit(conc(jr), ksi_um(jr).^-2, 1)
plot(conc, ksi_um.^-2, 'o', conc, polyval(p, conc));
figure(gcf)

DNA_hard_core_dia_um = p(1)/(6e23*1e-6*1e-15)*100/0.34/(6*pi)  %um
overlap_conc = -p(2)/p(1) %um
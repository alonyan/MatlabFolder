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

%% After all data are loaded into structure
%Fit with measured Structure factor in dilute solutions (modified Pincus theory)
%Take concentration of 6 uM as dilute 
DiluteFieldName = 'L6uM_v4111p13_1';
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
%% Fits
fieldToFit =  'L117um_v4111p13_1';
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
S.ksi = sqrt(beta(2))
eval([dataname '.'  fieldToFit '=S;']);
%% Summarize
 
for j=1:length(fnamesData),
   eval([dataname '.conc(j) = ' dataname '.' fnamesData{Isrt(j)} '.conc;']);
   eval([dataname '.ksi(j) =' dataname '.' fnamesData{Isrt(j)} '.ksi;']);
   eval([dataname '.countrate(j) =' dataname '.' fnamesData{Isrt(j)} '.countrateGood;']);
   eval([dataname '.G0(j) =' dataname '.' fnamesData{Isrt(j)} '.G0;']);
end;

%% ************************************************************************
% ************************************************************************
% ************************************************************************
%%  Processing  data of 250908: semidilute solutions of linear DNA

%% Add 500bp data to the structure:
data061008_proc0710.DNA500 = S;
b = 0.1;
L = 1.5*500*0.34e-3
Rg = sqrt(L*b/6 -b^2/4 + b^3./(4*L) - b^4./(8*L.^2).*(1 - exp(-2*L/b)))
SB500 = SharpBloomfieldStucFactor(S.q, Rg, L);
data061008_proc0710.field500.q = data061008_proc0710.DNA500.q;
data061008_proc0710.field500.fq = data061008_proc0710.DNA500.fq./SB500.Sq;
data061008_proc0710.field500.fq_int = data061008_proc0710.DNA500.fq_int./SB500.Sq;
data061008_proc0710.field500.errorFq = data061008_proc0710.DNA500.errorFq./SB500.Sq;
semilogy(data061008_proc0710.field500.q.^2, [data061008_proc0710.field500.fq data061008_proc0710.field500.fq_int]); 
%axis([0 1 1e-3 1.2]);
figure(gcf)
%% Pick the estimation of the field from L500
%  fit with Gaussian just in case field and fit it
minVt = 0.05; % um
dynRange  = 5;
lowestG = 1e-2;
showRange =20;
NormRange = [1 4]*1e-3;
B1.lag = data061008_proc0710.DNA500.lag;
B1.vt_um = [data061008_proc0710.DNA500.vt_um  data061008_proc0710.DNA500.vt_um];
B1.Normalized = [ones(size(data061008_proc0710.DNA500.Corrected))   data061008_proc0710.DNA500.Corrected];
B1.errorNormalized = [data061008_proc0710.DNA500.errorNormalized data061008_proc0710.DNA500.errorNormalized];

FigHdl = FitField_GUI_twoCF(B1, minVt, dynRange, showRange, lowestG, 30, NormRange*1e3)
%% Extract field 
B1 = guidata(FigHdl);
close(FigHdl);
data250908_proc0510.field500.wS = B1.field.paramGauss(2)
b = 0.1;
L = 1.5*500*0.34e-3
Rg = sqrt(L*b/6 -b^2/4 + b^3./(4*L) - b^4./(8*L.^2).*(1 - exp(-2*L/b)))
data250908_proc0510.field500.wXY = sqrt(data250908_proc0510.field500.wS^2 - 2/3*Rg^2)
%%
% First try field normalization by Rh6G: repeat for each loaded data
% Fit Debye and Ornstein-Zernicke structure factors

S.Sq = S.fq.*exp(wXY^2*S.q.^2/4);
S.Sq_int = S.fq_int.*exp(wXY^2*S.q.^2/4);
S.errorSq = S.errorFq.*exp(wXY^2*S.q.^2/4);

%% 
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

conc = [];
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

%% Fit with measured Structure factor in dilute solutions (modified Pincus theory)
% Keep Rhodamine field in the meantime
%Take concentration of 4_5 uM as dilute 
DiluteFieldName = 'L4uM_v4111p13_1';
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

fieldToFit =  'L480uM_v4111p13_1';
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
S.ksi_Rh = sqrt(beta(2))
eval([dataname '.'  fieldToFit '=S;']);

%% Now change to L500 field 
%Fit with measured Structure factor in dilute solutions (modified Pincus
%theory)

for i=1:length(fnamesData),
    S = eval([dataname '.'  fnamesData{i}]);
    S.Sq = S.fq./data250908_proc0510.field500.fq;
    S.Sq_int =S.fq_int./data250908_proc0510.field500.fq_int;
    S.errorSq = sqrt((S.errorFq./S.fq_int).^2 +(data250908_proc0510.field500.errorFq./data250908_proc0510.field500.fq_int).^2).*S.Sq_int;
    loglogErBar(S.q, S.Sq_int, S.errorSq);
    figure(gcf);
    pause;
    eval([dataname '.'  fnamesData{i} '=S;']);
end;
%Take concentration of 4_5 uM as dilute 
DiluteFieldName = 'L4uM_v4111p13_1';
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
%% Fits

fieldToFit =  'L480uM_v4111p13_1';
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
S.ksi = sqrt(beta(2))
eval([dataname '.'  fieldToFit '=S;']);

%% %% Summarize
 
for j=1:length(fnamesData),
   eval([dataname '.conc(j) = ' dataname '.' fnamesData{Isrt(j)} '.conc;']);
   eval([dataname '.ksi(j) =' dataname '.' fnamesData{Isrt(j)} '.ksi;']);
    eval([dataname '.ksi_Rh(j) =' dataname '.' fnamesData{Isrt(j)} '.ksi_Rh;']);
   eval([dataname '.countrate(j) =' dataname '.' fnamesData{Isrt(j)} '.countrateGood;']);
   eval([dataname '.G0(j) =' dataname '.' fnamesData{Isrt(j)} '.G0;']);
end;

%% Converting ksi into dimensional ksi (in um)

data230908_proc0510.ksi_um = data230908_proc0510.ksi*data230908_proc0510.SQ0.fitDebye(1)/sqrt(2);
data250908_proc0510.ksi_um = data250908_proc0510.ksi*data250908_proc0510.SQ0.fitDebye(1)/sqrt(2);
loglog(data230908_proc0510.conc, data230908_proc0510.ksi_um, 'o', data250908_proc0510.conc, data250908_proc0510.ksi_um, 'o', data250908_proc0510.conc, 7*data250908_proc0510.conc.^-0.5, data250908_proc0510.conc, 7*data250908_proc0510.conc.^-0.75)

%% Combine and fit data
conc = [data230908_proc0510.conc data250908_proc0510.conc];
ksi_um = [data230908_proc0510.ksi_um data250908_proc0510.ksi_um];
loglog(conc, ksi_um, 'o');
figure(gcf)
pause;
ax = axis;
jr =  InAxes;

p = polyfit(log(conc(jr)), log(ksi_um(jr)), 1)
loglog(conc, ksi_um, 'o', conc, exp(polyval(p, log(conc))));
figure(gcf)
pause;
loglog(conc(jr), ksi_um(jr), 'o', [10 500], exp(polyval(p, log([10 500]))), [10 500], 10*[10 500].^-0.75);
figure(gcf)

%% final list
conc_fin = conc(jr);
ksi_um_fin = ksi_um(jr);
[conc_fin, J] = sort(conc_fin);
ksi_um_fin = ksi_um_fin(J);
conc_fin(3) = mean(conc_fin(3:4));
conc_fin(4) = [];
ksi_um_fin(3) = mean(ksi_um_fin(3:4));
ksi_um_fin(4) = [];
loglog(conc_fin, ksi_um_fin, 'o', [10 500], exp(polyval(p, log([10 500]))));

%% A quick look at the data of 061008
dataname = 'data061008';
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

conc = [];
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

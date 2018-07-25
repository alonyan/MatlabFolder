                                             

%% Processing data of 150708: dilute solutions of linear DNA
% Use data obtained on 200bp and 500 bp fragments to calculate field.
% Evaluate their structure factor from Blumfield expression and extract
% field

b = 0.1;
L = 1.5*500*0.34e-3
Rg = sqrt(L*b/6 -b^2/4 + b^3./(4*L) - b^4./(8*L.^2).*(1 - exp(-2*L/b)))
SB500 = SharpBloomfieldStucFactor(S.q, Rg, L);
data061008.field500.q = S.q;
data061008.field500.fq = S.fq./SB500.Sq;
data061008.field500.fq_int = S.fq_int./SB500.Sq;
data061008.field500.errorFq = S.errorFq;
semilogy(data061008.field500.q.^2, [data061008.field500.fq data061008.field500.fq_int]); 
%axis([0 1 1e-3 1.2]);
figure(gcf)
pause;
semilogy(data061008.field500.q.^2, [ data061008.field500.fq data061008.field500.fq_int]);

%% Pick the estimation of the field from B500
%  fit with Gaussian just in case field and fit it
minVt = 0.05; % um
dynRange  = 5;
lowestG = 1e-2;
showRange =20;
NormRange = [1 4]*1e-3;
B1.lag = S.lag;
B1.vt_um = [S.vt_um S.vt_um];
B1.Normalized = [ones(size(S.Corrected))   S.Corrected];
B1.errorNormalized = [S.errorNormalized S.errorNormalized];

FigHdl = FitField_GUI_twoCF(B1, minVt, dynRange, showRange, lowestG, 30, NormRange*1e3)
%% Extract field 
B1 = guidata(FigHdl);
close(FigHdl);
data061008.field500.wS = B1.field.paramGauss(2)
b = 0.1;
L = 1.5*500*0.34e-3
Rg = sqrt(L*b/6 -b^2/4 + b^3./(4*L) - b^4./(8*L.^2).*(1 - exp(-2*L/b)))
data061008.field500.wXY = sqrt(data061008.field500.wS^2 - 2/3*Rg^2)

%% Processing  data of 230908: semidilute solutions of linear DNA

% Field normalization by Rh6G: repeat for each loaded data

S.Sq = S.fq./data061008.field500.fq;
S.Sq_int =S.fq_int./data061008.field500.fq_int;
S.errorSq = S.errorFq./data061008.field500.errorFq;


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
S.length = input('what length? (uM bp)')
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
%% Fits
fieldToFit =  'L289_v4111p13_1';
S = eval([dataname '.'  fieldToFit]);
S.Sq = S.fq.*exp(wXY^2*S.q.^2/4);
S.Sq_int = S.fq_int.*exp(wXY^2*S.q.^2/4);
S.errorSq = S.errorFq.*exp(wXY^2*S.q.^2/4);loglog(S.q, S.Sq_int)
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
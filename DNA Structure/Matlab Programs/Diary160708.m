%% Processing data of 150708: dilute solutions of linear DNA
% Use data obtained on 200bp and 500 bp fragments to calculate field.
% Evaluate their structure factor from Blumfield expression and extract
% field
b = 0.1;
L = 1.5*200*0.34e-3
Rg = sqrt(L*b/6 -b^2/4 + b^3./(4*L) - b^4./(8*L.^2).*(1 - exp(-2*L/b)))
SB200 = SharpBloomfieldStucFactor(data150708.L200.q, Rg, L);
data150708.field200.q = data150708.L200.q;
data150708.field200.fq = data150708.L200.fq./SB200.Sq;
data150708.field200.fq_int = data150708.L200.fq_int./SB200.Sq;
semilogy(data150708.field200.q.^2, [data150708.field200.fq data150708.field200.fq_int]); 
%axis([0 1 1e-3 1.2]);
figure(gcf)

%%
b = 0.1;
L = 1.5*500*0.34e-3
Rg = sqrt(L*b/6 -b^2/4 + b^3./(4*L) - b^4./(8*L.^2).*(1 - exp(-2*L/b)))
SB500 = SharpBloomfieldStucFactor(data150708.L500.q, Rg, L);
data150708.field500.q = data150708.L500.q;
data150708.field500.fq = data150708.L500.fq./SB500.Sq;
data150708.field500.fq_int = data150708.L500.fq_int./SB500.Sq;
semilogy(data150708.field500.q.^2, [data150708.field500.fq data150708.field500.fq_int]); 
%axis([0 1 1e-3 1.2]);
figure(gcf)
pause;
semilogy(data150708.field500.q.^2, [data150708.field200.fq data150708.field200.fq_int data150708.field500.fq data150708.field500.fq_int]);

%% Pick the estimation of the field from L500
%  fit with Gaussian just in case field and fit it
minVt = 0.05; % um
dynRange  = 5;
lowestG = 1e-2;
showRange =20;
NormRange = [1 4]*1e-3;
B1.lag = data150708.L500.lag;
B1.vt_um = [data150708.L500.vt_um data150708.L500.vt_um];
B1.Normalized = [ones(size(data150708.L500.Corrected))   data150708.L500.Corrected];
B1.errorNormalized = [data150708.L500.errorNormalized data150708.L500.errorNormalized];

FigHdl = FitField_GUI_twoCF(B1, minVt, dynRange, showRange, lowestG, 30, NormRange*1e3)
%% Extract field 
B1 = guidata(FigHdl);
close(FigHdl);
data150708.field500.wS = B1.field.paramGauss(2)
b = 0.1;
L = 1.5*500*0.34e-3
Rg = sqrt(L*b/6 -b^2/4 + b^3./(4*L) - b^4./(8*L.^2).*(1 - exp(-2*L/b)))
data150708.field500.wXY = sqrt(data150708.field500.wS^2 - 2/3*Rg^2)


%%
S = data150708.L10000; %change fieldname
S.Sq = S.fq./data150708.field500.fq;
S.Sq_int =S.fq_int./data150708.field500.fq_int;

%%
L = 1.5*10000*0.34e-3
S.length = L;
S.Rg_theory = sqrt(L*b/6 -b^2/4 + b^3./(4*L) - b^4./(8*L.^2).*(1 - exp(-2*L/b)));
loglog(S.q, S.Sq_int);
figure(gcf);
pause;

J= InAxes;
curAx = axis;

[BETA, temp, temp] = nlinfitWeight1(S.q(J), S.Sq_int(J), @FitSharpBloomfieldStucFactor, [S.Rg_theory 1], 0.001*ones(size(S.Sq_int(J))), L);
%[BETA, temp, temp] = nlinfitWeight1(S.q(J), S.Sq_int(J), @FitSharpBloomfieldStucFactor, [0.2 1], 0.001*S.Sq_int(J), L);
S.paramSB = BETA;
loglog(S.q, S.Sq_int, 'o', S.q(J), FitSharpBloomfieldStucFactor(BETA, S.q(J), L));
axis(curAx);
figure(gcf);
S.Jfit = J;
S.Rg_fit = BETA(1);

%% For short DNA estimate Rg from direct fit
%  fit with Gaussian 
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
S.wS = B1.field.paramGauss(2)
S.Rg_est  = sqrt(3/2*(S.wS^2 - data150708.field500.wXY^2))

%%
data150708.L10000 = S
%%
semilogy(data150708.L200.vt_um.^2, data150708.L200.Corrected, data150708.L500.vt_um.^2, data150708.L500.Corrected,  data150708.L1200.vt_um.^2, data150708.L1200.Corrected,  data150708.L3000.vt_um.^2, data150708.L3000.Corrected,  data150708.L6000.vt_um.^2, data150708.L6000.Corrected,  data150708.L10000.vt_um.^2, data150708.L10000.Corrected,   data150708.L500.vt_um.^2, data150708.L500.Corrected,  data150708.L24300.vt_um.^2, data150708.L24300.Corrected,  data150708.L48600.vt_um.^2, data150708.L48600.Corrected); axis([0 2 1e-2 1.1])

%%
b = 0.09;
L = 1.5:0.1:25;
Rg = sqrt(L*b/6 -b^2/4 + b^3./(4*L) - b^4./(8*L.^2).*(1 - exp(-2*L/b)));
data150708.length = [ data150708.L3000.length data150708.L6000.length data150708.L10000.length data150708.L24300.length data150708.L48600.length];
data150708.Rg_meas = [ data150708.L3000.Rg_fit data150708.L6000.Rg_fit data150708.L10000.Rg_fit data150708.L24300.Rg_fit data150708.L48600.Rg_fit];
loglog(data150708.length, data150708.Rg_meas, 'o', L, Rg, L, 1.5*(L*b/6).^0.6)
figure(gcf)
set(gca, 'YTick', [0.1 0.2 0.3 0.4 0.5 0.6 0.7], 'Xlim', [1 40], 'Ylim', [0.1 1]);
xlabel('DNA length ( \mu m)', 'FontSize', 14)
ylabel('Gyration radius ( \mu m)', 'FontSize', 14)
legend('Experiment', 'WLC theory - no excluded volume; b = 90nm', 'Excluded volume theory: R_g \sim L^{0.6}')

%% 
%%%%%%%%%%%%%%%%%%%%%%%%%
%% Processing data of 160708 : semidilute solutions
b = 0.1;
L = 1.5*200*0.34e-3
Rg = sqrt(L*b/6 -b^2/4 + b^3./(4*L) - b^4./(8*L.^2).*(1 - exp(-2*L/b)))
SB200 = SharpBloomfieldStucFactor(data160708.L200.q, Rg, L);
data160708.field200.q = data160708.L200.q;
data160708.field200.fq = data160708.L200.fq./SB200.Sq;
data160708.field200.fq_int = data160708.L200.fq_int./SB200.Sq;
semilogy(data160708.field200.q.^2, [data160708.field200.fq data160708.field200.fq_int]); 
%axis([0 1 1e-3 1.2]);
figure(gcf)
%%
b = 0.1;
L = 1.5*500*0.34e-3
Rg = sqrt(L*b/6 -b^2/4 + b^3./(4*L) - b^4./(8*L.^2).*(1 - exp(-2*L/b)))
SB500 = SharpBloomfieldStucFactor(data160708.L500.q, Rg, L);
data160708.field500.q = data160708.L500.q;
data160708.field500.fq = data160708.L500.fq./SB500.Sq;
data160708.field500.fq_int = data160708.L500.fq_int./SB500.Sq;
semilogy(data160708.field500.q.^2, [data160708.field500.fq data160708.field500.fq_int]); 
%axis([0 1 1e-3 1.2]);
figure(gcf)
pause;
semilogy(data160708.field500.q.^2, [data160708.field200.fq data160708.field200.fq_int data160708.field500.fq data160708.field500.fq_int]);

%% Pick the estimation of the field from L500
%  fit with Gaussian just in case field and fit it
minVt = 0.05; % um
dynRange  = 5;
lowestG = 1e-2;
showRange =20;
NormRange = [1 4]*1e-3;
B1.lag = data160708.L500.lag;
B1.vt_um = [data160708.L500.vt_um data160708.L500.vt_um];
B1.Normalized = [ones(size(data160708.L500.Corrected))   data160708.L500.Corrected];
B1.errorNormalized = [data160708.L500.errorNormalized data160708.L500.errorNormalized];

FigHdl = FitField_GUI_twoCF(B1, minVt, dynRange, showRange, lowestG, 30, NormRange*1e3)
%% Extract field 
B1 = guidata(FigHdl);
close(FigHdl);
data160708.field500.wS = B1.field.paramGauss(2)
b = 0.1;
L = 1.5*500*0.34e-3
Rg = sqrt(L*b/6 -b^2/4 + b^3./(4*L) - b^4./(8*L.^2).*(1 - exp(-2*L/b)))
data160708.field500.wXY = sqrt(data160708.field500.wS^2 - 2/3*Rg^2)

%% Reevaluate Sq
S = DD372_3uW;
S.conc = 372
S.Sq = S.fq./data160708.field500.fq;
S.Sq_int =S.fq_int./data160708.field500.fq_int;

data160708.DD372_3uW = S;

%% arrange fieldnames
dataname = 'data160708';
nameTemplate = 'DD';

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


%% Fit with measured Structure factor in dilute solutions (modified Pincus theory)
%Take concentration of 6.5uM as dilute (4.3uM stands off somewhat)
DiluteFieldName = 'DD6';
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
fieldToFit =  'DD372_3uW';
S = eval([dataname '.'  fieldToFit]);

loglog(S.q, S.Sq_int)
title('Find  range for fit');
axis([0 20 1e-3 S.Sq_int(1)*1.2]);
figure(gcf)
pause;
ax = axis;
j4 = find( (S.q > ax(1)) & (S.q < ax(2)));
beta = nlinfitWeight1(S.q(j4), S.Sq_int(j4), @FitSemidiluteStructureFactor, [S.Sq_int(1) 1], ones(size(j4)), [SQ0.q SQ0.Sq_int])

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

%% Preparing plots
b = 0.1;
L = 1.5*100000*0.34e-3
Rg = sqrt(L*b/6 -b^2/4 + b^3./(4*L) - b^4./(8*L.^2).*(1 - exp(-2*L/b)))
SB = SharpBloomfieldStucFactor(S.q, Rg, L);
loglog(SB.q, SB.Sq, SB.q, 3./(SB.q*Rg).^2, [pi/Rg pi/Rg], [1e-3 1], '--k');
figure(gcf)
axis([ 0.2191   28.1557    0.0067    1.2528]);
xlabel('q', 'FontSize', 14)
ylabel('S_0(q)', 'FontSize', 14)

%% Processing  data of  dilute Lambda solutions of linear DNA

% Field normalization by Rh6G: repeat for each loaded data

S.Sq = S.fq.*exp(wXY^2*S.q.^2/4);
S.Sq_int = S.fq_int.*exp(wXY^2*S.q.^2/4);
S.errorSq = S.errorFq.*exp(wXY^2*S.q.^2/4);

%% Fit Debye and Ornstein-Zernicke structure factors
len = input('what is DNA length? (in bp)');
S.length_um = len*0.34e-3*1.5;
b = 0.1;
L =S.length_um;
Rg_th = sqrt(L*b/6 -b^2/4 + b^3./(4*L) - b^4./(8*L.^2).*(1 - exp(-2*L/b)))
loglog(S.q, S.Sq_int);
figure(gcf);
pause;

J= InAxes;
curAx = axis;

[BETA, temp, temp] = nlinfitWeight1(S.q(J), S.Sq_int(J), @FitDebyeStucFactor, [Rg_th S.Sq_int(1)], S.errorSq(J));
S.fitDebye_Rh = BETA;
S.fitDebye_Rh(1)

[BETA, temp, temp] = nlinfitWeight1(S.q(J), S.Sq_int(J), @FitSharpBloomfieldStucFactor, [Rg_th S.Sq_int(1)], S.errorSq(J), S.length_um );

S.fitSB_Rh = BETA;
loglog(S.q, S.Sq_int, S.q(J), [FitDebyeStucFactor(S.fitDebye_Rh, S.q(J))  FitSharpBloomfieldStucFactor(S.fitSB_Rh, S.q(J), S.length_um) ] );
axis(curAx);
figure(gcf);
BETA(1)
%% For short DNA estimate Rg from direct fit
%  fit with Gaussian 
dataname ='Dilute111108'
fieldname = 'L1_3_v4111p13_1';
S = eval([dataname '.' fieldname]);

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
wXY = eval([dataname '.B.field.wXY'])
B1 = guidata(FigHdl);
close(FigHdl);
S.wS = B1.field.paramGauss(2)
S.Rg_est  = sqrt(3/2*(S.wS^2 - wXY^2))
eval([dataname '.' fieldname '=S'])
%%

%% Add to Data Structure
%fieldname = 'Lambda_5_4uMb';
fldname = filenames{1};
eval([dataname '.' fldname ' = S;']); %input structure

%% arrange fieldnames
%dataname ='Dilute111108'
nameTemplate = 'L';
conc = [];
fnamesData ={};
fnamesSuppl ={};
DNA_length=[];

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
    eval(['DNA_length(j) = ' dataname '.' fnamesData{j} '.length_um;']);
    eval(['len = length(' dataname '.' fnamesData{j} '.Normalized);']);

    if len < minLen,
        minLen = len;
    end;
end;
[DNA_lengthSorted, Isrt] = sort(DNA_length);
eval([dataname '=orderfields(' dataname ', [fnamesData(Isrt);fnamesSuppl])']);

vt_um = [];
Normalized = [];
countrate = [];
Rg_Deb_Rh = [];
Rg_SB_Rh = [];
J = 1:minLen;
Q = [];
Sq_int_norm=[];
for j=1:length(fnamesData),
   eval(['vt_um = [vt_um ' dataname '.' fnamesData{Isrt(j)} '.vt_um(J)];']);
   eval(['Normalized = [Normalized ' dataname '.' fnamesData{Isrt(j)} '.Normalized(J)];']);
   eval(['countrate = [countrate ' dataname '.' fnamesData{Isrt(j)} '.countrateGood];']);
   eval(['Rg_Deb_Rh = [Rg_Deb_Rh ' dataname '.' fnamesData{Isrt(j)} '.fitDebye_Rh(1)];']);
  eval(['Rg_SB_Rh = [Rg_SB_Rh  ' dataname '.' fnamesData{Isrt(j)} '.fitSB_Rh(1)];']);  
  
  eval(['Q = [Q ' dataname '.' fnamesData{Isrt(j)} '.q];']);
  eval(['Sq_int_norm = [Sq_int_norm ' dataname '.' fnamesData{Isrt(j)} '.Sq_int/' dataname '.' fnamesData{Isrt(j)} '.Sq_int(1)];']);
end;

semilogy(vt_um.^2, Normalized);
axis([0 4 1e-2 1.2]);
figure(gcf);
legend(fnamesData(Isrt))

figure;
plot(DNA_lengthSorted, countrate, 'o')

figure;
loglog(Q(:, 2:8), Sq_int_norm(:, 2:8));
legend(fnamesData(Isrt))
% legend('2600bp', '4300bp','6000bp','12000bp','17000bp','24000bp','48000bp');

%% After all data are loaded into structure
% plot Rg
%load process170708 data150708
% add old data

eval([dataname '.length_um = DNA_length' ]);
eval([dataname '.Rg_Deb_Rh= Rg_Deb_Rh' ]);

%%

load process101108 data191008 data150708 dilute0511
load process121108 Dilute111108 L48Dilute data061008
DNA_length = [ data061008.length_um L48Dilute.length_um Dilute111108.length_um dilute0511.length_um data191008.length_um data150708.length];
Rg_Deb_Rh = [ data061008.Rg_Deb_Rh L48Dilute.Rg_Deb_Rh Dilute111108 .Rg_Deb_Rh dilute0511.Rg_Deb_Rh data191008.Rg_Deb_Rh data150708.Rg_meas];

%DNA_length = [data061008.length_um ];
%Rg_Deb_Rh = [data061008 .Rg_Deb_Rh];


loglog(DNA_length, Rg_Deb_Rh, 'o',  L48Dilute.length_um, L48Dilute.Rg_Deb_Rh, 'ro')
title('find the range to fit power law')
figure(gcf)
pause;
ax = axis;
jr =  InAxes;

p = polyfit(log(DNA_length(jr)), log(Rg_Deb_Rh(jr)), 1)
[BETA, temp, temp]  = nlinfit(DNA_length(jr), Rg_Deb_Rh(jr), @FitRgSemiflexible, [0.1]);
Kuhn_len = BETA
lenVector = 0.5:0.1:30;

loglog(DNA_length, Rg_Deb_Rh, 'o', lenVector, exp(polyval(p, log(lenVector))), lenVector, FitRgSemiflexible(BETA, lenVector));
figure(gcf)
scalingExp = p(1)

%%
DNA_length_tofit = DNA_length;
Rg_Deb_Rh_tofit = Rg_Deb_Rh;
 while input('continue fitting (Yes=1/No=0)'),
    loglog(DNA_length_tofit, Rg_Deb_Rh_tofit, 'o')
    jr = 1:length(DNA_length_tofit);
    title('find points to deselect')
    figure(gcf)
    pause;
    ax = axis;
    jd =  InAxes;
    jr = setdiff(jr, jd);
    DNA_length_tofit = DNA_length_tofit(jr);  
    Rg_Deb_Rh_tofit =   Rg_Deb_Rh_tofit(jr);
    
    p = polyfit(log(DNA_length_tofit), log(Rg_Deb_Rh_tofit), 1)
    [BETA, temp, temp]  = nlinfit(DNA_length_tofit, Rg_Deb_Rh_tofit, @FitRgSemiflexible, [0.1]);
    Kuhn_len = BETA
    lenVector = 0.5:0.1:30;

    loglog(DNA_length_tofit, Rg_Deb_Rh_tofit, 'o', lenVector, exp(polyval(p, log(lenVector))), lenVector, FitRgSemiflexible(BETA, lenVector));
    figure(gcf)
    scalingExp = p(1)
 end;


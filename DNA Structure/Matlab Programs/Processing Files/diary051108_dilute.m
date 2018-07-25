%% Processing  data of 051108 dilute solutions of linear DNA

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

%% Add to Data Structure
%fieldname = 'Lambda_5_4uMb';
fldname = filenames{1};
eval([dataname '.' fldname ' = S;']); %input structure

%% arrange fieldnames
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
for j=1:length(fnamesData),
   eval(['vt_um = [vt_um ' dataname '.' fnamesData{Isrt(j)} '.vt_um(J)];']);
   eval(['Normalized = [Normalized ' dataname '.' fnamesData{Isrt(j)} '.Normalized(J)];']);
   eval(['countrate = [countrate ' dataname '.' fnamesData{Isrt(j)} '.countrateGood];']);
   eval(['Rg_Deb_Rh = [Rg_Deb_Rh ' dataname '.' fnamesData{Isrt(j)} '.fitDebye_Rh(1)];']);
  eval(['Rg_SB_Rh = [Rg_SB_Rh  ' dataname '.' fnamesData{Isrt(j)} '.fitSB_Rh(1)];']);  
end;

semilogy(vt_um.^2, Normalized);
axis([0 4 1e-2 1.2]);
figure(gcf);
legend(fnamesData(Isrt))

figure;
plot(DNA_lengthSorted, countrate, 'o')

%% After all data are loaded into structure
% plot Rg
%load process170708 data150708
% add old data

eval([dataname '.length_um = DNA_length' ]);
eval([dataname '.Rg_Deb_Rh= Rg_Deb_Rh' ]);

%%

DNA_length = [dilute0511 .length_um data191008.length_um data150708.length];
Rg_Deb_Rh = [dilute0511 .Rg_Deb_Rh data191008.Rg_Deb_Rh data150708.Rg_meas];


loglog(DNA_length, Rg_Deb_Rh, 'o')
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



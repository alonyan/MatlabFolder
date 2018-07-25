load 'D:\Oleg\MyPapers\DNA dilute\Data\process101108.mat' Dilute111108
dataname = 'Dilute111108';
field = eval([dataname '.B.field']);
param.NpointsZ = 200; 
param.NpointsR = 200;
param.wXY = field.wXY;
param.wSq = field.wSq;

%%
fieldname = 'L48_v4111p13_1'; % change the field name through all the measurements in the data
S = eval([dataname '.' fieldname]);

semilogy(S.vt_um.^2, S.Normalized);
title('Zoom into the range for fitting and press any key')
axis([0 2 1e-3 1.5])
figure(gcf)
pause;
b = 0.1;
L =S.length_um;
Rg_th = sqrt(L*b/6 -b^2/4 + b^3./(4*L) - b^4./(8*L.^2).*(1 - exp(-2*L/b)))

J = InAxes;
[BETA, temp, temp] = nlinfitWeight1(S.vt_um(J), S.Normalized(J), @DebyeDirectFitGr, [1 Rg_th], S.errorNormalized(J), param );
semilogy(S.vt_um(J).^2, S.Normalized(J), 'o', S.vt_um(J).^2, DebyeDirectFitGr(BETA, S.vt_um(J), param));
figure(gcf)
S.fitDirect.BETA = BETA;
S.fitDirect.Rg =  BETA(2);
S.fitDirect.dataNo = J;
% put back into the structure
eval([dataname '.' fieldname ' = S']) ;

%% after all data have been analyzed, summarize

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
    eval(['DNA_length(j) = ' dataname '.' fnamesData{j} '.length_um;']);
    eval(['Rg(j) =  ' dataname '.' fnamesData{j} '.fitDirect.Rg;']);
end;

[temp, sortJ] = sort(DNA_length);
eval([dataname '.Rg_Deb_direct =  Rg' ]);

data = eval(dataname);
loglog(data.length_um,  data.Rg_Deb_Rh, 'o', data.length_um, data.Rg_Deb_direct, 'o' );
figure(gcf)
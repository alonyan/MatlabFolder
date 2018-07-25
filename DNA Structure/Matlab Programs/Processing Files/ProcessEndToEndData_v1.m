%% Constants
%cd 'D:\Oleg\Students\Manish Nepal\Experiments\Processing'
cd 'D:\People\Oleg\Matlab Programs\Processing Files'
speedHigh = '4468p41*'
speedLow = '50p34*'
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
           'ImageArray'
           'ImageSize'
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
%% load files
fpath = 'D:\People\Manish\Experiments\140410\';
%fpath = 'D:\Oleg\Students\Manish Nepal\Experiments\080410\';
% fnametemplate_1Label = 'puc300_cut_Dyn';
% fnametemplate_2Label = 'puc300_uncut_Dyn';
% fname_Static_1L = {'puc300_cut_St'};
% fname_Static_2L = {'puc300_uncut_St'};

%fnametemplate_1Label = 'puc300_cut_dil5x_Dyn';
%fnametemplate_2Label = 'puc300_uncut_dil5x_Dyn';
%fname_Static_1L = {'puc300_cut_St'};
%fname_Static_2L = {'puc300_uncut_St'};

fnametemplate_1Label = 'PUC3K_Sgl_Dyn_1';
fnametemplate_2Label = 'PUC3K_Dbl_Dyn_1';
fname_Static_1L = {'PUC3K_Sgl_St'};
fname_Static_2L = {'PUC3K_Dbl_st'};

fnames = dir([fpath fnametemplate_1Label speedLow]);
S1L_slow = LoadMultipleCorrFunc_v3(fpath, {fnames.name}, 'Rejection', 2, 'NormalizationRange', [1e-3 2e-3],  'DeleteList', []);

fnames = dir([fpath fnametemplate_1Label speedHigh]);
S1L_fast = LoadMultipleCorrFunc_v3(fpath, {fnames.name}, 'Rejection', 2, 'NormalizationRange', [1e-3 2e-3],  'DeleteList', []);

%Find range for baseline subtraction
semilogx(S1L_fast.lag, S1L_fast. Normalized);
axis([1e-3 10000 -0.1 0.1])
figure(gcf)
title('single label: find range for baseline subtraction');
pause;
S1L_fast.rangeBL = InAxes;
S1L_fast.Normalized = (S1L_fast.Normalized - mean(S1L_fast.Normalized(InAxes)))/(1 - mean(S1L_fast.Normalized(InAxes)));
S1L_fast.AverageCF_CR = S1L_fast.Normalized*S1L_fast.G0;
semilogx(S1L_fast.lag, S1L_fast. AverageCF_CR);
axis([5e-4 1e3 -0.2*S1L_fast.G0 S1L_fast.G0*1.2])
figure(gcf)
title('single label: hit any key')
pause;

S1L_st = LoadMultipleCorrFunc_v3(fpath, fname_Static_1L, 'Rejection', 2, 'NormalizationRange', [1e-3 2e-3],  'DeleteList', []);

fnames = dir([fpath fnametemplate_2Label speedLow]);
S2L_slow = LoadMultipleCorrFunc_v3(fpath, {fnames.name}, 'Rejection', 2, 'NormalizationRange', [1e-3 2e-3],  'DeleteList', []);

fnames = dir([fpath fnametemplate_2Label speedHigh]);
S2L_fast = LoadMultipleCorrFunc_v3(fpath, {fnames.name}, 'Rejection', 2, 'NormalizationRange', [1e-3 2e-3],  'DeleteList', []);

%Find range for baseline subtraction
semilogx(S2L_fast.lag, S2L_fast. Normalized);
axis([1e-3 10000 -0.1 0.1])
figure(gcf)
title('double label: find range for baseline subtraction');
pause;
S2L_fast.rangeBL = InAxes;
S2L_fast.Normalized = (S2L_fast.Normalized - mean(S2L_fast.Normalized(InAxes)))/(1 - mean(S2L_fast.Normalized(InAxes)));
S2L_fast.AverageCF_CR = S2L_fast.Normalized*S2L_fast.G0;
semilogx(S2L_fast.lag, S2L_fast. AverageCF_CR);
axis([5e-4 1e3 -0.2*S2L_fast.G0 S2L_fast.G0*1.2])
figure(gcf)
title('double label: hit any key')
pause;

S2L_st = LoadMultipleCorrFunc_v3(fpath, fname_Static_2L, 'Rejection', 2, 'NormalizationRange', [1e-3 2e-3],  'DeleteList', []);


% %% 9) remove fields which are not needed for futher processing
% if isfield(S,  'corrfuncbad')
%         S = rmfield(S, [fields_to_removeGood; fields_to_removeBad]);
% else 
%         S = rmfield(S, fields_to_removeGood);
% end;


%% 2) Static and dynamic Rh6G measurements to evaluate field size
close all;
RhNameTemplate = 'Rh6G_Dyn' %dynamic
RhName_Static = {'Rh6G'} % define static rh file name

fnames = dir([fpath RhNameTemplate speedLow]);
Rh_slow = LoadMultipleCorrFunc_v3(fpath, {fnames.name}, 'Rejection', 2, 'NormalizationRange', [1e-3 2e-3],  'DeleteList', []);

fnames = dir([fpath RhNameTemplate speedHigh]);
Rh_fast = LoadMultipleCorrFunc_v3(fpath, {fnames.name}, 'Rejection', 2, 'NormalizationRange', [1e-3 2e-3],  'DeleteList', []);

Rh_st = LoadMultipleCorrFunc_v3(fpath, RhName_Static, 'Rejection', 2, 'NormalizationRange', [1e-3 2e-3],  'DeleteList', []);

FitParam = PlotFitCF(Rh_st, [0.002 1000], @Diffusion3D, [20000 0.05 30]);
wSq = FitParam.beta(3, 1);
% if isfield(RhV,  'corrfuncbad')
%         RhV = rmfield(RhV, [fields_to_removeGood; fields_to_removeBad]);
% else 
%         RhV = rmfield(RhV, fields_to_removeGood);
% end;

%% 3)  make field and fit it
minVt = 0.05; % um
dynRange  = 5;
lowestG = 1e-2;
showRange =20;
NormRange = [1 2]*1e-3;
B.lag = Rh_fast.lag;
B.vt_um = [Rh_fast.vt_um Rh_fast.vt_um];
B.Normalized = [Rh_slow.Normalized Rh_fast.Normalized];
B.errorNormalized = [Rh_slow.errorNormalized Rh_fast.errorNormalized];

FigHdl = FitField_GUI_twoCF_v2(B, minVt, dynRange, showRange, lowestG, wSq, NormRange*1e3)
%%  4) Extract field 
B = guidata(FigHdl);
close(FigHdl);
wXY = B.field.paramGauss(2)
B.fieldRh.wXY = wXY;
B.fieldRh.wSq = wSq;
%eval([dataname '.B = B;']);

%%  estimate field from single-labeled DNA data
minVt = 0.05; % um
dynRange  = 5;
lowestG = 1e-2;
showRange =20;
NormRange = [1 2]*1e-3;
B.lag = S1L_fast.lag;
B.vt_um = [S1L_fast.vt_um S1L_fast.vt_um];
B.Normalized = [S1L_slow.Normalized S1L_fast.Normalized];
%B.Normalized = [S1L_st.Normalized S1L_fast.Normalized];

B.errorNormalized = [S1L_slow.errorNormalized S1L_fast.errorNormalized];

FigHdl = FitField_GUI_twoCF_v2(B, minVt, dynRange, showRange, lowestG, wSq, NormRange*1e3)
%%  4) Extract field 
B = guidata(FigHdl);
close(FigHdl);
wXY = B.field.paramGauss(2)
B.fieldDNA.wXY = wXY;
B.fieldDNA.wSq = wSq;
%eval([dataname '.B = B;']);

% %% 6) Cluster analysis
% Nclust = 10;
% LinkageType ='single'% 'single', 'average', 'weighted'
% Range = [1e-2 100]; % range of decay of the correlation function
% [T, j, DeleteList] = ClusterizeCF_CR_v1(S, 'No of Clusters', Nclust, 'Normalization range', NormRange, 'Distance range', Range, 'Linkage', LinkageType);
% 
% %% 7) Reload if needed
% Rejection = 10;
%  S = LoadMultipleCorrFunc_v2(filepath, filenames, 'Rejection', Rejection, 'DeleteList', DeleteList);
 
% %% 8) Plot Speed
% plot(S.v_um_s)
% figure(gcf)
% %% 9) remove fields which are not needed for futher processing
% if isfield(S,  'corrfuncbad')
%         S = rmfield(S, [fields_to_removeGood; fields_to_removeBad]);
% else 
%         S = rmfield(S, fields_to_removeGood);
% end;

%% Have a look at static data and their difference
semilogx(S1L_st.lag, S1L_st.AverageCF_CR, S2L_st.lag, S2L_st.AverageCF_CR, S1L_st.lag, 2.5*(S2L_st.AverageCF_CR- S1L_st.AverageCF_CR));
figure(gcf)


%%  Have a look at slow data and their difference
semilogx(S1L_slow.lag, S1L_slow.AverageCF_CR, S2L_slow.lag, S2L_slow.AverageCF_CR, S1L_slow.lag, 2*(S2L_slow.AverageCF_CR- S2L_slow.PhotoDiodeMean/S1L_slow.PhotoDiodeMean*S1L_slow.AverageCF_CR));
figure(gcf)

%% %% Have a look at fast data and their difference
semilogx(S1L_fast.lag, S1L_fast.AverageCF_CR, S2L_fast.lag, S2L_fast.AverageCF_CR, S1L_fast.lag, 5*(S2L_fast.AverageCF_CR- S2L_fast.PhotoDiodeMean/S1L_fast.PhotoDiodeMean*S1L_fast.AverageCF_CR));
semilogx(S1L_fast.vt_um, S1L_fast.AverageCF_CR, S2L_fast.vt_um, S2L_fast.AverageCF_CR, S1L_fast.vt_um, 2*(S2L_fast.AverageCF_CR- S2L_fast.PhotoDiodeMean/S1L_fast.PhotoDiodeMean*S1L_fast.AverageCF_CR));

figure(gcf)

%% compare the differences for fast and slow data
semilogx(S1L_fast.vt_um, (S2L_fast.AverageCF_CR- S2L_fast.PhotoDiodeMean/S1L_fast.PhotoDiodeMean*S1L_fast.AverageCF_CR), S1L_fast.vt_um, (S2L_slow.AverageCF_CR- S2L_slow.PhotoDiodeMean/S1L_slow.PhotoDiodeMean*S1L_slow.AverageCF_CR));

figure(gcf)
pause;
S_slow = S2L_slow;
S_slow.AverageCF_CR = S2L_slow.AverageCF_CR- S2L_slow.PhotoDiodeMean/S1L_slow.PhotoDiodeMean*S1L_slow.AverageCF_CR;
%S_slow.AverageCF_CR = S2L_slow.AverageCF_CR- S1L_slow.AverageCF_CR;

S_slow.errorCF_CR = sqrt(S2L_slow.errorCF_CR.^2 + (S2L_slow.PhotoDiodeMean/S1L_slow.PhotoDiodeMean*S1L_slow.errorCF_CR.^2));

j = find((S_slow.lag > NormRange(1)) & (S_slow.lag < NormRange(2)));
S_slow.G0 = robmean(S_slow.AverageCF_CR(j), S_slow.errorCF_CR(j));
S_slow.Normalized = S_slow.AverageCF_CR./S_slow.G0;

S = S2L_fast;
S.AverageCF_CR = S2L_fast.AverageCF_CR- S2L_fast.PhotoDiodeMean/S1L_fast.PhotoDiodeMean*S1L_fast.AverageCF_CR;
S.errorCF_CR = sqrt(S2L_fast.errorCF_CR.^2 + (S2L_fast.PhotoDiodeMean/S1L_fast.PhotoDiodeMean*S1L_fast.errorCF_CR.^2));

j = find((S_slow.lag > NormRange(1)) & (S_slow.lag < NormRange(2)));
S.G0 = robmean(S.AverageCF_CR(j), S.errorCF_CR(j));
S.Normalized = S.AverageCF_CR./S.G0;
S.Corrected =  (S.Normalized./S_slow.Normalized).^(1./S_slow.Normalized);
semilogy(S.vt_um.^2,  S.Normalized, S.vt_um.^2,  S.Corrected);
axis([0 4 1e-3 1.2])
figure(gcf);


%% 17) preparing for Fourier Transform (return to using Corrected field)
N = 512; % number of interpolation points
Rm = 10; %upper limit of corrfunc confidence
minVtSq =  0.0025; 
lowestG = 1.5e-2;

load 'D:\People\Oleg\Matlab Programs\Processing Files\c.mat';  %for Hankel Transform
c = c(1, 1:N+1);    %Bessel function zeros;
S.r = c(1:N)'*Rm/c(N+1);   % Radius vector
 
% S.fr = exp(interp1(S.vt_um.^2, log(S.Normalized), S.r.^2, 'linear'));
% %zero-padding from the first zero encountered
% S.fr = real(S.fr);
% S.fr(find(S.fr< 0)) = 0;
% 
% semilogy(S.vt_um.^2, S.Normalized, '-o', S.r.^2, S.fr);
% pause;


j3= find(S.vt_um( :).^2 > minVtSq); 
Stemp.vt_um = S.vt_um(j3);
Stemp.AverageCF_CR = S.Corrected(j3);
%k= find(Stemp.AverageCF_CR < lowestG*(S2L_fast.G0 - S1L_fast.G0));
k= find(Stemp.AverageCF_CR < lowestG);
if isempty(k),
       k=length(Stemp.AverageCF_CR)+1;
end;
j2= 1:(min(k)-1);
       
               
 %       semilogyErBar(B.vt_um(i, j2).^2, B.ReNormalized(i, j2), B.errorReNormalized(i, j2),  'o') ;
  %      v= axis;
    
        %j1 = j2;
        
 
 
S.fr = exp(interp1(Stemp.vt_um(j2).^2, log(Stemp.AverageCF_CR(j2) ), S.r.^2, 'linear', 'extrap'));
%zero-padding from the first zero encountered
S.fr = real(S.fr);
S.fr(find(S.fr< 0)) = 0;

S.fr_int = exp(robustinterp(S.r.^2, Stemp.vt_um(j2).^2, log(Stemp.AverageCF_CR(j2)), 3));

S.fr_int =  S.fr_int(:);
%semilogy(S.vt_um( :), S.AverageCF_CR( :) , '-o', S.r, [S.fr S.fr_int]);
semilogy(S.vt_um( :), S.Corrected( :) , '-o', S.r, [S.fr S.fr_int]);
%axis([0 2 1 5000])
axis([0 2 1e-3 1.2])
figure(gcf)
       

% title('Find lower range for interpolation');
% axis([0 5 1e-3 1.2]);
% figure(gcf)
% pause;
% ax = axis;
% %j1 = InAxes; %
% j1 =find( (S.vt_um.^2 > ax(1)) & (S.vt_um.^2 < ax(2)) & (S.Corrected > ax(3)) & (S.Corrected < ax(4)));
% p1 = polyfit(S.vt_um(j1).^2, log(S.Corrected(j1)), 1);
% 
% S.fr_int = S.fr;
% j2 = find(S.r.^2 >  ax(2));
% S.fr_int(j2) = exp(polyval(p1, S.r(j2).^2));
% semilogy(S.vt_um.^2, S.Corrected, '-o', S.r(j2).^2, S.fr_int(j2));
% axis([0 5 1e-3 1.2]);
%  %%
% semilogy(S.vt_um.^2, S.Corrected, '-o', S.r.^2, S.fr_int);
% title('Find upper range for interpolation');
% axis([0 0.025 0.8 1.2]);
% figure(gcf)
% pause;
% ax = axis;
% %j3 = InAxes; % 
% j3 = find((S.vt_um.^2 > ax(1)) & (S.vt_um.^2 < ax(2)) );
% p2 = polyfit(S.vt_um(j3).^2, log(S.Corrected(j3)), 1);
% 
% j4 = find(S.r.^2  <  ax(2));
% S.fr_int(j4) = exp(polyval(p2, S.r(j4).^2));
% semilogy(S.vt_um.^2, S.Corrected, '-o', S.r.^2, S.fr_int);
% axis(ax);

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
figure(gcf);
pause;

S.Sq = S.fq.*exp(wXY^2*S.q.^2/4);
S.Sq_int = S.fq_int.*exp(wXY^2*S.q.^2/4);
J = find(S.q < 20);
semilogy(S.q(J).^2, [S.Sq(J) S.Sq_int(J)]);
figure(gcf)
  %%
J = find(S.q < 20);
plot(S.q(J), [S.Sq(J) S.Sq_int(J)]);
figure(gcf)

%% evaluate Fourier transform of the field from single labeled DNA
field.r = S.r;
j3= find(B.field.r( :).^2 > minVtSq); 
Stemp.r = B.field.r(j3);
Stemp.AverageCF_CR = B.field.G(j3);
%k= find(Stemp.AverageCF_CR < lowestG*(S2L_fast.G0 - S1L_fast.G0));
k= find(Stemp.AverageCF_CR < lowestG);
if isempty(k),
       k=length(Stemp.AverageCF_CR)+1;
end;
j2= 1:(min(k)-1);
       
               
 %       semilogyErBar(B.vt_um(i, j2).^2, B.ReNormalized(i, j2), B.errorReNormalized(i, j2),  'o') ;
  %      v= axis;
    
        %j1 = j2;
        
 
 
field.fr = exp(interp1(Stemp.r(j2).^2, log(Stemp.AverageCF_CR(j2) ), field.r.^2, 'linear', 'extrap'));
%zero-padding from the first zero encountered
field.fr = real(field.fr);
field.fr(find(field.fr< 0)) = 0;

field.fr_int = exp(robustinterp(field.r.^2, Stemp.r(j2).^2, log(Stemp.AverageCF_CR(j2)), 3));

field.fr_int =  field.fr_int(:);
%semilogy(S.vt_um( :), S.AverageCF_CR( :) , '-o', S.r, [S.fr S.fr_int]);
semilogy(B.field.r( :), B.field.G( :) , '-o', field.r, [field.fr field.fr_int]);
%axis([0 2 1 5000])
axis([0 2 1e-3 1.2])
figure(gcf)
pause;

%wXY = B.field.paramGauss(2)
FY = FourierTransform(field, '2D');
field.q = FY.q;
field.fq = FY.fq/FY.fq(1);

%interpolated Fourier Transform
Y.r = field.r;
Y.fr = field.fr_int;
FY = FourierTransform(Y, '2D');
field.fq_int = FY.fq/FY.fq(1);

semilogy(field.q.^2, field.fq, field.q.^2, field.fq_int, field.q.^2, field.fq(1)*exp(-wXY^2*field.q.^2/4))
figure(gcf);


 %%

J = find(S.q < 20);
plot(S.q(J), [S.Sq(J) S.Sq_int(J) S.fq(J)./field.fq(J)  S.fq_int(J)./field.fq_int(J)]);
figure(gcf)

%% One step  correction  for finite aspect ratio
 wXYsq = wXY^2;
 dqz = median(diff(S.q))/sqrt(wSq);
 S.qz = 0:dqz:(max(S.q)/sqrt(wSq)); 
 [Q, Qz] = meshgrid(S.q, S.qz);
 Qvec = sqrt(Q.^2 + Qz.^2);
 
 q = S.q;
 qz = S.qz;
 
normFz = sum(exp(-wXYsq*qz.^2*wSq/4 ));
kernFz = exp(-wXYsq*Qz.^2*(wSq-1)/4 )/normFz; 

%zero-pad S.fq above first zero
S.fq(min(find(S.fq <0)):size(S.fq)) =0;
S.fq_int(min(find(S.fq_int <0)):size(S.fq_int)) =0;
 
%for i=1:10,
    dGq2Dto3D = interp1( q, S.fq, Qvec(:));
    dGq2Dto3D = reshape(dGq2Dto3D, size(Qvec));
    dGq = S.fq  - sum(dGq2Dto3D.*kernFz)';
   S.fq_cor = S.fq + dGq;  
%end;

S.Sq_cor = S.fq_cor.*exp(wXYsq*q.^2/4); 
loglog(q, [S.Sq S.Sq_cor]);
figure(gcf)
pause;

    dGq2Dto3D = interp1( q, S.fq_int, Qvec(:));
    dGq2Dto3D = reshape(dGq2Dto3D, size(Qvec));
    dGq = S.fq_int  - sum(dGq2Dto3D.*kernFz)';
   S.fq_int_cor = S.fq_int + dGq;  
 
S.Sq_int_cor = S.fq_int_cor.*exp(wXYsq*q.^2/4); 
J = find(q < 20);
loglog(q(J), [S.Sq_int(J) S.Sq_int_cor(J)]);
figure(gcf)


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
 %   Corrected = (Corrected./St.Normalized(jp)).^(1./St.Normalized(jp));
 %   remove extra correction
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
S.errorSq = S.errorFq.*exp(wXYsq*q.^2/4); 


close all
clear
clc

%% load
load('/home/ryan/ryan/GenomicNoise_DataAnalysis/NoiseDecomposition/ALON_rankVars_08_22.mat')

%% gate on cells
Nt = size(Y_ref,1);
i=1;
J = ~isnan(Y_ref(i,:));
scatter(log(Y_ref(i,J)), log(C_ref(i,J))); shg
% pause

addpath('/home/alon/Repos/MatlabFolder/General Utilities')
addpath('/home/alon/Repos/MatlabFolder/Plotting Utilities/')

JJ = InAxes;
J = find(J);
J = J(JJ);
%
for i=1:Nt
    Y_ref_gated(i,:) =Y_ref(i,J);
    C_ref_gated(i,:) =C_ref(i,J);    
end
Y_ref_gated=Y_ref; 
C_ref_gated=C_ref; 

%% Remove correlated component from y
Y_ref_gated_comped = zeros(size(Y_ref_gated));
p = zeros(Nt,2);
%figure()
for i=1:Nt
    cla
    yy = Y_ref_gated(i,:);
    xx = C_ref_gated(i,:);
    J = ~isnan(xx);

% PlotColorCoded_v2(xx',yy',J, J, range(xx)/30, range(yy)/30 ); 
%shg; drawnow;


%PlotColorCoded_v2(xxComp',yyComp',J, J, range(xxComp)/30, range(yyComp)/30 ); 

 p(i,:) = polyfit(xx(J), yy(J),1);
 yVal = polyval(p(i,:),xx);
% plot(xx(J),yVal(J))
 yComped = yy-yVal;
%  PlotColorCoded_v2(xx',yComped',J, J, range(xx)/30, range(yComped)/30 ); 

%  shg; drawnow;
 Y_ref_gated_comped(i,:) = yComped;
end

%correlation bw blue-yellow slowly goes down, Bleaching?
%% Autocorrelation

a = Y_ref_gated_comped';

a = a-nanmean(a(:));
a(isnan(a))=0;
CorrCoeffs = triu(a'*a)./repmat(sum(a.^2),size(a,2),1);

AutoCorr=[]; for i=0:size(a,2)-1 AutoCorr = [AutoCorr nanmean(diag(CorrCoeffs,i))]; end
AutoCorrErr=[]; for i=0:size(a,2)-1 AutoCorrErr = [AutoCorrErr nanstd(diag(CorrCoeffs,i))/sqrt(numel(diag(CorrCoeffs,i)))]; end
ploterr(T, AutoCorr,[],AutoCorrErr); shg
 set(gca,'ylim',[0,1])

ylabel('autocorrelation')
xlabel('time')
hold all

%% Calculate Scaling for xcorr. Normalize so xCorr at 0 is pearson at 0
a = Y_ref_gated';
b = C_ref_gated';

a = a-nanmean(a(:));
a(isnan(a))=0;
b = b-nanmean(b(:));
b(isnan(b))=0;
CorrAt0 = zeros(1,Nt);
for i=1:Nt;
%R = corrcoef(a(:,i), b(:,i))
CorrAt0(i)=p(i,1);
end
ScalingFactors = diag(a'*b)'./CorrAt0;
%% xcorr
a = Y_ref_gated_comped';
b = C_ref_gated';

%a = repmat(Y_ref(1,:),124,1)';
a = a-nanmean(a(:));
a(isnan(a))=0;
b = b-nanmean(b(:));
b(isnan(b))=0;


CorrCoeffs = (a'*b)./repmat(ScalingFactors,Nt,1);

xCorr=[]; for i=-size(a,2)+1:size(a,2)-1 xCorr = [xCorr nanmean(diag(CorrCoeffs,i))]; end
xCorrErr=[]; for i=-size(a,2)+1:size(a,2)-1 xCorrErr = [xCorrErr nanstd(diag(CorrCoeffs,i))/sqrt(numel(diag(CorrCoeffs,i)))]; end

 ploterr([-flipud(T(2:end));T],xCorr,[],xCorrErr); shg
 set(gca,'ylim',[0,1])
 ylabel('xcorrelation')
 xlabel('time')
hold all
%%

%% Autocorrelation

a = Y_ref_gated_comped';

a = a-nanmean(a(:));
a(isnan(a))=0;
CorrCoeffs = triu(a'*a)./repmat(sum(a.^2),size(a,2),1);

AutoCorr=[]; for i=0:size(a,2)-1 AutoCorr = [AutoCorr nanmean(diag(CorrCoeffs,i))]; end
AutoCorrErr=[]; for i=0:size(a,2)-1 AutoCorrErr = [AutoCorrErr nanstd(diag(CorrCoeffs,i))/sqrt(numel(diag(CorrCoeffs,i)))]; end
ploterr(T, AutoCorr,[],AutoCorrErr); shg
 set(gca,'ylim',[0,1])

ylabel('autocorrelation')
xlabel('time')
hold all


%%
[~,ind] = sort(Y_ref_gated_comped(1,:));
a = Y_ref_gated_comped(:,ind);
h = plot(a);
tzeva = jet(numel(h));
for i=1:numel(h)
    set(h(i),'color',tzeva(i,:));
end




%%
[~,ind] = sort(Y_ref_gated_comped(1,:));
a = Y_ref_gated_comped(:,ind);
h = plot(a);
tzeva = jet(numel(h));
for i=1:numel(h)
    set(h(i),'color',tzeva(i,:));
end
%%
RankMat = [];
for i=1:size(a,1)
[~,ranks] = sort(a(i,:));
[~,ranks] = sort(ranks);
RankMat = [RankMat; ranks];
end
J = datasample(1:size(RankMat,2),100);
h = plot(RankMat(:,sort(J)));
tzeva = jet(numel(h));
for i=1:numel(h)
    set(h(i),'color',tzeva(i,:),'linewidth', 2);
    h(i).Color(4) = 0.1;
end
shg
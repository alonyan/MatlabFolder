a = [1 2 3 4 5 6; 1 2 4 3 5 6; 1 2 3 4  6 5; 1 3 2 4 5 6; 1 2 3 6 4 5; 1 2 4 6 3 5; 3 4 2 1 5 6; 5 1 2 3 6 4; 5 4 6 3 2 1; 5 3 6 4 1 2]';

a = a-nanmean(a(:));
a(isnan(a))=0;
CorrCoeffs = triu(a'*a)./repmat(sum(a.^2),size(a,2),1);

AutoCorr=[]; for i=0:size(a,2)-1 AutoCorr = [AutoCorr nanmean(diag(CorrCoeffs,i))]; end
AutoCorrErr=[]; for i=0:size(a,2)-1 AutoCorrErr = [AutoCorrErr nanstd(diag(CorrCoeffs,i))/sqrt(numel(diag(CorrCoeffs,i)))]; end
ploterr(0:size(a,2)-1, AutoCorr,[],AutoCorrErr); shg
ylabel('autocorrelation')
xlabel('time')
shg


%%
a = a-nanmean(a(:));
a(isnan(a))=0;
%%
AutoCorrMat = [];
for i=1:6;
CorrCoeffs = triu(a(i,:)'*a(i,:))./repmat(diag(a(i,:)'*a(i,:)),1,size(a,2));

AutoCorr=[]; for i=0:size(a,2)-1 AutoCorr = [AutoCorr nanmean(diag(CorrCoeffs,i))]; end
AutoCorrErr=[]; for i=0:size(a,2)-1 AutoCorrErr = [AutoCorrErr nanstd(diag(CorrCoeffs,i))/sqrt(numel(diag(CorrCoeffs,i)))]; end
ploterr(0:size(a,2)-1, AutoCorr,[],AutoCorrErr); shg
ylabel('autocorrelation')
xlabel('time')
shg
AutoCorrMat = [AutoCorrMat;AutoCorr]
end
plot(mean(AutoCorrMat))

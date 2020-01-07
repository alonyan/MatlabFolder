%% xcorr
a = slope2;
b = slope1;
figure('color','w')
%a = repmat(Y_ref(1,:),124,1)';
a = a-nanmean(a(:));
a(isnan(a))=0;
b = b-nanmean(b(:));
b(isnan(b))=0;


CorrCoeffs = (a'*b);

xCorr=[]; for i=-size(a,2)+1:size(a,2)-1 xCorr = [xCorr nanmean(diag(CorrCoeffs,i))]; end
xCorrErr=[]; for i=-size(a,2)+1:size(a,2)-1 xCorrErr = [xCorrErr nanstd(diag(CorrCoeffs,i))/sqrt(numel(diag(CorrCoeffs,i)))]; end

 ploterr([-size(a,2)+1:size(a,2)-1]/3,xCorr,[],xCorrErr); shg
 %set(gca,'ylim',[0,1])
 ylabel('xcorrelation')
 xlabel('time (h)')
hold all

set(gcf, 'PaperPositionMode','auto','color','w','InvertHardcopy','off')
print(gcf,'-dpng','-r300',fullfile(R.figSavePath, 'xCorrExample'));
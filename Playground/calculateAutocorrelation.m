function CorrFun = calculateAutocorrelation(V,varargin)
%%   calculate autocorrelation function
DistBinSize = ParseInputs('BinSize',1,varargin);

V = bsxfun(@minus,V,mean(V,2));
V(isnan(V))=0;

CorrCoeffs = triu(V'*V)./mean(diag(V'*V));
AutoCorr=[]; for i=0:size(V,2)-1 AutoCorr = [AutoCorr nanmean(diag(CorrCoeffs,i))]; end
AutoCorrErr=[]; for i=0:size(V,2)-1 AutoCorrErr = [AutoCorrErr nanstd(diag(CorrCoeffs,i))/sqrt(numel(diag(CorrCoeffs,i)))]; end
CorrFun.Corr = AutoCorr;
CorrFun.errCorr = AutoCorrErr;
CorrFun.Bins = 0:size(V,2)-1;

%     [AX1, AX2] = meshgrid([1:size(V,2)]./2);
%     dtMap = AX1-AX2;
%     
%     CorrMap = (V'*V);
%     
%     %No double counting, mister!
%     J = find(triu(dtMap));
%     dtMapVec = dtMap(J);
%     CorrMapVec = CorrMap(J);
%     
%     lenMax = ceil(max(dtMapVec)/DistBinSize);
%     lenMin = ceil(min(dtMapVec)/DistBinSize);
%     BinInd = lenMin:lenMax;
%     Bins = (BinInd-0.5)*DistBinSize;
%     BinNo = ceil(dtMapVec/DistBinSize);
%     
%     error_corr = zeros(length(Bins),1);
%     Corr = zeros(length(Bins),1);
%     Nbin = zeros(length(Bins),1);
%     for ii = 1:size(Bins,2),
%         J = find(BinNo == BinInd(ii));
%         Nbin(ii) = length(J);
%         Corr(ii) = mean(CorrMapVec(J));
%         error_corr(ii) = std(CorrMapVec(J))/sqrt(Nbin(ii));
%     end
    
%    CorrFun.Corr = Corr;
%    CorrFun.errCorr = error_corr;
%    CorrFun.Bins = Bins;
%     J = (error_corr~=0);
%     beta0 = [Corr(1),20,10];
%     %beta = lsqcurvefit(@ExpCosFit,beta0,Bins',Corr);
%     FitParam = nlinfitWeight2(Bins(J)',Corr(J), @ExpCosFit,beta0,error_corr(J),[],[0 5 0],[inf 60 inf]);
%     beta = FitParam.beta;
%     x = 0:0.1:120;
%     y = ExpCosFit(beta,x);
%     figure
%     ploterr(Bins,Corr,[],error_corr,'o'); shg;
%     hold on
%     plot(x,y,'-');
%     ylabel('autocorr')
%     xlabel('time(h)')
%     a = annotation('textbox',[0.6, 0.8,0.4, 0.05],'string', sprintf('period is %s h',num2str(FitParam.beta(2),2)),'linestyle','none');
%     
%     set(gca,'xlim',[0 120])
%     pause
end

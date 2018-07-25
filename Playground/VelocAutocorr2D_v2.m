function corr = VelocAutocorr2D_v2(Vx,Vy,timeStep)

%Vx = xCoordMat(i,2:end)-xCoordMat(i,1:end-1);
%Vy = yCoordMat(i,2:end)-yCoordMat(i,1:end-1);
%
% corr = struct;
% corrx = SoftCorrelator_v2(Vx,'PhCountCorr',timeStep);
% corry = SoftCorrelator_v2(Vy,'PhCountCorr',timeStep);
% corr.t = corrx.lag;
% corry.corrfunc(abs(corry.corrfunc)==inf | isnan(corry.corrfunc))=0;
% corrx.corrfunc(abs(corrx.corrfunc)==inf | isnan(corry.corrfunc))=0;
% 
% 

%corr.cfun = corrx.corrfunc+corry.corrfunc;

Y1.V = Vx';
Y2.V = Vx';
Y1.U = Vy';
Y2.U = Vy';

[AX1, AX2] = meshgrid([1:length(Y1.V)]./2);
dtMap = AX1-AX2;
CorrMap = (Y1.V'*Y2.V+Y1.U'*Y2.U);

J = find(triu(dtMap));
dtMapVec = dtMap(J);
CorrMapVec = CorrMap(J);

DistBinSize = 1;
lenMax = ceil(max(dtMapVec)/DistBinSize);
lenMin = ceil(min(dtMapVec)/DistBinSize);
BinInd = lenMin:lenMax;
Bins = (BinInd-0.5)*DistBinSize;
BinNo = ceil(dtMapVec/DistBinSize);

error_corr = zeros(length(Bins),1);
Corr = zeros(length(Bins),1);
Nbin = zeros(length(Bins),1);
for ii = 1:size(Bins,2),
    J = find(BinNo == BinInd(ii));
    Nbin(ii) = length(J);
    Corr(ii) = mean(CorrMapVec(J));
    error_corr(ii) = std(CorrMapVec(J))/sqrt(Nbin(ii));
end

corr.cfun = Corr;
corr.t = BinNo*timeStep;
%plot(corrx.lag(2:end), corrx.corrfunc(2:end)+corry.corrfunc(2:end));
%shg
%figure
%scatter(xCoordMat(i,:), yCoordMat(i,:))
end
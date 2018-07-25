function corr = VelocAutocorr2D(Vx,Vy,timeStep)

%Vx = xCoordMat(i,2:end)-xCoordMat(i,1:end-1);
%Vy = yCoordMat(i,2:end)-yCoordMat(i,1:end-1);
%
corr = struct;
corrx = SoftCorrelator_v2(Vx,'PhCountCorr',timeStep);
corry = SoftCorrelator_v2(Vy,'PhCountCorr',timeStep);
corr.t = corrx.lag;
corry.corrfunc(abs(corry.corrfunc)==inf | isnan(corry.corrfunc))=0;
corrx.corrfunc(abs(corrx.corrfunc)==inf | isnan(corry.corrfunc))=0;
corr.cfun = corrx.corrfunc+corry.corrfunc;
%plot(corrx.lag(2:end), corrx.corrfunc(2:end)+corry.corrfunc(2:end));
%shg
%figure
%scatter(xCoordMat(i,:), yCoordMat(i,:))
end
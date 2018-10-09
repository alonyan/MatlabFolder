j=1
pos =  R.PosNames{j};
function setEpitheliumFitParams(R,pos)
i=1;
CorneaCells = R.getCorneaCellsLbl(pos);
distScore = CorneaCells{i}.Centroids(:,3)-CorneaCells{i}.TopoZ;
[h, Xbins] = histcounts(distScore,50, 'Normalization', 'probability');
Xbins = (Xbins(2:end)+Xbins(1:end-1))/2;
plot(Xbins,h);
shg
title('select gaussian area for lower (epithelium) peak')
pause;
J =InAxes;

hToFit = h(J);
XtoFit = Xbins(J);

%
posit = median(XtoFit)
stdev = std(XtoFit)
amp = max(hToFit)*sqrt(2*pi)*stdev
BETA0 = [amp posit stdev];
[BETA,RESNORM,RESIDUAL,EXITFLAG] = lsqcurvefit(@GaussianFit, BETA0 ,XtoFit, hToFit,[0 -inf 0], [inf inf inf])
x = min(Xbins):0.1:max(Xbins);
if EXITFLAG>=0;
    plot(Xbins, h, '-.', x, GaussianFit(BETA, x));
    figure(gcf)
end
    set(gca,'xlim',[-100,200],'ylim',[0,0.2]);
CorneaCells{i}.FitParam.func = @(x) GaussianFit(BETA, x);
CorneaCells{i}.FitParam.stdev = BETA(3); 
CorneaCells{i}.FitParam.posit = BETA(2);
CorneaCells{i}.FitParam.amp = BETA(1);

%%
for i=2:numel(CorneaCells)
    distScore = CorneaCells{i}.Centroids(:,3)-CorneaCells{i}.TopoZ;

    [h, Xbins] = histcounts(distScore,50,'Normalization', 'probability');
    Xbins = (Xbins(2:end)+Xbins(1:end-1))/2;
    
    J =logical((Xbins>(BETA(2)-2*BETA(3))).*(Xbins<(BETA(2)+BETA(3))));
    
    hToFit = h(J);
    XtoFit = Xbins(J);
    
    %
    posit = median(XtoFit)
    stdev = std(XtoFit)
    amp = max(hToFit)*sqrt(2*pi)*stdev
    BETA0 = [amp posit stdev];
    [BETA,RESNORM,RESIDUAL,EXITFLAG] = lsqcurvefit(@GaussianFit, BETA0 ,XtoFit, hToFit,[0 -inf 0], [inf inf inf])
    x = min(Xbins):0.1:max(Xbins);
    if EXITFLAG>=0;
        plot(Xbins, h, '-.', x, GaussianFit(BETA, x));
        figure(gcf)
    end
    set(gca,'xlim',[-100,200],'ylim',[0,0.2]);
    pause(0.1)
    
    CorneaCells{i}.FitParam.func = @(x) GaussianFit(BETA, x);
    CorneaCells{i}.FitParam.stdev = BETA(3);
    CorneaCells{i}.FitParam.posit = BETA(2);
    CorneaCells{i}.FitParam.amp = BETA(1);
end
R.setCorneaCellsLbl(pos) = CorneaCells;
end
%%Western data from: 12.14.13
%Areas were obtained from imageJ analysis of Western

pSTAT1BandArea=[20357.614 767.962 0 18655.836 3974.246 1287.790 0];
pSTAT1BandArea=reshape(pSTAT1BandArea, 1,7);

GAPDHBandArea=[19884.643 21351.685 20720.359 16474.494 15555.421 15031.421 15271.673];
GAPDHBandArea=reshape(GAPDHBandArea, 1,7);

Total=pSTAT1BandArea+GAPDHBandArea;

PercentofTotal=(pSTAT1BandArea./Total)*100;

RelativeDensity=[PercentofTotal./PercentofTotal(1,1)];

figure()
bar(RelativeDensity)
set(gca, 'fontsize', 25, 'ylim', [0 1.1], 'XTickLabel', {'10nM IFN', 'Media', 'Jaki @T0', '10m post-Jaki', '30m', '45m', '60m'})
set(gcf, 'color', 'w')
title('Decay of pSTAT1 signal post-Jaki')
ylabel('Normalized Band Intensity, (a.u.)')

range=2:5;
time1=[0 10 30 45 60];
decay1=[1.0000 1.0498 0.4023 0.1560 0];
time=time1(range);
decay=decay1(range);

%Estimate lambda for exponential decay 
amp = max(decay);
lambda = 1/[time1*(decay1==median(decay1))'];
%Fit
decay_fit=lsqcurvefit(@Exponent, [amp lambda], time, decay, [0 -inf 0]);

HalfLife=log(2)./lambda;

t=0:0.1:100;
plot(time, decay, 'o', t, Exponent(decay_fit, t), '-k', 'linewidth', 1.5)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 25)
ylabel('pSTAT1 decay')
xlabel('Time post-Jaki, (min)')
title('Fitted pSTAT1 decay')
figure(gcf)
%%
figure()
plot(time, decay, 'o', time, Exponent(decay_fit, time), '-k', 'linewidth', 1.5)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 25)
ylabel('pSTAT1 decay')
xlabel('Time post-Jaki, (min)')
title('Fitted pSTAT1 decay')

%%

% B16 stimulation 24 hours with higher resolution of IFN-g
%12.20.13
%%
%Corresponding MHC fluorescence values for the same experiment
MHC=[4603 3462 2937 930 483 369 395 327 351];

IFNg=[10e-9 2e-9 400e-12 80e-12 16e-12 3.2e-12 640e-15 125e-15 12.5e-15]; %Note that the last 2 (lowest) IFN-g concentrations are actually 0 and 10nM + 10uM Jaki from T0

figure()
hold on
plot(IFNg, MHC, '-ko', 'markerfacecolor', 'b', 'markeredgecolor', 'k', 'markersize', 15)
set(gca, 'Fontsize', 25, 'xscale', 'log', 'yscale', 'log', 'xgrid', 'on', 'ygrid', 'on')
set(gcf, 'color', 'w')
xlabel('[IFN-\gamma], (M)')
ylabel('GMFI H-2K^b')
box on
title('MHC expression at 24 hours')

%normalize MHC to 1
MHC=[MHC-min(MHC)]./max(MHC);

%Estimate EC50 as an initial parameter
a=[IFNg*(MHC==median(MHC))'];

EC50 = lsqcurvefit(@HillFunction, [a], IFNg, MHC, [0 -Inf 0])

%Make sure i doesn't have too many points b/c you'll crash memory
figure()
i=-15:0.01:-5;
i=10.^i;
semilogx(IFNg, MHC, 'o', i, hillfunction(EC50, i), '-k', 'linewidth', 1.5)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 25)
ylabel('Normalized MHC')
xlabel('log[IFN-\gamma], (M)')
title('Fitted MHC')

%%

pSTAT1=[4.7966 2.7605 2.0168 0.6246 0.2804 0.1104 0.1960];
pSTAT1=pSTAT1./max(pSTAT1);
MHC=MHC(1:7);

figure()
hold on
plot(pSTAT1, MHC, 'o', 'markerfacecolor', 'r', 'markeredgecolor', 'k', 'markersize', 8)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 25, 'xscale', 'log', 'yscale', 'log')
xlabel('Normalized pSTAT1 intensity')
ylabel('Normalized MHC')
box on

a=[pSTAT1*(MHC==median(MHC))'];
EC50_2 = lsqcurvefit(@HillFunction, [a], pSTAT1, MHC, [0 -Inf 0])

figure()
i=-3:0.01:1;
i=10.^i;
semilogx(pSTAT1, MHC, 'o', i, hillfunction(EC50_2, i), '-k', 'linewidth', 1.5)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 25)
ylabel('Normalized MHC')
xlabel('Normalized pSTAT1')
title('Fitted MHC')


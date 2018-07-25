% B16 stimulation 24 hours with higher resolution of IFN-g
%12.20.13
%%

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
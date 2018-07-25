%DC B16 IFNg short time-scale stim 1.8.14

gamma=[10e-9 2e-9 400e-12 80e-12 16e-12 3.2e-12 640e-15 0];

B16=[11367 11740 6210 1866 903 642 584 623];

DC=[2212 2003 1176 655 480 413 430 381];

figure()
hold on
plot(gamma, B16, '-ko', 'markerfacecolor', 'r', 'markeredgecolor', 'k', 'markersize', 10)
plot(gamma, DC, '-ko', 'markerfacecolor' ,'b', 'markeredgecolor', 'k', 'markersize', 10)
set(gcf, 'color', 'w')
set(gca, 'xscale', 'log', 'yscale', 'log', 'xgrid', 'on', 'ygrid', 'on', 'fontsize', 25, 'xlim', [1e-13 1e-7], 'ylim', [300 13000])
xlabel('[IFN-\gamma], (M)')
ylabel('GMFI pSTAT1')
legend('B16 Melanoma', 'CD11c+ DC')
box on
title('pSTAT1 response to IFN-\gamma')
%%
gamma=gamma(1:7);
B16=B16(1:7);
DC=DC(1:7);

B16_norm=(B16-min(B16))./max(B16);
DC_norm=(DC-min(DC))./max(DC);

a = (gamma*(B16_norm==median(B16_norm))');
%Estimate EC50 for B16s

EC50 = lsqcurvefit(@hillfunction, [a], gamma, B16_norm, [0 -Inf 0])

i=-15:0.01:-5;
i=10.^i;
semilogx(gamma, B16_norm, 'o', i, hillfunction(EC50, i), '-k', 'linewidth', 1.5)
set(gca, 'color', 'w')
set(gca, 'Fontsize', 25)
ylabel('Normalized pSTAT1')
xlabel('[IFN-\gamma], (M)')
text(40, max(B16_norm)  , ['EC50 =' num2str(EC50) ' EC50'], 'Color', 'k','FontSize',16, 'FontWeight', 'bold');
title('Fitted pSTAT1 signal')
figure(gcf)
%B16-OT1 coculture + IFN-g R blocking antibodies
%Pulsed B16 melanoma cells with 100nM Ova then mixed 10e5 B16 with 10e5
%CFSE-labeled naive OT-1.  Timepoints and stained for: MHC, Ova, CD8,
%CD25

%%

%condition A = 10e5 Ova-Pulsed B16 + 10e5 CFSE labeled naive OT1
%condition B = 10e5 UNPULSED B16 + 10e5 CFSE labeled naive OT1 
%condition C = 10e5 Ova-Pulsed B16 + 10e5 CFSE labeled naive OT1 + 10ug/mL
%anti-IFN-gR

A_MHC=[5052 18115 19469 19244 14976];
B_MHC=[445 616 607 505 865];
C_MHC=[2539 18346 16838 16089 15486];

A_OVA=[1140 3824 5936 5034 3641];
B_OVA=[947 875 757 890 858];
C_OVA=[886 4423 4261 3200 3573];

time=[12 24 36 48 60];

Ratio_A=A_MHC./A_OVA;
Ratio_B=B_MHC./B_OVA;

figure()
hold on
plot(time, Ratio_A, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
plot(time, Ratio_B, '-ko', 'markeredgecolor', 'k', 'markerfacecolor' ,'k', 'markersize', 10)
set(gca, 'Fontsize', 20, 'xgrid', 'on', 'ygrid', 'on')
set(gcf, 'color', 'w')
xlabel('Time, (hours)')
ylabel('Ratio H-2K^b/K^b-Ova ')
legend('+10nM IFN-\gamma', 'media control')
box on

figure()
subplot(1,3,1)
hold on
plot(time, A_MHC, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
plot(time, B_MHC, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'k', 'markersize', 10)
plot(time, C_MHC, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
set(gca, 'Fontsize', 20, 'yscale', 'log', 'ygrid', 'on', 'xgrid', 'on')
set(gcf, 'color', 'w')
xlabel('Time, (hours)')
ylabel('log H-2K^b GMFI')
title('MHC expression')
legend('+10nM IFN-\gamma', 'media control', '+10nM IFN-\gamma+\alpha-IFN-\gammaR' )
box on
subplot(1,3,2)
hold on
plot(time, A_OVA, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
plot(time, B_OVA, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'k', 'markersize', 10)
plot(time, C_OVA, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
set(gca, 'Fontsize', 20, 'yscale', 'log', 'ygrid', 'on', 'xgrid', 'on')
set(gcf, 'color', 'w')
xlabel('Time, (hours)')
ylabel('log H-2K^b GMFI')
title('\alpha-Ova staining')
box on
subplot(1,3,3)
hold on
plot(A_MHC, A_OVA, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
plot(B_MHC, B_OVA, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'k', 'markersize', 10)
plot(C_MHC, C_OVA, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
set(gca, 'Fontsize', 20, 'yscale', 'log', 'xscale', 'log', 'ygrid', 'on', 'xgrid', 'on')
set(gcf, 'color', 'w')
ylabel('log Ova GMFI')
xlabel('log H-2K^b GMFI')
title('MHC staining versus \alpha-Ova')
box on

A_CD25=[5.82 34.2 55.9 49.8 55.5];
B_CD25=[0.516 0.94 1.18 0.633 0.664];
C_CD25=[3.64 53 62.1 61.5 49.6];

figure()
hold on
plot(time, A_CD25, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
plot(time, B_CD25, '-ko', 'markeredgecolor', 'k', 'markerfacecolor' ,'k', 'markersize', 10)
plot(time, C_CD25, '-ko', 'markeredgecolor', 'k', 'markerfacecolor' ,'b', 'markersize', 10)
set(gca, 'Fontsize', 20, 'xgrid', 'on', 'ygrid', 'on')
set(gcf, 'color', 'w')
xlabel('Time, (hours)')
ylabel('%CD25+')
legend('+10nM IFN-\gamma', 'media control', '+10nM IFN-\gamma+\alpha-IFN-\gammaR')
box on


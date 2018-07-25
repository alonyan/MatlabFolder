%Unpulsed B16 Kb-Ova control
%To test the bacground of Kb-Ova, exposed B16 cells to high dose of IFN-g
%(10nM), and then stained for Kb-Ova and H-2Kb. 

%%

%condition A = 10e5 B16 + 10nM IFN-g UNPULSED
%condition B = 10e5 B16 - IFN-g UNPULSED
%condition C = 10e5 B16 + 10nM IFN-g + 10ug/mL anti-IFN-gR UNPULSED

A_MHC=[7585 32363 36620 30382 32561];
B_MHC=[589 724 943 826 464];
C_MHC=[7579 24064 26692 26253 23612];

A_OVA=[995 5242 7239 6609 6658];
B_OVA=[961 854 905 821 851];
C_OVA=[1215 3932 5156 4114 4450];

ratio_A=A_MHC./A_OVA;
ratio_B=B_MHC./B_OVA;

blockratio=A_MHC./C_MHC;
blockratio_OVA=A_OVA./C_OVA;

time=[12 24 36 48 60];

figure
plot(time, blockratio, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
set(gca, 'Fontsize', 20, 'ygrid', 'on', 'xgrid', 'on')
set(gcf, 'color', 'w')
xlabel('Time, (hours)')
ylabel('Ratio MHC exp. non-block/block')
box on

figure
plot(time, blockratio_OVA, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
set(gca, 'Fontsize', 20, 'ygrid', 'on', 'xgrid', 'on')
set(gcf, 'color', 'w')
xlabel('Time, (hours)')
ylabel('Ratio Ova non-block/block')

figure()
hold on
plot(time, ratio_A, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
plot(time, ratio_B, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'k', 'markersize', 10)
set(gca, 'Fontsize', 20, 'ygrid', 'on', 'xgrid', 'on')
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





%GeoMFI of H2kb for gated APCs with no exogenously supplied IFN-g

N1P1=[5878 3468 3360 3786 3103 2392]; Norm_N1P1=N1P1./6398;
N1P2=[6398 3007 3331 3688 3085 2316]; Norm_N1P2=N1P2./6398;
N1P3=[6231 2989 3137 3620 3234 2346]; Norm_N1P3=N1P3./6398;

N2P1=[5878 2735 2967 3354 2704 2353]; Norm_N2P1=N2P1./6398;
N2P2=[6398 2739 3009 3120 2758 2493]; Norm_N2P2=N2P1./6398;
N2P3=[6231 2782 2837 2957 2541 2394]; Norm_N2P3=N2P3./6398;

N3P1=[5878 2509 2540 2491 2306 2223]; Norm_N3P1=N3P1./6398;
N3P2=[6398 2514 2489 2462 1989 1616]; Norm_N3P2=N3P2./6398;
N3P3=[6231 2395 2532 2153 2071 1591]; Norm_N3P3=N3P3./6398;

t=[0 9 17 25 32.5 41];

figure()
subplot(1,3,1)
hold on
plot(t, N1P1, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
plot(t, N2P1, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
plot(t, N3P1, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 10)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 20, 'ylim', [1000 6500], 'xgrid', 'on', 'ygrid', 'on', 'ytick', [1000 2000 3000 4000 5000 6000])
xlabel('Time, (hours)')
ylabel('MFI H-2kb')
legend('10e5 OT-1', '10e4 OT-1', '10e3 OT-1')
title('100nM OVA')
box on
subplot(1,3,2)
hold on
plot(t, N1P2, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
plot(t, N2P2, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
plot(t, N3P2, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 10)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 20, 'ylim', [1000 6500], 'xgrid', 'on', 'ygrid', 'on', 'ytick', [1000 2000 3000 4000 5000 6000])
xlabel('Time, (hours)')
ylabel('MFI H-2kb')
title('10nM OVA')
box on
subplot(1,3,3)
hold on
plot(t, N1P3, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
plot(t, N2P3, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
plot(t, N3P3, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 10)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 20, 'ylim', [1000 6500], 'xgrid', 'on', 'ygrid', 'on', 'ytick', [1000 2000 3000 4000 5000 6000])
xlabel('Time, (hours)')
ylabel('MFI H-2kb')
title('1nM OVA')
box on

figure()
subplot(1,3,1)
hold on
plot(t, N1P1, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
plot(t, N1P2, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
plot(t, N1P3, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 10)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 20, 'ylim', [1000 6500], 'xgrid', 'on', 'ygrid', 'on', 'ytick', [1000 2000 3000 4000 5000 6000])
xlabel('Time, (hours)')
ylabel('MFI H-2kb')
legend('100nM OVA', '10nM OVA', '1nM OVA')
title('10e5 OT-1')
box on
subplot(1,3,2)
hold on
plot(t, N2P1, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
plot(t, N2P2, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
plot(t, N2P3, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 10)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 20, 'ylim', [1000 6500], 'xgrid', 'on', 'ygrid', 'on', 'ytick', [1000 2000 3000 4000 5000 6000])
xlabel('Time, (hours)')
ylabel('MFI H-2kb')
title('10e4 OT-1')
box on
subplot(1,3,3)
hold on
plot(t, N3P1, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
plot(t, N3P2, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
plot(t, N3P3, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 10)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 20, 'ylim', [1000 6500], 'xgrid', 'on', 'ygrid', 'on', 'ytick', [1000 2000 3000 4000 5000 6000])
xlabel('Time, (hours)')
ylabel('MFI H-2kb')
title('10e3 OT-1')
box on

%%

% Percent ova+ of apc's

N1P1=[98.8 87 62.2 71.2 69.9 58]; Norm_N1P1_O=N1P1./98.8;
N1P2=[94.8 59.2 54.7 62.4 65.4 50.7]; Norm_N1P2_O=N1P2./98.8;
N1P3=[70.4 49.7 47.1 56.4 60.7 52]; Norm_N1P3_O=N1P3./98.8;

N2P1=[98.8 96.7 75.8 75.6 77 71.7]; Norm_N2P1_O=N2P1./98.8;
N2P2=[94.8 67.6 66.5 70.1 73.3 69]; Norm_N2P2_O=N2P2./98.8;
N2P3=[70.4 56.8 58.4 64.3 70.4 65.5]; Norm_N2P3_O=N2P3./98.8;

N3P1=[98.8 97.1 76 74.9 75.5 72.7]; Norm_N3P1_O=N3P1./98.8;
N3P2=[94.8 68.1 66.2 68.4 73.5 65.4]; Norm_N3P2_O=N3P2./98.8;
N3P3=[70.4 50.7 58.2 60.3 67.8 58.4]; Norm_N3P3_O=N3P3./98.8;

t=[0 9 17 25 32.5 41];
figure()
subplot(1,3,1)
hold on
plot(t, N1P1, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
plot(t, N2P1, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
plot(t, N3P1, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 10)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 20, 'xgrid', 'on', 'ygrid', 'on', 'ylim', [40 100])
xlabel('Time, (hours)')
ylabel('%OVA+ of APCs')
legend('10e5 OT-1', '10e4 OT-1', '10e3 OT-1')
title('100nM OVA')
box on
subplot(1,3,2)
hold on
plot(t, N1P2, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
plot(t, N2P2, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
plot(t, N3P2, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 10)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 20, 'xgrid', 'on', 'ygrid', 'on', 'ylim', [40 100])
xlabel('Time, (hours)')
ylabel('%OVA+ of APCs')
title('10nM OVA')
box on
subplot(1,3,3)
hold on
plot(t, N1P3, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
plot(t, N2P3, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
plot(t, N3P3, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 10)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 20, 'xgrid', 'on', 'ygrid', 'on', 'ylim', [40 100])
xlabel('Time, (hours)')
ylabel('%OVA+ of APCs')
title('1nM OVA')
box on

figure()
subplot(1,3,1)
hold on
plot(t, N1P1, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
plot(t, N1P2, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
plot(t, N1P3, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 10)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 20, 'xgrid', 'on', 'ygrid', 'on', 'ylim', [40 100])
xlabel('Time, (hours)')
ylabel('%OVA+ of APCs')
legend('100nM OVA', '10nM OVA', '1nM OVA')
title('10e5 OT-1')
box on
subplot(1,3,2)
hold on
plot(t, N2P1, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
plot(t, N2P2, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
plot(t, N2P3, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 10)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 20, 'xgrid', 'on', 'ygrid', 'on', 'ylim', [40 100])
xlabel('Time, (hours)')
ylabel('%OVA+ of APCs')
title('10e4 OT-1')
box on
subplot(1,3,3)
hold on
plot(t, N3P1, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
plot(t, N3P2, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
plot(t, N3P3, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 10)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 20, 'xgrid', 'on', 'ygrid', 'on', 'ylim', [40 100])
xlabel('Time, (hours)')
ylabel('%OVA+ of APCs')
title('10e3 OT-1')
box on

%%

%Normalized both OVa percentages and MFI of APC to 1 and will plot them
%versus each other.  Does a high APC mean also high OVA?

figure()
subplot(1,3,1)
hold on
plot(Norm_N1P1, Norm_N1P1_O, 'o', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
plot(Norm_N2P1, Norm_N2P1_O, 'o', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
plot(Norm_N3P1, Norm_N3P1_O, 'o', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 10)
set(gca, 'Fontsize', 20)
set(gcf, 'color', 'w')
ylabel('Normalized OVA')
xlabel('Normalized H-2Kb')
legend('10e5 OT-1', '10e4 OT-1', '10e3 OT-1')
box on
title('100nM OVA')
subplot(1,3,2)
hold on
plot(Norm_N1P2, Norm_N1P2_O, 'o', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
plot(Norm_N2P2, Norm_N2P2_O, 'o', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
plot(Norm_N3P2, Norm_N3P2_O, 'o', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 10)
set(gca, 'Fontsize', 20)
set(gcf, 'color', 'w')
ylabel('Normalized OVA')
xlabel('Normalized H-2Kb')
box on
title('10nM OVA')
subplot(1,3,3)
hold on
plot(Norm_N1P3, Norm_N1P3_O, 'o', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
plot(Norm_N2P3, Norm_N2P3_O, 'o', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
plot(Norm_N3P3, Norm_N3P3_O, 'o', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 10)
set(gca, 'Fontsize', 20)
set(gcf, 'color', 'w')
ylabel('Normalized OVA')
xlabel('Normalized H-2Kb')
box on
title('1nM OVA')

%%

% Added exogenous IFN-gamma at T0.  H-2Kb MFI

P1_gamma1=[5878 3278 3654 3389 3021 2793];
P2_gamma1=[6398 3211 3514 3620 3066 2586];
P3_gamma1=[6231 2994 3374 2723 2637 2661];

P1_gamma2=[5878 3391 3526 3457 3035 2701];
P2_gamma2=[6398 3297 3603 3569 3023 2629];
P3_gamma2=[6231 2909 3283 2589 2490 2823];

%plot gamma 1 (10nM)
figure()
subplot(1,3,1)
hold on
plot(t, P1_gamma1, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
plot(t, N1P1, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
set(gca, 'Fontsize', 20, 'ylim', [2000 6500], 'xgrid', 'on', 'ygrid', 'on')
set(gcf, 'color', 'w')
ylabel('H-2Kb MFI')
xlabel('Time, (hours)')
box on
title('100nM OVA - 10nM gamma')
legend('+IFN-g', 'Endog')
subplot(1,3,2)
hold on
plot(t, P2_gamma1, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
plot(t, N1P2, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
set(gca, 'Fontsize', 20, 'ylim', [2000 6500], 'xgrid', 'on', 'ygrid', 'on')
set(gcf, 'color', 'w')
ylabel('H-2Kb MFI')
xlabel('Time, (hours)')
box on
title('10nM OVA - 10nM gamma')
subplot(1,3,3)
hold on
plot(t, P3_gamma1, '-ko','markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
plot(t, N1P3, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
set(gca, 'Fontsize', 20, 'ylim', [2000 6500], 'xgrid', 'on', 'ygrid', 'on')
set(gcf, 'color', 'w')
ylabel('H-2Kb MFI')
xlabel('Time, (hours)')
box on
title('1nM OVA - 10nM gamma')

%plot gamma 2 (1nM)
figure()
subplot(1,3,1)
hold on
plot(t, P1_gamma2, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
plot(t, N1P1, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
set(gca, 'Fontsize', 20, 'ylim', [2000 6500], 'xgrid', 'on', 'ygrid', 'on')
set(gcf, 'color', 'w')
ylabel('H-2Kb MFI')
xlabel('Time, (hours)')
box on
title('100nM OVA - 1nM gamma')
legend('+IFN-g', 'Endog')
subplot(1,3,2)
hold on
plot(t, P2_gamma2, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
plot(t, N1P2, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
set(gca, 'Fontsize', 20, 'ylim', [2000 6500], 'xgrid', 'on', 'ygrid', 'on')
set(gcf, 'color', 'w')
ylabel('H-2Kb MFI')
xlabel('Time, (hours)')
box on
title('10nM OVA - 1nM gamma')
subplot(1,3,3)
hold on
plot(t, P3_gamma2, '-ko','markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
plot(t, N1P3, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
set(gca, 'Fontsize', 20, 'ylim', [2000 6500], 'xgrid', 'on', 'ygrid', 'on')
set(gcf, 'color', 'w')
ylabel('H-2Kb MFI')
xlabel('Time, (hours)')
box on
title('1nM OVA - 1nM gamma')

%%
% Added exogenous IFN-gamma at T0.  percent OVA+ of H-2Kb+

P1_gamma1=[98.8 81.8 64.5 66 68.7 59.8];
P2_gamma1=[94.8 60.6 54.8 59.4 61.3 54.2];
P3_gamma1=[70.4 49.4 51.4 52.9 59.6 57.2];

P1_gamma2=[98.8 81.1 63.7 64.8 70.9 63.1];
P2_gamma2=[94.8 59.5 54.6 59 60.3 51];
P3_gamma2=[70.4 49 51.4 53.7 59.7 56.8];

%plot gamma 1 (10nM)
figure()
subplot(1,3,1)
hold on
plot(t, P1_gamma1, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
plot(t, N1P1, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
set(gca, 'Fontsize', 20, 'xgrid', 'on', 'ygrid', 'on')
set(gcf, 'color', 'w')
ylabel('%OVA+')
xlabel('Time, (hours)')
box on
title('100nM OVA - 10nM gamma')
legend('+IFN-g', 'Endog')
subplot(1,3,2)
hold on
plot(t, P2_gamma1, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
plot(t, N1P2, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
set(gca, 'Fontsize', 20, 'xgrid', 'on', 'ygrid', 'on')
set(gcf, 'color', 'w')
ylabel('%OVA+')
xlabel('Time, (hours)')
box on
title('10nM OVA - 10nM gamma')
subplot(1,3,3)
hold on
plot(t, P3_gamma1, '-ko','markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
plot(t, N1P3, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
set(gca, 'Fontsize', 20, 'xgrid', 'on', 'ygrid', 'on')
set(gcf, 'color', 'w')
ylabel('%OVA+')
xlabel('Time, (hours)')
box on
title('1nM OVA - 10nM gamma')

%plot gamma 2 (1nM)
figure()
subplot(1,3,1)
hold on
plot(t, P1_gamma2, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
plot(t, N1P1, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
set(gca, 'Fontsize', 20, 'xgrid', 'on', 'ygrid', 'on')
set(gcf, 'color', 'w')
ylabel('%OVA+')
xlabel('Time, (hours)')
box on
title('100nM OVA - 1nM gamma')
legend('+IFN-g', 'Endog')
subplot(1,3,2)
hold on
plot(t, P2_gamma2, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
plot(t, N1P2, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
set(gca, 'Fontsize', 20, 'xgrid', 'on', 'ygrid', 'on')
set(gcf, 'color', 'w')
ylabel('%OVA+')
xlabel('Time, (hours)')
box on
title('10nM OVA - 1nM gamma')
subplot(1,3,3)
hold on
plot(t, P3_gamma2, '-ko','markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
plot(t, N1P3, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
set(gca, 'Fontsize', 20,'xgrid', 'on', 'ygrid', 'on')
set(gcf, 'color', 'w')
ylabel('%OVA+')
xlabel('Time, (hours)')
box on
title('1nM OVA - 1nM gamma')






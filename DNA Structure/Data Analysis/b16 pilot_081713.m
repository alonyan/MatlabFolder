%Experiment - B16 melanoma cell line pulsed with OVA & dose response of
%IFN-gamma.  Timepoints taken roughly every 8 hours out until 24 hours.  

%H-2Kb MFI 

T1=[1183 1236 1054 915 674 621 606  
    1361 1297 1053 763 659 591 630];
e1=std(T1);
T1=mean(T1);

Unpulsed1=[622 576]
eu1=std(Unpulsed1);
Tu1=mean(Unpulsed1);

T2=[1818 1757 1380 822 605 555 579 
    2067 1931 1313 891 583 539 558];
e2=std(T2);
T2=mean(T2);

Unpulsed2=[577 594];
eu2=std(Unpulsed2);
Tu2=mean(Unpulsed2);

T3=[2696 2604 1692 1031 638 534 573
    5585 2754 2091 1152 613 588 555];
e3=std(T3);
T3=mean(T3);

Unpulsed3=[679 617];
eu3=std(Unpulsed3);
Tu3=mean(Unpulsed3);

gamma=[10e-9 1e-9 100e-12 10e-12 1e-12 100e-15 0];
time=[8 19 28];

figure()
subplot(1,3,1)
hold on
errorbar(gamma, T1, e1, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 8)
errorbar(10e-15, Tu1, eu1, '-ko', 'markersize', 8)
set(gca, 'Fontsize', 20, 'xscale', 'log','ylim', [500 6000], 'ytick', [500 1000 2000 3000 4000 5000 6000])
set(gcf, 'color', 'w')
xlabel('[IFN-\gamma], (M)')
ylabel('H-2Kb GMFI')
title('T1 - 8 hours')
legend('Ova-pulsed', 'Unpulsed')
box on
subplot(1,3,2)
hold on
errorbar(gamma, T2, e2, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 8)
errorbar(10e-15, Tu2, eu2, '-ko', 'markersize', 8)
set(gca, 'Fontsize', 20, 'xscale', 'log', 'ylim', [500 6000], 'ytick', [500 1000 2000 3000 4000 5000 6000])
set(gcf, 'color', 'w')
xlabel('[IFN-\gamma], (M)')
ylabel('H-2Kb GMFI')
title('T2 - 19 hours')
box on
subplot(1,3,3)
hold on
errorbar(gamma, T3, e3, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 8)
errorbar(10e-15, Tu3, eu3, '-ko', 'markersize', 8)
set(gca, 'Fontsize', 20, 'xscale', 'log', 'ylim', [500 6000], 'ytick', [500 1000 2000 3000 4000 5000 6000])
set(gcf, 'color', 'w')
xlabel('[IFN-\gamma], (M)')
ylabel('H-2Kb GMFI')
title('T2 - 19 hours')
box on

gamma1=[T1(:,1), T2(:,1), T3(:,1)]; gamma2=[T1(:,2), T2(:,2), T3(:,2)]; gamma3=[T1(:,3), T2(:,3), T3(:,3)];
gamma4=[T1(:,4), T2(:,4), T3(:,4)]; gamma5=[T1(:,5), T2(:,5), T3(:,5)]; gamma6=[T1(:,6), T2(:,6), T3(:,6)];
gamma7=[T1(:,7), T2(:,7), T3(:,7)]; unpulsed=[Tu1, Tu2, Tu3];

eg1=[e1(:,1), e2(:,1), e3(:,1)]; eg2=[e1(:,2), e2(:,2), e3(:,2)]; eg3=[e1(:,3), e2(:,3), e3(:,3)];
eg4=[e1(:,4), e2(:,4), e3(:,4)]; eg5=[e1(:,5), e2(:,5), e3(:,5)]; eg6=[e1(:,6), e2(:,6), e3(:,6)];
eg7=[e1(:,7), e2(:,7), e3(:,7)]; eunpulsed=[eu1, eu2, eu3];

figure()
hold on
errorbar(time, gamma1, eg1, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 8)
errorbar(time, gamma2, eg2, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', [1 0.5 0.2], 'markersize', 8)
errorbar(time, gamma3, eg3, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 8)
errorbar(time, gamma4, eg4, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'g', 'markersize', 8)
errorbar(time, gamma5, eg5, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 8)
errorbar(time, gamma6, eg6, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'c', 'markersize', 8)
errorbar(time, gamma7, eg7, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'k', 'markersize', 8)
errorbar(time, unpulsed, eunpulsed, '-ko', 'markersize', 8)
set(gca, 'Fontsize', 20, 'ylim', [500 6000],'ytick', [500 1000 2000 3000 4000 5000 6000])
set(gcf, 'color', 'w')
xlabel('Time, (hours)')
ylabel('H-2Kb GMFI')
legend('10nM IFN-\gamma', '1nM', '100pM', '10pM', '1pM', '100fM', '0', 'Unpulsed')
title('Change in MHC expression over time')
box on


%%
%Percent Ova+  

T1=[34.5 42.7 35.3 33.8 28.6 23.9 26.7
    46.8 45.9 38.9 29.2 30.9 22.7 28.2];
e1=std(T1);
T1=mean(T1);

Unpulsed1=[0.637 1.17];
eu1=std(Unpulsed1);
Tu1=mean(Unpulsed1);

T2=[6.99 7.55 5.64 5.36 5.75 4.65 6.01
    8.07 8.91 5.61 4.82 4.79 3.64 5.09];
e2=std(T2);
T2=mean(T2);

Unpulsed2=[3.73  4.1];
eu2=std(Unpulsed2);
Tu2=mean(Unpulsed2);

T3=[4.63 5.06 3.31 2.88 3.95 2.44 3.26
    7.41 3.87 2.43 2.23 1.89 3.71 2.76];
e3=std(T3);
T3=mean(T3);

Unpulsed3=[0.808 2.19];
eu3=std(Unpulsed3);
Tu3=mean(Unpulsed3);

gamma=[10e-9 1e-9 100e-12 10e-12 1e-12 100e-15 0];

figure()
subplot(1,3,1)
hold on
errorbar(gamma, T1, e1, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 8)
errorbar(10e-15, Tu1, eu1, '-ko', 'markersize', 8)
set(gca, 'Fontsize', 20, 'xscale', 'log')
set(gcf, 'color', 'w')
xlabel('[IFN-\gamma], (M)')
ylabel('%Ova+')
title('T1 - 8 hours')
legend('Ova-pulsed', 'Unpulsed')
box on
subplot(1,3,2)
hold on
errorbar(gamma, T2, e2, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 8)
errorbar(10e-15, Tu2, eu2, '-ko', 'markersize', 8)
set(gca, 'Fontsize', 20, 'xscale', 'log', 'ylim', [0 50])
set(gcf, 'color', 'w')
xlabel('[IFN-\gamma], (M)')
ylabel('%Ova+')
title('T2 - 19 hours')
box on
subplot(1,3,3)
hold on
errorbar(gamma, T3, e3, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 8)
errorbar(10e-15, Tu3, eu3, '-ko', 'markersize', 8)
set(gca, 'Fontsize', 20, 'xscale', 'log', 'ylim', [0 50])
set(gcf, 'color', 'w')
xlabel('[IFN-\gamma], (M)')
ylabel('%Ova+')
title('T2 - 19 hours')
box on

gamma1=[T1(:,1), T2(:,1), T3(:,1)]; gamma2=[T1(:,2), T2(:,2), T3(:,2)]; gamma3=[T1(:,3), T2(:,3), T3(:,3)];
gamma4=[T1(:,4), T2(:,4), T3(:,4)]; gamma5=[T1(:,5), T2(:,5), T3(:,5)]; gamma6=[T1(:,6), T2(:,6), T3(:,6)];
gamma7=[T1(:,7), T2(:,7), T3(:,7)]; unpulsed=[Tu1, Tu2, Tu3];

eg1=[e1(:,1), e2(:,1), e3(:,1)]; eg2=[e1(:,2), e2(:,2), e3(:,2)]; eg3=[e1(:,3), e2(:,3), e3(:,3)];
eg4=[e1(:,4), e2(:,4), e3(:,4)]; eg5=[e1(:,5), e2(:,5), e3(:,5)]; eg6=[e1(:,6), e2(:,6), e3(:,6)];
eg7=[e1(:,7), e2(:,7), e3(:,7)]; eunpulsed=[eu1, eu2, eu3];

figure()
hold on
errorbar(time, gamma1, eg1, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 8)
errorbar(time, gamma2, eg2, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', [1 0.5 0.2], 'markersize', 8)
errorbar(time, gamma3, eg3, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 8)
errorbar(time, gamma4, eg4, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'g', 'markersize', 8)
errorbar(time, gamma5, eg5, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 8)
errorbar(time, gamma6, eg6, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'c', 'markersize', 8)
errorbar(time, gamma7, eg7, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'k', 'markersize', 8)
errorbar(time, unpulsed, eunpulsed, '-ko', 'markersize', 8)
set(gca, 'Fontsize', 20)
set(gcf, 'color', 'w')
xlabel('Time, (hours)')
ylabel('%Ova+')
legend('10nM IFN-\gamma', '1nM', '100pM', '10pM', '1pM', '100fM', '0', 'Unpulsed')
title('Change in Ova presentation over time')
box on
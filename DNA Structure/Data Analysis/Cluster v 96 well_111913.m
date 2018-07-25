%Cluster versus 96 well plate Th1/Th2 experiment 11.19.13

%%

%Plot Different populations for 96 well versus cluster

Time=[1 2 3 4 5 6];

DN_96=[27.4 28.4 5.67 4.43 1.75 1.61];
Tbetpos_96=[48.9 38.5 40.2 34.8 31 27.5];
Gata3pos_96=[6.53 6.2 1.09 0.613 0.2 0.308];
DP_96=[17.1 26.9 53 60.2 67.1 70.5];

DN_cluster=[70.1 66.5 69.9 59.7 45.5 36.7];
Tbetpos_cluster=[20.1 16.6 11.3 15.1 19 19.1];
Gata3pos_cluster=[5.33 8.91 10.1 7.66 4.96 3.6];
DP_cluster=[4.41 7.93 8.77 17.6 30.5 40.7];

figure()
subplot(1,2,1)
hold on
plot(Time, DN_96, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'w', 'markersize', 10)
plot(Time, Tbetpos_96, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
plot(Time, Gata3pos_96, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'g', 'markersize', 10)
plot(Time, DP_96, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'k', 'markersize', 10)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 25, 'xgrid', 'on', 'ygrid', 'on')
xlabel('Time, (days)')
ylabel('% of CD4+')
legend('Double Negative', 'Tbet^+', 'Gata3^+', 'Double Positive')
title('96 well')
box on
subplot(1,2,2)
hold on
plot(Time, DN_cluster, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'w', 'markersize', 10)
plot(Time, Tbetpos_cluster, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
plot(Time, Gata3pos_cluster, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'g', 'markersize', 10)
plot(Time, DP_cluster, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'k', 'markersize', 10)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 25, 'xgrid', 'on', 'ygrid', 'on')
xlabel('Time, (days)')
ylabel('% of CD4+')
title('Cluster')
box on

%%

%Plot the pSTAT1 levels for different quadrants

Time=[1 2 3 4 5 6];

DN_96=[448 505 702 724 587 577];
Tbetpos_96=[1046 680 903 1213 1440 1506];
Gata3pos_96=[630 581 783 891 801 606];
DP_96=[1115 775 1163 1493 1899 2161];

DN_cluster=[616 470 417 374 419 436];
Tbetpos_cluster=[1091 843 681 663 712 740];
Gata3pos_cluster=[672 546 497 463 520 490];
DP_cluster=[1271 978 921 934 1093 1166];

figure()
subplot(1,2,1)
hold on
plot(Time, DN_96, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
plot(Time, Tbetpos_96, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
plot(Time, Gata3pos_96, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'g', 'markersize', 10)
plot(Time, DP_96, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'k', 'markersize', 10)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 25, 'xgrid', 'on', 'ygrid', 'on', 'yscale', 'log')
xlabel('Time, (days)')
ylabel('log GMFI pSTAT1')
legend('Double Negative', 'Tbet^+', 'Gata3^+', 'Double Positive')
title('96 well')
box on
subplot(1,2,2)
hold on
plot(Time, DN_cluster, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
plot(Time, Tbetpos_cluster, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
plot(Time, Gata3pos_cluster, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'g', 'markersize', 10)
plot(Time, DP_cluster, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'k', 'markersize', 10)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 25, 'xgrid', 'on', 'ygrid', 'on', 'yscale', 'log')
xlabel('Time, (days)')
ylabel('log GMFI pSTAT1')
title('Cluster')
box on

%%

%Plot the pSTAT6 levels for different quadrants

Time=[1 2 3 4 5 6];

DN_96=[1376 680 602 630 626 550];
Tbetpos_96=[2893 999 818 1130 1366 1455];
Gata3pos_96=[2054 846 672 789 548 721];
DP_96=[3173 1111 1099 1430 1826 2060];

DN_cluster=[2435 949 574 535 629 632];
Tbetpos_cluster=[4101 2046 810 714 733 749];
Gata3pos_cluster=[2894 1049 599 579 626 663];
DP_cluster=[4466 2338 975 957 1060 1155];

figure()
subplot(1,2,1)
hold on
plot(Time, DN_96, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'w', 'markersize', 10)
plot(Time, Tbetpos_96, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
plot(Time, Gata3pos_96, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'g', 'markersize', 10)
plot(Time, DP_96, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'k', 'markersize', 10)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 25, 'xgrid', 'on', 'ygrid', 'on', 'yscale', 'log')
xlabel('Time, (days)')
ylabel('log GMFI pSTAT6')
legend('Double Negative', 'Tbet^+', 'Gata3^+', 'Double Positive')
title('96 well')
box on
subplot(1,2,2)
hold on
plot(Time, DN_cluster, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'w', 'markersize', 10)
plot(Time, Tbetpos_cluster, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
plot(Time, Gata3pos_cluster, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'g', 'markersize', 10)
plot(Time, DP_cluster, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'k', 'markersize', 10)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 25, 'xgrid', 'on', 'ygrid', 'on', 'yscale', 'log')
xlabel('Time, (days)')
ylabel('log GMFI pSTAT6')
title('Cluster')
box on
%Analyses of in vivo 12212012
%order is IL2-IC, Jaki, None

CD25per=[42.5
15.4
49.5];

CD25per=reshape(CD25per, 1,3);

CD25GMFI=[619
144
936];
CD25GMFI=reshape(CD25GMFI, 1,3);

pSTAT5GMFI=[743
58
730];
pSTAT5GMFI=reshape(pSTAT5GMFI, 1,3);

CD25pSTAT5=[30.5
1.43
30.1]
CD25pSTAT5=reshape(CD25pSTAT5, 1,3);

%%

figure(1)
subplot(2,2,1)
plot([1 2 3], CD25per, 'o', 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'm', 'MarkerSize', 12)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold')
title('Percent CD25+ of AdTr')
ylabel('%CD25+')
subplot(2,2,2)
plot([1 2 3], CD25GMFI, 'o', 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'y', 'MarkerSize', 12)
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'yscale', 'log')
title('CD25 GMFI of AdTr')
ylabel('log GMFI CD25')
ylim([1e2, 1e4])
subplot(2,2,3)
plot([1 2 3], CD25pSTAT5, 'o', 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'g', 'MarkerSize', 12)
set(gca, 'Fontsize', 16, 'Fontweight', 'bold')
title('Percent CD25+pSTAT5+ of AdTr')
ylabel('%CD25+pSTAT5+')
subplot(2,2,4)
plot([1 2 3], pSTAT5GMFI, 'o', 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'b', 'MarkerSize', 12)
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'yscale', 'log')
title('pSTAT5 GMFI of AdTr')
ylabel('log GMFI pSTAT5')

%%

%percent occupancy by CFSE dilution

IL2=[74.3	23 0 0];
Jaki=[88	2.15 0 0];
None=[65.7	30.8 0 0];

peak=[1 2 3 4];

figure()
hold on
plot(peak, IL2, '-mo', 'linewidth', 2)
plot(peak, Jaki, '-bo', 'linewidth', 2)
plot(peak, None, '-go', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold')
xlabel('CFSE Peak')
ylabel('%AdTr Cells')
title('Percent occupancy of AdTr cells in CFSE peak')
legend('IL2', 'Jaki', 'None')
box on

%%

%Percent of cells that have divided

IL2=23;
Jaki=2.15;
None=30.8;

Percent=[IL2 Jaki None];

figure()
hold on
plot([1 2 3], Percent, 'o', 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'm', 'MarkerSize', 12)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold')
ylabel('% divided')
title('Percent of AdTr cells that have divided')
box on

%%

%IL2-IC response to ex vivo IL2


pSTAT5=[2092
1795
198
369
122
52.8
58.8
-56];

IL2=[10000 1000 100 10 1 0.1 0.01 0];

figure()
hold on
plot(IL2, pSTAT5, '-ko', 'linewidth', 2)
plot([0.01, max(IL2)], [743, 743], '--m', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'xscale', 'log')
ylabel('log GMFI pSTAT5')
xlabel('[IL2], (pM)')
legend('IL2 DR', 'Snapshot')
title('IL2-IC')
box on

%%

%Jaki response to ex vivo IL2


pSTAT5=[1177
1129
-78.3
990
189
213
190
-46.8];

IL2=[10000 1000 100 10 1 0.1 0.01 0];

figure()
hold on
plot(IL2, pSTAT5, '-ko', 'linewidth', 2)
plot([0.01, max(IL2)], [58, 58], '--m', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'xscale', 'log')
ylabel('log GMFI pSTAT5')
xlabel('[IL2], (pM)')
legend('IL2 DR', 'Snapshot')
title('Jaki')
box on

%%

%None response to ex vivo IL2

pSTAT5=[2936
2640
1847
998
221
149
144
-44.8];

IL2=[10000 1000 100 10 1 0.1 0.01 0];

figure()
hold on
plot(IL2, pSTAT5, '-ko', 'linewidth', 2)
plot([0.01, max(IL2)], [730, 730], '--m', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'xscale', 'log')
ylabel('log GMFI pSTAT5')
xlabel('[IL2], (pM)')
legend('IL2 DR', 'Snapshot')
title('None')
box on

%%
%IL2 estimation for IL2-IC

T=2126
B=0
E=118.1


IL2=(690.2-B)./(T-690.2).*E
%%

%IL2 estimation for None

T=2865
B=0
E=50.14

IL2=(586-B)/(T-586).*E

%%
%IL2 backcalculated from pSTAT5 response

figure(1)
hold on
plot([1 2], [56.77, 12.8925], 'o', 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'm', 'MarkerSize', 12)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold')
title('Splenic IL2 backcalculated from pSTAT5')
ylabel('[IL2], (pM)')
box on

%%
%Instead of GMFI, now I'll use percent CD25+pSTAT5+

%IL2-IC
Percent=[26.3
24.3
7.11
17.6
6.98
3.43
5.45
0.405];

IL2=[10000 1000 100 10 1 0.1 0.01 0];

figure()
hold on
plot(IL2, Percent, '-ko', 'linewidth', 2)
plot([0.01, max(IL2)], [30.5, 30.5], '--m', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'xscale', 'log')
ylabel('%pSTAT5+CD25+')
xlabel('[IL2], (pM)')
legend('IL2 DR', 'Snapshot')
title('IL2-IC')
box on

%%

%Jaki

pSTAT5=[13.6
11
0
9.95
6.15
8.11
5.83
1.09];

IL2=[10000 1000 100 10 1 0.1 0.01 0];

figure()
hold on
plot(IL2, pSTAT5, '-ko', 'linewidth', 2)
plot([0.01, max(IL2)], [1.43, 1.43], '--m', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'xscale', 'log')
ylabel('%pSTAT5+CD25+')
xlabel('[IL2], (pM)')
legend('IL2 DR', 'Snapshot')
title('Jaki')
box on

%%

%None

pSTAT5=[36.6
39
30.2
31.4
17.9
12.7
12.5
0.413];

IL2=[10000 1000 100 10 1 0.1 0.01 0];

figure()
hold on
plot(IL2, pSTAT5, '-ko', 'linewidth', 2)
plot([0.01, max(IL2)], [30.1, 30.1], '--m', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'xscale', 'log')
ylabel('%pSTAT5+CD25+')
xlabel('[IL2], (pM)')
legend('IL2 DR', 'Snapshot')
title('None')
box on

%%

%Tregs percent pSTAT5+ for IL2-IC

pSTAT5=[56.5
58.4
5.1
19.7
4.17
3.62
3.66
1.28];

IL2=[10000 1000 100 10 1 0.1 0.01 0];

figure()
hold on
plot(IL2, pSTAT5, '-ko', 'linewidth', 2)
plot([0.01, max(IL2)], [50.4, 50.4], '--m', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'xscale', 'log')
ylabel('%pSTAT5+')
xlabel('[IL2], (pM)')
legend('IL2 DR', 'Snapshot')
title('Tregs, IL2-IC')
box on

%%

%Tregs percent pSTAT5+ for Jaki

pSTAT5=[43.5
48.8
1.5
31.8
18.7
16.6
15.8
4.63];

IL2=[10000 1000 100 10 1 0.1 0.01 0];

figure()
hold on
plot(IL2, pSTAT5, '-ko', 'linewidth', 2)
plot([0.01, max(IL2)], [1.18, 1.18], '--m', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'xscale', 'log')
ylabel('%pSTAT5+')
xlabel('[IL2], (pM)')
legend('IL2 DR', 'Snapshot')
title('Tregs, Jaki')
box on

%%

%Tregs percent pSTAT5+ for None

pSTAT5=[54.7
54
45.8
27.6
6.02
4.96
3.65
0.942];

IL2=[10000 1000 100 10 1 0.1 0.01 0];

figure()
hold on
plot(IL2, pSTAT5, '-ko', 'linewidth', 2)
plot([0.01, max(IL2)], [20.2, 20.2], '--m', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'xscale', 'log')
ylabel('%pSTAT5+')
xlabel('[IL2], (pM)')
legend('IL2 DR', 'Snapshot')
title('Tregs, None')
box on

%%

%Tregs pSTAT5 GMFI for IL2-IC

pSTAT5=[754
768
%33.6
252
94.4
85.4
86.7
50.8];
pSTAT52=pSTAT5-min(pSTAT5)

IL2=[10000 1000 100 10 1 0.1 0.01 0];

figure()
hold on
plot(IL2, pSTAT5, '-ko', 'linewidth', 2)
plot([0.01, max(IL2)], [624, 624], '--m', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'xscale', 'log')
ylabel('GMFI pSTAT5')
xlabel('[IL2], (pM)')
legend('IL2 DR', 'Snapshot')
title('Tregs, IL2-IC')
box on

%%

%Tregs pSTAT5 GMFI for Jaki

pSTAT5=[546
619
%-6.27
395
250
240
236
87.3];
pSTAT52=pSTAT5-min(pSTAT5)

IL2=[10000 1000 100 10 1 0.1 0.01 0];

figure()
hold on
plot(IL2, pSTAT5, '-ko', 'linewidth', 2)
plot([0.01, max(IL2)], [95.7, 95.7], '--m', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'xscale', 'log')
ylabel('GMFI pSTAT5')
xlabel('[IL2], (pM)')
legend('IL2 DR', 'Snapshot')
title('Tregs, IL2-IC')
box on

%%

%Tregs pSTAT5 GMFI for None

pSTAT5=[748
700
571
318
132
114
100
57.6];
pSTAT52=pSTAT5-min(pSTAT5)

IL2=[10000 1000 100 10 1 0.1 0.01 0];

figure()
hold on
plot(IL2, pSTAT5, '-ko', 'linewidth', 2)
plot([0.01, max(IL2)], [414, 414], '--m', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'xscale', 'log')
ylabel('GMFI pSTAT5')
xlabel('[IL2], (pM)')
legend('IL2 DR', 'Snapshot')
title('Tregs, None')
box on

%%

%Treg fits

%IL2 estimation for IL2-IC

T=722
B=0
E=26.26

IL2=(573.2-B)/(T-573.2).*E


%%

%Treg fits

%IL2 estimation for None

T=708.3
B=0
E=22.94

IL2=(356.4-B)/(T-356.4).*E


%%

%Treg IL2 backcalculation

IL2=[6.18 22.65];

figure(1)
hold on
plot([1 2], [101.1575, 23.23], 'o', 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'm', 'MarkerSize', 12)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold')
title('Splenic IL2 backcalculated from Treg pSTAT5')
ylabel('[IL2], (pM)')
box on

%%

%Bead ELISA

GMFIPe=[35641
8048
1525
412
81.9
30.6
21
40
14.7];
Pe2=GMFIPe-min(GMFIPe)

IL2=[3200 800 200 50 12.5 3.12 0.780 0.195 0];

figure()
hold on
plot(IL2, GMFIPe, '-ko', 'linewidth', 2)
plot([0.195, max(IL2)], [554 554], '-m', 'linewidth', 2)
plot([0.195, max(IL2)], [71.2 71.2], '-y', 'linewidth', 2)
plot([0.195, max(IL2)], [125 125], '-b', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'xscale', 'log', 'yscale', 'log')
xlabel('[IL2], (pM)')
ylabel('Log GMFI Pe')
title('Bead ELISA')
legend('Standards', 'IL2-IC', 'Jaki', 'None')
box on

%%

%IL2 from bead elisa


T=80000
B=25
E=3740

IL2_IL2IC=[(554-B)/(T-554).*E]*2
IL2_Jak=[(71.2-B)/(T-71.2).*E]*2
IL2_None=[(125-B)/(T-125).*E]*2

IL2=[IL2_IL2IC, IL2_Jak, IL2_None];

figure()
plot([1 2 3], IL2, 'o', 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'g', 'MarkerSize', 14)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold')
ylabel('Splenic IL2, (pM)')
title('Splenic IL2 from Bead ELISA')
box on

%%

%Compiled IL2 estimations

IL2_Teff=[56.77, NaN, 12.8925];
IL2_Treg=[101.1575, NaN, 23.23];
IL2_ELISA=[49.8064, 4.3235, 9.3646];

%figure()
%hold on
%plot([1 2 3], [56.77, NaN, 12.8295], 'o', 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'm', 'MarkerSize', 14)
%plot([1 2 3], [101.1575, NaN, 23.23], 'o', 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'g', 'MarkerSize', 14)
%plot([1 2 3], [49.8064, 4.3235, 9.3646], 'o', 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'y', 'MarkerSize', 14)
%set(gcf, 'color', 'w')
%set(gca, 'Fontsize', 16, 'Fontweight', 'bold')
%ylabel('[IL2], (pM)')
%legend('IL2 backcalculated from Teff', 'IL2 backcalculated from Treg', 'IL2 from bead ELISA')
%box on
%title('Splenic [IL2] estimates summarized')

%Plotted against one another

figure()
hold on
[AX, H1, H2]=plotyy(IL2_ELISA, IL2_Teff, IL2_ELISA, IL2_Treg)
set(AX(2), 'ylabel', '[IL2] estimates from ELISA', 'fontsize', 16, 'fontweight', 'bold', 'color', 'k')
set(get(AX(2), 'ylabel'), 'string', '[IL2] estimated from ELISA', 'fontsize', 16, 'fontweight', 'bold')
set(H1, 'marker', 'o', 'markersize', 13, 'markeredgecolor', 'k', 'markerfacecolor', 'y')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold')
xlabel('[IL2] estimated from Teff, (pM)')
ylabel('[IL2] estimated from Treg, (pM)')
%%
figure()
hold on
plot(IL2_ELISA, IL2_Teff, 'o', 'Markeredgecolor', 'k', 'Markerfacecolor', 'm', 'markersize', 13)
plot(IL2_ELISA, IL2_Treg, 'o', 'Markeredgecolor', 'k', 'Markerfacecolor', 'y', 'markersize', 13)
plot(IL2_Teff, IL2_Treg, 'o', 'markeredgecolor', 'k', 'markerfacecolor', 'g', 'markersize', 13)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'xlim', [0 110], 'ylim', [0 110])
xlabel('[IL2], (pM)')
ylabel('[IL2], (pM)')
box on
legend('ELISA versus Teff', 'ELISA versus Treg', 'Teff versus Treg')
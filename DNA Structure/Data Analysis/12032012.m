%Percent CD25+ of Adoptively Transferred

WTCD25=[87.8
18.9
3.57];
KOCD25=[93.9
4.08
0.856];

T=[24 48 72];

figure()
hold on
plot(T, WTCD25, '-ro', 'linewidth', 2)
plot(T, KOCD25, '-bo', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold')
ylabel('Percent CD25+ of AdTr')
xlabel('Time post immunization, (hr)')
title('Percentage of AdTr cells CD25+ over time')
legend('WT', 'IL2-/-')
box on
%%
%Percent CD25+/pSTAT5+ of Adoptively Transferred

WTdhi24=[72.5
NaN
53.8
33.3
0
15.8
4.88
0
];


KOdhi24=[82.4
88.2
90.9
47.1
0
0
0
0];


WTdhi48=[13.4
13.9
13.2
4.87
0.512
0.424
0.428
0.384];


KOdhi48=[2.67
3.21
3.16
2.83
2.26
2.22
1.25
1.53];


WTdhi72=[2.53
2.1
2.18
0.603
0.164
0.208
0.122
0.401];


KOdhi72=[0.297
0.293
0.274
0.15
0.0605
0.0439
0.0693
0.0774];



IL2=[10000 1000 100 10 1 0.1 0.01 0];

figure()
subplot(3,1,1)
hold on
plot(IL2, WTdhi24, '-ro', 'linewidth', 2)
plot([0.01 max(IL2)], [18 18], '--r', 'linewidth', 2)
plot(IL2, KOdhi24, '-bo', 'linewidth', 2)
plot([0.01 max(IL2)], [11 11], '--b', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'xscale', 'log')
ylabel('%CD25+pSTAT5+')
xlabel('[IL2], (pM)')
title('Percent of AdTr Cells CD25+pSTAT5+ in response to IL2 at 24 hrs')
legend('WT DR', 'WT SS','IL2-/- DR', 'IL2-/- SS')
box on
subplot(3,1,2)
hold on
plot(IL2, WTdhi48, '-ro', 'linewidth', 2)
plot([0.01 max(IL2)], [9.87 9.87], '--r', 'linewidth', 2)
plot(IL2, KOdhi48, '-bo', 'linewidth', 2)
plot([0.01 max(IL2)], [.344 .344], '--b', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'xscale', 'log')
ylabel('%CD25+pSTAT5+')
xlabel('[IL2], (pM)')
title('Percent of AdTr Cells CD25+pSTAT5+ in response to IL2 at 48 hrs')
box on
subplot(3,1,3)
hold on
plot(IL2, WTdhi72, '-ro', 'linewidth', 2)
plot([0.01 max(IL2)], [0.06 0.06], '--r', 'linewidth', 2)
plot(IL2, KOdhi72, '-bo', 'linewidth', 2)
plot([0.01 max(IL2)], [.261 .261], '--b', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'xscale', 'log')
ylabel('%CD25+pSTAT5+')
xlabel('[IL2], (pM)')
title('Percent of AdTr Cells CD25+pSTAT5+ in response to IL2 at 72 hrs')
box on




%%

%Geometric mean of pSTAT5 of CD25 at 48 hours

WT48=[993
894
748
229
41.9
36.4
37
44.5];


KO48=[1065
1168
866
504
812
412
298
328];


IL2=[10000 1000 100 10 1 0.1 0.01 0];

figure()
hold on
plot(IL2, WT48, '-ro', 'linewidth', 2)
plot(IL2, KO48, '-bo', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'xscale', 'log')
ylabel('GMFI pSTAT5 of CD25+')
xlabel('[IL2], (pM)')
legend('WT', 'IL2KO')
title('GMFI pSTAT5 of CD25+ AdTr 48 hours post immunization')
box on


%%

%Percentage of cells by CFSE dilution

WT24=[77.5	20 0 0 0 0];
KO24=[23.5	76.5 0 0 0 0];

WT48=[0	0	4.98	40.5	51.3	2.56];
KO48=[0	0	22.5	60.2	16.2	6.6];

WT72=[0	0	0.233	2.87	13.4	79.7];
KO72=[0	0	0.0223	0.668	4.11	88.7];

P=[1 2 3 4 5 6];

figure()
subplot(3,1,1)
hold on
plot(P, WT24, '-ro', 'linewidth', 2)
plot(P, KO24, '-bo', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold')
ylabel('%AdTr cells per CFSE peak')
xlabel('CFSE peak')
title('Division of cells for WT and IL2KO at 24 hrs')
legend ('WT', 'IL2KO')
box on
subplot(3,1,2)
hold on
plot(P, WT48, '-ro', 'linewidth', 2)
plot(P, KO48, '-bo', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold')
ylabel('%AdTr cells per CFSE peak')
xlabel('CFSE peak')
title('Division of cells for WT and IL2KO at 48 hrs')
box on
subplot(3,1,3)
hold on
plot(P, WT72, '-ro', 'linewidth', 2)
plot(P, KO72, '-bo', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold')
ylabel('%AdTr cells per CFSE peak')
xlabel('CFSE peak')
title('Division of cells for WT and IL2KO at 72 hrs')
box on

%%
%24

pSTAT524=[18];



T=71.5;
B=6.216;
EC50=22.56;

IL224=(pSTAT524-B)./(T-pSTAT524).*EC50
%%
%48
pSTAT548=[9.87];

T=13.65;
B=.4164;
EC50=14.69;

IL248=(pSTAT548-B)./(T-pSTAT548).*EC50

%%

pSTAT572=[0.06];

T=2.321;
B=.1608;
EC50=22;

IL272=(pSTAT572-B)./(T-pSTAT572).*EC50



%%

%Treg analysis (GMFI pSTAT5 of Treg compartment)

KO24=[221
163
150
78.4
34.8
16.9
17.8
25.5];

WT24=[161
NaN
135
77.4
39
37.8
30.9
24.5];

KO48=[201
152
130
102
32.3
24.9
24.8
23.6];

WT48=[254
224
177
67.4
24.5
15.8
15.7
23.1];

KO72=[197
238
171
87.3
37.2
35.5
28.4
29.7];

WT72=[226
260
219
96.7
44.9
35.2
24.2
31.4];

figure()
subplot(3,1,1)
hold on
plot(IL2, WT24, '-ro', 'linewidth', 2)
plot([0.01 max(IL2)], [90.8 90.8], '--r', 'linewidth', 2)
plot(IL2, KO24, '-bo', 'linewidth', 2)
plot([0.01 max(IL2)], [36.3 36.3], '--b', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'xscale', 'log')
ylabel('GMFI pSTAT5 of endog. CD25+')
xlabel('[IL2], (pM)')
title('GMFI pSTAT5 of Tregs at 24 hrs')
legend('WT DR', 'WT SS','IL2-/- DR', 'IL2-/- SS')
box on
subplot(3,1,2)
hold on
plot(IL2, WT48, '-ro', 'linewidth', 2)
plot([0.01 max(IL2)], [57.6 57.6], '--r', 'linewidth', 2)
plot(IL2, KO48, '-bo', 'linewidth', 2)
plot([0.01 max(IL2)], [29.1 29.1], '--b', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'xscale', 'log')
ylabel('GMFI pSTAT5 of endog. CD25+')
xlabel('[IL2], (pM)')
title('GMFI pSTAT5 of Tregs at 48 hrs')
box on
subplot(3,1,3)
hold on
plot(IL2, WT72, '-ro', 'linewidth', 2)
plot([0.01 max(IL2)], [0.00 0.00], '--r', 'linewidth', 2)
plot(IL2, KO72, '-bo', 'linewidth', 2)
plot([0.01 max(IL2)], [9.5 9.5], '--b', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'xscale', 'log')
ylabel('GMFI pSTAT5 of endog. CD25+')
xlabel('[IL2], (pM)')
title('GMFI pSTAT5 of Tregs at 72 hrs')
box on

%%

%Backcalculation of IL2 based on Tregs
%WT
GpSTAT524=[90.8];

T=161.4;
B=32.9;
EC50=21.11;

IL224=(GpSTAT524-B)./(T-GpSTAT524).*EC50

GpSTAT548=[57.6];

T=250.1;
B=14.14;
EC50=41.9;

IL248=(GpSTAT548-B)./(T-GpSTAT548).*EC50

%KO
GpSTAT524K=[36.3];

T=234.4;
B=6.022;
EC50=55.79;

IL224K=(GpSTAT524K-B)./(T-GpSTAT524K).*EC50

GpSTAT548K=[29.1];

T=221.7;
B=7.1;
EC50=50.13;

IL248K=(GpSTAT548K-B)./(T-GpSTAT548K).*EC50

GpSTAT572K=[9.5];

T=217.5;
B=31.4;
EC50=25.87;

IL224K=(GpSTAT524K-B)./(T-GpSTAT524K).*EC50


%%

%Backcalculated IL2 over time
%Calculated from Tregs
IL2WT=[17.31 9.45 0];

IL2KO=[8.527 5.726 0.699];

%Calculated from Teffs
%"0" replaces a slightly negative number

IL2WTEffs=[4.9691 36.7 0];

Time=[24 48 72];

figure()
hold on
plot(Time, IL2WT, '--ro', 'linewidth', 2)
plot(Time, IL2KO, '--bo', 'linewidth', 2)
plot(Time, IL2WTEffs, '-ro', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold')
ylabel('Back-calculated [IL2] in the spleen, (pM)')
xlabel('Time post immunization, (hours)')
title('IL2 backcalculated from the spleen over time')
legend('IL2WT from Treg', 'IL2KO from Treg', 'IL2WT from Teffs')
box on

%%

%Bead ELISA IL2 calculations

WT24=[131];
WT48=[125];
WT72=[117];

KO24=[110];
KO48=[106];
KO72=[107];

T=14718;
B=38.01;
EC50=276.5;

IL2WT24=(WT24-B)./(T-WT24).*EC50
IL2WT48=(WT48-B)./(T-WT48).*EC50
IL2WT72=(WT72-B)./(T-WT72).*EC50

IL2KO24=(KO24-B)./(T-KO24).*EC50
IL2KO48=(KO48-B)./(T-KO48).*EC50
IL2KO72=(KO72-B)./(T-KO72).*EC50

WT=[IL2WT24 IL2WT48 IL2WT72];
KO=[IL2KO24 IL2KO48 IL2KO72];

%When extract spleen homogenate I add 50uL RPMI and homogenize.  i.e. I
%dilute the IL2 in the spleen by roughly 1/2.  
WT=WT*2
KO=KO*2

%%
%Bead Elisa Backcalculated IL2 plotted

figure()
hold on
plot(Time, WT, '-ro', 'linewidth', 2)
plot(Time, KO, '-bo', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold')
ylabel('Measured IL2 in the spleen, (pM)')
xlabel('Time, (hrs)')
title('IL2 measured from bead elisa')
legend('WT', 'IL2 KO')
box on


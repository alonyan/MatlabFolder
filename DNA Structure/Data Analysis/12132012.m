%In vivo 12/13/2012

%pSTAT5 responses to exogenous IL2 post-cytokine strip

pSTAT5KO24=[86.4
91.1
92.1
89.2
14.1
1.14
0
3.03];
pSTAT5KO24=pSTAT5KO24-min(pSTAT5KO24);

KO24SS=2.13;

pSTAT5KO48=[40.9
41.2
25.8
15.6
6.04
2.82
4.13
6.16];
pSTAT5KO48=pSTAT5KO48-min(pSTAT5KO48);

KO48SS=17.9;

pSTAT5WT24=[75
31.2
50
41.7
11.1
0
0
0];
pSTAT5WT24=pSTAT5WT24-min(pSTAT5WT24);


WT24SS=0;

pSTAT5WT48=[55.8
52.1
35.4
13
12
15.1
13.9
12.7];
pSTAT5WT48=pSTAT5WT48-min(pSTAT5WT48);

WT48SS=2.85;

IL2=[10000 1000 100 10 1 0.1 0.01 0];

figure()
hold on
plot(IL2, pSTAT5KO24, '-bo', 'linewidth', 2)
plot([0.01 max(IL2)], [2.13 2.13], '-b', 'linewidth', 1)
plot(IL2, pSTAT5KO48, '--bo', 'linewidth', 2)
plot([0.01 max(IL2)], [17.9 17.9], '--b', 'linewidth', 1)
plot(IL2, pSTAT5WT24, '-ro', 'linewidth', 2)
plot([0.01, max(IL2)], [0 0], '-ro', 'linewidth', 1)
plot(IL2, pSTAT5WT48, '--ro', 'linewidth', 2)
plot([0.01, max(IL2)], [2.85 2.85], '--ro','linewidth', 1)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'xscale', 'log', 'Fontweight', 'bold')
ylabel('Percent CD25+pSTAT5+ of AdTr')
xlabel('[IL2], (pM)')
legend('IL2KO 24 hr', 'KO 24 Snapshot', 'IL2KO 48 hr', 'KO 48 Snapshot', 'IL2WT 24 hr', 'WT 24 Snapshot', 'IL2WT 48 hr', 'WT 48 Snapshot')
title('pSTAT5 responses to IL2 for Adoptively Transferred cells')
box on

%%
%Percent CD25+

KO=[93.1 8.57];

WT=[47.1 2.38];

Time=[24 48];

figure()
hold on
plot(Time, KO, '-bo', 'linewidth', 2)
plot(Time, WT, '-ro', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold')
ylabel('Percent CD25+ of AdTr')
xlabel('Time, (hours post immunization)')
title('Percent CD25+ of Adoptively Transferred Cells after immunization')
legend('IL2KO', 'IL2WT')
box on

%%

KO24=[97.9	2.66	0	0	0	0];
KO48=[0	0	1.37	11	34.9	52.7];

WT24=[93.8	0	0	0	0	0];
WT48=[0	1.47	5.3	3.01	21.2	69.2];

Peak=[1 2 3 4 5 6];

figure()
subplot(2,1,1)
hold on
plot(Peak, KO24, '-bo', 'linewidth', 2)
plot(Peak, WT24, '-ro', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold')
ylabel('Percent of AdTr cells in Peak')
xlabel('CFSE Peak')
legend('IL2KO', 'IL2WT')
box on
title('Percent Occupancy of AdTr in CFSE Peaks at 24 hrs')
subplot(2,1,2)
hold on
plot(Peak, KO48, '-bo', 'linewidth', 2)
plot(Peak, WT48, '-ro', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold')
ylabel('Percent of AdTr cells in Peak')
xlabel('CFSE Peak')
box on
title('Percent Occupancy of AdTr in CFSE Peaks at 48 hrs')

%%

%Tregs

pSTAT5KO24=[73
73.2
70.2
55.5
12.6
1.47
1.64
1.15];
pSTAT5KO24=pSTAT5KO24-min(pSTAT5KO24);

KO24SS=7.85;

pSTAT5KO48=[71.5
69.7
61.8
47.1
7.06
1.44
1.39
1.01];
pSTAT5KO48=pSTAT5KO48-min(pSTAT5KO48);

KO48SS=7.51;

pSTAT5WT24=[41.3
37.9
33.9
17.9
3.33
3.11
2.64
2.11];
pSTAT5WT24=pSTAT5WT24-min(pSTAT5WT24);


WT24SS=3.31;

pSTAT5WT48=[52.9
57.7
55.1
29.1
2.26
1.31
0.479
0.638];
pSTAT5WT48=pSTAT5WT48-min(pSTAT5WT48);

WT48SS=1.89;

IL2=[10000 1000 100 10 1 0.1 0.01 0];
figure()
hold on
plot(IL2, pSTAT5KO24, '-bo', 'linewidth', 2)
plot([0.01 max(IL2)], [7.85 7.85], '-b', 'linewidth', 1)
plot(IL2, pSTAT5KO48, '--bo', 'linewidth', 2)
plot([0.01 max(IL2)], [7.51 7.51], '--b', 'linewidth', 1)
plot(IL2, pSTAT5WT24, '-ro', 'linewidth', 2)
plot([0.01, max(IL2)], [3.31 3.31], '-ro', 'linewidth', 1)
plot(IL2, pSTAT5WT48, '--ro', 'linewidth', 2)
plot([0.01, max(IL2)], [1.89 1.89], '--ro','linewidth', 1)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'xscale', 'log', 'Fontweight', 'bold')
ylabel('Percent pSTAT5+ of Tregs')
xlabel('[IL2], (pM)')
legend('IL2KO 24 hr', 'KO 24 Snapshot', 'IL2KO 48 hr', 'KO 48 Snapshot', 'IL2WT 24 hr', 'WT 24 Snapshot', 'IL2WT 48 hr', 'WT 48 Snapshot')
title('pSTAT5 responses to IL2 for Endogenous Tregs (CFSE-CD4+CD25+)')
box on


%%

%From Treg curves, KO at 24 hrs
A=7.85;

T=71.52;
B=0;
E=3.908;

IL2KO24=(A-B)./(T-A).*E
%%

%From Treg curves, KO at 48 hrs
A=7.51;

T=67.68;
B=0;
E=5.701;

IL2KO48=(A-B)./(T-A).*E
%%

%From Treg curves, WT at 24 hrs

A=3.31;

T=37.86;
B=0;
E=15.56;

IL2WT24=(A-B)./(T-A).*E

%%

%From Treg curves, WT at 48 hrs

A=1.89;

T=55.10;
B=0;
E=9.505;

IL2WT24=(A-B)./(T-A).*E
%%

%Backcalculated IL2 from Treg fits and instantaneous pSTAT5

KO=[0.4818 0.7116];
WT=[1.49 0.3376];

Time=[24 48];

figure()
hold on
plot(Time, KO, '-bo', 'linewidth', 2)
plot(Time, WT, '-ro', 'linewidth', 2)
axis([20 50 0.2 5])
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold')
ylabel('[IL2], (pM)')
xlabel('Time, (hours post immunization)')
legend('IL2KO', 'IL2WT')
title('IL2 backcalculated from Treg fits of pSTAT5 response to IL2')
box on 

%%

%From Teff curves, KO at 24 hrs
A=2.13;

T=89.88;
B=0;
E=1.812;

IL2KO24=(A-B)./(T-A).*E

%%

%From Teff curves, KO at 48 hrs
A=17.9;

T=40.99;
B=0;
E=47.14;

IL2KO48=(A-B)./(T-A).*E

%%

%From Teff curves, WT at 24 hrs
A=0;

T=52.72;
B=0;
E=3.235;

IL2WT24=(A-B)./(T-A).*E
%%


%From Teff curves, WT at 24 hrs
A=2.85;

T=42.75;
B=0;
E=89.16;

IL2WT24=(A-B)./(T-A).*E

%%

%%Backcalculated IL2 from AdTr Teff fits and instantaneous pSTAT5

KO=[0.0440 36.54];
WT=[0 6.36];

Time=[24 48];

figure()
hold on
plot(Time, KO, '-bo', 'linewidth', 2)
plot(Time, WT, '-ro', 'linewidth', 2)
axis([20 50 0 40])
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold')
ylabel('[IL2], (pM)')
xlabel('Time, (hours post immunization)')
legend('IL2KO', 'IL2WT')
title('IL2 backcalculated from AdTr Teff fits of pSTAT5 response to IL2')
box on 

%%

%GMFI of pSTAT5 responses to IL2 for Teffs

KO24=[12495
11819
9464
5590
586
194
210
187];
KO24=KO24-min(KO24);

KO24SS=263;

KO48=[4762
6765
5366
2215
401
384
254
250];
KO48=KO48-min(KO48);

KO48SS=1465;

WT24=[119
339
1161
1003
334
231
122
127];
WT24=WT24-min(WT24);

WT48SS=119;

WT48=[3065
2685
2599
2139
2299
1673
1858
1189];
WT48=WT48-min(WT48);

WT48SS=1444;

IL2=[10000 1000 100 10 1 0.1 0.01 0];

figure()
hold on
plot(IL2, KO24, '-bo', 'linewidth', 2)
plot([0.01 max(IL2)], [263 263], '-b', 'linewidth', 1)
plot(IL2, KO48, '--bo', 'linewidth', 2)
plot([0.01 max(IL2)], [1463 1463], '--b', 'linewidth', 1)
plot(IL2, WT24, '-ro', 'linewidth', 2)
plot([0.01, max(IL2)], [119 119], '-ro', 'linewidth', 1)
plot(IL2, WT48, '--ro', 'linewidth', 2)
plot([0.01, max(IL2)], [1444 1444], '--ro','linewidth', 1)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'xscale', 'log', 'Fontweight', 'bold')
ylabel('GMFI pSTAT5 of CD25+ AdTr cells')
xlabel('[IL2], (pM)')
legend('IL2KO 24 hr', 'KO 24 Snapshot', 'IL2KO 48 hr', 'KO 48 Snapshot', 'IL2WT 24 hr', 'WT 24 Snapshot', 'IL2WT 48 hr', 'WT 48 Snapshot')
title('pSTAT5 responses to IL2 for AdTr Teffs')
box on

%%

%%GMFI of pSTAT5 responses to IL2 for Tregs

KO24=[975
989
895
569
162
74.1
64.9
53.8];
KO24=KO24-min(KO24);

KO24SS=132;

KO48=[887
853
677
447
127
67.1
65.3
49];
KO48=KO48-min(KO48);

KO48SS=118;

WT24=[999
902
832
536
180
127
132
93.5];
WT24=WT24-min(WT24);

WT24SS=210;

WT48=[871
971
904
476
140
116
105
68.5];
WT48=WT48-min(WT48);

WT48SS=110;

IL2=[10000 1000 100 10 1 0.1 0.01 0];

figure()
hold on
plot(IL2, KO24, '-bo', 'linewidth', 2)
plot([0.01 max(IL2)], [132 132], '-b', 'linewidth', 1)
plot(IL2, KO48, '--bo', 'linewidth', 2)
plot([0.01 max(IL2)], [118 118], '--b', 'linewidth', 1)
plot(IL2, WT24, '-ro', 'linewidth', 2)
plot([0.01, max(IL2)], [210 210], '-ro', 'linewidth', 1)
plot(IL2, WT48, '--ro', 'linewidth', 2)
plot([0.01, max(IL2)], [110 110], '--ro','linewidth', 1)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'xscale', 'log', 'Fontweight', 'bold')
ylabel('GMFI pSTAT5 of Tregs')
xlabel('[IL2], (pM)')
legend('IL2KO 24 hr', 'KO 24 Snapshot', 'IL2KO 48 hr', 'KO 48 Snapshot', 'IL2WT 24 hr', 'WT 24 Snapshot', 'IL2WT 48 hr', 'WT 48 Snapshot')
title('pSTAT5 responses to IL2 for endogenous Tregs (CFSe-CD4+CD25+)')
box on

%%
%Quantifying the number of cells per peak versus the percentage of cells
%per peak

KO24C=[57	3
54	2
95	6
85	8
92	8
86	3
102	0
90	5];
KO24C=mean(KO24C);

KO24P=[96.6	5.08
96.4	3.57
94.1	5.94
91.4	8.6
92.9	8.08
97.7	3.41
94.4	0
90.9	5.05];
KO24P=mean(KO24P);

WT24C=[16	0
10	0
8	0
16	1
11	0
17	0
30	0];
WT24C=mean(WT24C);

WT24P=[100	0
100	0
66.7	0
88.9	5.56
91.7	0
94.4	0
93.8	0];
WT24P=mean(WT24P);

KO48C=[0	1	4	19	40	69
0	0	1	16	28	69
0	0	0	4	30	59
1	0	0	12	29	67
1	1	4	11	38	95
0	0	3	16	36	87
1	0	2	9	34	101
0	0	2	16	51	77];
KO48C=mean(KO48C)

KO48P=[0	0.769	3.08	14.6	30.8	53.1
0	0	0.877	14	24.6	60.5
0	0	0	4.3	32.3	63.4
0.926	0	0	11.1	26.9	62
0.676	0.676	2.7	7.43	25.7	64.2
0	0	2.11	11.3	25.4	61.3
0.68	0	1.36	6.12	23.1	68.7
0	0	1.37	11	34.9	52.7];
KO48P=mean(KO48P);

WT48C=[1	23	184	49	47	96
0	21	236	51	70	136
0	18	235	63	65	149
1	23	266	55	65	173
0	21	278	64	72	126
0	12	214	63	95	195
1	26	271	58	86	191
0	28	208	40	58	89];
WT48C=mean(WT48C)

WT48P=[0.258	5.93	47.4	12.6	12.1	24.7
0	4.13	46.5	10	13.8	26.8
0	3.45	45	12.1	12.5	28.5
0.174	4.01	46.3	9.58	11.3	30.1
0	3.8	50.4	11.6	13	22.8
0	2.09	37.3	11	16.6	34
0.16	4.17	43.4	9.29	13.8	30.6
0	6.73	50	9.62	13.9	21.4];
WT48P=mean(WT48P);

Peak=[1 2];
Peak2=[1 2 3 4 5 6];

%%

figure()
subplot(2,1,1)
hold on
plot(Peak, KO24C, '-bo', 'linewidth', 2)
plot(Peak, WT24C, '-ro', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold')
ylabel('Number of cells per Peak')
xlabel('Peak')
title('Number of cells per CFSE dilution at 24 hours (averaged)')
legend('IL2KO', 'IL2WT')
box on
subplot(2,1,2)
hold on
plot(Peak2, KO48C, '-bo' , 'linewidth', 2)
plot(Peak2, WT48C, '-ro' ,'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold')
ylabel('Number of cells per Peak')
xlabel('Peak')
title('Number of cells per CFSE dilution at 48 hours (averaged)')
box on

%%

CD25KO24=[29292
33612
31131
33386
34367
33303
28018
31250];
CD25KO24=mean(CD25KO24);

CD25KO48=[3258
3051
2667
3427
2956
2870
2541
3121];
CD25KO48=mean(CD25KO48);

CD25WT24=[13474
13400
12436
9533
11115
10763
10561];
CD25WT24=mean(CD25WT24);

CD25WT48=[3736
3575
4010
3562
3676
4012
4198
4581];
CD25WT48=mean(CD25WT48);

CD25KO=[CD25KO24, CD25KO48];
CD25WT=[CD25WT24, CD25WT48];

Time=[24 48];

figure()
hold on
plot(Time, CD25KO, '-bo', 'linewidth', 2)
plot(Time, CD25WT, '-ro', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'yscale', 'log')
ylabel('GMFI CD25')
xlabel('Time, hrs')
title('GMFI CD25 over time')
legend('IL2KO' ,'IL2WT')
box on



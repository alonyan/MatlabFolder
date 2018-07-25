%T1 counts

CTV=[6379
6114
4976
5591
6532
8382
7319
5891
6093
7458
7381
6940
8230
9363
7709
6935
6198
8490
8803
9221
8908
10129
7435
6455];

NoTregs=CTV(1:8);
Tregs=CTV(9:16);
antiIL2=CTV(17:24);

peptide=[5e-6 1e-6 200e-9 40e-9 8e-9 1.6e-9 320e-12 64e-12];

figure()
hold on
plot(peptide, NoTregs, '-bo', 'linewidth', 2)
plot(peptide, Tregs, '-ro', 'linewidth', 2)
plot(peptide, antiIL2, '-go', 'linewidth', 2)
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'xscale', 'log', 'yscale', 'log')
set(gcf, 'color', 'w')
ylabel('Log K5 specific cells per 80k events')
xlabel('K5 peptide, (M)')
legend('No Tregs', '+Tregs', '+Tregs +anti-IL2')
box on
title('48 hours')
%%

%T2 counts

CTV=[25873
25558
17515
23642
17531
11454
8838
8026
19538
21244
20590
19174
16372
12494
9163
9218
26596
27188
20310
18197
12670
7158
7324
8116];

NoTregs=CTV(1:8);
Tregs=CTV(9:16);
antiIL2=CTV(17:24);

peptide=[5e-6 1e-6 200e-9 40e-9 8e-9 1.6e-9 320e-12 64e-12];

figure()
hold on
plot(peptide, NoTregs, '-bo', 'linewidth', 2)
plot(peptide, Tregs, '-ro', 'linewidth', 2)
plot(peptide, antiIL2, '-go', 'linewidth', 2)
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'xscale', 'log', 'yscale', 'log')
set(gcf, 'color', 'w')
ylabel('Log K5 specific cells per 80k events')
xlabel('K5 peptide, (M)')
legend('No Tregs', '+Tregs', '+Tregs +anti-IL2')
box on
title('65 hours')


%%

%Percent Occupancy T1

CTV=[68	12.2	13.7	3.54
65.1	12.4	15.5	4.37
78.8	8.34	7.82	3.01
85.6	5.85	4.49	2.16
93	2.69	1.79	0.781
94.5	2.31	0.99	0.429
94.6	2.04	0.506	0.287
96.3	1.78	0	0
61.6	12.7	16.3	6.76
64.1	11.6	14.7	6.76
80.7	6.43	7.2	3.41
87.9	4.24	3.96	2
94.3	2.06	1.11	0.384
94.2	2.28	0.636	0.169
93.6	2.26	0.548	0.505
58.2	15.6	19.2	3.94
60.9	18	16.6	1.51
67.6	15.1	13.3	1.74
78.7	10.6	7.73	1.16
90.4	4.65	2.54	0.449
95.6	1.94	0.454	0.188
97.5	0.928	0.0941	0.242
95.4	1.78	0.217	0.263];

NoTregs=CTV(1:8,:);
Tregs=CTV(9:15,:);
antiIL2=CTV(16:23,:);

peak=[1 2 3 4];

figure()
subplot(1,3,1)
plot(peak, NoTregs, '-o', 'linewidth', 2)
set(gca, 'Fontsize', 16, 'Fontweight', 'bold')
set(gcf, 'color', 'w')
ylabel('Percent Occupancy')
xlabel('Dye dilution')
legend('5uM', '1uM', '200nM', '40nM', '8nM', '1.6nM', '320pM', '64pM')
box on
title('No Tregs')
subplot(1,3,2)
plot(peak, Tregs, '-o', 'linewidth', 2)
set(gca, 'Fontsize', 16, 'Fontweight', 'bold')
set(gcf, 'color', 'w')
ylabel('Percent Occupancy')
xlabel('Dye dilution')
box on
title('+Tregs')
subplot(1,3,3)
plot(peak, antiIL2, '-o', 'linewidth', 2)
set(gca, 'Fontsize', 16, 'Fontweight', 'bold')
set(gcf, 'color', 'w')
ylabel('Percent Occupancy')
xlabel('Dye dilution')
box on
title('+Tregs+antiIL2')

%%
%Percent Occupancy T2

CTV=[12.7	3.6	13.5	32	30.6	5.89
13.6	5.63	16.8	31.7	23.3	6.08
19.8	3.81	12.3	28.5	26.1	7.53
22	3.18	8.74	22.1	27.5	13.7
38.7	3.46	7.27	17	21.9	8.4
82	3.29	2.9	4.35	4.2	1.23
92	2.93	0.973	0.803	0.826	0.441
93.4	2.48	0.424	0.561	0.498	0.548
13.7	4.26	15	32.9	27.7	4.15
16.1	4.68	14.1	30.1	25.6	6.69
17.7	3.87	11.5	27.6	28.1	8.89
26	3.43	8.63	21.7	26.3	11.4
38.4	3.37	7.62	17.5	23.4	5.81
84.9	3.16	2.5	3.55	2.65	1.13
92	2.97	0.786	0.873	0.535	0.731
92.6	2.74	0.564	0.456	0.597	0.629
13.8	5.49	17.9	38.9	20.4	1.27
14.6	6.14	17.8	34.5	21.1	3.36
23.1	6.3	16.1	32.4	17.9	1.66
33.7	5.67	13.3	25.1	17.6	1.63
60.5	6.33	8.18	12.9	7.25	1.66
89.5	3.76	1.61	1.52	0.699	0.573
92.7	3.02	0.683	0.532	0.423	0.628
91.5	3.57	0.579	0.419	0.481	1.02];

NoTregs=CTV(1:8,:);
Tregs=CTV(9:16,:);
antiIL2=CTV(17:24,:);

peak=[1 2 3 4 5 6];

figure()
subplot(1,3,1)
plot(peak, NoTregs, '-o', 'linewidth', 2)
set(gca, 'Fontsize', 16, 'Fontweight', 'bold')
set(gcf, 'color', 'w')
ylabel('Percent Occupancy')
xlabel('Dye dilution')
legend('5uM', '1uM', '200nM', '40nM', '8nM', '1.6nM', '320pM', '64pM')
box on
title('No Tregs')
subplot(1,3,2)
plot(peak, Tregs, '-o', 'linewidth', 2)
set(gca, 'Fontsize', 16, 'Fontweight', 'bold')
set(gcf, 'color', 'w')
ylabel('Percent Occupancy')
xlabel('Dye dilution')
box on
title('+Tregs')
subplot(1,3,3)
plot(peak, antiIL2, '-o', 'linewidth', 2)
set(gca, 'Fontsize', 16, 'Fontweight', 'bold')
set(gcf, 'color', 'w')
ylabel('Percent Occupancy')
xlabel('Dye dilution')
box on
title('+Tregs+antiIL2')

figure()
subplot(4,2,1)
hold on
plot(peak, NoTregs (1,:), '-ro', 'linewidth', 2)
plot(peak, Tregs (1,:), '-bo', 'linewidth', 2)
plot(peak, antiIL2 (1,:), '-go', 'linewidth', 2)
set(gca, 'Fontsize', 16, 'Fontweight', 'bold')
set(gcf, 'color', 'w')
ylabel('Percent Occupancy')
xlabel('Dye dilution')
legend('No Tregs', 'Tregs', 'Tregs + anti-IL2')
title('5uM K5')
subplot(4,2,2)
hold on
plot(peak, NoTregs (2,:), '-ro', 'linewidth', 2)
plot(peak, Tregs (2,:), '-bo', 'linewidth', 2)
plot(peak, antiIL2 (2,:), '-go', 'linewidth', 2)
set(gca, 'Fontsize', 16, 'Fontweight', 'bold')
set(gcf, 'color', 'w')
ylabel('Percent Occupancy')
xlabel('Dye dilution')
title('1uM K5')
subplot(4,2,3)
hold on
plot(peak, NoTregs (3,:), '-ro', 'linewidth', 2)
plot(peak, Tregs (3,:), '-bo', 'linewidth', 2)
plot(peak, antiIL2 (3,:), '-go', 'linewidth', 2)
set(gca, 'Fontsize', 16, 'Fontweight', 'bold')
set(gcf, 'color', 'w')
ylabel('Percent Occupancy')
xlabel('Dye dilution')
title('200nM K5')
subplot(4,2,4)
hold on
plot(peak, NoTregs (4,:), '-ro', 'linewidth', 2)
plot(peak, Tregs (4,:), '-bo', 'linewidth', 2)
plot(peak, antiIL2 (4,:), '-go', 'linewidth', 2)
set(gca, 'Fontsize', 16, 'Fontweight', 'bold')
set(gcf, 'color', 'w')
ylabel('Percent Occupancy')
xlabel('Dye dilution')
title('40nM K5')
subplot(4,2,5)
hold on
plot(peak, NoTregs (5,:), '-ro', 'linewidth', 2)
plot(peak, Tregs (5,:), '-bo', 'linewidth', 2)
plot(peak, antiIL2 (5,:), '-go', 'linewidth', 2)
set(gca, 'Fontsize', 16, 'Fontweight', 'bold')
set(gcf, 'color', 'w')
ylabel('Percent Occupancy')
xlabel('Dye dilution')
title('8nM K5')
subplot(4,2,6)
hold on
plot(peak, NoTregs (6,:), '-ro', 'linewidth', 2)
plot(peak, Tregs (6,:), '-bo', 'linewidth', 2)
plot(peak, antiIL2 (6,:), '-go', 'linewidth', 2)
set(gca, 'Fontsize', 16, 'Fontweight', 'bold')
set(gcf, 'color', 'w')
ylabel('Percent Occupancy')
xlabel('Dye dilution')
title('1.6nM K5')
subplot(4,2,7)
hold on
plot(peak, NoTregs (7,:), '-ro', 'linewidth', 2)
plot(peak, Tregs (7,:), '-bo', 'linewidth', 2)
plot(peak, antiIL2 (7,:), '-go', 'linewidth', 2)
set(gca, 'Fontsize', 16, 'Fontweight', 'bold')
set(gcf, 'color', 'w')
ylabel('Percent Occupancy')
xlabel('Dye dilution')
title('320pM K5')
subplot(4,2,8)
hold on
plot(peak, NoTregs (8,:), '-ro', 'linewidth', 2)
plot(peak, Tregs (8,:), '-bo', 'linewidth', 2)
plot(peak, antiIL2 (8,:), '-go', 'linewidth', 2)
set(gca, 'Fontsize', 16, 'Fontweight', 'bold')
set(gcf, 'color', 'w')
ylabel('Percent Occupancy')
xlabel('Dye dilution')
title('6.4pM K5')
%%

%CD25+ T1

CTV=[49.3
49.6
34
26
19.7
16
14.5
11.7
NaN
59.6
52.1
33.1
23.6
19.5
16.7
14.4
58.9
38.4
23.3
19.2
18.8
20.5
18.3
19.1];

NoTregs=CTV(1:8);
Tregs=CTV(9:16);
antiIL2=CTV(17:24);

peptide=[5e-6 1e-6 200e-9 40e-9 8e-9 1.6e-9 320e-12 64e-12];

figure()
hold on
plot(peptide, NoTregs, '-bo', 'linewidth', 2)
plot(peptide, Tregs, '-ro', 'linewidth', 2)
plot(peptide, antiIL2, '-go', 'linewidth', 2)
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'xscale', 'log')
set(gcf, 'color', 'w')
ylabel('Percent CD25+')
xlabel('K5 peptide, (M)')
legend('No Tregs', '+Tregs', '+Tregs +anti-IL2')
box on
title('48 hours')
%%

%CD25+T2

CTV=[84.4
83.7
52.3
32.7
26.9
15.6
13.1
12.2
74.7
73.4
35.1
22
19.2
14.3
13.6
14.1
33.9
32.1
13.8
16
15.2
13.9
10.4
11.8];

NoTregs=CTV(1:8);
Tregs=CTV(9:16);
antiIL2=CTV(17:24);

peptide=[5e-6 1e-6 200e-9 40e-9 8e-9 1.6e-9 320e-12 64e-12];

figure()
hold on
plot(peptide, NoTregs, '-bo', 'linewidth', 2)
plot(peptide, Tregs, '-ro', 'linewidth', 2)
plot(peptide, antiIL2, '-go', 'linewidth', 2)
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'xscale', 'log')
set(gcf, 'color', 'w')
ylabel('Percent CD25+')
xlabel('K5 peptide, (M)')
legend('No Tregs', '+Tregs', '+Tregs +anti-IL2')
box on
title('65 hours')

%%

%PD1 positive T1

CTV=[35.2
36.8
29.1
26.5
23
21.4
19.4
16.1
NaN
39.8
34.5
26.6
23.8
24.1
21.9
20.1
39.1
30.3
26.4
24.3
23.2
26.3
21.1
23.6];

NoTregs=CTV(1:8);
Tregs=CTV(9:16);
antiIL2=CTV(17:24);

peptide=[5e-6 1e-6 200e-9 40e-9 8e-9 1.6e-9 320e-12 64e-12];

figure()
hold on
plot(peptide, NoTregs, '-bo', 'linewidth', 2)
plot(peptide, Tregs, '-ro', 'linewidth', 2)
plot(peptide, antiIL2, '-go', 'linewidth', 2)
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'xscale', 'log')
set(gcf, 'color', 'w')
ylabel('Percent PD1+')
xlabel('K5 peptide, (M)')
legend('No Tregs', '+Tregs', '+Tregs +anti-IL2')
box on
title('48 hours')

%%

%PD1 positive T2

CTV=[6.64
7.07
4.73
5.33
6.47
9.43
13
13.4
6.88
7.67
5.08
5.87
5.63
11.3
14.7
15.5
10.9
9.77
8.98
10
11.4
15.5
12.7
14.4
];

NoTregs=CTV(1:8);
Tregs=CTV(9:16);
antiIL2=CTV(17:24);

peptide=[5e-6 1e-6 200e-9 40e-9 8e-9 1.6e-9 320e-12 64e-12];

figure()
hold on
plot(peptide, NoTregs, '-bo', 'linewidth', 2)
plot(peptide, Tregs, '-ro', 'linewidth', 2)
plot(peptide, antiIL2, '-go', 'linewidth', 2)
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'xscale', 'log')
set(gcf, 'color', 'w')
ylabel('Percent PD1+')
xlabel('K5 peptide, (M)')
legend('No Tregs', '+Tregs', '+Tregs +anti-IL2')
box on
title('65 hours')

%%

%PD-1 hi or low CD25 gmfi T1

CTV_hi=[4722
4321
3996
3660
3400
2880
2854
2659
NaN
5561
5057
4484
3904
2956
2778
2617
4899
3615
3027
2951
2937
2876
3054
2930];

NoTregs_hi=CTV_hi(1:8);
Tregs_hi=CTV_hi(9:16);
antiIL2_hi=CTV_hi(17:24);

peptide=[5e-6 1e-6 200e-9 40e-9 8e-9 1.6e-9 320e-12 64e-12];

figure()
hold on
plot(peptide, NoTregs_hi, '-bo', 'linewidth', 2)
plot(peptide, Tregs_hi, '-ro', 'linewidth', 2)
plot(peptide, antiIL2_hi, '-go', 'linewidth', 2)
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'xscale', 'log', 'ylim', [1000 6000], 'ytick', [2000, 4000, 6000])
set(gcf, 'color', 'w')
ylabel('CD25 GMFI for PD-1+')
xlabel('K5 peptide, (M)')
legend('No Tregs', '+Tregs', '+Tregs +anti-IL2')
box on
title('48 hours')

CTV_lo=[1887
1806
1485
1288
1189
1136
1169
1168
NaN
2147
1847
1421
1226
1150
1167
1138
2035
1575
1241
1153
1156
1211
1327
1217
];

NoTregs_lo=CTV_lo(1:8);
Tregs_lo=CTV_lo(9:16);
antiIL2_lo=CTV_lo(17:24);

peptide=[5e-6 1e-6 200e-9 40e-9 8e-9 1.6e-9 320e-12 64e-12];

figure()
hold on
plot(peptide, NoTregs_lo, '-bo', 'linewidth', 2)
plot(peptide, Tregs_lo, '-ro', 'linewidth', 2)
plot(peptide, antiIL2_lo, '-go', 'linewidth', 2)
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'xscale', 'log', 'ylim', [1000 6000], 'ytick', [2000, 4000, 6000])
set(gcf, 'color', 'w')
ylabel('CD25 GMFI for PD-1-')
xlabel('K5 peptide, (M)')
legend('No Tregs', '+Tregs', '+Tregs +anti-IL2')
box on
title('48 hours')

figure()
subplot(1,3,1)
hold on
plot(peptide, NoTregs_hi, '-bo', 'linewidth', 2)
plot(peptide, NoTregs_lo, '--bo', 'linewidth', 2)
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'xscale', 'log', 'ylim', [1000 6000], 'ytick', [2000 4000 6000 8000])
set(gcf, 'color', 'w')
ylabel('CD25 GMFI')
xlabel('K5 peptide, (M)')
title('No Tregs - 48 hours')
legend('PD-1+', 'PD-1-')
box on
subplot(1,3,2)
hold on
plot(peptide, Tregs_hi, '-ro', 'linewidth', 2)
plot(peptide, Tregs_lo, '--ro', 'linewidth', 2)
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'xscale', 'log', 'ylim', [1000 6000], 'ytick', [2000 4000 6000 8000])
set(gcf, 'color', 'w')
ylabel('CD25 GMFI')
xlabel('K5 peptide, (M)')
title('+Tregs - 48 hours')
legend('PD-1+', 'PD-1-')
box on
subplot(1,3,3)
hold on
plot(peptide, antiIL2_hi, '-go', 'linewidth', 2)
plot(peptide, antiIL2_lo, '--go', 'linewidth', 2)
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'xscale', 'log', 'ylim', [1000 6000], 'ytick', [2000 4000 6000 8000])
set(gcf, 'color', 'w')
ylabel('CD25 GMFI')
xlabel('K5 peptide, (M)')
title('+Tregs+antiIL2 - 48 hours')
legend('PD-1+', 'PD-1-')
box on


%%

%PD-1 hi or low CD25 gmfi T2

CTV_hi=[7056
7790
5229
4075
4000
4006
3220
3061
6086
6895
4392
3662
3617
3751
3036
3022
4338
4224
3301
3395
3411
3057
2851
2788];

NoTregs_hi=CTV_hi(1:8);
Tregs_hi=CTV_hi(9:16);
antiIL2_hi=CTV_hi(17:24);

peptide=[5e-6 1e-6 200e-9 40e-9 8e-9 1.6e-9 320e-12 64e-12];

figure()
hold on
plot(peptide, NoTregs_hi, '-bo', 'linewidth', 2)
plot(peptide, Tregs_hi, '-ro', 'linewidth', 2)
plot(peptide, antiIL2_hi, '-go', 'linewidth', 2)
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'xscale', 'log', 'ylim', [1000 8000], 'ytick', [2000, 4000, 6000, 8000])
set(gcf, 'color', 'w')
ylabel('CD25 GMFI for PD-1+')
xlabel('K5 peptide, (M)')
legend('No Tregs', '+Tregs', '+Tregs +anti-IL2')
box on
title('65 hours')

CTV_lo=[4501
5001
2543
1599
1392
1238
1209
1199
3669
3942
1667
1151
1200
1163
1199
1200
1284
1218
664
846
1041
1182
1219
1179];

NoTregs_lo=CTV_lo(1:8);
Tregs_lo=CTV_lo(9:16);
antiIL2_lo=CTV_lo(17:24);

peptide=[5e-6 1e-6 200e-9 40e-9 8e-9 1.6e-9 320e-12 64e-12];

figure()
hold on
plot(peptide, NoTregs_lo, '-bo', 'linewidth', 2)
plot(peptide, Tregs_lo, '-ro', 'linewidth', 2)
plot(peptide, antiIL2_lo, '-go', 'linewidth', 2)
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'xscale', 'log', 'ylim', [1000 8000], 'ytick', [2000, 4000, 6000, 8000])
set(gcf, 'color', 'w')
ylabel('CD25 GMFI for PD-1-')
xlabel('K5 peptide, (M)')
legend('No Tregs', '+Tregs', '+Tregs +anti-IL2')
box on
title('65 hours')

figure()
subplot(1,3,1)
hold on
plot(peptide, NoTregs_hi, '-bo', 'linewidth', 2)
plot(peptide, NoTregs_lo, '--bo', 'linewidth', 2)
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'xscale', 'log', 'ylim', [1000 8000], 'ytick', [2000 4000 6000 8000])
set(gcf, 'color', 'w')
ylabel('CD25 GMFI')
xlabel('K5 peptide, (M)')
title('No Tregs - 65 hours')
legend('PD-1+', 'PD-1-')
box on
subplot(1,3,2)
hold on
plot(peptide, Tregs_hi, '-ro', 'linewidth', 2)
plot(peptide, Tregs_lo, '--ro', 'linewidth', 2)
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'xscale', 'log', 'ylim', [1000 8000], 'ytick', [2000 4000 6000 8000])
set(gcf, 'color', 'w')
ylabel('CD25 GMFI')
xlabel('K5 peptide, (M)')
title('+Tregs - 65 hours')
legend('PD-1+', 'PD-1-')
box on
subplot(1,3,3)
hold on
plot(peptide, antiIL2_hi, '-go', 'linewidth', 2)
plot(peptide, antiIL2_lo, '--go', 'linewidth', 2)
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'xscale', 'log', 'ylim', [1000 8000], 'ytick', [2000 4000 6000 8000])
set(gcf, 'color', 'w')
ylabel('CD25 GMFI')
xlabel('K5 peptide, (M)')
title('+Tregs+antiIL2 - 65 hours')
legend('PD-1+', 'PD-1-')
box on

%%
%CD25 hi or low PD-1 GMFI

CTV_hi=[600
610
649
727
837
906
885
778
NaN
582
566
623
756
843
841
854
570
605
731
816
844
850
795
808];

NoTregs_hi=CTV_hi(1:8);
Tregs_hi=CTV_hi(9:16);
antiIL2_hi=CTV_hi(17:24);

peptide=[5e-6 1e-6 200e-9 40e-9 8e-9 1.6e-9 320e-12 64e-12];

figure()
hold on
plot(peptide, NoTregs_hi, '-bo', 'linewidth', 2)
plot(peptide, Tregs_hi, '-ro', 'linewidth', 2)
plot(peptide, antiIL2_hi, '-go', 'linewidth', 2)
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'xscale', 'log')
set(gcf, 'color', 'w')
ylabel('PD-1 GMFI for CD25+')
xlabel('K5 peptide, (M)')
legend('No Tregs', '+Tregs', '+Tregs +anti-IL2')
box on
title('48 hours')

CTV_lo=[338
349
344
345
331
333
320
310
NaN
332
323
321
322
322
309
311
329
330
336
333
324
327
325
312];

NoTregs_lo=CTV_lo(1:8);
Tregs_lo=CTV_lo(9:16);
antiIL2_lo=CTV_lo(17:24);

peptide=[5e-6 1e-6 200e-9 40e-9 8e-9 1.6e-9 320e-12 64e-12];

figure()
hold on
plot(peptide, NoTregs_lo, '-bo', 'linewidth', 2)
plot(peptide, Tregs_lo, '-ro', 'linewidth', 2)
plot(peptide, antiIL2_lo, '-go', 'linewidth', 2)
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'xscale', 'log')
set(gcf, 'color', 'w')
ylabel('PD-1 GMFI for CD25-')
xlabel('K5 peptide, (M)')
legend('No Tregs', '+Tregs', '+Tregs +anti-IL2')
box on
title('48 hours')

figure()
subplot(1,3,1)
hold on
plot(peptide, NoTregs_hi, '-bo', 'linewidth', 2)
plot(peptide, NoTregs_lo, '--bo', 'linewidth', 2)
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'xscale', 'log')
set(gcf, 'color', 'w')
ylabel('PD-1 GMFI')
xlabel('K5 peptide, (M)')
title('No Tregs - 48 hours')
legend('CD25+', 'CD25-')
box on
subplot(1,3,2)
hold on
plot(peptide, Tregs_hi, '-ro', 'linewidth', 2)
plot(peptide, Tregs_lo, '--ro', 'linewidth', 2)
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'xscale', 'log', 'ylim', [300 1000])
set(gcf, 'color', 'w')
ylabel('PD-1 GMFI')
xlabel('K5 peptide, (M)')
title('+Tregs - 48 hours')
legend('CD25+', 'CD25-')
box on
subplot(1,3,3)
hold on
plot(peptide, antiIL2_hi, '-go', 'linewidth', 2)
plot(peptide, antiIL2_lo, '--go', 'linewidth', 2)
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'xscale', 'log', 'ylim', [300 1000])
set(gcf, 'color', 'w')
ylabel('PD-1 GMFI')
xlabel('K5 peptide, (M)')
title('+Tregs+antiIL2 - 48 hours')
legend('CD25+', 'CD25-')
box on

%%

%CD25 hi or low PD-1 gmfi T2

CTV_hi=[185
196
183
214
248
416
647
686
192
198
207
259
281
534
702
701
323
304
436
432
483
741
745
730];

NoTregs_hi=CTV_hi(1:8);
Tregs_hi=CTV_hi(9:16);
antiIL2_hi=CTV_hi(17:24);

peptide=[5e-6 1e-6 200e-9 40e-9 8e-9 1.6e-9 320e-12 64e-12];

figure()
hold on
plot(peptide, NoTregs_hi, '-bo', 'linewidth', 2)
plot(peptide, Tregs_hi, '-ro', 'linewidth', 2)
plot(peptide, antiIL2_hi, '-go', 'linewidth', 2)
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'xscale', 'log')
set(gcf, 'color', 'w')
ylabel('PD-1 GMFI for CD25+')
xlabel('K5 peptide, (M)')
legend('No Tregs', '+Tregs', '+Tregs +anti-IL2')
box on
title('65 hours')

CTV_lo=[167
157
151
141
182
250
274
276
159
157
140
152
176
253
278
278
193
185
208
223
247
283
290
282];

NoTregs_lo=CTV_lo(1:8);
Tregs_lo=CTV_lo(9:16);
antiIL2_lo=CTV_lo(17:24);

peptide=[5e-6 1e-6 200e-9 40e-9 8e-9 1.6e-9 320e-12 64e-12];

figure()
hold on
plot(peptide, NoTregs_lo, '-bo', 'linewidth', 2)
plot(peptide, Tregs_lo, '-ro', 'linewidth', 2)
plot(peptide, antiIL2_lo, '-go', 'linewidth', 2)
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'xscale', 'log')
set(gcf, 'color', 'w')
ylabel('PD-1 GMFI for CD25-')
xlabel('K5 peptide, (M)')
legend('No Tregs', '+Tregs', '+Tregs +anti-IL2')
box on
title('65 hours')

figure()
subplot(1,3,1)
hold on
plot(peptide, NoTregs_hi, '-bo', 'linewidth', 2)
plot(peptide, NoTregs_lo, '--bo', 'linewidth', 2)
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'xscale', 'log', 'ylim', [100 800])
set(gcf, 'color', 'w')
ylabel('PD-1 GMFI')
xlabel('K5 peptide, (M)')
title('No Tregs - 65 hours')
legend('CD25+', 'CD25-')
box on
subplot(1,3,2)
hold on
plot(peptide, Tregs_hi, '-ro', 'linewidth', 2)
plot(peptide, Tregs_lo, '--ro', 'linewidth', 2)
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'xscale', 'log')
set(gcf, 'color', 'w')
ylabel('PD-1 GMFI')
xlabel('K5 peptide, (M)')
title('+Tregs - 65 hours')
legend('CD25+', 'CD25-')
box on
subplot(1,3,3)
hold on
plot(peptide, antiIL2_hi, '-go', 'linewidth', 2)
plot(peptide, antiIL2_lo, '--go', 'linewidth', 2)
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'xscale', 'log')
set(gcf, 'color', 'w')
ylabel('PD-1 GMFI')
xlabel('K5 peptide, (M)')
title('+Tregs+antiIL2 - 65 hours')
legend('CD25+', 'CD25-')
box on


%%
%Among CD25+, PD1 positive percentage T1 (48 hours)

CD25=[89.3
89.7
92
94.7
96.9
99.3
99
99.7
NaN
84.7
82.9
87.6
94.5
98.9
98.8
99.1
83.2
87.7
94.5
97.5
98.5
99.4
98.7
99.1];

peptide=[5e-6 1e-6 200e-9 40e-9 8e-9 1.6e-9 320e-12 64e-12];

NoTregs=CD25(1:8);
Tregs=CD25(9:16);
antiIL2=CD25(17:24);

figure()
hold on
plot(peptide, NoTregs, '-bo', 'linewidth', 2)
plot(peptide, Tregs, '-ro', 'linewidth', 2)
plot(peptide, antiIL2, '-go', 'linewidth', 2)
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'xscale', 'log', 'ylim', [10 100])
set(gcf, 'color', 'w')
ylabel('%PD-1+ among activated cells')
xlabel('K5 peptide, (M)')
legend('No Tregs', '+Tregs', '+Tregs +anti-IL2')
box on
title('48 hours')


%%


%Among CD25+, PD1 positive percentage T2 (65 hours)

CD25=[15.6
18.7
16.5
26.3
32.3
63.7
90.8
96
17.7
20.9
23.6
35.3
37.9
78.8
93.6
95.4
44.7
42.2
63.9
62.2
69.5
96
97.2
97.6];

peptide=[5e-6 1e-6 200e-9 40e-9 8e-9 1.6e-9 320e-12 64e-12];

NoTregs=CD25(1:8);
Tregs=CD25(9:16);
antiIL2=CD25(17:24);

figure()
hold on
plot(peptide, NoTregs, '-bo', 'linewidth', 2)
plot(peptide, Tregs, '-ro', 'linewidth', 2)
plot(peptide, antiIL2, '-go', 'linewidth', 2)
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'xscale', 'log')
set(gcf, 'color', 'w')
ylabel('%PD-1+ among activated cells')
xlabel('K5 peptide, (M)')
legend('No Tregs', '+Tregs', '+Tregs +anti-IL2')
box on
title('65 hours')



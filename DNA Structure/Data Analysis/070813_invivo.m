%Number & counts of AdTr for KO

KO_No=[511
630
481
1433
1289
463
1492
1434
2053
1328
2758
3055
4391
1539
1986
3276
3815
3911];

WT_No=[335
205
283
1002
242
190
1382
1100
1948
NaN
1593
2682
NaN
758
NaN
NaN
1432
2483];

K5=[0.1 0.1 0.1 1 1 1 3 3 3 10 10 10 30 30 30 100 100 100];

%Percent of AdTr for KO

KO_Per=[1.24
1.45
0.989
4.17
2.95
0.765
3.83
3.61
5.47
4.28
6.5
6.34
14.3
4.77
6.54
11.4
13
10.2];

WT_Per=[0.791
0.61
0.706
2.44
0.543
0.352
3.34
2.72
4.54
NaN
3.77
6.15
NaN
1.45
NaN
NaN
3.54
6.84];

figure()
subplot(1,2,1)
hold on
plot(K5, KO_Per, 'o', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
plot(K5, WT_Per, 'o', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'yscale', 'log', 'xscale', 'log')
xlabel('[K5 peptide], (ug)')
ylabel('% of CD4+')
title('% of CD4+')
legend('IL2 KO', 'IL2 WT')
box on
subplot(1,2,2)
hold on
plot(K5, KO_No, 'o', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
plot(K5, WT_No, 'o', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'yscale', 'log', 'xscale', 'log')
xlabel('[K5 peptide], (ug)')
ylabel('Number of AdTr Cells')
title('Number of Cells')
legend('IL2 KO', 'IL2 WT')
box on

%%

%percent occupancy

WT=[65.1	15.2	7.16	3.58	1.19	0
72.2	9.76	3.9	3.41	1.46	0
62.2	17.7	8.48	3.89	0.353	0
4.29	10.5	35.1	34.2	10.5	1.4
81.4	6.2	5.37	2.07	0.826	0
87.4	1.05	0	0.526	0	1.58
1.52	3.69	25.4	44.9	16.7	2.75
4.45	0.636	9.18	37.9	34	8.55
0.616	1.03	13.4	40.2	33.9	6.42
NaN	NaN	NaN	NaN	NaN	NaN
0.628	0.439	8.04	35.6	39	9.92
0.0746	0.0746	0.671	13.3	53.4	26
NaN	NaN	NaN	NaN	NaN	NaN
12.5	0.132	3.17	24.4	45.5	9.37
NaN	NaN	NaN	NaN	NaN	NaN
NaN	NaN	NaN	NaN	NaN	NaN
2.44	0.0698	0.0698	2.09	41.6	41.1
0.161	0.0403	0.644	12.7	56.8	20.9];

WTa=WT(1:3,:);
WTb=WT(4:6,:);
WTc=WT(7:9,:);
WTd=WT(10:12,:);
WTe=WT(13:15,:);
WTf=WT(16:18,:);

KO=[79.5	9.78	2.35	1.57	0.391	0.587
70.6	13.7	4.44	2.38	1.27	0.476
70.1	12.3	1.25	0.624	0.832	2.08
6.49	24.4	29.9	26.2	9.84	1.88
7.45	31	32.1	21.8	5.43	1.24
82.3	2.59	0	0.216	0.216	1.3
2.75	21.4	35.1	28.2	9.12	2.61
2.23	22	32.8	29.9	9.9	2.58
1.9	13.5	29.1	35.2	17.4	3.41
0.622	3.99	21.7	43	25.4	3.99
0.753	9.94	30.3	35.6	16.5	4.29
0.471	3.7	20.1	43	26.9	5
0.137	0.615	1.91	19.3	54.6	20.1
0.715	9.75	26.5	37.3	18.7	5.52
0.252	0.403	0.755	10.2	40.9	37.5
0	0.122	0.397	4.64	43.5	44.7
0	0.21	0.367	6.08	47.6	41.9
0.0256	0.384	1.18	14.2	51.9	27.3];

KOa=KO(1:3,:);
KOb=KO(4:6,:);
KOc=KO(7:9,:);
KOd=KO(10:12,:);
KOe=KO(13:15,:);
KOf=KO(16:18,:);

peak=[1 2 3 4 5 6];

figure()
subplot(3,2,1)
hold on
plot(peak, KOa, '-ro', 'linewidth', 2)
plot(peak, WTa, '-bo', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold')
xlabel('CTV peak')
ylabel('% Occupancy')
title('0.1ug K5')
box on
subplot(3,2,2)
hold on
plot(peak, KOb, '-ro', 'linewidth', 2)
plot(peak, WTb, '-bo', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold')
xlabel('CTV peak')
ylabel('% Occupancy')
title('1ug K5')
box on
subplot(3,2,3)
hold on
plot(peak, KOc, '-ro', 'linewidth', 2)
plot(peak, WTc, '-bo', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold')
xlabel('CTV peak')
ylabel('% Occupancy')
title('3ug K5')
box on
subplot(3,2,4)
hold on
plot(peak, KOd, '-ro', 'linewidth', 2)
plot(peak, WTd, '-bo', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold')
xlabel('CTV peak')
ylabel('% Occupancy')
title('10ug K5')
box on
subplot(3,2,5)
hold on
plot(peak, KOe, '-ro', 'linewidth', 2)
plot(peak, WTe, '-bo', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold')
xlabel('CTV peak')
ylabel('% Occupancy')
title('30ug K5')
box on
subplot(3,2,6)
hold on
plot(peak, KOf, '-ro', 'linewidth', 2)
plot(peak, WTf, '-bo', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold')
xlabel('CTV peak')
ylabel('% Occupancy')
title('100ug K5')
box on







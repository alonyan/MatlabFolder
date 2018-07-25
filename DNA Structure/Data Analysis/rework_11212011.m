%Rework of rotation experiment 11212011


%Percent occupancy by peak
%A=1ug
%B=10ug
%C=100ug

AWT=[52	25.3	11.9	5.26	0.181	0	0];
BWT=[0	0.468	5.28	25.6	45.4	13.9	1.58];
CWT=[0	3.64e-3	0.197	5.08	40.4	42.3	8.66];

AKO=[0	0.595	4.77	16.2	27.8	29	16.9];
BKO=[0	2.31e-3	0.134	2.14	15.9	40.7	37.1];
CKO=[0	0	7.29e-3	0.187	4.36	25.5	64.6];

Peak=[1 2 3 4 5 6 7];

figure()
subplot(3,1,1)
hold on
plot(Peak, AWT, '-yo', 'linewidth', 2)
plot(Peak, AKO, '--yo', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold')
ylabel('Percent of AdTr cells')
xlabel('CFSE peak')
title('Percent occupancy by CFSE dilution for 1ug K5 @ 48hrs')
box on
subplot(3,1,2)
hold on
plot(Peak, BWT, '-ro', 'linewidth', 2)
plot(Peak, BKO, '--ro', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold')
ylabel('Percent of AdTr cells')
xlabel('CFSE peak')
title('Percent occupancy by CFSE dilution for 10ug K5 @ 48hrs')
box on
subplot(3,1,3)
hold on
plot(Peak, CWT, '-bo', 'linewidth', 2)
plot(Peak, CKO,' --bo', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold')
ylabel('Percent of AdTr cells')
xlabel('CFSE peak')
title('Percent occupancy by CFSE dilution for 100ug K5 @ 48hrs')
box on


%%

%Cell counts by peak
%A=1ug
%B=10ug
%C=100ug

AWT=[859	419	196	87	3	0	0];
BWT=[0	110	1241	6009	10674	3267	372];
CWT=[0	1	54	1395	11078	11598	2375];

AKO=[0	139	1113	3775	6497	6774	3942];
BKO=[0	1	58	925	6851	17595	16006];
CKO=[0	0	5	128	2988	17493	44304];

Peak=[1 2 3 4 5 6 7];

figure()
subplot(3,1,1)
hold on
plot(Peak, AWT, '-yo', 'linewidth', 2)
plot(Peak, AKO, '--yo', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold')
ylabel('Number of AdTr cells')
xlabel('CFSE peak')
title('Number of AdTr cells by CFSE dilution for 1ug K5 @ 48hrs')
box on
subplot(3,1,2)
hold on
plot(Peak, BWT, '-ro', 'linewidth', 2)
plot(Peak, BKO, '--ro', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold')
ylabel('Number of AdTr cells')
xlabel('CFSE peak')
title('Number of AdTr cells by CFSE dilution for 1ug K5 @ 48hrs')
box on
subplot(3,1,3)
hold on
plot(Peak, CWT, '-bo', 'linewidth', 2)
plot(Peak, CKO,' --bo', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold')
ylabel('Number of AdTr cells')
xlabel('CFSE peak')
title('Number of AdTr cells by CFSE dilution for 1ug K5 @ 48hrs')
box on

%%

%Total AdTr cells in snapshot

WT=[1653
23490
27437];

KO=[23344
43200
68558];

Peptide=[1 10 100];

figure()
hold on
plot(Peptide, WT, '-ro', 'linewidth', 2)
plot(Peptide, KO, '-bo', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'xscale', 'log', 'yscale', 'log')
ylabel('Number of AdTr cells in Snapshot')
xlabel('[K5 Peptide], (ug)')
legend('WT', 'IL2KO')
title('Number of AdtR cells in snapshot by Peptide quantity')
box on

%%

%Dose response pSTAT5 (GeoMFI)

AWT=[849
649
758
574
340
526
414];
AWT=AWT-min(AWT);

BWT=[520
564
474
402
298
244
256];
BWT=BWT-min(BWT);

CWT=[936
567
624
523
184
209
128];
CWT=CWT-min(CWT);

AKO=[393
501
468
423
343
151
308];
AKO=AKO-min(AKO);

BKO=[183
275
251
255
120
148
135];
BKO=BKO-min(BKO);

CKO=[428
298
178
268
255
238
303];
CKO=CKO-min(CKO);

IL2=[10000 1000 100 10 1 0.1 0]

figure()
subplot(3,1,1)
hold on
plot(IL2, AWT, '-yo', 'linewidth', 2)
plot(IL2, AKO, '--yo', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'xscale', 'log')
ylabel('GMFI pSTAT5 of CD25+')
xlabel('[IL2], (pM)')
title('pSTAT5 response of AdTr cells to IL2 for 1ug K5')
box on
subplot(3,1,2)
hold on
plot(IL2, BWT, '-ro', 'linewidth', 2)
plot(IL2, BKO, '--ro', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'xscale', 'log')
ylabel('GMFI pSTAT5 of CD25+')
xlabel('[IL2], (pM)')
title('pSTAT5 response of AdTr cells to IL2 for 10ug K5')
box on
subplot(3,1,3)
hold on
plot(IL2, CWT, '-bo', 'linewidth', 2)
plot(IL2, CKO, '--bo', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'xscale', 'log')
ylabel('GMFI pSTAT5 of CD25+')
xlabel('[IL2], (pM)')
title('pSTAT5 response of AdTr cells to IL2 for 100ug K5')
box on
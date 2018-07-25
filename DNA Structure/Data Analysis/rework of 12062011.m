%Rework of rotation work 12062011

%Percent occupancy

%A=0.1ug
%B=1ug
%C=10ug
%D=100ug

AWT=[88.1	6.08	4.07	0.55	0	0
88.3	6.27	3.59	0.48	0.032	0];
AWT=mean(AWT);

BWT=[88.2	5.9	2.33	0.369	0	0
88	6.72	4.4	0.489	0.122	0];
BWT=mean(BWT);

CWT=[0.276	1.14	11.1	37.1	46.6	2.1
0.178	0.961	10.9	34.5	46.9	4.84];
CWT=mean(CWT);

DWT=[0.199	0.0871	3.15	9.78	42.6	41.3
0.0445	0.0519	1.21	4.61	20.6	72.1];
DWT=mean(DWT);

AKO=[89.2	7.09	2.93	0.114	0	0
82.6	11.5	5.05	0.601	0	0];
AKO=mean(AKO);

BKO=[47.9	12.4	14.3	16.1	7.89	0
47.8	11.9	14.1	15.4	9.82	0];
BKO=mean(BKO);

CKO=[4.88	29.8	40.6	13.4	10.3	0
5.38	30	37.2	13.7	12.8	0];
CKO=mean(CKO);

DKO=[0.177	0.584	7.85	26.8	54.3	8.43
0.274	0.878	11.1	29.4	51.4	4.61];
DKO=mean(DKO);

Peak=[1 2 3 4 5 6];

figure()
subplot(4,1,1)
hold on
plot(Peak, AWT, '-yo', 'linewidth', 2)
plot(Peak, AKO, '--yo', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold')
ylabel('Percent of AdTr cells')
xlabel('CFSE peak')
title('Percent occupancy by CFSE dilution for 0.1ug K5 @ 48hrs')
box on
subplot(4,1,2)
hold on
plot(Peak, BWT, '-yo', 'linewidth', 2)
plot(Peak, BKO, '--yo', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold')
ylabel('Percent of AdTr cells')
xlabel('CFSE peak')
title('Percent occupancy by CFSE dilution for 1ug K5 @ 48hrs')
box on
subplot(4,1,3)
hold on
plot(Peak, CWT, '-ro', 'linewidth', 2)
plot(Peak, CKO, '--ro', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold')
ylabel('Percent of AdTr cells')
xlabel('CFSE peak')
title('Percent occupancy by CFSE dilution for 10ug K5 @ 48hrs')
box on
subplot(4,1,4)
hold on
plot(Peak, DWT, '-bo', 'linewidth', 2)
plot(Peak, DKO,' --bo', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold')
ylabel('Percent of AdTr cells')
xlabel('CFSE peak')
title('Percent occupancy by CFSE dilution for 100ug K5 @ 48hrs')
box on

%%

%Rework of rotation work 12062011

%Percent occupancy

%A=0.1ug
%B=1ug
%C=10ug
%D=100ug

AWT=[3204	221	148	20	0	0
2758	196	112	15	1	0];
AWT=mean(AWT);

BWT=[718	48	19	3	0	0
720	55	36	4	1	0];
BWT=mean(BWT);

CWT=[68	281	2741	9137	11459	517
43	232	2639	8322	11332	1169];
CWT=mean(CWT);

DWT=[16	7	253	786	3424	3320
6	7	163	622	2775	9722];
DWT=mean(DWT);

AKO=[3132	249	103	4	0	0
2061	286	126	15	0	0];
AKO=mean(AKO);

BKO=[2631	682	785	885	433	0
2515	626	743	810	517	0];
BKO=mean(BKO);

CKO=[483	2952	4012	1330	1021	0
623	3472	4306	1587	1486	0];
CKO=mean(CKO);

DKO=[100	330	4435	15154	30665	4762
103	330	4168	11048	19318	1732];
DKO=mean(DKO);

Peak=[1 2 3 4 5 6];

figure()
subplot(4,1,1)
hold on
plot(Peak, AWT, '-yo', 'linewidth', 2)
plot(Peak, AKO, '--yo', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold')
ylabel('Number of AdTr cells')
xlabel('CFSE peak')
title('Number of cells by CFSE dilution for 0.1ug K5 @ 48hrs')
box on
subplot(4,1,2)
hold on
plot(Peak, BWT, '-yo', 'linewidth', 2)
plot(Peak, BKO, '--yo', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold')
ylabel('Number of AdTr cells')
xlabel('CFSE peak')
title('Number of cells by CFSE dilution for 1ug K5 @ 48hrs')
box on
subplot(4,1,3)
hold on
plot(Peak, CWT, '-ro', 'linewidth', 2)
plot(Peak, CKO, '--ro', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold')
ylabel('Number of AdTr cells')
xlabel('CFSE peak')
title('Number of cells by CFSE dilution for 10ug K5 @ 48hrs')
box on
subplot(4,1,4)
hold on
plot(Peak, DWT, '-bo', 'linewidth', 2)
plot(Peak, DKO,' --bo', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold')
ylabel('Number of AdTr cells')
xlabel('CFSE peak')
title('Number of cells by CFSE dilution for 100ug K5 @ 48hrs')
box on

zero_WT=[89.6 0 0 0 0 0];

zero_KO=[97.9 0 0 0 0 0];

one_WT=[3.52	15.3	30	29.3	19.6 0];

one_KO=[1.52	4.45	18.7	35.9	39 0];

three_WT=[14.5	39.2	30.1	13	2.08 0];

three_KO=[1.02	1.85	11.1	28.2	31.8 0];

ten_WT=[1.02	0.746	7.05	30.9	29.2	29.7];

ten_KO=[0.331	0.421	1.08	10.6	46.5	39.5];

thirty_WT=[0.399	0.157	0.382	3.21	24	71.8];

thirty_KO=[0.22	0.293	0.607	7.43	47.2	43.6];

hundred_WT=[0.343	0.109	0.238	1.5	10.5	86.1];

hundred_KO=[0.115	0.158	0.503	3.97	45.4	49.8];

Peak=[1 2 3 4 5 6];

WT=[89.6 0 0 0 0 0 3.52	15.3	30	29.3	19.6 0 14.5	39.2	30.1	13	2.08 0 1.02	0.746	7.05	30.9	29.2	29.7 0.399	0.157	0.382	3.21	24	71.8 0.343	0.109	0.238	1.5	10.5	86.1];
KO=[97.9 0 0 0 0 0 1.52	4.45	18.7	35.9	39 0 1.02	1.85	11.1	28.2	31.8 0 0.331	0.421	1.08	10.6	46.5	39.5 0.22	0.293	0.607	7.43	47.2	43.6 0.115	0.158	0.503	3.97	45.4	49.8];
WT=reshape(WT, 6,6)
KO=reshape(KO, 6,6)

WT_percentMax=[0 0 0 29.7 71.8 86.1];
KO_percentMax=[0 0 0 39.5 43.6 49.8];

Peptide=[0.1 1 3 10 30 100];

figure()
hold on
plot(Peptide, WT_percentMax, '-mo' ,'linewidth', 2)
plot(Peptide, KO_percentMax, '-ko', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'xscale', 'log')
ylabel('Percent of cells undergone max divisions')
xlabel('Peptide (ug K5)')
legend('WT', 'KO')
box on
title('Percent of AdTr cells undergone Max Divisions')
%%

figure()
subplot(2,1,1)
hold on
plot(Peak, zero_WT, '-ro', 'linewidth', 2)
plot(Peak, one_WT, '-ko', 'linewidth', 2)
plot(Peak, three_WT, '-mo', 'linewidth', 2)
plot(Peak, ten_WT, '-go', 'linewidth', 2)
plot(Peak, thirty_WT, '-yo', 'linewidth', 2)
plot(Peak, hundred_WT, '-co', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold')
ylabel('Percent Occupancy')
xlabel('Peak')
title('WT')
legend('LPS only', '1ug K5', '3ug', '10ug', '30ug', '100ug')
subplot(2,1,2)
hold on
plot(Peak, zero_KO, '-ro', 'linewidth', 2)
plot(Peak, one_KO, '-ko', 'linewidth', 2)
plot(Peak, three_KO, '-mo', 'linewidth', 2)
plot(Peak, ten_KO, '-go', 'linewidth', 2)
plot(Peak, thirty_KO, '-yo', 'linewidth', 2)
plot(Peak, hundred_KO, '-co', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold')
ylabel('Percent Occupancy')
xlabel('Peak')
title('IL2 KO')

figure()
subplot(2,1,1)
plot(Peak, WT, '-o', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold')
ylabel('Percent Occupancy')
xlabel('Peak')
title('WT')
box on
subplot(2,1,2)
plot(Peak, KO, '-o', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold')
ylabel('Percent Occupancy')
xlabel('Peak')
title('KO')
box on

figure()
subplot(3,2,1)
hold on
plot(Peak, zero_WT, '-mo', 'linewidth', 2)
plot(Peak, zero_KO, '-ko', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold')
ylabel('Percent Occupancy')
xlabel('Peak')
title('LPS only')
legend('WT', 'KO')
subplot(3,2,2)
hold on
plot(Peak, one_WT, '-mo', 'linewidth', 2)
plot(Peak, one_KO, '-ko', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold')
ylabel('Percent Occupancy')
xlabel('Peak')
title('1ug K5')
subplot(3,2,3)
hold on
plot(Peak, three_WT, '-mo', 'linewidth', 2)
plot(Peak, three_KO, '-ko', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold')
ylabel('Percent Occupancy')
xlabel('Peak')
title('3ug K5')
subplot(3,2,4)
hold on
plot(Peak, ten_WT, '-mo', 'linewidth', 2)
plot(Peak, ten_KO, '-ko', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold')
ylabel('Percent Occupancy')
xlabel('Peak')
title('10ug K5')
subplot(3,2,5)
hold on
plot(Peak, thirty_WT, '-mo', 'linewidth', 2)
plot(Peak, thirty_KO, '-ko', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold')
ylabel('Percent Occupancy')
xlabel('Peak')
title('30ug K5')
subplot(3,2,6)
hold on
plot(Peak, hundred_WT, '-mo', 'linewidth', 2)
plot(Peak, hundred_KO, '-ko', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold')
ylabel('Percent Occupancy')
xlabel('Peak')
title('100ug K5')

%%

KO=[3349
17426
21431
21644
40360
34131];

Norm_KO=KO/min(KO)


WT=[2678
12596
6213
25454
41444
46826];
Norm_WT=WT/min(WT)

Peptide=[0.1 1 3 10 30 100];
Peptide_2=[0 1 3 10 30 100]

figure()
hold on
plot(Peptide, WT, '-mo', 'linewidth', 2)
plot(Peptide, KO, '-ko', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'xscale', 'log', 'yscale', 'log')
ylabel('No. of Cells')
xlabel('Peptide (ug K5)')
legend('WT', 'IL2KO')
title('Absolute No. of AdTr Cells')
box on

figure()
hold on
plot(Peptide_2, Norm_WT, '-mo', 'linewidth', 2)
plot(Peptide_2, Norm_KO, '-ko', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'xscale', 'log')
ylabel('Fold Proliferation')
xlabel('Peptide (ug K5)')
legend('WT', 'IL2KO')
title('Fold proliferation of AdTr cells over LPS Control')
box on

%%

KO=[1.72
6.58
10.4
10
12.1
13.3];
WT=[1.61
5.97
2.58
10
21.8
22.5];

Peptide=[0.1 1 3 10 30 100];

figure()
hold on
plot(Peptide, WT, '-mo', 'linewidth', 2)
plot(Peptide, KO, '-ko', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'xscale', 'log')
ylabel('Percentage of CD4+')
xlabel('Peptide (ug K5)')
legend('WT', 'IL2KO')
title('Percent Ag Specific of total CD4+')
box on

%%

%Percent CD25 positive

KO=[3.92 5.52 5.14 5.06 4.66 3.73];

WT=[1.65 3.29 3.09 4.55 5.98 12.9];

Peptide=[0.1 1 3 10 30 100];

figure()
hold on
plot(Peptide, WT, '-mo', 'linewidth', 2)
plot(Peptide, KO, '-ko', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'xscale', 'log')
ylabel('Percent CD25+')
xlabel('Peptide (ug K5)')
legend('WT', 'KO')
title('Percent of AdTr CD25+ at 48 hours')
box on

%%

%Treg CD25 analysis GMFI CD25 of FoxP3+CD4+
Peptide=[0.1 1 3 10 30 100];

KO=[1293
513
1791
1329
1069
1046];

WT=[1146
1662
1393
982
1574
2211];

figure()
hold on
plot(Peptide, WT, '-mo', 'linewidth', 2)
plot(Peptide, KO, '-ko', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'xscale', 'log', 'yscale', 'log')
ylabel('GMFI CD25')
xlabel('Peptide (ug K5)')
legend('WT', 'KO')
title('GMFI CD25 of CD4+FoxP3+')
box on

%%
Peptide=[0.1 1 3 10 30 100];

KO=[11.7
3
5.74
10.8
14.3
10.4];

WT=[10.6
7.28
13.7
6.84
11
13.2];


figure()
hold on
plot(Peptide, WT, '-mo', 'linewidth', 2)
plot(Peptide, KO, '-ko', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'xscale', 'log')
ylabel('%CD25+FoxP3+')
xlabel('Peptide (ug K5)')
legend('WT', 'KO')
title('Percent of CD4 CD25+FoxP3+')
box on

%%

KO_eff=[2115 19001 26994 30174 53550 39151]

WT_eff=[2125 12355 5859 34425 47081 52156];

KO_reg=[28278 12319 16029 29710 61538 34679];
 
WT_reg=[25102 20445 45907 24798 31381 35106];

KO_ratio=KO_eff./KO_reg

WT_ratio=WT_eff./WT_reg

peptide=[0.1 1 3 10 30 100];

figure()
hold on
plot(peptide, WT_ratio, '-mo', 'linewidth', 2)
plot(peptide, KO_ratio, '-ko', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'xscale', 'log')
ylabel('Ratio of Effectors:Treg')
xlabel('Peptide, (ug K5)')
box on
title('Ratio of Teffector:Treg Cells')
legend('WT', 'KO')

%%

%Total CD25 in the system

KO_eff=[2.12e6 8.28e6 9.41e6 7.1e6 1.61e7 1.47e7];

WT_eff=[1.19e6 5.29e6 3.3e6 9.44e6 2.44e7 7.95e7];

KO_reg=[1.18e8 1.18e8 1.63e8 1.18e8 1.19e8 1.27e8];

WT_reg=[8.7e7 7.64e7 1.32e8 9.89e7 1.47e8 2.57e8];

KO=KO_eff./KO_reg;
WT=WT_eff./WT_reg;

peptide=[0.1 1 3 10 30 100];

figure()
subplot(1,3,1)
hold on
plot(peptide, WT_eff, '-mo', 'linewidth', 2)
plot(peptide, KO_eff, '-ko', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'xscale', 'log', 'yscale', 'log')
xlabel('Peptide, (ug K5)')
ylabel('Integral CD25*Cell No.')
title('Total CD25 for Teffs')
box on
%legend('WT', 'KO')
subplot(1,3,2)
hold on
plot(peptide, WT_reg, '-mo', 'linewidth', 2)
plot(peptide, KO_reg, '-ko', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'xscale', 'log', 'yscale', 'log', 'ylim', ([1e7 1e9]))
xlabel('Peptide, (ug K5)')
ylabel('Integral CD25*Cell No.')
title('Total CD25 for Tregs')
box on
subplot(1,3,3)
hold on
plot(peptide, WT, '-mo', 'linewidth', 2)
plot(peptide, KO, '-ko', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'xscale' ,'log')
xlabel('Peptide, (ug K5)')
ylabel('Integral CD25*Cell No. Teff/Treg')
box on
title('Ratio of Total CD25 for Teff versus Treg')

%%

%Treg percentage of CD4

WT=[15
9.69
19.1
9.77
16.5
16.9];

KO=[14.5
4.66
7.76
13.7
18.5
13.5];

peptide=[0.1 1 3 10 30 100];

figure()
hold on
plot(peptide, WT, '-mo', 'linewidth', 2)
plot(peptide, KO, '-ko', 'linewidth', 2)
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'xscale', 'log')
set(gcf, 'color', 'w')
ylabel('% of CD4')
xlabel('Peptide, (ug K5)')
box on
title('Treg percentage of CD4')
legend('WT', 'KO')

%%

%Cutoff at 10^3 for CD25 on Tregs and Effectors CD25 quantification

WT_reg=[7.91e7 1.04e8 1.47e8 8.82e7 1.33e8 2.42e8];
WT_eff=[6.1e5 3.34e6 1.87e6 5.17e6 1.82e7 7.15e7];
WT=WT_eff./WT_reg;

KO_reg=[1.01e8 6.99e7 1.17e8 1.03e8 1.76e8 1.14e8];
KO_eff=[1.2e6 4.77e6 5.66e6 3.61e6 9.13e6 8.7e6];
KO=KO_eff./KO_reg;

peptide=[0.1 1 3 10 30 100];

figure()
subplot(3,1,1)
hold on
plot(peptide, WT_reg, '-mo', 'linewidth', 2)
plot(peptide, KO_reg, '-ko', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'xscale', 'log', 'yscale', 'log', 'Ylim', ([1e8 1e9]))
xlabel('peptide (ug K5)')
ylabel('Integral cell No.*CD25')
box on

title('Total CD25 if cutoff is above 10^3 for Tregs')
subplot(3,1,2)
hold on
plot(peptide, WT_eff, '-mo', 'linewidth', 2)
plot(peptide, KO_eff, '-ko', 'linewidth' ,2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'xscale', 'log', 'yscale',' log')
xlabel('peptide (ug K5)')
ylabel('Integral cell No.*CD25')
box on

title('Total CD25 if cutoff is above 10^3 for Teffs')
subplot(3,1,3)
hold on
plot(peptide, WT, '-mo', 'linewidth', 2)
plot(peptide, KO, '-ko', 'linewidth' ,2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'xscale', 'log')
xlabel('peptide (ug K5)')
ylabel('Integral cell No.*CD25 Teff/Treg')
box on

title('Ratio CD25 for Teffs versus Tregs w/ cutoff')

%%

%Cutoff at 10^3.2 for CD25 Tregs & Effectors CD25 quantification

WT_reg=[7.84e7 6.9e7 1.63e8 9.3e7 1.16e8 2.02e8];
WT_eff=[4.72e5 1.2e7 5.51e6 4.18e7 7.65e7 1.8e8];
WT=WT_eff./WT_reg;

KO_reg=[7.28e7 1.3e8 1.54e8 2.4e8 1.57e8 2.62e8];
KO_eff=[2.21e6 3.24e7 2.45e7 3.37e7 6.84e7 4.11e7];
KO=KO_eff./KO_reg;

peptide=[0.1 1 3 10 30 100];

figure()
subplot(1,3,1)
hold on
plot(peptide, WT_eff, '-mo', 'linewidth', 2)
plot(peptide, KO_eff, '-ko', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'xscale', 'log', 'yscale', 'log')
xlabel('peptide (ug K5)')
ylabel('Integral cell No.*CD25')
box on
title('Total CD25 if cutoff is above 10^3 for Teffs')
subplot(1,3,2)
hold on
plot(peptide, WT_reg, '-mo', 'linewidth', 2)
plot(peptide, KO_reg, '-ko', 'linewidth' ,2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'xscale', 'log', 'yscale',' log')
xlabel('peptide (ug K5)')
ylabel('Integral cell No.*CD25')
box on
title('Total CD25 if cutoff is above 10^3 for Tregs')
subplot(1,3,3)
hold on
plot(peptide, WT, '-mo', 'linewidth', 2)
plot(peptide, KO, '-ko', 'linewidth' ,2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'xscale', 'log')
xlabel('peptide (ug K5)')
ylabel('Integral cell No.*CD25 Teff/Treg')
box on
title('Ratio CD25 for Teffs versus Tregs w/ cutoff')

%%
zero_WT=[89.6 0 0 0 0 0];


zero_KO=[97.9 0 0 0 0 0];

one_WT=[3.52	15.3	30	29.3	19.6 0];

one_KO=[1.52	4.45	18.7	35.9	39 0];

three_WT=[14.5	39.2	30.1	13	2.08 0];

three_KO=[1.02	1.85	11.1	28.2	31.8 0];

ten_WT=[1.02	0.746	7.05	30.9	29.2	29.7];

ten_KO=[0.331	0.421	1.08	10.6	46.5	39.5];

thirty_WT=[0.399	0.157	0.382	3.21	24	71.8];

thirty_KO=[0.22	0.293	0.607	7.43	47.2	43.6];

hundred_WT=[0.343	0.109	0.238	1.5	10.5	86.1];

hundred_KO=[0.115	0.158	0.503	3.97	45.4	49.8];

Peak=[1 2 3 4 5 6];

%% % Treg GMFI

CD25_GMFI=[1457
1617
1597
1545
1581
1761
1784
1616
1751
1676
1749
2238];

CD25_GMFI=reshape(CD25_GMFI, 2,6)

peptide=[0.1 1 3 10 30 100];

figure()
plot(peptide, CD25_GMFI, '-o', 'linewidth', 2)
set(gca,'Fontweight', 'bold', 'Fontsize', 16, 'xscale', 'log', 'yscale', 'log', 'Ylim', [10e2 10e3])
set(gcf, 'color', 'w')
box on
legend('IL2KO', 'WT')

%% %Treg numbers

Count=[54880
28561
52466
49225
73533
43142
31110
45858
56607
35774
51548
66953];

Count=reshape(Count, 2,6)

peptide=[0.1 1 3 10 30 100];

figure()
plot(peptide, Count, '-o', 'linewidth', 2)
set(gca,'Fontweight', 'bold', 'Fontsize', 16, 'xscale', 'log', 'yscale', 'log', 'Ylim', [10e3 10e5])
set(gcf, 'color', 'w')
box on
legend('IL2KO', 'WT')



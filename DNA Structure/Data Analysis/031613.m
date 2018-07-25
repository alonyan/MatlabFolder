%AdTR frequency & count

WT_count=[2096 6575 9223 9412 16559 15396];
WT_frequency=[0.451 2.84 3.41 7.47 8.35 8.61];

WT_count_2=WT_count./min(WT_count);

KO_count=[1829 5517 7681 7005 13140 14111];
KO_frequency=[0.394 2.39 2.84 5.56 6.62 7.89];

KO_count_2=KO_count./min(KO_count);

Peptide=[0.1 1 3 10 30 100];

figure()
subplot(1,2,1)
hold on
plot(Peptide, WT_frequency, '-mo', 'linewidth', 2)
plot(Peptide, KO_frequency, '-ko', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'xscale', 'log')
ylabel('% of CD4')
xlabel('Peptide, (ug K5)')
title('Percent AdTr of total CD4')
legend('WT', 'KO')
box on
subplot(1,2,2)
hold on
plot(Peptide, WT_count, '-mo', 'linewidth', 2)
plot(Peptide, KO_count, '-ko', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'xscale', 'log', 'yscale' ,'log')
ylabel('No. of Cells')
xlabel('Peptide, (ug K5)')
title('Total AdTr Cells')
box on


figure()
subplot(1,2,1)
hold on
plot(Peptide, WT_frequency, '-mo', 'linewidth', 2)
plot(Peptide, KO_frequency, '-ko', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'xscale', 'log')
ylabel('% of CD4')
xlabel('Peptide, (ug K5)')
title('Percent AdTr of total CD4')
legend('WT', 'KO')
box on
subplot(1,2,2)
hold on
plot(Peptide, WT_count_2, '-mo', 'linewidth' ,2)
plot(Peptide, KO_count_2, '-ko', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'xscale', 'log')
ylabel('Fold Proliferation')
xlabel('Peptide, (ug K5)')
title('Fold Proliferation over LPS Control')
box on

%%

%AdTr percent occupancy in each dye peak

WT=[83.4	6.97	2.29	2.1	1.05	1.05 0 
8.82	7.6	34.3	33.4	9.57	1.48 0
4.15	4.69	25.8	41.5	18	6.6 0
3.02	2.92	23.1	43.2	20	10 0
0.761	0.809	5.45	12.1	66.1	8.91 0 
1.09	1.63	16.7	52.2	25.5	4.54 0];

WT=reshape(WT,6, 7);

KO=[94.9	0.929	1.2	0.984	0.82	0.875 0
2.88	20.5	35.3	30.5	7.43	2.97 0
1.38	11.5	33.7	34.7	14.2	1.3 0
2.56	13.1	31.4	34.5	17.5	1.68 0
0.342	2.63	29	63.7	3.47	0.974 0
0.524	4.26	19.9	50.7	26.2	1.64 0];

KO=reshape(KO, 6,7);

Peak=[1 2 3 4 5 6 7];

figure()
subplot(1,2,1)
plot(Peak, WT, '-o', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold')
ylabel('% Occupancy')
xlabel('Dye Peak')
title('Percent of WT AdTr cells in each Peak')
legend('LPS', '1ug', '3ug', '10ug', '30ug', '100ug')
box on
subplot(1,2,2)
plot(Peak, KO, '-o', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold')
ylabel('% Occupancy')
xlabel('Dye Peak')
title('Percent of KO AdTr cells in each Peak')
legend('LPS', '1ug', '3ug', '10ug', '30ug', '100ug')
box on

figure()
hold on
plot(Peak, WT, '-o', 'linewidth', 2)
plot(Peak, KO, '--o', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold')
ylabel('% Occupancy')
xlabel('Dye Peak')
title('Percent of AdTr cells in each Peak')
legend('LPS', '1ug', '3ug', '10ug', '30ug', '100ug')
box on

%%

LPS_WT=[83.4	6.97	2.29	2.1	1.05	1.05];
LPS_KO=[94.9	0.929	1.2	0.984	0.82	0.875];
One_WT=[8.82	7.6	34.3	33.4	9.57	1.48];
One_KO=[2.88	20.5	35.3	30.5	7.43	2.97];
Three_WT=[4.15	4.69	25.8	41.5	18	6.6];
Three_KO=[1.38	11.5	33.7	34.7	14.2	1.3];
Ten_WT=[3.02	2.92	23.1	43.2	20	10];
Ten_KO=[2.56	13.1	31.4	34.5	17.5	1.68];
Thirty_WT=[0.761	0.809	5.45	12.1	66.1	8.91];
Thirty_KO=[0.342	2.63	29	63.7	3.47	0.974];
Hundred_WT=[1.09	1.63	16.7	52.2	25.5	4.54];
Hundred_KO=[0.524	4.26	19.9	50.7	26.2	1.64];

peak=[1 2 3 4 5 6];

figure()
subplot(3,2,1)
hold on
plot(peak, LPS_WT, '-mo', 'linewidth', 2)
plot(peak, LPS_KO, '-ko', 'linewidth', 2)
set(gca, 'Fontsize', 16, 'Fontweight', 'bold')
set(gcf, 'color', 'w')
xlabel('Dye Peak')
ylabel('Percent Occupancy')
box on
title('LPS')
legend('WT', 'KO')
subplot(3,2,2)
hold on
plot(peak, One_WT, '-mo', 'linewidth', 2)
plot(peak, One_KO, '-ko', 'linewidth', 2)
set(gca, 'Fontsize', 16, 'Fontweight', 'bold')
xlabel('Dye Peak')
ylabel('Percent Occupancy')
box on
title('1ug')
subplot(3,2,3)
hold on
plot(peak, Three_WT, '-mo', 'linewidth', 2)
plot(peak, Three_KO, '-ko', 'linewidth', 2)
set(gca, 'Fontsize', 16, 'Fontweight', 'bold')
xlabel('Dye Peak')
ylabel('Percent Occupancy')
box on
title('3ug')
subplot(3,2,4)
hold on
plot(peak, Ten_WT, '-mo', 'linewidth', 2)
plot(peak, Ten_KO, '-ko', 'linewidth', 2)
set(gca, 'Fontsize', 16, 'Fontweight', 'bold')
xlabel('Dye Peak')
ylabel('Percent Occupancy')
box on
title('10ug')
subplot(3,2,5)
hold on
plot(peak, Thirty_WT, '-mo', 'linewidth', 2)
plot(peak, Thirty_KO, '-ko', 'linewidth', 2)
set(gca, 'Fontsize', 16, 'Fontweight', 'bold')
xlabel('Dye Peak')
ylabel('Percent Occupancy')
box on
title('30ug')
subplot(3,2,6)
hold on
plot(peak, Hundred_WT, '-mo', 'linewidth', 2)
plot(peak, Hundred_KO, '-ko', 'linewidth', 2)
set(gca, 'Fontsize', 16, 'Fontweight', 'bold')
xlabel('Dye Peak')
ylabel('Percent Occupancy')
box on
title('100ug')

%%

%Total CD25 in the system

WT=[7.71e5 1.77e6 2.44e6 2.72e6 1.03e7 3.24e6];
KO=[3.58e5 1.41e6 2.14e6 2.03e6 1.85e7 2.96e6];
Reg=[1.62e8 4.77e7 1.0e8 3.89e7 1.61e8 7.51e7];

WT_ratio=WT./Reg;
KO_ratio=KO./Reg;

Peptide=[0.1 1 3 10 30 100];
%%

figure()
subplot(1,3,1)
hold on
plot(Peptide, WT, '-mo', 'linewidth', 2)
plot(Peptide, KO, '-ko', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'xscale', 'log', 'yscale', 'log')
ylabel('Integral CD25*Cell No.')
xlabel('Peptide, (ug K5)')
title('CD25 Teffs')
legend('WT', 'KO')
box on
subplot(1,3,2)
plot(Peptide, Reg, '-o', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'xscale', 'log', 'yscale', 'log')
ylabel('Integral CD25*Cell No.')
xlabel('Peptide, (ug K5)')
title('CD25 Tregs')
box on
subplot(1,3,3)
hold on
plot(Peptide, WT_ratio, '-mo', 'linewidth', 2)
plot(Peptide, KO_ratio, '-ko', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'xscale', 'log')
ylabel('Integral CD25*Cell No. for Eff/Reg')
xlabel('Peptide, (ug K5)')
title('Ratio CD25 Effectors:Tregs')
box on
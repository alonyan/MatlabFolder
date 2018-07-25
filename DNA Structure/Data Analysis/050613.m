%Percent CFSE+ or CTV+ of CD4+ WT and KO solo

PerWT=[12.3 11.6 8.86 5.91 1.01];

PerKO=[8.94 12.3 7.72 4.13 3.19];

NoWT=[10528 10528 6926 5064 1233];

NoKO=[8348 11959 7151 3801 2681];

Peptide=[100 30 10 3 1];

figure()
subplot(2,1,1)
hold on
plot(Peptide, PerWT, '-ro', 'linewidth', 2)
plot(Peptide, PerKO, '-bo', 'linewidth', 2)
set(gca,'Fontweight', 'bold', 'Fontsize', 16, 'xscale', 'log')
set(gcf, 'color', 'w')
ylabel('% AdTr of total CD4')
xlabel('[Antigen], (ug K5)')
title('Percent of AdTr of total CD4+')
legend('WT', 'KO')
box on
subplot(2,1,2)
hold on
plot(Peptide, NoWT, '-ro', 'linewidth', 2)
plot(Peptide, NoKO, '-bo', 'linewidth', 2)
set(gca, 'Fontweight', 'bold', 'Fontsize', 16, 'xscale', 'log', 'yscale', 'log')
set(gcf, 'color', 'w')
ylabel('No. of AdTr Cells')
xlabel('[Antigen], (ug K5)')
title('Number of AdTr Cells')
box on

%%
%Percent CFSE+ or CTV+ of CD4 WT and KO co-transferred 

PerWT=[2.02 4.65 3.59 2.48 1.56];

PerKO=[2.07 4.55 3.84 2.69 1.65];

NoWT=[1667 4126 3177 2121 1374];

NoKO=[1710 4037 3397 2300 1447];

Peptide=[100 30 10 3 1];

figure()
subplot(2,1,1)
hold on
plot(Peptide, PerWT, '-ro', 'linewidth', 2)
plot(Peptide, PerKO, '-bo', 'linewidth', 2)
set(gca,'Fontweight', 'bold', 'Fontsize', 16, 'xscale', 'log')
set(gcf, 'color', 'w')
ylabel('% AdTr of total CD4')
xlabel('[Antigen], (ug K5)')
title('Percent of AdTr of total CD4+')
legend('WT', 'KO')
box on
subplot(2,1,2)
hold on
plot(Peptide, NoWT, '-ro', 'linewidth', 2)
plot(Peptide, NoKO, '-bo', 'linewidth', 2)
set(gca, 'Fontweight', 'bold', 'Fontsize', 16, 'xscale', 'log', 'yscale', 'log')
set(gcf, 'color', 'w')
ylabel('No. of AdTr Cells')
xlabel('[Antigen], (ug K5)')
title('Number of AdTr Cells')
box on

%%

%Percent Occupancy for CFSE versus CTV - Cotransfer

One_CoT=[0.655	6.33	25.3	36.8	23.9	4.08	2.84
11.8	13.6	26.3	30.3	15.4	2.14	0.553];

Three_CoT=[0.849	4.48	20.5	37.9	28.7	5.56	1.7
6.17	8.78	25.8	34.5	21	2.7	0.522];

Ten_CoT=[0.0944	0.283	3.81	23.4	48	22.1	2.11
1.65	1.8	8.07	31.6	44.9	11.2	0.765];

Thirty_CoT=[0	0.0242	0.339	5.87	42.4	46.8	4.97
0.718	0.991	2.28	14.8	53.1	27	1.16];

Hund_CoT=[0.18	1.74	10.8	27	38.8	19.4	1.92
3.92	6.96	15.7	31.5	32.3	8.19	0.877];

Peak=[1 2 3 4 5 6 7];

figure()
subplot(3,2,1)
plot(Peak, One_CoT, '-o', 'linewidth', 2)
set(gca, 'Fontweight', 'bold', 'Fontsize', 16)
set(gcf, 'color', 'w')
xlabel('Dye Dilution')
ylabel('% of AdTr Cells')
legend('WT', 'KO')
title('1ug K5 - Co-Transfer')
subplot(3,2,2)
plot(Peak, Three_CoT, '-o', 'linewidth', 2)
set(gca, 'Fontweight', 'bold', 'Fontsize', 16)
set(gcf, 'color', 'w')
xlabel('Dye Dilution')
ylabel('% of AdTr Cells')
title('3ug K5 - Co-Transfer')
subplot(3,2,3)
plot(Peak, Ten_CoT, '-o', 'linewidth', 2)
set(gca, 'Fontweight', 'bold', 'Fontsize', 16)
set(gcf, 'color', 'w')
xlabel('Dye Dilution')
ylabel('% of AdTr Cells')
title('10ug K5 - Co-Transfer')
subplot(3,2,4)
plot(Peak, Thirty_CoT, '-o', 'linewidth', 2)
set(gca, 'Fontweight', 'bold', 'Fontsize', 16)
set(gcf, 'color', 'w')
xlabel('Dye Dilution')
ylabel('% of AdTr Cells')
title('30ug K5 - Co-Transfer')
subplot(3,2,5)
plot(Peak, Hund_CoT, '-o', 'linewidth', 2)
set(gca, 'Fontweight', 'bold', 'Fontsize', 16)
set(gcf, 'color', 'w')
xlabel('Dye Dilution')
ylabel('% of AdTr Cells')
title('100ug K5 - Co-Transfer')

%%

%Percent Occupancy for CFSE versus CTV - Solo Transfers

One_Solo=[094.4	0.811	0	0.0811	0.0811	0.0811	0.243
16	25.1	28.8	20.2	7.61	1.68	0.522];

Three_Solo=[0.494	5.11	23	38.7	26.8	4.54	0.849
7.89	12.9	30.7	31.4	14.5	2	0.474];

Ten_Solo=[0.0578	0.924	8.95	32.3	42.8	13.6	1.27
1.52	2.27	10	33.3	43.1	9.19	0.545];

Thirty_Solo=[0.0343	0.0429	0.343	4.67	39.5	52.3	3.75
0.452	0.477	1.75	13.8	56	26.8	0.97];

Hund_Solo=[0.0285	0.019	0.114	1.23	24.2	70	5.46
0.0839	0.132	0.299	6.11	64	28.9	0.755];

Peak=[1 2 3 4 5 6 7];

figure()
subplot(3,2,1)
plot(Peak, One_Solo, '-o', 'linewidth', 2)
set(gca, 'Fontweight', 'bold', 'Fontsize', 16)
set(gcf, 'color', 'w')
xlabel('Dye Dilution')
ylabel('% of AdTr Cells')
legend('WT', 'KO')
title('1ug K5 - Solo-Transfer')
subplot(3,2,2)
plot(Peak, Three_Solo, '-o', 'linewidth', 2)
set(gca, 'Fontweight', 'bold', 'Fontsize', 16)
set(gcf, 'color', 'w')
xlabel('Dye Dilution')
ylabel('% of AdTr Cells')
title('3ug K5 - Solo-Transfer')
subplot(3,2,3)
plot(Peak, Ten_Solo, '-o', 'linewidth', 2)
set(gca, 'Fontweight', 'bold', 'Fontsize', 16)
set(gcf, 'color', 'w')
xlabel('Dye Dilution')
ylabel('% of AdTr Cells')
title('10ug K5 - Solo-Transfer')
subplot(3,2,4)
plot(Peak, Thirty_Solo, '-o', 'linewidth', 2)
set(gca, 'Fontweight', 'bold', 'Fontsize', 16)
set(gcf, 'color', 'w')
xlabel('Dye Dilution')
ylabel('% of AdTr Cells')
title('30ug K5 - Solo-Transfer')
subplot(3,2,5)
plot(Peak, Hund_Solo, '-o', 'linewidth', 2)
set(gca, 'Fontweight', 'bold', 'Fontsize', 16)
set(gcf, 'color', 'w')
xlabel('Dye Dilution')
ylabel('% of AdTr Cells')
title('100ug K5 - Solo-Transfer')





















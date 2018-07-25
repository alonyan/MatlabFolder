Freq=[3.33e-3	5.23e-3
6.41e-3	0.018
1.83	0.519
7.59	1.22
9.37	1.57];

i_CFSE=Freq(:,1);
i_CTV=Freq(:,2);

CFSE=i_CFSE;
CTV=i_CTV;

count=[7	11
20	56
5458	1547
20856	3339
30744	5136];

i_CFSE_C=count(:,1);
i_CTV_C=count(:,2);

CFSE_count=i_CFSE_C;
CTV_count=i_CTV_C;

%Ratio is ratio of a(1)m agonist to K5

Rat=[0.01, 0.1 1 30 100];

figure()
subplot(2,1,1)
hold on
plot(Rat, CFSE, '-ro', 'linewidth' ,2)
plot(Rat, CTV, '-bo', 'linewidth', 2)
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'xscale', 'log')
set(gcf, 'color', 'w')
xlabel('a(1)m agonist to K5')
ylabel('% of CD4 compartment')
title('Percent AdTr of CD4+ Compartment')
legend('5c.c7', 'Tac374')
box on
subplot(2,1,2)
hold on
plot(Rat, CFSE_fold, '-ro', 'linewidth' ,2)
plot(Rat, CTV_fold, '-bo', 'linewidth', 2)
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'xscale', 'log')
set(gcf, 'color', 'w')
xlabel('a(1)m agonist to K5')
ylabel('Fold Proliferation')
title('Fold Proliferation over LPS control')
legend('5c.c7', 'Tac374')
box on

figure()
hold on
plot(Rat, CFSE_count, '-ro', 'linewidth' ,2)
plot(Rat, CTV_count, '-bo', 'linewidth', 2)
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'xscale', 'log', 'yscale', 'log')
set(gcf, 'color', 'w')
xlabel('a(1)m agonist to K5')
ylabel('No. of AdTr Cells')
title('Absolute # of AdTr Cells')
legend('5c.c7', 'Tac374')
box on
%%


CFSE=[85.7	0	0	0	0 
100	0	0	0	0 
2.24	13.9	40.6	38	3.83  
0.0527	0.221	5.54	47	44 
0.0455	0.0813	2.1	39.1	54.1 ];

i_p1=CFSE(1,:);
i_p2=CFSE(2,:);
i_p3=CFSE(3,:);
i_p4=CFSE(4,:);
i_p5=CFSE(5,:);

peak=[1 2 3 4 5];

figure()
hold on
plot(peak, i_p1, '-ko', 'linewidth', 2)
plot(peak, i_p2, '-bo', 'linewidth', 2)
plot(peak, i_p3, '-go', 'linewidth', 2)
plot(peak, i_p4, '-ro', 'linewidth', 2)
plot(peak, i_p5, '-co', 'linewidth', 2)
set(gca, 'Fontsize', 16, 'Fontweight','bold')
set(gcf, 'color', 'w')
xlabel('Dye Peak')
ylabel('Percent occupancy')
title('5c.c7')
legend('LPS', '1ug a(1)m, 0 K5', '1ug a(1)m, 1ug K5', '1ug a(1)m, 30ug K5', '1ug a(1)m, 100ug K5')
box on

CTV=[100 0 0 0 0 
7.14	1.79	17.9	21.4	19.6  
4.14	12.8	34.6	40	6.85 
3.83	9.04	27.3	42.1	15  
3.21	9.66	29.3	41.7	14.1 ];

i_p1=CTV(1,:);
i_p2=CTV(2,:);
i_p3=CTV(3,:);
i_p4=CTV(4,:);
i_p5=CTV(5,:);

figure()
hold on
plot(peak, i_p1, '-ko', 'linewidth', 2)
plot(peak, i_p2, '-bo', 'linewidth', 2)
plot(peak, i_p3, '-go', 'linewidth', 2)
plot(peak, i_p4, '-ro', 'linewidth', 2)
plot(peak, i_p5, '-co', 'linewidth', 2)
set(gca, 'Fontsize', 16, 'Fontweight','bold')
set(gcf, 'color', 'w')
xlabel('Dye Peak')
ylabel('Percent occupancy')
title('Tac374')
legend('LPS', '1ug a(1)m, 0 K5', '1ug a(1)m, 1ug K5', '1ug a(1)m, 30ug K5', '1ug a(1)m, 100ug K5')
box on
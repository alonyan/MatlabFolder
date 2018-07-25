WT_frequency=[4.58	22.2	40.8	27.2	3.3
0.288	3.16	24.4	51.2	19
0	0	3.56	48.7	43.9
0.159	0.159	2.12	41.2	52.5
0	0	0.554	36.3	59.3];

WT_100=WT_frequency(1,:);
WT_30=WT_frequency(2,:);
WT_10=WT_frequency(3,:);
WT_3=WT_frequency(4,:);
WT_1=WT_frequency(5,:);

KO_frequency=[10.8	38.4	31	14.7	4.72
1.81	13.8	34.3	33.5	16.1
0.621	3.3	18.8	43.4	32.4
0.175	0.319	2.06	21.8	69.4
0.0314	0.141	0.707	11.9	80.1];

KO_100=KO_frequency(1,:);
KO_30=KO_frequency(2,:);
KO_10=KO_frequency(3,:);
KO_3=KO_frequency(4,:);
KO_1=KO_frequency(5,:);

Peak=[1 2 3 4 5];

figure()
subplot(2,1,1)
hold on
plot(Peak, WT_100, '-ro', 'linewidth', 2)
plot(Peak, WT_30, '-bo', 'linewidth', 2)
plot(Peak, WT_10, '-yo', 'linewidth', 2)
plot(Peak, WT_3, '-co', 'linewidth', 2)
plot(Peak, WT_1, '-ko', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontweight', 'bold', 'Fontsize', 16, 'ylim', [0, 100])
xlabel('Division')
ylabel('Percent Occupancy')
title('WT')
subplot(2,1,2)
hold on
plot(Peak, KO_100, '-ro', 'linewidth', 2)
plot(Peak, KO_30, '-bo', 'linewidth', 2)
plot(Peak, KO_10, '-yo', 'linewidth', 2)
plot(Peak, KO_3, '-co', 'linewidth', 2)
plot(Peak, KO_1, '-ko', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontweight', 'bold', 'Fontsize', 16, 'ylim', [0, 100])
xlabel('Division')
ylabel('Percent Occupancy')
title('KO')

figure()
subplot(3,2,1)
hold on
plot(Peak, WT_100, '-ro', 'linewidth', 2)
plot(Peak, KO_100, '--ro', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontweight', 'bold', 'Fontsize', 16, 'ylim', [0, 100])
xlabel('Division')
ylabel('Percent Occupancy')
title('100ug K5')
subplot(3,2,2)
hold on
plot(Peak, WT_30, '-bo', 'linewidth', 2)
plot(Peak, KO_30, '--bo', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontweight', 'bold', 'Fontsize', 16, 'ylim', [0, 100])
xlabel('Division')
ylabel('Percent Occupancy')
title('30ug K5')
subplot(3,2,3)
hold on
plot(Peak, WT_10, '-yo', 'linewidth', 2)
plot(Peak, KO_10, '--yo', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontweight', 'bold', 'Fontsize', 16, 'ylim', [0, 100])
xlabel('Division')
ylabel('Percent Occupancy')
title('10ug K5')
subplot(3,2,4)
hold on
plot(Peak, WT_3, '-co', 'linewidth', 2)
plot(Peak, KO_3, '--co', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontweight', 'bold', 'Fontsize', 16, 'ylim', [0, 100])
xlabel('Division')
ylabel('Percent Occupancy')
title('3ug K5')
subplot(3,2,5)
hold on
plot(Peak, WT_1, '-ko', 'linewidth', 2)
plot(Peak, KO_1, '--ko', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontweight', 'bold', 'Fontsize', 16, 'ylim', [0, 100])
xlabel('Division')
ylabel('Percent Occupancy')
title('1ug K5')






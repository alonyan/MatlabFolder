%GMFI pSTAT5 of CD25+ compartment

KO1=[1514
1537
1179
729
435
406
411
414];

KO2=[1066
1022
871
615
464
477
454
486];

KO3=[1505
1425
1156
713
497
480
457
468];

WT1=[1934
1797
1428
524
445
431
395
405];

WT2=[1946
2007
1550
743
460
425
414
428];

WT3=[2049
1930
1456
661
456
421
412
424];

IL2=[10000 1000 100 10 1 0.1 0.01 0];

figure()
hold on
plot(IL2, KO1, '-ro', 'linewidth', 2)
plot(IL2, KO2, '-ro', 'linewidth', 2)
plot(IL2, KO3, '-ro', 'linewidth', 2)
plot(IL2, WT1, '-bo', 'linewidth', 2)
plot(IL2, WT2, '-bo', 'linewidth', 2)
plot(IL2, WT3, '-bo', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'xscale', 'log')
ylabel('GMFI pSTAT5')
xlabel('[IL2], (pM)')
title('pSTAT5 response to IL2 for cRel KO and WT')
box on


%%
%percent pSTAT5 positive of CD25 compartment

KO1=[49.7
48.8
39.4
21.7
2.04
1.21
1.29
0.949];

KO2=[36.8
35.4
28
14.1
2.15
2.04
1.75
2.6];

KO3=[48.2
46.1
37.5
18.1
2.3
1.75
1.9
1.77];

WT1=[55.9
53.9
49.1
3.94
1.93
1.78
0.895
1.13];

WT2=[58.5
58.9
49.7
21.7
3.76
1.94
2.01
1.49];

WT3=[60
58
47.3
16.5
3.2
2
1.82
1.91];

IL2=[10000 1000 100 10 1 0.1 0.01 0];

figure()
hold on
plot(IL2, KO1, '-ro', 'linewidth', 2)
plot(IL2, KO2, '-ro', 'linewidth', 2)
plot(IL2, KO3, '-ro', 'linewidth', 2)
plot(IL2, WT1, '-bo', 'linewidth', 2)
plot(IL2, WT2, '-bo', 'linewidth', 2)
plot(IL2, WT3, '-bo', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'xscale', 'log')
ylabel('percent pSTAT5+ of CD25+')
xlabel('[IL2], (pM)')
title('pSTAT5 response to IL2 for cRel KO and WT')
box on



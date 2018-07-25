%CD25+ 24 hrs

CD25=[18.1
25.1
22.5
14
8.3
3.47
1.81
2.1
33.9
34.7
30.2
18.2
9.39
5.73
6.6
4.12
35.1
36.7
36.6
19.3
8.65
5.6
3.74
2.94];

NoTregs=CD25(1:8);
Tregs=CD25(9:16);
antiIL2=CD25(17:24);

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
title('24 hours')

%%

%CD25+ 72 hours

CD25=[78.4
67.6
70.5
63.7
30
14.8
5.2
3.96
67.7
70.3
78.6
64.6
37.3
12.9
5.16
5.47
86
90.5
85.2
52.3
22.8
9.9
4.2
4.16];

NoTregs=CD25(1:8);
Tregs=CD25(9:16);
antiIL2=CD25(17:24);

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
title('72 hours')

%%

%PD1+ 24 hrs

PD1=[66.1
69
54.4
53.9
63
68
79.8
82.2
78.6
70.4
59.8
56.3
58.5
64.4
80.5
82.9
64.5
50.3
45.7
43.9
62.7
73.7
82.2
85.2];

NoTregs=PD1(1:8);
Tregs=PD1(9:16);
antiIL2=PD1(17:24);

peptide=[5e-6 1e-6 200e-9 40e-9 8e-9 1.6e-9 320e-12 64e-12];

figure()
hold on
plot(peptide, NoTregs, '-bo', 'linewidth', 2)
plot(peptide, Tregs, '-ro', 'linewidth', 2)
plot(peptide, antiIL2, '-go', 'linewidth', 2)
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'xscale', 'log')
set(gcf, 'color', 'w')
ylabel('Percent pD1+')
xlabel('K5 peptide, (M)')
legend('No Tregs', '+Tregs', '+Tregs +anti-IL2')
box on
title('24 hours')

%%

%PD1+ 72 hrs

PD1=[95.8
95.8
91.6
82.3
65
71
71.4
78.2
97.3
97.1
90.5
74.4
73.1
68.6
74.3
83.6
94.4
88.8
73.7
68.6
52.9
57.7
69.6
70.4];

NoTregs=PD1(1:8);
Tregs=PD1(9:16);
antiIL2=PD1(17:24);

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
title('72 hours')

%%

%+IL2 with 320pM [K5]

CD25=[18.5
19.1
16.8
16.5
14.5
11.3
18.3
12.9];

IL2=[5e-9 1e-9 200e-12 40e-12 8e-12 1.6e-12 320e-15 0];

PD1=[77.7
68.3
66.4
67.3
72.9
74.4
72.7
71.4];

figure()
subplot(1,2,1)
plot(IL2, CD25, '-ko', 'linewidth', 1, 'markeredgecolor', 'k', 'markerfacecolor', 'g', 'markersize', 10)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'xscale', 'log', 'ylim', [5 30])
xlabel('[IL2], (M)')
ylabel('%CD25+')
title('%CD25+ for IL2 spiked low peptide activation')
subplot(1,2,2)
plot(IL2, PD1, '-ko', 'linewidth', 1, 'markeredgecolor', 'k', 'markerfacecolor', 'm', 'markersize', 10)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'xscale', 'log', 'ylim', [50 80])
xlabel('[IL2], (M)')
ylabel('%PD1+ among activated cells')
title('%PD1+ among CD25+ for IL2 spiked low peptide activation')

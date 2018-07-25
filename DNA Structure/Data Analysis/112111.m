GMFIpSTAT5_IL2d=[152
188
171
115
107
49.3
95.2
116
139
126
128
72
92.7
99.7
173
130
99.6
121
160
106
132
];
GMFIpSTAT5_IL2s=[251
196
164
146
125
122
107
173
163
142
118
117
114
127
526
307
293
226
113
176
110
]; 
%%
GMFIpSTAT5_IL2d=reshape(GMFIpSTAT5_IL2d, 7,3)

GMFIpSTAT5_IL2s=reshape(GMFIpSTAT5_IL2s, 7,3)

IL2=[0, 1e-13, 1e-12, 1e-11, 1e-10, 1e-9, 1e-8]

couleur=[1 0 0
       0 1 0
       0 0 1
       0.71 0.25 1
       1 0.08 0.59
       0 0 0];
   
 il2=fliplr(IL2)

%%

figure()
hold on
for p=1:3
plot (il2, GMFIpSTAT5_IL2d(:,p), '-o', 'color', couleur (p,:))
end
set(gcf, 'color', [1 1 1])
set(gca, 'Xscale', 'log')
set(gca, 'Yscale', 'log')
xlabel('IL2 (M)')
ylabel('GMFI pSTAT5')
Title('GMFI pSTAT5 IL2-/-')
axis([1e-14 1e-8 40 550])

figure()
hold on
for p=1:3
    plot (il2, GMFIpSTAT5_IL2s(:,p), '-o', 'color', couleur (p,:))
end
set(gcf, 'color', [1 1 1])
set(gca, 'Xscale', 'log')
set(gca, 'Yscale', 'log')
xlabel('IL2 (M)')
ylabel('GMFI pSTAT5')
Title('GMFI pSTAT5 IL2 sufficient')
axis([1e-14 1e-8 40 550])

%%

GMFI_CD25_IL2s=[251
196
164
146
125
122
107
173
163
142
118
117
114
127
526
307
293
226
113
176
110
]

GMFI_CD25_IL2d=[32.4
34.8
32.8
31.7
29.9
24
30.6
30.6
35.2
35.6
36.1
31.7
33.2
36.6
40.3
29.5
36.7
36.2
32.2
40.5
38.9
]
%%
GMFI_CD25_IL2d=reshape(GMFI_CD25_IL2d, 7,3)
GMFI_CD25_IL2s=reshape(GMFI_CD25_IL2s, 7,3)

%%

figure()
hold on
for p=1:3
plot (il2.*1e12, GMFI_CD25_IL2d(:,p), '-o', 'color', couleur(p,:))
end
set(gcf, 'color', [1 1 1])
set(gca, 'Xscale', 'log')
xlabel('IL2 (pM)')
ylabel('GMFI CD25')
Title('GMFI CD25 IL2-/-')
axis([0.1 1e4 10 600])

figure()
hold on
for p=1:3
    plot (il2.*1e12, GMFI_CD25_IL2s(:,p), '-o', 'color', couleur(p,:))
end
set(gcf, 'color', [1 1 1])
set(gca, 'Xscale', 'log')
xlabel('IL2 (pM)')
ylabel('GMFI CD25')
Title('GMFI CD25 IL2 sufficient')
axis([0.1 1e4 10 600])

%%

Peptide=[1 10 100]

Snapshot_CD25_GMFI=[102
90.1
103
145
125
237
]

i_IL2d=[1 3 5]
i_IL2s=[2 4 6]

Snapshot_CD25_GMFI_IL2s=Snapshot_CD25_GMFI(i_IL2s)
Snapshot_CD25_GMFI_IL2d=Snapshot_CD25_GMFI(i_IL2d)

Snapshot_CD25_GMFI_IL2d=reshape(Snapshot_CD25_GMFI_IL2d, 3, 1)
Snapshot_CD25_GMFI_IL2s=reshape(Snapshot_CD25_GMFI_IL2s, 3, 1)

%%
figure()
hold on
    plot(Peptide, Snapshot_CD25_GMFI_IL2d, '-ro') 
    plot(Peptide, Snapshot_CD25_GMFI_IL2s, '-bo') 
set(gcf, 'color', [1 1 1])
set(gca, 'Xscale', 'log')
set(gca, 'Yscale', 'log')
xlabel('Peptide (ug)')
ylabel('GMFI CD25')
Title('GMFI CD25 Snapshot')

%%

Snapshot_pSTAT5_GMFI=[111
98.1
117
142
137
154
]

i_IL2d=[1 3 5]
i_IL2s=[2 4 6]

Snapshot_pSTAT5_GMFI_IL2d=Snapshot_pSTAT5_GMFI(i_IL2d)
Snapshot_pSTAT5_GMFI_IL2s=Snapshot_pSTAT5_GMFI(i_IL2s)

Snapshot_pSTAT5_GMFI_IL2d=reshape(Snapshot_pSTAT5_GMFI_IL2d, 3, 1)
Snapshot_pSTAT5_GMFI_IL2s=reshape(Snapshot_pSTAT5_GMFI_IL2s, 3, 1)
%%
figure()
hold on
plot(Peptide, Snapshot_pSTAT5_GMFI_IL2d, '-ro')
plot(Peptide, Snapshot_pSTAT5_GMFI_IL2s, '-bo')
set(gcf, 'color', [1 1 1])
set(gca, 'Xscale', 'log')
set(gca, 'Yscale', 'log')
Xlabel('Peptide (ug)')
Ylabel('GMFI pSTAT5')
Title('GMFI pSTAT5 Snapshot')

%%

couleur=[1 0.51 0
       1 0.86 0
       0.51 1 0
       0.71 0.25 1
       1 0.08 0.59
       0 0 0];

Peak=[1 2 3 4 5 6 7]

Percent_Occupancy=[0.025	1.03	3.47	12.8	32.9	35.7	12.6
43.5	30.9	13	6.22	1.34	0	0
2.28e-3	0.0457	0.0616	0.895	16.1	52.4	28.2
0	0.501	1.77	17.3	58.5	19.2	0.264
0.0119	0.0312	0.0149	0.0624	3.93	38.4	51.2
0.0171	0.0103	0.0514	1.49	41.5	50.6	6.81
]

i_IL2d=[1 3 5]
i_IL2s=[2 4 6]

Percent_Occupancy_IL2d=Percent_Occupancy(i_IL2d,:)
Percent_Occupancy_IL2s=Percent_Occupancy(i_IL2s,:)

%%
figure()
    plot(Peak, Percent_Occupancy_IL2d)
set(gcf, 'color', [1 1 1])
Xlabel('No. of Divisions')
Ylabel('Percent Occupancy')
Title('Percent Occupancy - Snapshot - IL2-/-')

figure()
plot(Peak, Percent_Occupancy_IL2s)
set(gcf, 'color', [1 1 1])
Xlabel('No. of Divisions')
Ylabel('Percent Occupancy')
Title('Percent Occupancy - Snapshot - IL2 sufficient')
%%
figure()
subplot(1,3,1)
hold on
plot(Peak, Percent_Occupancy_IL2d (1,:), '-ro', 'linewidth', 2)
plot(Peak, Percent_Occupancy_IL2s (1,:), '-bo', 'linewidth', 2)
set(gcf, 'color', [1 1 1])
set(gca, 'Fontsize', 16, 'Fontweight', 'bold')
Xlabel('CFSE Peak')
Ylabel('Percent Occupancy')
Title ('Percent Occupancy-Snapshot-1ug')
legend('IL2 KO', 'WT')
box on
subplot(1,3,2)
hold on
plot(Peak, Percent_Occupancy_IL2d (2,:), '-ro', 'linewidth', 2)
plot(Peak, Percent_Occupancy_IL2s (2,:), '-bo', 'linewidth', 2)
set(gcf, 'color', [1 1 1])
set(gca, 'Fontsize', 16, 'Fontweight', 'bold')
Xlabel('CFSE Peak')
Ylabel('Percent Occupancy')
Title ('Percent Occupancy-Snapshot-10ug')
box on
subplot(1,3,3)
hold on
plot(Peak, Percent_Occupancy_IL2d (3,:), '-ro', 'linewidth', 2)
plot(Peak, Percent_Occupancy_IL2s (3,:), '-bo', 'linewidth', 2)
set(gcf, 'color', [1 1 1])
set(gca, 'Fontsize', 16, 'Fontweight', 'bold')
Xlabel('CFSE Peak')
Ylabel('Percent Occupancy')
Title ('Percent Occupancy-Snapshot-100ug')
box on

%%

Peptide=[1 10 100]

Tregs=[2.48e5
2.49e5
2.45e5
2.98e5
2.21e5
2.59e5
]

i_IL2d=[1 3 5]
i_IL2s=[2 4 6]

No_IL2d=Tregs(i_IL2d,:)
No_IL2s=Tregs(i_IL2s,:)


Tregpercent=[10.6
10.7
10.7
12.9
9.98
11.5
]

Percent_IL2d=Tregpercent(i_IL2d,:)
Percent_IL2s=Tregpercent(i_IL2s,:)

%%
figure()
hold on
plot(Peptide, No_IL2d, '-ro')
plot(Peptide, No_IL2s, '-bo')
set(gcf, 'color', [1 1 1])
set(gca, 'Xscale', 'log')
Xlabel('[Peptide] (ug)')
Ylabel('Treg count')
Title ('Treg count in IL2-/- and IL2 sufficient conditions')

figure()
hold on
plot(Peptide, Percent_IL2d, '-ro')
plot(Peptide, Percent_IL2s, '-bo')
set(gcf, 'color', [1 1 1])
set(gca, 'Xscale', 'log')
Xlabel('[Peptide] (ug)')
Ylabel('Treg percent')
Title ('Treg percentage of endogenous Vb3- T cells')

%%
RBC_count=[2.e6
1.97e6
1.96e6
1.98e6
2.02e6
1.96e6
]

i_IL2d=[1 3 5]
i_IL2s=[2 4 6]


No_IL2d=RBC_count(i_IL2d,:)
No_IL2s=RBC_count(i_IL2s,:)

RBCnormalizedTreg=[1.24E-01
1.26E-01
1.25E-01
1.51E-01
1.09E-01
1.32E-01]

Norm_IL2d=RBCnormalizedTreg(i_IL2d,:)
Norm_IL2s=RBCnormalizedTreg(i_IL2s,:)

Treg_CD25GMFI=[34.2
30.1
34
37
32.2
35.4
];

Treg_IL2d=[1 3 5];
Treg_IL2s=[2 4 6];

Treg_CD25GMFId=Treg_CD25GMFI(Treg_IL2d)
Treg_CD25GMFIs=Treg_CD25GMFI(Treg_IL2s)

%%
figure()
hold on
plot(Peptide, No_IL2d, '-ro')
plot(Peptide, No_IL2s, '-bo')
set(gcf, 'color', [1 1 1])
set(gca, 'Xscale', 'log')
Xlabel('[Peptide] (ug)')
Ylabel('RBC count')
Title('RBC count')

figure()
hold on
plot(Peptide, Norm_IL2d, '-ro')
plot(Peptide, Norm_IL2s, '-bo')
set(gcf, 'color', [1 1 1])
set(gca, 'Xscale', 'log')
Xlabel('[Peptide] (ug)')
Ylabel('RBC Normalized Treg count')
Title('Tregs normalized to RBC counts')

figure()
hold on
plot(Peptide, Treg_CD25GMFId, '-ro')
plot(Peptide, Treg_CD25GMFIs, '-bo')
set(gcf, 'color', [1 1 1])
set(gca, 'Xscale', 'log')
Xlabel('[Peptide] (ug)')
Ylabel('GMFI')
Title('Treg CD25 GMFI')

%%

Count_CD25=[14273
802
26303
16480
44097
23177
];

Count=[25332
1739
45412
25225
71328
31068
];

Peptide=[1 10 100];

i_IL2s=[2 4 6];
i_IL2d=[1 3 5];

Count_IL2s=Count(i_IL2s);
Count_IL2d=Count(i_IL2d);

Count_CD25s=Count_CD25(i_IL2s);
Count_CD25d=Count_CD25(i_IL2d);

Count_CD25s=reshape(Count_CD25s, 1,3);
Count_CD25d=reshape(Count_CD25d, 1,3);

Count_IL2s=reshape(Count_IL2s, 1,3)
Count_IL2d=reshape(Count_IL2d, 1,3)

%%

figure()
hold on
plot(Peptide, Count_IL2s, '-bo', 'linewidth', 1.1) 
plot(Peptide, Count_IL2d, '-ro', 'linewidth', 1.1)
set(gcf, 'color', [1 1 1])
set(gca, 'Xscale', 'log')
set(gca, 'Yscale', 'log')
Xlabel('[Peptide] (ug)')
Ylabel('Absolute No. of cells')
Title('Absolute No. of CSFE+CD4+ cells')

figure()
hold on
plot(Peptide, Count_IL2s, '-bo', 'linewidth', 1.1)
plot(Peptide, Count_IL2d, '-ro', 'linewidth', 1.1)
set(gcf, 'color', [1 1 1])
set(gca, 'Xscale', 'log')
Xlabel('[Peptide] (ug)')
Ylabel('Absolute No. of cells')
Title('Absolute No. of CSFE+CD4+ cells')

figure()
hold on
plot(Peptide, Count_CD25s, '-bo', 'linewidth', 1.1)
plot(Peptide, Count_CD25d, '-ro', 'linewidth', 1.1)
set(gcf, 'color', [1 1 1])
set(gca, 'Xscale', 'log')
Xlabel('[Peptide] (ug)')
Ylabel('Absolute No. of cells')
Title('Absolute No. of Activated CSFE+CD4+ cells')

figure()
hold on
plot(Peptide, Count_CD25s, '-bo', 'linewidth', 1.1)
plot(Peptide, Count_CD25d, '-ro', 'linewidth', 1.1)
set(gcf, 'color', [1 1 1])
set(gca, 'Xscale', 'log')
set(gca, 'Yscale', 'log')
Xlabel('[Peptide] (ug)')
Ylabel('Absolute No. of cells')
Title('Absolute No. of Activated CSFE+CD4+ cells')

%%





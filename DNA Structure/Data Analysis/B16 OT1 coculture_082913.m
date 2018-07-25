%B16 - OT-1 Coculture_082913
%B16 cells (250k per well) were pulsed with 3 different [OVA] (100nM, 10nM, 1nM) for 4 hours.  Sup was then
%removed, cells washed and T cells (CFSE labeled)(10e5) were added.  At each timepoint,
%supernatant was reserved for IFN-gamma ELISA and both cell fractions
%(anything floating and anything adherent) were reserved for FACS.  1/2 of
%cells were live stained & FACSed and the other were fixed/permed.  

%%
%OT's were first gated as CFSE+, CD8+, and then Dapi- (alive).  Percent of OT-1 T cells that were activated (CD69+) over time
%Order is 100nM, 10nM, 1nM, and Unpulsed control

T1=[31 10.2 3.25 2.22
    21.6 6.83 3.47 2.8];

T2=[22.9 12.1 4.04 2.35
    35.1 11.4 4.16 2.06];

T3=[40.1 13.2 5.13 3.37
    41.8 17.3 6.1 3.84];

T4=[29.3 15.1 9.12 5.37
    41.5 18 11.6 10.2];

T5=[27.6 9.18 5.12 5.04
    33.7 15.2 10.7 6.31];

T6=[44.8 19.8 9.9 10.2
    34.6 14.7 7.14 11.4];

T7=[35.8 16.2 19.7 24.2
    27.9 13.3 12.7 18.5];

T8=[33.8 19 17.5 19.2
    39.4 12.5 11.7 9.88];

P1=[T1(:,1), T2(:,1), T3(:,1), T4(:,1), T5(:,1), T6(:,1), T7(:,1), T8(:,1)];
eP1=std(P1);
mP1=mean(P1);

P2=[T1(:,2), T2(:,2), T3(:,2), T4(:,2), T5(:,2), T6(:,2), T7(:,2), T8(:,2)];
eP2=std(P2);
mP2=mean(P2);

P3=[T1(:,3), T2(:,3), T3(:,3), T4(:,3), T5(:,3), T6(:,3), T7(:,3), T8(:,3)];
eP3=std(P3);
mP3=mean(P3);

UP=[T1(:,4), T2(:,4), T3(:,4), T4(:,4), T5(:,4), T6(:,4), T7(:,4), T8(:,4)];
eUP=std(UP);
mUP=mean(UP);

time=[12 24 36 48 60 72 84 96];

figure()
hold on
errorbar(time, mP1, eP1, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
errorbar(time, mP2, eP2, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', [1 0.5 0], 'markersize', 10)
errorbar(time, mP3, eP3, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 10)
errorbar(time, mUP, eUP, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'g', 'markersize', 10)
set(gca, 'Fontsize', 20, 'xgrid', 'on', 'ygrid', 'on')
set(gcf, 'color', 'w')
xlabel('Time, (hours)')
ylabel('%CD69+')
title('Activated Cells over Time')
legend('100nM OVA', '10nm OVA', '1nM OVA', 'Unpulsed control')
box on

%%
%Plot the percentage of B16's alive

%B16's were first gated as CFSE-, then gated for size, then Dapi+/-

%Order is 100nM, 10nM, 1nM, and Unpulsed control

T1=[93.9 95.5 97.4 97.5
    97.7 97 97.5 97.1];

T2=[93.2 92.1 87.1 86.3 
    95.8 93.5 92.7 92.9];

T3=[83.2 92.3 89.7 83.1 
    88.6 87.2 84.4 77.6];

T4=[87.3 79.3 75.8 78.8
    80.2 85 83.4 88.4];

T5=[88.7 87.9 89.6 86.9 
    88.2 89.5 88.2 88.5];

T6=[78.9 79.2 80.8 85.1
    89 86.2 87.5 89.3];

T7=[83.9 82.2 84.7 86.9 
    83 80 81 88.1];

T8=[81.9 82 84.1 85.2
    78 84.2 84.9 86];

P1=[T1(:,1), T2(:,1), T3(:,1), T4(:,1), T5(:,1), T6(:,1), T7(:,1), T8(:,1)];
eP1=std(P1);
mP1=mean(P1);

P2=[T1(:,2), T2(:,2), T3(:,2), T4(:,2), T5(:,2), T6(:,2), T7(:,2), T8(:,2)];
eP2=std(P2);
mP2=mean(P2);

P3=[T1(:,3), T2(:,3), T3(:,3), T4(:,3), T5(:,3), T6(:,3), T7(:,3), T8(:,3)];
eP3=std(P3);
mP3=mean(P3);

UP=[T1(:,4), T2(:,4), T3(:,4), T4(:,4), T5(:,4), T6(:,4), T7(:,4), T8(:,4)];
eUP=std(UP);
mUP=mean(UP);

time=[12 24 36 48 60 72 84 96];

figure()
hold on
errorbar(time, mP1, eP1, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
errorbar(time, mP2, eP2, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', [1 0.5 0], 'markersize', 10)
errorbar(time, mP3, eP3, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 10)
errorbar(time, mUP, eUP, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'g', 'markersize', 10)
set(gca, 'Fontsize', 20, 'ylim', [70 100], 'xgrid', 'on', 'ygrid', 'on')
set(gcf, 'color', 'w')
xlabel('Time, (hours)')
ylabel('%Alive')
title('% of B16s Alive over time')
legend('100nM OVA', '10nm OVA', '1nM OVA', 'Unpulsed control')
box on

%%

%Plot the MFI of H-2Kb on living B16s

%B16's were first gated as CFSE-, then gated for size, then Dapi-

%Order is 100nM, 10nM, 1nM, and Unpulsed control

T1=[1100 780 813 623
    1148 758 714 676];

T2=[2533 1701 987 849
    2212 1811 1036 922];

T3=[3416 1914 728 622
    2771 997 663 545];

T4=[3419 1469 709 633
    3169 1271 837 734];

T5=[6388 1698 1297 1212
    5422 1541 898 903];

T6=[9613 1706 1057 994
    3586 1535 1005 978];

T7=[7374 2802 1869 1480
    5526 2212 1460 1436];

T8=[11015 5243 2560 2393
    22747 3536 2215 2065];

P1=[T1(:,1), T2(:,1), T3(:,1), T4(:,1), T5(:,1), T6(:,1), T7(:,1), T8(:,1)];
eP1=std(P1);
mP1=mean(P1);

P2=[T1(:,2), T2(:,2), T3(:,2), T4(:,2), T5(:,2), T6(:,2), T7(:,2), T8(:,2)];
eP2=std(P2);
mP2=mean(P2);

P3=[T1(:,3), T2(:,3), T3(:,3), T4(:,3), T5(:,3), T6(:,3), T7(:,3), T8(:,3)];
eP3=std(P3);
mP3=mean(P3);

UP=[T1(:,4), T2(:,4), T3(:,4), T4(:,4), T5(:,4), T6(:,4), T7(:,4), T8(:,4)];
eUP=std(UP);
mUP=mean(UP);

time=[12 24 36 48 60 72 84 96];

figure()
hold on
errorbar(time, mP1, eP1, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
errorbar(time, mP2, eP2, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', [1 0.5 0], 'markersize', 10)
errorbar(time, mP3, eP3, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 10)
errorbar(time, mUP, eUP, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'g', 'markersize', 10)
set(gca, 'Fontsize', 20, 'yscale', 'log', 'xgrid', 'on', 'ygrid', 'on')
set(gcf, 'color', 'w')
xlabel('Time, (hours)')
ylabel('log H-2Kb')
title('B16 MHC Expression over time')
legend('100nM OVA', '10nm OVA', '1nM OVA', 'Unpulsed control')
box on

%%
%Plot the percentage of T cells alive

%T cells were first gated as CFSE+, then CD8+, then Dapi-

%Order is 100nM, 10nM, 1nM, and Unpulsed control

T1=[90.1 79.9 81.6 80.8
    88.9 82 80.7 79.8];

T2=[65.5 66.7 58.1 55.3
    71.1 62.1 59.3 51.8];

T3=[70.5 48.5 37.7 34.1
    55 31.8 26.2 23.6];

T4=[48.4 27.6 19.7 21.6
    38.5 22.6 23.2 23.1];

T5=[59.1 38.3 32.4 33.8
    42.5 29.9 25.1 22.7];

T6=[35.3 15.8 15.5 13.2
    33.6 28.3 24 21.3];

T7=[26 16 14.4 18.3
    20.5 14.9 14.4 15];

T8=[24.8 17.1 16.3 21
    32.7 25.9 25.8 27.8];

P1=[T1(:,1), T2(:,1), T3(:,1), T4(:,1), T5(:,1), T6(:,1), T7(:,1), T8(:,1)];
eP1=std(P1);
mP1=mean(P1);

P2=[T1(:,2), T2(:,2), T3(:,2), T4(:,2), T5(:,2), T6(:,2), T7(:,2), T8(:,2)];
eP2=std(P2);
mP2=mean(P2);

P3=[T1(:,3), T2(:,3), T3(:,3), T4(:,3), T5(:,3), T6(:,3), T7(:,3), T8(:,3)];
eP3=std(P3);
mP3=mean(P3);

UP=[T1(:,4), T2(:,4), T3(:,4), T4(:,4), T5(:,4), T6(:,4), T7(:,4), T8(:,4)];
eUP=std(UP);
mUP=mean(UP);

time=[12 24 36 48 60 72 84 96];

figure()
hold on
errorbar(time, mP1, eP1, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
errorbar(time, mP2, eP2, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', [1 0.5 0], 'markersize', 10)
errorbar(time, mP3, eP3, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 10)
errorbar(time, mUP, eUP, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'g', 'markersize', 10)
set(gca, 'Fontsize', 20, 'xgrid', 'on', 'ygrid', 'on')
set(gcf, 'color', 'w')
xlabel('Time, (hours)')
ylabel('%Alive')
title('% of OT-1 cells Alive over time')
legend('100nM OVA', '10nm OVA', '1nM OVA', 'Unpulsed control')
box on
%%
%Plot the Covariance of MHC for B16s over time.  

%Order is 100nM, 10nM, 1nM, and Unpulsed control

T1=[117 136 105 129
    168 192 115 207];

T2=[106 139 203 84.9
    102 107 167 82.5];

T3=[112 115 98 131
    121 128 116 97.9];

T4=[130 154 151 85.5
    132 144 166 89.9];

T5=[102 119 91.9 107
    118 135 156 111];

T6=[94 116 98.1 121
    111 118 118 124];

T7=[86.2 115 126 107
    93.9 109 111 117];

T8=[80.6 93.3 101 86.1 
    66.9 106 94.2 91];

P1=[T1(:,1), T2(:,1), T3(:,1), T4(:,1), T5(:,1), T6(:,1), T7(:,1), T8(:,1)];
eP1=std(P1);
mP1=mean(P1);

P2=[T1(:,2), T2(:,2), T3(:,2), T4(:,2), T5(:,2), T6(:,2), T7(:,2), T8(:,2)];
eP2=std(P2);
mP2=mean(P2);

P3=[T1(:,3), T2(:,3), T3(:,3), T4(:,3), T5(:,3), T6(:,3), T7(:,3), T8(:,3)];
eP3=std(P3);
mP3=mean(P3);

UP=[T1(:,4), T2(:,4), T3(:,4), T4(:,4), T5(:,4), T6(:,4), T7(:,4), T8(:,4)];
eUP=std(UP);
mUP=mean(UP);

time=[12 24 36 48 60 72 84 96];

figure()
hold on
errorbar(time, mP1, eP1, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
errorbar(time, mP2, eP2, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', [1 0.5 0], 'markersize', 10)
errorbar(time, mP3, eP3, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 10)
errorbar(time, mUP, eUP, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'g', 'markersize', 10)
set(gca, 'Fontsize', 20, 'xgrid', 'on', 'ygrid', 'on')
set(gcf, 'color', 'w')
xlabel('Time, (hours)')
ylabel('Covariance')
title('CV of MHC distribution over time')
legend('100nM OVA', '10nm OVA', '1nM OVA', 'Unpulsed control')
box on

%%


%Plot the OVA presentation on living B16s

%B16's were first gated as CFSE-, then gated for size, then Dapi-

%Order is 100nM, 10nM, 1nM, and Unpulsed control

T1=[91.8 120 187 148 
    122 125 145 170];

T2=[155 183 204 174
    198 191 159 187];

T3=[215 233 212 271
    168 256 270 256];

T4=[259 231 242 260
    204 221 288 287];

T5=[310 270 306 294 
    277 284 273 282];

T6=[271 232 235 231
    224 227 236 217];

T7=[252 276 275 271
    246 274 247 260];

T8=[308 304 338 328 
    346 305 289 285];

P1=[T1(:,1), T2(:,1), T3(:,1), T4(:,1), T5(:,1), T6(:,1), T7(:,1), T8(:,1)];
eP1=std(P1);
mP1=mean(P1);

P2=[T1(:,2), T2(:,2), T3(:,2), T4(:,2), T5(:,2), T6(:,2), T7(:,2), T8(:,2)];
eP2=std(P2);
mP2=mean(P2);

P3=[T1(:,3), T2(:,3), T3(:,3), T4(:,3), T5(:,3), T6(:,3), T7(:,3), T8(:,3)];
eP3=std(P3);
mP3=mean(P3);

UP=[T1(:,4), T2(:,4), T3(:,4), T4(:,4), T5(:,4), T6(:,4), T7(:,4), T8(:,4)];
eUP=std(UP);
mUP=mean(UP);

time=[12 24 36 48 60 72 84 96];

figure()
hold on
errorbar(time, mP1, eP1, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
errorbar(time, mP2, eP2, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', [1 0.5 0], 'markersize', 10)
errorbar(time, mP3, eP3, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 10)
errorbar(time, mUP, eUP, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'g', 'markersize', 10)
set(gca, 'Fontsize', 20, 'yscale', 'log', 'xgrid', 'on', 'ygrid', 'on')
set(gcf, 'color', 'w')
xlabel('Time, (hours)')
ylabel('log K^b-Ova')
title('B16 Ova Presentation over time')
legend('100nM OVA', '10nm OVA', '1nM OVA', 'Unpulsed control')
box on



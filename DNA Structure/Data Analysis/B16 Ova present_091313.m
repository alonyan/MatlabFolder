%B16-Ova presentation experiment 9.13.13
%Group 1: 100nM Ova + IFN-g titration to cells at T0
%Group 2: 100nM Ova at T0, at T=4 hr, added IFN-g titration
%Group 3: 100nM Ova at T0, at T=4 hr, wash cells to remove Ova then add
%IFN-g titration.
%Group 4: Titration of IFN-g at T0, at T=4hr, added 100nM Ova
%Group 5: Unpulsed/No IFN-g controls

%%
%Group 1 - GMFI of H-2Kb

MHC=[1463 1255 1125 930 991 968
     1221 1122 1089 900 908 877
     2834 2354 1435 912 796 809
     2697 2229 1346 914 825 771
     7745 5366 1957 770 529 544 
     7050 5520 2008 693 556 543
     41778 29458 9151 1327 678 652
     48517 31062 9400 1229 596 602
     48670 40405 12456 1722 738 696
     53420 36687 11403 1710 702 705];
 
 Cal_APC=[852 1716 11594 35166];
 Cal_APCstand=[16801 79927 791383 2266692];
 

 
 eMHC_1=std(MHC(1:2,:)); eMHC_2=std(MHC(3:4,:)); eMHC_3=std(MHC(5:6,:)); eMHC_4=std(MHC(7:8,:)); eMHC_5=std(MHC(9:10,:));
 mMHC_1=mean(MHC(1:2,:)); mMHC_2=mean(MHC(3:4,:)); mMHC_3=mean(MHC(5:6,:)); mMHC_4=mean(MHC(7:8,:)); mMHC_5=mean(MHC(9:10,:));

 G1e_MHC=[eMHC_1, eMHC_2, eMHC_3, eMHC_4, eMHC_5];
 G1e_MHC=reshape(G1e_MHC, 6,5);
 
 G1m_MHC=[mMHC_1, mMHC_2, mMHC_3, mMHC_4, mMHC_5];
 G1m_MHC=reshape(G1m_MHC, 6,5);
 

 gamma=[10e-9 1e-9 100e-12 10e-12 1e-12 0];
 time=[4 8 12 20 24];
 
figure()
hold on
errorbar(time, G1m_MHC(1,:), G1e_MHC(1,:), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 8)
errorbar(time, G1m_MHC(2,:), G1e_MHC(2,:), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', [1 0.5 0], 'markersize', 8)
errorbar(time, G1m_MHC(3,:), G1e_MHC(3,:), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 8)
errorbar(time, G1m_MHC(4,:), G1e_MHC(4,:), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'g', 'markersize', 8)
errorbar(time, G1m_MHC(5,:), G1e_MHC(5,:), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 8)
errorbar(time, G1m_MHC(6,:), G1e_MHC(6,:), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'c', 'markersize', 8)
set(gca, 'fontsize', 20, 'yscale', 'log', 'xgrid', 'on', 'ygrid', 'on')
set(gcf, 'color', 'w')
xlabel('Time, (hours)')
ylabel('log H-2K^b GMFI')
legend('10nM IFN-\gamma', '1nM', '100pM', '10pM', '1pM', '0')
title('MHC Expression over time +OVA+IFN T0')
box on

OVA=[1852 1617 1441 1203 1386 1336
     1457 1368 1366 1156 1217 1157 
     2196 1861 1451 1346 1330 1326
     2068 1780 1321 1315 1328 1214
     4036 2716 1260 1126 1055 1077 
     3457 2731 1249 974 1085 1062
     12264 7797 2671 1447 1203 1179
     12316 7092 2683 1315 864 1077
     10843 7932 2830 1600 1078 1118 
     10971 7265 2816 1448 1088 1131];
 
 UP=[230 210 176 236 310
     204 228 153 224 379]; UPe=std(UP); UPm=mean(UP);
 UP=[217.0000  219.0000  164.5000  230.0000  344.5000
     217.0000  219.0000  164.5000  230.0000  344.5000
     217.0000  219.0000  164.5000  230.0000  344.5000
     217.0000  219.0000  164.5000  230.0000  344.5000
     217.0000  219.0000  164.5000  230.0000  344.5000
     217.0000  219.0000  164.5000  230.0000  344.5000]; %To make subtraction easier for normalization purposes
 
 Cal_PE=[153 1287 5762 25387];
 Cal_PEstand=[2147 14975 70770 344668];
 
 eOVA_1=std(OVA(1:2,:)); eOVA_2=std(OVA(3:4,:)); eOVA_3=std(OVA(5:6,:)); eOVA_4=std(OVA(7:8,:)); eOVA_5=std(OVA(9:10,:));
 mOVA_1=mean(OVA(1:2,:)); mOVA_2=mean(OVA(3:4,:)); mOVA_3=mean(OVA(5:6,:)); mOVA_4=mean(OVA(7:8,:)); mOVA_5=mean(OVA(9:10,:));

 G1e_OVA=[eOVA_1, eOVA_2, eOVA_3, eOVA_4, eOVA_5];
 G1e_OVA=reshape(G1e_OVA, 6,5);
 
 G1m_OVA=[mOVA_1, mOVA_2, mOVA_3, mOVA_4, mOVA_5];
 G1m_OVA=reshape(G1m_OVA, 6,5);

 gamma=[10e-9 1e-9 100e-12 10e-12 1e-12 0];
 time=[4 8 12 20 24];
 
figure()
hold on
errorbar(time, G1m_OVA(1,:), G1e_OVA(1,:), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 8)
errorbar(time, G1m_OVA(2,:), G1e_OVA(2,:), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', [1 0.5 0], 'markersize', 8)
errorbar(time, G1m_OVA(3,:), G1e_OVA(3,:), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 8)
errorbar(time, G1m_OVA(4,:), G1e_OVA(4,:), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'g', 'markersize', 8)
errorbar(time, G1m_OVA(5,:), G1e_OVA(5,:), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 8)
errorbar(time, G1m_OVA(6,:), G1e_OVA(6,:), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'c', 'markersize', 8)
errorbar(time, UPm, UPe, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'w', 'markersize', 8)
set(gca, 'fontsize', 20, 'yscale', 'log', 'xgrid', 'on', 'ygrid', 'on')
set(gcf, 'color', 'w')
xlabel('Time, (hours)')
ylabel('log K^b-OVA GMFI')
legend('10nM IFN-\gamma', '1nM', '100pM', '10pM', '1pM', '0', 'Unpulsed')
title('OVA Presentation over time +OVA+IFN T0')
box on

G1m_OVA=G1m_OVA-UP; %Subtract out the background

figure()
hold on
plot(G1m_MHC(1,:), G1m_OVA(1,:), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 8)
plot(G1m_MHC(2,:), G1m_OVA(2,:), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', [1 0.5 0], 'markersize', 8)
plot(G1m_MHC(3,:), G1m_OVA(3,:), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 8)
plot(G1m_MHC(4,:), G1m_OVA(4,:), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'g', 'markersize', 8)
plot(G1m_MHC(5,:), G1m_OVA(5,:), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 8)
plot(G1m_MHC(6,:), G1m_OVA(6,:), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'c', 'markersize', 8)
set(gca, 'fontsize', 20, 'yscale', 'log', 'xscale', 'log', 'xgrid', 'on', 'ygrid', 'on', 'ylim', [10e1 10e4])
set(gcf, 'color', 'w')
xlabel('log H-2K^b GMFI')
ylabel('log normalized K^b-OVA GMFI')
legend('10nM IFN-\gamma', '1nM', '100pM', '10pM', '1pM', '0')
title('MHC versus OVA, +OVA+IFN T0')
box on
%%
%Group 2 - GMFI of H-2Kb

MHC=[1034 973 983 974 1020 1004 
     951 910 988 954 995 1009
     928 867 902 758 778 777
     875 843 780 710 707 714
     2098 2018 1203 646 484 498
     2017 1731 1219 611 495 470
     24014 19825 7113 1250 578 572
     22857 19200 7098 1167 614 519
     31283 31189 10918 1816 751 672
     29958 25204 10863 1802 685 602];
 
 eMHC_1=std(MHC(1:2,:)); eMHC_2=std(MHC(3:4,:)); eMHC_3=std(MHC(5:6,:)); eMHC_4=std(MHC(7:8,:)); eMHC_5=std(MHC(9:10,:));
 mMHC_1=mean(MHC(1:2,:)); mMHC_2=mean(MHC(3:4,:)); mMHC_3=mean(MHC(5:6,:)); mMHC_4=mean(MHC(7:8,:)); mMHC_5=mean(MHC(9:10,:));

 G1e_MHC=[eMHC_1, eMHC_2, eMHC_3, eMHC_4, eMHC_5];
 G1e_MHC=reshape(G1e_MHC, 6,5);
 
 G1m_MHC=[mMHC_1, mMHC_2, mMHC_3, mMHC_4, mMHC_5];
 G1m_MHC=reshape(G1m_MHC, 6,5);
 

 gamma=[10e-9 1e-9 100e-12 10e-12 1e-12 0];
 time=[4 8 12 20 24];
 
figure()
hold on
errorbar(time, G1m_MHC(1,:), G1e_MHC(1,:), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 8)
errorbar(time, G1m_MHC(2,:), G1e_MHC(2,:), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', [1 0.5 0], 'markersize', 8)
errorbar(time, G1m_MHC(3,:), G1e_MHC(3,:), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 8)
errorbar(time, G1m_MHC(4,:), G1e_MHC(4,:), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'g', 'markersize', 8)
errorbar(time, G1m_MHC(5,:), G1e_MHC(5,:), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 8)
errorbar(time, G1m_MHC(6,:), G1e_MHC(6,:), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'c', 'markersize', 8)
set(gca, 'fontsize', 20, 'yscale', 'log', 'xgrid', 'on', 'ygrid', 'on')
set(gcf, 'color', 'w')
xlabel('Time, (hours)')
ylabel('log H-2K^b GMFI')
legend('10nM IFN-\gamma', '1nM', '100pM', '10pM', '1pM', '0')
title('MHC Expression over time +OVA @ T0, +IFN at T1')
box on

OVA=[1407 1284 1330 1319 1386 1359
     1206 1141 1328 1262 1328 1368
     1391 1273 1356 1182 1234 1212
     1283 1241 1155 1073 1086 1107
     1691 1649 1125 1047 860 868
     1613 1371 1126 906 855 759
     6199 4851 1907 1223 889 873
     5767 4437 1853 1092 874 779
     6652 5827 2312 1246 1026 1041
     7098 5308 2206 1202 1015 857];
 
 eOVA_1=std(OVA(1:2,:)); eOVA_2=std(OVA(3:4,:)); eOVA_3=std(OVA(5:6,:)); eOVA_4=std(OVA(7:8,:)); eOVA_5=std(OVA(9:10,:));
 mOVA_1=mean(OVA(1:2,:)); mOVA_2=mean(OVA(3:4,:)); mOVA_3=mean(OVA(5:6,:)); mOVA_4=mean(OVA(7:8,:)); mOVA_5=mean(OVA(9:10,:));

 G1e_OVA=[eOVA_1, eOVA_2, eOVA_3, eOVA_4, eOVA_5];
 G1e_OVA=reshape(G1e_OVA, 6,5);
 
 G1m_OVA=[mOVA_1, mOVA_2, mOVA_3, mOVA_4, mOVA_5];
 G1m_OVA=reshape(G1m_OVA, 6,5);
 

 gamma=[10e-9 1e-9 100e-12 10e-12 1e-12 0];
 time=[4 8 12 20 24];
 
figure()
hold on
errorbar(time, G1m_OVA(1,:), G1e_OVA(1,:), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 8)
errorbar(time, G1m_OVA(2,:), G1e_OVA(2,:), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', [1 0.5 0], 'markersize', 8)
errorbar(time, G1m_OVA(3,:), G1e_OVA(3,:), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 8)
errorbar(time, G1m_OVA(4,:), G1e_OVA(4,:), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'g', 'markersize', 8)
errorbar(time, G1m_OVA(5,:), G1e_OVA(5,:), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 8)
errorbar(time, G1m_OVA(6,:), G1e_OVA(6,:), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'c', 'markersize', 8)
errorbar(time, UPm, UPe, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'w', 'markersize', 8)
set(gca, 'fontsize', 20, 'yscale', 'log', 'xgrid', 'on', 'ygrid', 'on', 'ylim', [10e1 10e4])
set(gcf, 'color', 'w')
xlabel('Time, (hours)')
ylabel('log K^b-OVA GMFI')
legend('10nM IFN-\gamma', '1nM', '100pM', '10pM', '1pM', '0', 'Unpulsed')
title('OVA Presentation over time +OVA @ T0, +IFN at T1')
box on

G1m_OVA=G1m_OVA-UP; %Subtract out the background

figure()
hold on
plot(G1m_MHC(1,:), G1m_OVA(1,:), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 8)
plot(G1m_MHC(2,:), G1m_OVA(2,:), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', [1 0.5 0], 'markersize', 8)
plot(G1m_MHC(3,:), G1m_OVA(3,:), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 8)
plot(G1m_MHC(4,:), G1m_OVA(4,:), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'g', 'markersize', 8)
plot(G1m_MHC(5,:), G1m_OVA(5,:), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 8)
plot(G1m_MHC(6,:), G1m_OVA(6,:), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'c', 'markersize', 8)
set(gca, 'fontsize', 20, 'yscale', 'log', 'xscale', 'log', 'xgrid', 'on', 'ygrid', 'on', 'ylim', [10e1 10e4])
set(gcf, 'color', 'w')
xlabel('log H-2K^b GMFI')
ylabel('log normalized K^b-OVA GMFI')
legend('10nM IFN-\gamma', '1nM', '100pM', '10pM', '1pM', '0')
title('MHC versus OVA, +OVA @ T0, +IFN at T1')
box on
%%
%Group 3 - GMFI of H-2Kb

MHC=[922 977 982 988 1039 977
     974 945 933 996 888 989 
     667 721 693 637 616 570
     698 810 674 596 661 593
     1492 1478 902 491 396 412
     1616 1450 900 547 418 388
     24103 19992 6519 1000 434 438
     21141 18696 6470 945 450 432
     37500 34559 13014 1328 513 490
     39868 35677 12788 1386 553 519];
 
 eMHC_1=std(MHC(1:2,:)); eMHC_2=std(MHC(3:4,:)); eMHC_3=std(MHC(5:6,:)); eMHC_4=std(MHC(7:8,:)); eMHC_5=std(MHC(9:10,:));
 mMHC_1=mean(MHC(1:2,:)); mMHC_2=mean(MHC(3:4,:)); mMHC_3=mean(MHC(5:6,:)); mMHC_4=mean(MHC(7:8,:)); mMHC_5=mean(MHC(9:10,:));

 G1e_MHC=[eMHC_1, eMHC_2, eMHC_3, eMHC_4, eMHC_5];
 G1e_MHC=reshape(G1e_MHC, 6,5);
 
 G1m_MHC=[mMHC_1, mMHC_2, mMHC_3, mMHC_4, mMHC_5];
 G1m_MHC=reshape(G1m_MHC, 6,5);
 

 gamma=[10e-9 1e-9 100e-12 10e-12 1e-12 0];
 time=[4 8 12 20 24];
 
figure()
hold on
errorbar(time, G1m_MHC(1,:), G1e_MHC(1,:), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 8)
errorbar(time, G1m_MHC(2,:), G1e_MHC(2,:), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', [1 0.5 0], 'markersize', 8)
errorbar(time, G1m_MHC(3,:), G1e_MHC(3,:), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 8)
errorbar(time, G1m_MHC(4,:), G1e_MHC(4,:), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'g', 'markersize', 8)
errorbar(time, G1m_MHC(5,:), G1e_MHC(5,:), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 8)
errorbar(time, G1m_MHC(6,:), G1e_MHC(6,:), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'c', 'markersize', 8)
set(gca, 'fontsize', 20, 'yscale', 'log', 'xgrid', 'on', 'ygrid', 'on')
set(gcf, 'color', 'w')
xlabel('Time, (hours)')
ylabel('log H-2K^b GMFI')
legend('10nM IFN-\gamma', '1nM', '100pM', '10pM', '1pM', '0')
title('MHC Expression over time +OVA @ T0, WASH & +IFN at T1')
box on

OVA=[1195 1237 1277 1288 1345 1258
     1266 1197 1202 1304 1117 1270
     481 520 513 493 515 422 
     547 676 541 469 565 472
     258 270 224 211 220 237
     216 276 273 342 247 187
     533 471 253 201 214 235
     510 509 242 189 234 221
     997 1075 585 295 336 284
     1113 1081 520 365 347 338];
 
 eOVA_1=std(OVA(1:2,:)); eOVA_2=std(OVA(3:4,:)); eOVA_3=std(OVA(5:6,:)); eOVA_4=std(OVA(7:8,:)); eOVA_5=std(OVA(9:10,:));
 mOVA_1=mean(OVA(1:2,:)); mOVA_2=mean(OVA(3:4,:)); mOVA_3=mean(OVA(5:6,:)); mOVA_4=mean(OVA(7:8,:)); mOVA_5=mean(OVA(9:10,:));

 G1e_OVA=[eOVA_1, eOVA_2, eOVA_3, eOVA_4, eOVA_5];
 G1e_OVA=reshape(G1e_OVA, 6,5);
 
 G1m_OVA=[mOVA_1, mOVA_2, mOVA_3, mOVA_4, mOVA_5];
 G1m_OVA=reshape(G1m_OVA, 6,5);
 

 gamma=[10e-9 1e-9 100e-12 10e-12 1e-12 0];
 time=[4 8 12 20 24];
 
figure()
hold on
errorbar(time, G1m_OVA(1,:), G1e_OVA(1,:), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 8)
errorbar(time, G1m_OVA(2,:), G1e_OVA(2,:), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', [1 0.5 0], 'markersize', 8)
errorbar(time, G1m_OVA(3,:), G1e_OVA(3,:), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 8)
errorbar(time, G1m_OVA(4,:), G1e_OVA(4,:), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'g', 'markersize', 8)
errorbar(time, G1m_OVA(5,:), G1e_OVA(5,:), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 8)
errorbar(time, G1m_OVA(6,:), G1e_OVA(6,:), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'c', 'markersize', 8)
errorbar(time, UPm, UPe, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'w', 'markersize', 8)
set(gca, 'fontsize', 20, 'yscale', 'log', 'xgrid', 'on', 'ygrid', 'on')
set(gcf, 'color', 'w')
xlabel('Time, (hours)')
ylabel('log K^b-OVA GMFI')
legend('10nM IFN-\gamma', '1nM', '100pM', '10pM', '1pM', '0', 'Unpulsed')
title('OVA Presentation over time +OVA @ T0, WASH & +IFN at T1')
box on

G1m_OVA=G1m_OVA-UP; %Subtract out the background

figure()
hold on
plot(G1m_MHC(1,:), G1m_OVA(1,:), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 8)
plot(G1m_MHC(2,:), G1m_OVA(2,:), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', [1 0.5 0], 'markersize', 8)
plot(G1m_MHC(3,:), G1m_OVA(3,:), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 8)
plot(G1m_MHC(4,:), G1m_OVA(4,:), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'g', 'markersize', 8)
plot(G1m_MHC(5,:), G1m_OVA(5,:), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 8)
plot(G1m_MHC(6,:), G1m_OVA(6,:), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'c', 'markersize', 8)
set(gca, 'fontsize', 20, 'yscale', 'log', 'xscale', 'log', 'xgrid', 'on', 'ygrid', 'on','ylim', [10 10e3])
set(gcf, 'color', 'w')
xlabel('log H-2K^b GMFI')
ylabel('log normalized K^b-OVA GMFI')
legend('10nM IFN-\gamma', '1nM', '100pM', '10pM', '1pM', '0')
title('MHC versus OVA, +OVA @ T0, WASH & +IFN at T1')
box on
%%
%Group 4 - GMFI of H-2Kb

MHC=[630 630 620 532 551 566
     690 650 640 572 594 535
     2031 1844 1239 903 745 730
     1936 1913 1265 891 752 715
     6216 5244 1930 770 576 584
     7239 5211 1783 752 610 604
     39462 28181 7533 929 532 493
     38097 29529 8505 936 584 476
     43776 35868 11128 1607 695 558
     42867 39077 12895 1935 843 722];
 
 eMHC_1=std(MHC(1:2,:)); eMHC_2=std(MHC(3:4,:)); eMHC_3=std(MHC(5:6,:)); eMHC_4=std(MHC(7:8,:)); eMHC_5=std(MHC(9:10,:));
 mMHC_1=mean(MHC(1:2,:)); mMHC_2=mean(MHC(3:4,:)); mMHC_3=mean(MHC(5:6,:)); mMHC_4=mean(MHC(7:8,:)); mMHC_5=mean(MHC(9:10,:));

 G1e_MHC=[eMHC_1, eMHC_2, eMHC_3, eMHC_4, eMHC_5];
 G1e_MHC=reshape(G1e_MHC, 6,5);
 
 G1m_MHC=[mMHC_1, mMHC_2, mMHC_3, mMHC_4, mMHC_5];
 G1m_MHC=reshape(G1m_MHC, 6,5);
 

 gamma=[10e-9 1e-9 100e-12 10e-12 1e-12 0];
 time=[4 8 12 20 24];
 
figure()
hold on
errorbar(time, G1m_MHC(1,:), G1e_MHC(1,:), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 8)
errorbar(time, G1m_MHC(2,:), G1e_MHC(2,:), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', [1 0.5 0], 'markersize', 8)
errorbar(time, G1m_MHC(3,:), G1e_MHC(3,:), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 8)
errorbar(time, G1m_MHC(4,:), G1e_MHC(4,:), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'g', 'markersize', 8)
errorbar(time, G1m_MHC(5,:), G1e_MHC(5,:), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 8)
errorbar(time, G1m_MHC(6,:), G1e_MHC(6,:), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'c', 'markersize', 8)
set(gca, 'fontsize', 20, 'yscale', 'log', 'xgrid', 'on', 'ygrid', 'on')
set(gcf, 'color', 'w')
xlabel('Time, (hours)')
ylabel('log H-2K^b GMFI')
legend('10nM IFN-\gamma', '1nM', '100pM', '10pM', '1pM', '0')
title('MHC Expression over time +IFN @ T0, +OVA at T1')
box on

OVA=[254 274 291 290 310 361
     343 317 357 347 370 322
     1656 1505 1116 1165 1010 985
     1567 1508 1141 1104 1024 981
     3343 2685 1253 1018 920 924
     3982 2634 1144 980 985 990
     16764 10471 2897 1177 922 800
     17292 11641 3461 1134 1058 741
     17128 11997 3728 1891 1339 831
     16126 12864 4697 2300 1730 1355];
 
 eOVA_1=std(OVA(1:2,:)); eOVA_2=std(OVA(3:4,:)); eOVA_3=std(OVA(5:6,:)); eOVA_4=std(OVA(7:8,:)); eOVA_5=std(OVA(9:10,:));
 mOVA_1=mean(OVA(1:2,:)); mOVA_2=mean(OVA(3:4,:)); mOVA_3=mean(OVA(5:6,:)); mOVA_4=mean(OVA(7:8,:)); mOVA_5=mean(OVA(9:10,:));

 G1e_OVA=[eOVA_1, eOVA_2, eOVA_3, eOVA_4, eOVA_5];
 G1e_OVA=reshape(G1e_OVA, 6,5);
 
 G1m_OVA=[mOVA_1, mOVA_2, mOVA_3, mOVA_4, mOVA_5];
 G1m_OVA=reshape(G1m_OVA, 6,5);
 

 gamma=[10e-9 1e-9 100e-12 10e-12 1e-12 0];
 time=[4 8 12 20 24];
 
figure()
hold on
errorbar(time, G1m_OVA(1,:), G1e_OVA(1,:), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 8)
errorbar(time, G1m_OVA(2,:), G1e_OVA(2,:), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', [1 0.5 0], 'markersize', 8)
errorbar(time, G1m_OVA(3,:), G1e_OVA(3,:), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 8)
errorbar(time, G1m_OVA(4,:), G1e_OVA(4,:), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'g', 'markersize', 8)
errorbar(time, G1m_OVA(5,:), G1e_OVA(5,:), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 8)
errorbar(time, G1m_OVA(6,:), G1e_OVA(6,:), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'c', 'markersize', 8)
errorbar(time, UPm, UPe, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'w', 'markersize', 8)
set(gca, 'fontsize', 20, 'yscale', 'log', 'xgrid', 'on', 'ygrid', 'on')
set(gcf, 'color', 'w')
xlabel('Time, (hours)')
ylabel('log K^b-OVA GMFI')
legend('10nM IFN-\gamma', '1nM', '100pM', '10pM', '1pM', '0', 'Unpulsed')
title('OVA Presentation over time +IFN @ T0, +OVA at T1')
box on

G1m_OVA=G1m_OVA-UP; %Subtract out the background

figure()
hold on
plot(G1m_MHC(1,:), G1m_OVA(1,:), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 8)
plot(G1m_MHC(2,:), G1m_OVA(2,:), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', [1 0.5 0], 'markersize', 8)
plot(G1m_MHC(3,:), G1m_OVA(3,:), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 8)
plot(G1m_MHC(4,:), G1m_OVA(4,:), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'g', 'markersize', 8)
plot(G1m_MHC(5,:), G1m_OVA(5,:), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 8)
plot(G1m_MHC(6,:), G1m_OVA(6,:), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'c', 'markersize', 8)
set(gca, 'fontsize', 20, 'yscale', 'log', 'xscale', 'log', 'xgrid', 'on', 'ygrid', 'on', 'ylim', [10 10e4])
set(gcf, 'color', 'w')
xlabel('log H-2K^b GMFI')
ylabel('log normalized K^b-OVA GMFI')
legend('10nM IFN-\gamma', '1nM', '100pM', '10pM', '1pM', '0')
title('MHC versus OVA, +IFN @ T0, +OVA at T1')
box on

%%

gamma1_MHC=[0.1342e4    0.2766e4   0.7398e4    4.5148e4   5.1045e4			
            0.0993e4    0.0901e4   0.2057e4    2.3436e4   3.0621e4			
            0.0948e4    0.0683e4   0.1554e4    2.2622e4   3.8684e4			
            0.0660e4    0.1983e4   0.6727e4    3.8779e4   4.3322e4];
    
gamma1_OVA=[0.1437e4    0.1913e4    0.3582e4    1.2060e4    1.0562e4			
			1.0895e3    1.1180e3    1.4875e3    5.7530e3    6.5305e3			
            1.0135e3    0.2950e3    0.0725e3    0.2915e3    0.7105e3					
            0.0081e4    0.1393e4   0.3498e4     1.6798e4    1.6282e4];
               
gamma2_MHC=[0.1188e4    0.2291e4    0.5443e4    3.0260e4    3.8546e4			
            0.0941e4    0.0855e4    0.1875e4    1.9512e4    2.8197e4			
            0.0961e4    0.0766e4    0.1464e4    1.9344e4    3.5118e4			
            0.0640e4    0.1878e4    0.5228e4    2.8855e4    3.7473e4];
    
gamma2_OVA=[0.1275e4    0.1601e4    0.2559e4    0.7215e4    0.7254e4			
            0.9955e3    1.0380e3    1.3455e3    4.4140e3    5.2230e3			
            1.0000e3    0.3790e3    0.1085e3    0.2600e3    0.7335e3			
            0.0078e4    0.1288e4    0.2495e4    1.0826e4    1.2086e4];
        
gamma3_MHC=[0.1107e4    0.1391e4    0.1983e4    0.9275e4    1.1929e4			
            0.0985e4    0.0841e4    0.1211e4    0.7106e4    1.0891e4			
            0.0958e4    0.0683e4    0.0901e4    0.6494e4    1.2901e4			
            0.0630e4    0.1252e4    0.1857e4    0.8019e4    1.2011e4];
    
gamma3_OVA=[0.1187e4    0.1167e4    0.1090e4    0.2447e4    0.2478e4			
            1.1120e3    1.0365e3    0.9610e3    1.6500e3    1.9145e3			
            1.0225e3    0.3080e3    0.0840e3    0.0175e3    0.2080e3			
			0.0107e4    0.0910e4    0.1034e4    0.2949e4    0.3868e4];
        
gamma4_MHC=[0.0915e4    0.0913e4    0.0732e4    0.1278e4    0.1716e4			
            0.0964e4    0.0734e4    0.0629e4    0.1208e4    0.1809e4			
            0.0992e4    0.0617e4    0.0519e4    0.0973e4    0.1357e4			
            0.0552e4    0.0897e4    0.0761e4    0.0932e4    0.1771e4];
    
%Negative values have been replaced with NaN
gamma4_OVA=[0.0963e4    0.1111e4    0.0886e4    0.1151e4    0.1179e4			
            1.0735e3    0.9085e3    0.8120e3    0.9275e3    0.8795e3			
            1.0790e3    0.2620e3    0.1120e3    NaN         NaN		
            0.0101e4    0.0916e4    0.0834e4    0.0925e4    0.1751e4];
        
gamma5_MHC=[0.0950e4    0.0810e4    0.0542e4    0.0637e4    0.0720e4			
            0.1008e4    0.0742e4    0.0490e4    0.0596e4    0.0718e4			
            0.0964e4    0.0639e4    0.0407e4    0.0442e4    0.0533e4			
            0.0573e4    0.0748e4    0.0593e4    0.0558e4    0.0769e4];
    
gamma5_OVA=[0.1085e4    0.1110e4    0.0906e4    0.0804e4    0.0738e4			
            1.1400e3    0.9410e3    0.6930e3    0.6515e3    0.6760e3			
            1.0140e3    0.3210e3    0.0690e3    NaN         NaN			
            0.0123e4    0.0798e4    0.0788e4    0.0760e4    0.1190e4];

gamma6_MHC=[0.0922e4    0.0790e4    0.0544e4    0.0627e4    0.0701e4
            0.1007e4    0.0746e4    0.0484e4    0.0546e4    0.0637e4
            0.0983e4    0.0582e4    0.0400e4    0.0435e4    0.0505e4
            0.0551e4    0.0722e4    0.0594e4    0.0485e4    0.0640e4];
    
gamma6_OVA=[0.1029e4    0.1051e4    0.0905e4    0.0898e4    0.0780e4
            1.1465e3    0.9405e3    0.6490e3    0.5960e3    0.6045e3
            1.0470e3    0.2280e3    0.0475e3   	NaN         NaN
            0.0124e4    0.0764e4    0.0793e4    0.0541e4    0.0748e4];       
        
figure()
subplot(2,3,1)
hold on
plot(gamma1_MHC(1,:), gamma1_OVA(1,:), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
plot(gamma1_MHC(2,:), gamma1_OVA(2,:), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', [1 0.5 0], 'markersize', 10)
plot(gamma1_MHC(3,:), gamma1_OVA(3,:), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
plot(gamma1_MHC(4,:), gamma1_OVA(4,:), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'c', 'markersize', 10)
set(gca, 'fontsize', 20, 'yscale', 'log', 'xscale', 'log', 'xgrid', 'on', 'ygrid', 'on', 'ylim', [10 10e4])
set(gcf, 'color', 'w')
xlabel('log H-2K^b GMFI')
ylabel('log normalized K^b-OVA GMFI')
legend('Group 1', 'Group 2', 'Group 3', 'Group 4')
title('MHC versus OVA - 10nM IFN')
box on
subplot(2,3,2)
hold on
plot(gamma2_MHC(1,:), gamma2_OVA(1,:), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
plot(gamma2_MHC(2,:), gamma2_OVA(2,:), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', [1 0.5 0], 'markersize', 10)
plot(gamma2_MHC(3,:), gamma2_OVA(3,:), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
plot(gamma2_MHC(4,:), gamma2_OVA(4,:), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'c', 'markersize', 10)
set(gca, 'fontsize', 20, 'yscale', 'log', 'xscale', 'log', 'xgrid', 'on', 'ygrid', 'on', 'ylim', [10 10e4])
set(gcf, 'color', 'w')
xlabel('log H-2K^b GMFI')
ylabel('log normalized K^b-OVA GMFI')
title('MHC versus OVA - 1nM IFN')
box on
subplot(2,3,3)
hold on
plot(gamma3_MHC(1,:), gamma3_OVA(1,:), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
plot(gamma3_MHC(2,:), gamma3_OVA(2,:), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', [1 0.5 0], 'markersize', 10)
plot(gamma3_MHC(3,:), gamma3_OVA(3,:), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
plot(gamma3_MHC(4,:), gamma3_OVA(4,:), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'c', 'markersize', 10)
set(gca, 'fontsize', 20, 'yscale', 'log', 'xscale', 'log', 'xgrid', 'on', 'ygrid', 'on', 'ylim', [10 10e4])
set(gcf, 'color', 'w')
xlabel('log H-2K^b GMFI')
ylabel('log normalized K^b-OVA GMFI')
title('MHC versus OVA - 100pM IFN')
box on
subplot(2,3,4)
hold on
plot(gamma4_MHC(1,:), gamma4_OVA(1,:), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
plot(gamma4_MHC(2,:), gamma4_OVA(2,:), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', [1 0.5 0], 'markersize', 10)
plot(gamma4_MHC(3,:), gamma4_OVA(3,:), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
plot(gamma4_MHC(4,:), gamma4_OVA(4,:), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'c', 'markersize', 10)
set(gca, 'fontsize', 20, 'yscale', 'log', 'xscale', 'log', 'xgrid', 'on', 'ygrid', 'on', 'ylim', [10 10e4])
set(gcf, 'color', 'w')
xlabel('log H-2K^b GMFI')
ylabel('log normalized K^b-OVA GMFI')
title('MHC versus OVA - 10pM IFN')
box on
subplot(2,3,5)
hold on
plot(gamma5_MHC(1,:), gamma5_OVA(1,:), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
plot(gamma5_MHC(2,:), gamma5_OVA(2,:), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', [1 0.5 0], 'markersize', 10)
plot(gamma5_MHC(3,:), gamma5_OVA(3,:), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
plot(gamma5_MHC(4,:), gamma5_OVA(4,:), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'c', 'markersize', 10)
set(gca, 'fontsize', 20, 'yscale', 'log', 'xscale', 'log', 'xgrid', 'on', 'ygrid', 'on', 'ylim', [10 10e4])
set(gcf, 'color', 'w')
xlabel('log H-2K^b GMFI')
ylabel('log normalized K^b-OVA GMFI')
title('MHC versus OVA - 1pM IFN')
box on
subplot(2,3,6)
hold on
plot(gamma6_MHC(1,:), gamma6_OVA(1,:), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
plot(gamma6_MHC(2,:), gamma6_OVA(2,:), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', [1 0.5 0], 'markersize', 10)
plot(gamma6_MHC(3,:), gamma6_OVA(3,:), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
plot(gamma6_MHC(4,:), gamma6_OVA(4,:), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'c', 'markersize', 10)
set(gca, 'fontsize', 20, 'yscale', 'log', 'xscale', 'log', 'xgrid', 'on', 'ygrid', 'on', 'ylim', [10 10e4])
set(gcf, 'color', 'w')
xlabel('log H-2K^b GMFI')
ylabel('log normalized K^b-OVA GMFI')
title('MHC versus OVA - Media only')
box on
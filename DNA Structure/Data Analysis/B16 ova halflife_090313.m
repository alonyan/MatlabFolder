%B16 OVA halflife experiment
%Pulsed B16 cells (100k per well) with titration of IFN-gamma and 100nM OVA

%MHC GMFI

t1=[1289 1219 1104 1005 1017 959  
    1247 1220 1053 1033 1040 1048];
e1=std(t1);
t1_m=mean(t1); 
up1=[1020 902];
eup1=std(up1);
eup1_m=mean(up1);

t2=[3703 3226 2098 1290 1003 973
    3577 2957 2021 1253 969 937];
e2=std(t2);
t2_m=mean(t2);
up2=[947 922];
eup2=std(up2);
eup2_m=mean(up2);

t3=[11555 8637 3961 1587 1016 999
    10637 8316 3752 1363 992 974];
e3=std(t3);
t3_m=mean(t3);
up3=[1022 960];
eup3=std(up3);
eup3_m=mean(up3);

t4=[40798 32746 11550 2161 1112 1001
    49050 32421 11383 1893 845 976];
e4=std(t4);
t4_m=mean(t4);
up4=[1042 1035];
eup4=std(up4);
eup4_m=mean(up4);

t5=[86277 71575 25152 2948 1209 1200
    62679 42502 16433 2476 1224 1916];
e5=std(t5);
t5_m=mean(t5);
up5=[1256 1224];
eup5=std(up5);
eup5_m=mean(up5);

IFN=[10e-9 1e-9 100e-12 10e-12 1e-12 0];

%Plot H-2Kb GMFI versus IFN gamma at different time points

figure()
hold on
errorbar(IFN, t1_m, e1, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 8)
errorbar(IFN, t2_m, e2, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', [1 0.5 0], 'markersize', 8)
errorbar(IFN, t3_m, e3, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 8)
errorbar(IFN, t4_m, e4, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'g', 'markersize', 8)
errorbar(IFN, t5_m, e5, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 8)
set(gca, 'Fontsize', 20, 'xscale', 'log', 'yscale', 'log', 'ylim', [1e3 1e5], 'ygrid', 'on', 'xgrid', 'on')
set(gcf, 'color', 'w')
xlabel('log [IFN-\gamma], (M)')
ylabel('log H-2kb GMFI')
legend('4hr', '8hr', '12hr', '20hr', '24hr')
title('MHC expression over time')
box on

%%
%Organizing & Plotting MHC expression over time

mhcgamma1=[t1(:,1), t2(:,1), t3(:,1), t4(:,1), t5(:,1)];
eg1=std(mhcgamma1);
mhcgamma1_m=mean(mhcgamma1);

mhcgamma2=[t1(:,2), t2(:,2), t3(:,2), t4(:,2), t5(:,2)];
eg2=std(mhcgamma2);
mhcgamma2_m=mean(mhcgamma2);

mhcgamma3=[t1(:,3), t2(:,3), t3(:,3), t4(:,3), t5(:,3)];
eg3=std(mhcgamma3);
mhcgamma3_m=mean(mhcgamma3);

mhcgamma4=[t1(:,4), t2(:,4), t3(:,4), t4(:,4), t5(:,4)];
eg4=std(mhcgamma4);
mhcgamma4_m=mean(mhcgamma4);

mhcgamma5=[t1(:,5), t2(:,5), t3(:,5), t4(:,5), t5(:,5)];
eg5=std(mhcgamma5);
mhcgamma5_m=mean(mhcgamma5);

mhcgamma6=[t1(:,6), t2(:,6), t3(:,6), t4(:,6), t5(:,6)];
eg6=std(mhcgamma6);
mhcgamma6_m=mean(mhcgamma6);

unpulsed=[up1, up2, up3, up4, up5];
unpulsed=reshape(unpulsed, 2,5);
e_unpulsed=std(unpulsed);
m_unpulsed=mean(unpulsed);

time=[4 8 12 20 24];

figure()
hold on
errorbar(time, mhcgamma1_m, eg1, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 8)
errorbar(time, mhcgamma2_m, eg2, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', [1 0.5 0], 'markersize', 8)
errorbar(time, mhcgamma3_m, eg3, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 8)
errorbar(time, mhcgamma4_m, eg4, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'g', 'markersize', 8)
errorbar(time, mhcgamma5_m, eg5, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 8)
errorbar(time, mhcgamma6_m, eg6, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'c', 'markersize', 8)
errorbar(time, m_unpulsed, e_unpulsed, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'w', 'markersize', 8)
set(gca, 'Fontsize', 20, 'yscale', 'log', 'xgrid', 'on', 'ygrid', 'on')
set(gcf, 'color', 'w')
xlabel('Time, (hours)')
ylabel('log H-2Kb GMFI')
legend('10nM IFN-\gamma', '1nM', '100pM', '10pM', '1pM', '0', 'Unpulsed')
title('H-2Kb expression over time')
box on
%

%%
%ova GMFI

t1=[1715 1577 1450 1427 1442 1360  
    1600 1595 1433 1455 1490 1509];
e1=std(t1);
t1_m=mean(t1); 
up1=[234 228];
eup1=std(up1);
eup1_m=mean(up1);

t2=[1918 1805 1422 1383 1325 1295
    1818 1621 1325 1280 1263 1229];
e2=std(t2);
t2_m=mean(t2);
up2=[256 248];
eup2=std(up2);
eup2_m=mean(up2);

t3=[1349 1138 870 843 815 804
    1259 1094 795 698 756 757];
e3=std(t3);
t3_m=mean(t3);
up3=[354 324];
eup3=std(up3);
eup3_m=mean(up3);

t4=[1766 1415 566 432 426 390
    1870 1326 540 391 381 356];
e4=std(t4);
t4_m=mean(t4);
up4=[329 326];
eup4=std(up4);
eup4_m=mean(up4);

t5=[2731 2457 776 439 417 349
    2287 1651 638 388 396 836];
e5=std(t5);
t5_m=mean(t5);
up5=[381 333];
eup5=std(up5);
eup5_m=mean(up5);

IFN=[10e-9 1e-9 100e-12 10e-12 1e-12 0];

%Plot OVA GMFI versus IFN gamma at different time points

figure()
hold on
errorbar(IFN, t1_m, e1, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 8)
errorbar(1e-12, eup1_m, eup1, 'ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
errorbar(IFN, t2_m, e2, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', [1 0.5 0], 'markersize', 8)
errorbar(10e-12, eup2_m, eup2, 'ko', 'markeredgecolor', 'k', 'markerfacecolor', [1 0.5 0], 'markersize', 10)
errorbar(IFN, t3_m, e3, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 8)
errorbar(100e-12, eup3_m, eup3, 'ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 10)
errorbar(IFN, t4_m, e4, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'g', 'markersize', 8)
errorbar(1000e-12, eup4_m, eup4, 'ko', 'markeredgecolor', 'k', 'markerfacecolor', 'g', 'markersize', 10)
errorbar(IFN, t5_m, e5, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 8)
errorbar(10000e-12, eup5_m, eup5, 'ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
set(gca, 'Fontsize', 20, 'xscale', 'log', 'yscale', 'log', 'xgrid', 'on', 'ygrid', 'on')
set(gcf, 'color', 'w')
xlabel('log [IFN-\gamma], (M)')
ylabel('log OVA GMFI')
legend('4hr', 'Unpulsed 4h', '8hr', 'Unpulsed 8hr', '12hr', 'Unpulsed 12hr', '20hr', 'Unpulsed 20hr', '24hr', 'Unpulsed 24hr')
title('OVA expression over time')
box on

%%
%Organizing & Plotting OVA presentation over time

gamma1=[t1(:,1), t2(:,1), t3(:,1), t4(:,1), t5(:,1)];
eg1=std(gamma1);
gamma1_m=mean(gamma1);

gamma2=[t1(:,2), t2(:,2), t3(:,2), t4(:,2), t5(:,2)];
eg2=std(gamma2);
gamma2_m=mean(gamma2);

gamma3=[t1(:,3), t2(:,3), t3(:,3), t4(:,3), t5(:,3)];
eg3=std(gamma3);
gamma3_m=mean(gamma3);

gamma4=[t1(:,4), t2(:,4), t3(:,4), t4(:,4), t5(:,4)];
eg4=std(gamma4);
gamma4_m=mean(gamma4);

gamma5=[t1(:,5), t2(:,5), t3(:,5), t4(:,5), t5(:,5)];
eg5=std(gamma5);
gamma5_m=mean(gamma5);

gamma6=[t1(:,6), t2(:,6), t3(:,6), t4(:,6), t5(:,6)];
eg6=std(gamma6);
gamma6_m=mean(gamma6);

unpulsed=[up1, up2, up3, up4, up5];
unpulsed=reshape(unpulsed, 2,5);
e_unpulsed=std(unpulsed);
m_unpulsed=mean(unpulsed);

%Subtract the background from Kb-OVA staining by subtracting GMFI of
%unpulsed control
gamma1_norm=gamma1_m-m_unpulsed;
gamma2_norm=gamma2_m-m_unpulsed; 
gamma3_norm=gamma3_m-m_unpulsed; 
gamma4_norm=gamma4_m-m_unpulsed; 
gamma5_norm=gamma5_m-m_unpulsed; 
gamma6_norm=gamma6_m-m_unpulsed; 

time=[4 8 12 20 24];

figure()
hold on
errorbar(time, gamma1_m, eg1, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 8)
errorbar(time, gamma2_m, eg2, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', [1 0.5 0], 'markersize', 8)
errorbar(time, gamma3_m, eg3, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 8)
errorbar(time, gamma4_m, eg4, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'g', 'markersize', 8)
errorbar(time, gamma5_m, eg5, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 8)
errorbar(time, gamma6_m, eg6, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'c', 'markersize', 8)
errorbar(time, m_unpulsed, e_unpulsed, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'w', 'markersize', 8)
set(gca, 'Fontsize', 20, 'yscale', 'log', 'xgrid', 'on', 'ygrid', 'on')
set(gcf, 'color', 'w')
xlabel('Time, (hours)')
ylabel('log OVA GMFI')
legend('10nM IFN-\gamma', '1nM', '100pM', '10pM', '1pM', '0', 'Unpulsed')
title('OVA expression over time')
box on

%Plot the product of normalized Kb-OVA and MHC
figure()
hold on
plot(mhcgamma1_m, gamma1_norm, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 8)
plot(mhcgamma2_m, gamma2_norm, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', [1 0.5 0], 'markersize', 8)
plot(mhcgamma3_m, gamma3_norm, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 8)
plot(mhcgamma4_m, gamma4_norm, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'g', 'markersize', 8)
plot(mhcgamma5_m, gamma5_norm, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 8)
plot(mhcgamma6_m, gamma6_norm, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'c', 'markersize', 8)
set(gca, 'Fontsize', 20, 'yscale', 'log', 'xscale', 'log', 'xgrid', 'on', 'ygrid', 'on')
set(gcf, 'color', 'w')
xlabel('log H-2Kb GMFI')
ylabel('log Normalized Kb-OVA GMFI')
legend('10nM IFN-\gamma', '1nM', '100pM', '10pM', '1pM', '0')
title('Normalized Kb-OVA*MHC fluorescence')
box on

%%

%Plot the percentage of living cells in the first 24 hours of exposure to
%IFN-gamma

t1=[96.6 95.8 95.7 96.5 96.7 96.2
    97.2 97.8 97.7 97.6 97.8 97.1];
e1=std(t1);
t1_m=mean(t1); 

t2=[97.6 97.6 97.8 97.9 96.8 98.3
    96.6 97.1 97.6 98.1 97.8 97.2];
e2=std(t2);
t2_m=mean(t2);

t3=[96.5 97.8 98.4 98 98.4 98
    93.4 96.8 94.9 96.6 96.7 96.5];
e3=std(t3);
t3_m=mean(t3);

t4=[98.1 99 98.7 99.1 99 99.1
    97.6 98 97.9 98 98.3 98.5];
e4=std(t4);
t4_m=mean(t4);

t5=[97.4 97.8 96.6 98.6 98.6 98.9
    97.3 97.7 96.7 97.9 98.8 96.6];
e5=std(t5);
t5_m=mean(t5);

%Reorganize data to plot the percentage alive over time for each IfN-gamma
%concentration.
gamma1=[t1(:,1), t2(:,1), t3(:,1), t4(:,1), t5(:,1)];
eg1=std(gamma1);
gamma1_m=mean(gamma1);

gamma2=[t1(:,2), t2(:,2), t3(:,2), t4(:,2), t5(:,2)];
eg2=std(gamma2);
gamma2_m=mean(gamma2);

gamma3=[t1(:,3), t2(:,3), t3(:,3), t4(:,3), t5(:,3)];
eg3=std(gamma3);
gamma3_m=mean(gamma3);

gamma4=[t1(:,4), t2(:,4), t3(:,4), t4(:,4), t5(:,4)];
eg4=std(gamma4);
gamma4_m=mean(gamma4);

gamma5=[t1(:,5), t2(:,5), t3(:,5), t4(:,5), t5(:,5)];
eg5=std(gamma5);
gamma5_m=mean(gamma5);

gamma6=[t1(:,6), t2(:,6), t3(:,6), t4(:,6), t5(:,6)];
eg6=std(gamma6);
gamma6_m=mean(gamma6);

time=[4 8 12 20 24];

figure()
hold on
errorbar(time, gamma1_m, eg1, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 8)
errorbar(time, gamma2_m, eg2, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', [1 0.5 0], 'markersize', 8)
errorbar(time, gamma3_m, eg3, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 8)
errorbar(time, gamma4_m, eg4, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'g', 'markersize', 8)
errorbar(time, gamma5_m, eg5, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 8)
errorbar(time, gamma6_m, eg6, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'c', 'markersize', 8)
set(gca, 'Fontsize', 20, 'xgrid', 'on', 'ygrid', 'on', 'ylim', [0 100])
set(gcf, 'color', 'w')
xlabel('Time, (hours)')
ylabel('% alive')
legend('10nM IFN-\gamma', '1nM', '100pM', '10pM', '1pM', '0')
title('Percentage alive over time')
box on

%%
%MHC CV over time

t1=[88.3 84.8 90.8 93.3 103 106
    89.7 91.4 88.8 94.2 94.3 92.8];
e1=std(t1);
t1_m=mean(t1); 
up1=[98.5 96];
eup1=std(up1);
eup1_m=mean(up1);

t2=[73.8 77.9 80 93.1 107 99.6
    73.1 74.9 80.7 95.3 101 106];
e2=std(t2);
t2_m=mean(t2);
up2=[95.8 95.7];
eup2=std(up2);
eup2_m=mean(up2);

t3=[59 58.7 67 83.3 93.4 95.9
    60 59.3 68.5 84.4 90.3 97.9];
e3=std(t3);
t3_m=mean(t3);
up3=[87 92.2];
eup3=std(up3);
eup3_m=mean(up3);

t4=[55.6 53.6 65.2 84.6 117 106
    50.8 53.6 63.2 84 83.2 93.6];
e4=std(t4);
t4_m=mean(t4);
up4=[93.6 91.4];
eup4=std(up4);
eup4_m=mean(up4);

t5=[42.7 44.2 55 82.5 94.5 92.6
    58.9 66.3 68.8 88.4 111 87.7];
e5=std(t5);
t5_m=mean(t5);
up5=[135 105];
eup5=std(up5);
eup5_m=mean(up5);

IFN=[10e-9 1e-9 100e-12 10e-12 1e-12 0];

%Plot H-2Kb GMFI versus IFN gamma at different time points

figure()
hold on
errorbar(IFN, t1_m, e1, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 8)
errorbar(IFN, t2_m, e2, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', [1 0.5 0], 'markersize', 8)
errorbar(IFN, t3_m, e3, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 8)
errorbar(IFN, t4_m, e4, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'g', 'markersize', 8)
errorbar(IFN, t5_m, e5, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 8)
set(gca, 'Fontsize', 20, 'xscale', 'log', 'ygrid', 'on', 'xgrid', 'on')
set(gcf, 'color', 'w')
xlabel('log [IFN-\gamma], (M)')
ylabel('CV')
legend('4hr', '8hr', '12hr', '20hr', '24hr')
title('CV of MHC distribution')
box on

%%
%Organizing & Plotting MHC CV expression over time

gamma1=[t1(:,1), t2(:,1), t3(:,1), t4(:,1), t5(:,1)];
eg1=std(gamma1);
gamma1_m=mean(gamma1);

gamma2=[t1(:,2), t2(:,2), t3(:,2), t4(:,2), t5(:,2)];
eg2=std(gamma2);
gamma2_m=mean(gamma2);

gamma3=[t1(:,3), t2(:,3), t3(:,3), t4(:,3), t5(:,3)];
eg3=std(gamma3);
gamma3_m=mean(gamma3);

gamma4=[t1(:,4), t2(:,4), t3(:,4), t4(:,4), t5(:,4)];
eg4=std(gamma4);
gamma4_m=mean(gamma4);

gamma5=[t1(:,5), t2(:,5), t3(:,5), t4(:,5), t5(:,5)];
eg5=std(gamma5);
gamma5_m=mean(gamma5);

gamma6=[t1(:,6), t2(:,6), t3(:,6), t4(:,6), t5(:,6)];
eg6=std(gamma6);
gamma6_m=mean(gamma6);

unpulsed=[up1, up2, up3, up4, up5];
unpulsed=reshape(unpulsed, 2,5);
e_unpulsed=std(unpulsed);
m_unpulsed=mean(unpulsed);

time=[4 8 12 20 24];

figure()
hold on
errorbar(time, gamma1_m, eg1, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 8)
errorbar(time, gamma2_m, eg2, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', [1 0.5 0], 'markersize', 8)
errorbar(time, gamma3_m, eg3, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 8)
errorbar(time, gamma4_m, eg4, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'g', 'markersize', 8)
errorbar(time, gamma5_m, eg5, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 8)
errorbar(time, gamma6_m, eg6, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'c', 'markersize', 8)
errorbar(time, m_unpulsed, e_unpulsed, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'w', 'markersize', 8)
set(gca, 'Fontsize', 20, 'xgrid', 'on', 'ygrid', 'on')
set(gcf, 'color', 'w')
xlabel('Time, (hours)')
ylabel('CV')
legend('10nM IFN-\gamma', '1nM', '100pM', '10pM', '1pM', '0', 'Unpulsed')
title('CV of MHC distribution over time')
box on


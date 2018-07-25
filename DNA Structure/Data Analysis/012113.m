%Percent AdTr CFSE+ of CD4 compartment

Vehicle=[0.193 15.2];
Jaki=[0.575 6.6];

Vehic_Count=[172 13387];
Jaki_Count=[402 4019];

Time=[24 48];

figure()
subplot(1,2,1)
hold on
plot(Time, Vehicle, '-bo', 'linewidth', 2)
plot(Time, Jaki, '-ro', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold')
ylabel('Percent Ag specific of total CD4+')
xlabel('Time, hours')
title('Percent Ag-specific CD4+ of total CD4+ compartment')
legend('Vehicle', 'Jaki')
box on
subplot(1,2,2)
hold on
plot(Time, Vehic_Count, '-bo', 'linewidth', 2)
plot(Time, Jaki_Count, '-ro', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'yscale', 'log')
ylabel('Number of Ag-specific CD4+')
xlabel('Time, hours')
title('Number of Ag-specific CD4+ T cells')
box on

%%
%Percent occupancy of AdTr in each CFSE peak

Peak=[1 2 3 4 5 6];

V_occupancy_24=[84.3	14.5	0.581	0	0	0];
V_occupancy_48=[0.0448	7.47e-3	0.0523	1.81	23.2	73.8];

J_occupancy_24=[93.8	5.72	0	0	0	0];
J_occupancy_48=[0.149	0.0249	3.14	65.8	24.3	3.76];

figure()
subplot(1,2,1)
hold on
plot(Peak, V_occupancy_24, '-bo', 'linewidth', 2)
plot(Peak, J_occupancy_24, '-ro', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold')
ylabel('Percent occupancy')
xlabel('CFSE Peak')
title('Percent occupancy of AdTr cells in each CFSE peak at 24 hrs')
legend('Vehicle', 'Jaki')
box on
subplot(1, 2, 2)
hold on
plot(Peak, V_occupancy_48, '-bo', 'linewidth', 2)
plot(Peak, J_occupancy_48, '-ro', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold')
ylabel('Percent occupancy')
xlabel('CFSE Peak')
title('Percent occupancy of AdTr cells in each CFSE peak at 48 hrs')
box on

%%
%Number of cells in each CFSE peak

Peak=[1 2 3 4 5 6];

V_occupancy_24=[145	25	1	0	0	0];
V_occupancy_48=[6	1	7	242	3104	9873];

J_occupancy_24=[377	23	0	0	0	0];
J_occupancy_48=[6	1	126	2643	975	151];

figure()
subplot(1,2,1)
hold on
plot(Peak, V_occupancy_24, '-bo', 'linewidth', 2)
plot(Peak, J_occupancy_24, '-ro', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'yscale', 'log')
ylabel('Number of Cells')
xlabel('CFSE Peak')
title('No. of AdTr cells in each CFSE peak at 24 hrs')
legend('Vehicle', 'Jaki')
box on
subplot(1, 2, 2)
hold on
plot(Peak, V_occupancy_48, '-bo', 'linewidth', 2)
plot(Peak, J_occupancy_48, '-ro', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'yscale', 'log')
ylabel('Number of cells')
xlabel('CFSE Peak')
title('No. of AdTr cells in each CFSE peak at 48 hrs')
box on

%%

%GMFI CD25

V_Treg=[2581 2708];
J_Treg=[661 681];

V_Teff=[7203 249];
J_Teff=[4598 229];

figure()
subplot(1,2,1)
hold on
bar(V_Treg, 0.8, 'b')
bar(J_Treg, 0.7, 'r')
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'yscale', 'log', 'YLim', [10e1 10e3])
ylabel('log GMFI CD25')
title('GMFI CD25 for Tregs')
box on
subplot(1,2,2)
hold on
bar(V_Teff, 0.8, 'b')
bar(J_Teff, 0.7, 'r')
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'yscale', 'log', 'YLim', [10e1 10e3])
ylabel('log GMFI CD25')
title('GMFI CD25 for Teffs')
box on


%%
%pSTAT5 IL2 dose response

pSTAT5_24_V=[638
572
604
450
205
354
238
223];
pSTAT5_24_V=pSTAT5_24_V-min(pSTAT5_24_V);


IL2=[10000 1000 100 10 1 0.1 0.01 0];

figure()
hold on
plot(IL2, pSTAT5_24_V, '-ko', 'linewidth', 2)
plot([0.01 max(IL2)], [724 724], '-m', 'linewidth', 2 )
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'xscale', 'log')








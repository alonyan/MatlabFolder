%ppErk CD50 repeat - 11.12.13
%Pulsed B16 cells o/n with IFN-g titration to get them to express different
%levels of MHC-I.  Then in am added 100nM Ova, pulsed for 2 hours, before washing
%diluting cells and adding 10e5 naive OT-I into Vbottom.  
%Spun down and then incubated at 37oC before timepoints.

%%
%ppErk+ at 30"

%ppErk+ at 1.5hr
t1=[66.3
20.6
3.64
1.25
71
20.7
3.53
0.956
60.1
13.8
2.39
1.15
58.8
15.9
2.31
1.29
53.8
11.8
2.96
0.983
46.9
7.93
1.93
0.754
0.3
0.866
1.21
0.832];

t1=t1/max(t1)*100

t1=reshape(t1, 4,7);

cells=[1e5 1e4 1e3 1e2];
gamma=[10e-9 1e-9 100e-12 10e-12 1e-12 100e-15]

figure()
hold on
plot(cells, t1(:,1), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
plot(cells, t1(:,2), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', [1 0.5 0], 'markersize', 10)
plot(cells, t1(:,3), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 10)
plot(cells, t1(:,4), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'g', 'markersize', 10)
plot(cells, t1(:,5), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
plot(cells, t1(:,6), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'c', 'markersize', 10)
plot(cells, t1(:,7), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'k', 'markersize', 10)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 20, 'xscale', 'log', 'xgrid', 'on', 'ygrid', 'on')
legend('10nM IFN-\gamma', '1nM', '100pM', '10pM', '1pM', '0', '0 unpulsed')
xlabel('log #B16')
ylabel('% of max ppErk')
title('30"')
box on

figure()
subplot(2,2,1)
plot(gamma, t1(1,1:6), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 20, 'xscale', 'log', 'xgrid', 'on', 'ygrid', 'on')
xlabel('log[IFN-\gamma], (M)')
ylabel('% of max ppErk')
title('10e5 B16')
box on
subplot(2,2,2)
plot(gamma, t1(2,1:6), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', [1 0.5 0], 'markersize', 10)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 20, 'xscale', 'log', 'xgrid', 'on', 'ygrid', 'on')
xlabel('log[IFN-\gamma], (M)')
ylabel('% of max ppErk')
title('10e4 B16')
box on
subplot(2,2,3)
plot(gamma, t1(3,1:6), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 10)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 20, 'xscale', 'log', 'xgrid', 'on', 'ygrid', 'on')
xlabel('log[IFN-\gamma], (M)')
ylabel('% of max ppErk')
title('10e3 B16')
box on
subplot(2,2,4)
plot(gamma, t1(4,1:6), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 20, 'xscale', 'log', 'xgrid', 'on', 'ygrid', 'on')
xlabel('log[IFN-\gamma], (M)')
ylabel('% of max ppErk')
title('10e2 B16')
box on

%Concentration of cells necessary to half maximally activate T cells (ppErk)
CD50=[393026 504717	611721	298149	6.034e+009	1.713e+009];

figure()
subplot(1,2,1)
plot(gamma, CD50, '-ko', 'markerfacecolor', 'm', 'markersize', 10)
set(gcf, 'color', 'w')
set(gca, 'xscale', 'log', 'Fontsize', 20, 'xgrid', 'on', 'ygrid', 'on', 'yscale', 'log')
xlabel('log[IFN-\gamma], (M)')
ylabel('Cell Density_{50}')
title('# of B16 required for half-maximal ppErk')

ratioB16=CD50./10e5;
subplot(1,2,2)
plot(gamma, ratioB16, '-ko', 'markerfacecolor', 'm', 'markersize', 10)
set(gcf, 'color', 'w')
set(gca, 'xscale', 'log', 'Fontsize', 20, 'xgrid', 'on', 'ygrid', 'on', 'yscale', 'log')
xlabel('log[IFN-\gamma], (M)')
ylabel('B16:OT-1_{50}')
title('Ratio of B16 to OT-1 required for half-maximal ppErk')


%%
%ppErk+ at 1.5hr
t2=[89.1
54.4
13.2
3.49
89.4
72.9
26.7
6.04
86
64.8
28.8
3.76
85.8
60.4
14.5
3.13
81.8
57.9
19.2
2.07
79.5
45.5
8.74
1.48
3.58
0.976
1.97
0.684];

t2=t2/max(t2)*100;

t2=reshape(t2, 4,7);

cells=[1e5 1e4 1e3 1e2];
cells_norm=[8333 1515 165 16]; %The average number of cells that 1e5 T cells would be touching based on geometry.

gamma=[10e-9 1e-9 100e-12 10e-12 1e-12 100e-15];

figure()
hold on
plot(cells_norm, t2(:,1), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
plot(cells_norm, t2(:,2), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', [1 0.5 0], 'markersize', 10)
plot(cells_norm, t2(:,3), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 10)
plot(cells_norm, t2(:,4), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'g', 'markersize', 10)
plot(cells_norm, t2(:,5), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
plot(cells_norm, t2(:,6), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'c', 'markersize', 10)
plot(cells_norm, t2(:,7), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'k', 'markersize', 10)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 20, 'xscale', 'log', 'xgrid', 'on', 'ygrid', 'on')
legend('10nM IFN-\gamma', '1nM', '100pM', '10pM', '1pM', '0', '0 unpulsed')
xlabel('log #B16')
ylabel('% of max ppErk')
title('1.5 hrs.')
box on

figure()
subplot(2,2,1)
plot(gamma, t2(1,1:6), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 20, 'xscale', 'log', 'xgrid', 'on', 'ygrid', 'on')
xlabel('log[IFN-\gamma], (M)')
ylabel('% of max ppErk')
title('10e5 B16')
box on
subplot(2,2,2)
plot(gamma, t2(2,1:6), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', [1 0.5 0], 'markersize', 10)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 20, 'xscale', 'log', 'xgrid', 'on', 'ygrid', 'on')
xlabel('log[IFN-\gamma], (M)')
ylabel('% of max ppErk')
title('10e4 B16')
box on
subplot(2,2,3)
plot(gamma, t2(3,1:6), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 10)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 20, 'xscale', 'log', 'xgrid', 'on', 'ygrid', 'on')
xlabel('log[IFN-\gamma], (M)')
ylabel('% of max ppErk')
title('10e3 B16')
box on
subplot(2,2,4)
plot(gamma, t2(4,1:6), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 20, 'xscale', 'log', 'xgrid', 'on', 'ygrid', 'on')
xlabel('log[IFN-\gamma], (M)')
ylabel('% of max ppErk')
title('10e2 B16')
box on

%Concentration of cells necessary to half maximally activate T cells (ppErk)
CD50=[80305	27152	25215	51996	43339	91173];

figure()
subplot(1,2,1)
plot(gamma, CD50, '-ko', 'markerfacecolor', 'm', 'markersize', 10)
set(gcf, 'color', 'w')
set(gca, 'xscale', 'log', 'Fontsize', 20, 'xgrid', 'on', 'ygrid', 'on')
xlabel('log[IFN-\gamma], (M)')
ylabel('Cell Density_{50}')
title('# of B16 required for half-maximal ppErk')

ratioB16=CD50./10e5;
subplot(1,2,2)
plot(gamma, ratioB16, '-ko', 'markerfacecolor', 'm', 'markersize', 10)
set(gcf, 'color', 'w')
set(gca, 'xscale', 'log', 'Fontsize', 20, 'xgrid', 'on', 'ygrid', 'on')
xlabel('log[IFN-\gamma], (M)')
ylabel('B16:OT-1_{50}')
title('Ratio of B16 to OT-1 required for half-maximal ppErk')
%%
%Compute the actual number of MHC on the cell surface.  This was a live
%measurement from B16 experiment done on 11.07.13.  The H-2Kb staining was
%so poor in this experiment using fixed cells, that I could not measure.  I
%took measurements from 11.7 from the 25 hour timepoint (time that roughly
%corresponds best with my tp) and will convert to actual numbers in order
%to estimate my "antigenicity"

%0 1 2 3 4 5 = 10nM 1nM 100pM 10pM 1pM 0 concentration of IFN-gamma pulsed
%with
%Equation obtained from APC calibration beads - (linear regression)
x=(y+5.266)/0.003484;
y=1.3e4; 

y1=8392; 
x1=(y1+5.266)/0.003484;

y2=1797;
x2=(y2+5.266)/0.003484; 

y3=262;
x3=(y3+5.266)/0.003484;

y4=190.5; 
x4=(y4+5.266)/0.003484;

y5=170.5;
x5=(y5+5.266)/0.003484;

MHC_mol=[x, x1, x2, x3, x4, x5];
B16=[1e5 1e4 1e3 1e2];

AG1=MHC_mol(:,1)*B16;
AG2=MHC_mol(:,2)*B16;
AG3=MHC_mol(:,3)*B16;
AG4=MHC_mol(:,4)*B16;
AG5=MHC_mol(:,5)*B16;
AG6=MHC_mol(:,6)*B16;
AG7=[0 0 0 0];

figure()
plot(gamma, MHC_mol, '-ko', 'markerfacecolor', 'k', 'markersize', 10)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 20, 'xgrid', 'on', 'ygrid', 'on', 'xscale' ,'log', 'yscale', 'log')
xlabel('[IFN-\gamma], (M)')
ylabel('# MHC molecules')
title('# MHC molecules for a given gamma stimulation @ 25 h')
box on

antigenicity=[AG1, AG2, AG3, AG4, AG5, AG6, AG7];
antigenicity=reshape(antigenicity, 4,7);

t2=[89.1 54.4 13.2 3.49 89.4 72.9 26.7 6.04 86 64.8 28.8 3.76 85.8 60.4 14.5 3.13 81.8 57.9 19.2 2.07 79.5 45.5 8.74 1.48 3.58 0.976 1.97 0.684];

t2=t2/max(t2)*100;
t2=reshape(t2, 4,7);
figure()
subplot(1,2,1)
plot(antigenicity, t2, 'o', 'markersize', 10, 'markeredgecolor', 'k', 'markerfacecolor', 'm')
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 20,'xgrid', 'on', 'ygrid', 'on', 'xscale', 'log', 'xlim', [1e4 1e12])
xlabel('Antigenicity, (#MHC*#B16)')
ylabel('% of max ppErk')
title('1.5 hrs.')
box on

%Compute the total amount of MHC that T cells contact when normalized for
%geometry of the system.  

%Average # of B16 cells that a T cell is touching in each case:
% [#B16/(#B16+#T cells)]/6 b/c a T cell on average can touch 6 other cells

%1e5 B16 to 1e5 OT1
B1=[1e5/(1e5+1e5)]*6;
B2=[1e4/(1e4+1e5)]*6;
B3=[1e3/(1e3+1e5)]*6;
B4=[1e2/(1e2+1e5)]*6;

Prob=[B1 B2 B3 B4]; % This is the average # of B16 that one T cell is touching at any given time
Prob=Prob*1e5; %This is the estimated # of B16 that the entire population of T cells are touching

%Now multiply the number of MHC per B16 cell x the number of B16 cells
%that the T cells are touching
AG1_norm=MHC_mol(:,1)*Prob;
AG2_norm=MHC_mol(:,2)*Prob;
AG3_norm=MHC_mol(:,3)*Prob;
AG4_norm=MHC_mol(:,4)*Prob;
AG5_norm=MHC_mol(:,5)*Prob;
AG6_norm=MHC_mol(:,6)*Prob;
AG7_norm=[0 0 0 0];

ag_normalized=[AG1_norm AG2_norm AG3_norm AG4_norm AG5_norm AG6_norm AG7_norm]; 
ag_normalized=reshape(ag_normalized, 4,7);

subplot(1,2,2)
plot(ag_normalized, t2, 'o', 'markersize', 10, 'markeredgecolor', 'k', 'markerfacecolor', [1 0.5 0])
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 20,'xgrid', 'on', 'ygrid', 'on', 'xscale', 'log')
xlabel('Antigenicity norm by geometry, (#MHC*#B16 touching T cells)')
ylabel('% of max ppErk')
title('1.5 hrs.')
box on

figure()
hold on
plot(ag_normalized(1,:), t2(1,:), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
plot(ag_normalized(2,:), t2(2,:), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', [1 0.5 0], 'markersize', 10)
plot(ag_normalized(3,:), t2(3,:), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 10)
plot(ag_normalized(4,:), t2(4,:), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 20, 'xgrid', 'on', 'ygrid', 'on', 'xscale', 'log', 'xlim', [1e7 1e12])
box on
legend('1e5 B16', '1e4', '1e3', '1e2')
xlabel('Antigenicity (#MHC*#B16 in contact)')
ylabel('% of max ppErk+')
title('OT-1 activation at 1.5 hrs')
%%
%ppErk+ at 3 hours
t3=[63.6
65.1
20.4
2.31
63.1
77.9
40.3
6.5
52.4
79.8
37.7
3.65
55.9
72.5
39
3.62
52.1
75.5
24.7
3.19
47.5
66
12.5
0.841
0.527
0.302
0.39
0.454];

t3=t3/max(t3)*100

t3=reshape(t3, 4,7);

cells=[1e5 1e4 1e3 1e2];
gamma=[10e-9 1e-9 100e-12 10e-12 1e-12 100e-15]

figure()
hold on
plot(cells, t3(:,1), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
plot(cells, t3(:,2), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', [1 0.5 0], 'markersize', 10)
plot(cells, t3(:,3), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 10)
plot(cells, t3(:,4), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'g', 'markersize', 10)
plot(cells, t3(:,5), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
plot(cells, t3(:,6), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'c', 'markersize', 10)
plot(cells, t3(:,7), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'k', 'markersize', 10)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 20, 'xscale', 'log', 'xgrid', 'on', 'ygrid', 'on')
legend('10nM IFN-\gamma', '1nM', '100pM', '10pM', '1pM', '0', '0 unpulsed')
xlabel('log #B16')
ylabel('% of max ppErk')
title('3 hrs.')
box on

figure()
subplot(2,2,1)
plot(gamma, t3(1,1:6), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 20, 'xscale', 'log', 'xgrid', 'on', 'ygrid', 'on')
xlabel('log[IFN-\gamma], (M)')
ylabel('% of max ppErk')
title('10e5 B16')
box on
subplot(2,2,2)
plot(gamma, t3(2,1:6), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', [1 0.5 0], 'markersize', 10)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 20, 'xscale', 'log', 'xgrid', 'on', 'ygrid', 'on')
xlabel('log[IFN-\gamma], (M)')
ylabel('% of max ppErk')
title('10e4 B16')
box on
subplot(2,2,3)
plot(gamma, t3(3,1:6), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 10)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 20, 'xscale', 'log', 'xgrid', 'on', 'ygrid', 'on')
xlabel('log[IFN-\gamma], (M)')
ylabel('% of max ppErk')
title('10e3 B16')
box on
subplot(2,2,4)
plot(gamma, t3(4,1:6), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 20, 'xscale', 'log', 'xgrid', 'on', 'ygrid', 'on')
xlabel('log[IFN-\gamma], (M)')
ylabel('% of max ppErk')
title('10e2 B16')
box on

%Concentration of cells necessary to half maximally activate T cells (ppErk)
CD50=[];

figure()
subplot(1,2,1)
plot(gamma, CD50, '-ko', 'markerfacecolor', 'm', 'markersize', 10)
set(gcf, 'color', 'w')
set(gca, 'xscale', 'log', 'Fontsize', 20, 'xgrid', 'on', 'ygrid', 'on')
xlabel('log[IFN-\gamma], (M)')
ylabel('Cell Density_{50}')
title('# of B16 required for half-maximal ppErk')

ratioB16=CD50./10e5;
subplot(1,2,2)
plot(gamma, ratioB16, '-ko', 'markerfacecolor', 'm', 'markersize', 10)
set(gcf, 'color', 'w')
set(gca, 'xscale', 'log', 'Fontsize', 20, 'xgrid', 'on', 'ygrid', 'on')
xlabel('log[IFN-\gamma], (M)')
ylabel('B16:OT-1_{50}')
title('Ratio of B16 to OT-1 required for half-maximal ppErk')

%%

time=[.5 1.5 3];

g1_c1=[t1(1,1), t2(1,1), t3(1,2)];
g1_c2=[t1(2,1), t2(2,1), t3(2,2)];
g1_c3=[t1(3,1), t2(3,1), t3(3,2)];
g1_c4=[t1(4,1), t2(4,1), t3(4,2)];

g2_c1=[t1(1,2), t2(1,2), t3(1,2)];
g2_c2=[t1(2,2), t2(2,2), t3(2,2)];
g2_c3=[t1(3,2), t2(3,2), t3(3,2)];
g2_c4=[t1(4,2), t2(4,2), t3(4,2)];

g3_c1=[t1(1,3), t2(1,3), t3(1,3)];
g3_c2=[t1(2,3), t2(2,3), t3(2,3)];
g3_c3=[t1(3,3), t2(3,3), t3(3,3)];
g3_c4=[t1(4,3), t2(4,3), t3(4,3)];

g4_c1=[t1(1,4), t2(1,4), t3(1,4)];
g4_c2=[t1(2,4), t2(2,4), t3(2,4)];
g4_c3=[t1(3,4), t2(3,4), t3(3,4)];
g4_c4=[t1(4,4), t2(4,4), t3(4,4)];

g5_c1=[t1(1,5), t2(1,5), t3(1,5)];
g5_c2=[t1(2,5), t2(2,5), t3(2,5)];
g5_c3=[t1(3,5), t2(3,5), t3(3,5)];
g5_c4=[t1(4,5), t2(4,5), t3(4,5)];

g6_c1=[t1(1,6), t2(1,6), t3(1,6)];
g6_c2=[t1(2,6), t2(2,6), t3(2,6)];
g6_c3=[t1(3,6), t2(3,6), t3(3,6)];
g6_c4=[t1(4,6), t2(4,6), t3(4,6)];

g7_c1=[t1(1,7), t2(1,7), t3(1,7)];
g7_c2=[t1(2,7), t2(2,7), t3(2,7)];
g7_c3=[t1(3,7), t2(3,7), t3(3,7)];
g7_c4=[t1(4,7), t2(4,7), t3(4,7)];

figure()
subplot(2,4,1)
hold on
plot(time, g1_c1, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
plot(time, g1_c2, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', [1 0.5 0], 'markersize', 10)
plot(time, g1_c3, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 10)
plot(time, g1_c4, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 20, 'xgrid', 'on', 'ygrid', 'on')
xlabel('Time, (hours)')
ylabel('% of max ppErk+')
title('10nM IFN-\gamma')
legend('10e5 B16', '10e4', '10e3', '10e2')
box on
subplot(2,4,2)
hold on
plot(time, g2_c1, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
plot(time, g2_c2, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', [1 0.5 0], 'markersize', 10)
plot(time, g2_c3, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 10)
plot(time, g2_c4, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 20,'xgrid', 'on', 'ygrid', 'on')
xlabel('Time, (hours)')
ylabel('% of max ppErk+')
title('1nM IFN-\gamma')
box on
subplot(2,4,3)
hold on
plot(time, g3_c1, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
plot(time, g3_c2, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', [1 0.5 0], 'markersize', 10)
plot(time, g3_c3, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 10)
plot(time, g3_c4, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 20, 'xgrid', 'on', 'ygrid', 'on')
xlabel('Time, (hours)')
ylabel('% of max ppErk+')
title('100pM IFN-\gamma')
box on
subplot(2,4,4)
hold on
plot(time, g4_c1, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
plot(time, g4_c2, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', [1 0.5 0], 'markersize', 10)
plot(time, g4_c3, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 10)
plot(time, g4_c4, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 20, 'xgrid', 'on', 'ygrid', 'on')
xlabel('Time, (hours)')
ylabel('% of max ppErk+')
title('10pM IFN-\gamma')
box on
subplot(2,4,5)
hold on
plot(time, g5_c1, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
plot(time, g5_c2, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', [1 0.5 0], 'markersize', 10)
plot(time, g5_c3, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 10)
plot(time, g5_c4, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 20, 'xgrid', 'on', 'ygrid', 'on')
xlabel('Time, (hours)')
ylabel('% of max ppErk+')
title('1pM IFN-\gamma')
box on
subplot(2,4,6)
hold on
plot(time, g6_c1, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
plot(time, g6_c2, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', [1 0.5 0], 'markersize', 10)
plot(time, g6_c3, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 10)
plot(time, g6_c4, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 20, 'xgrid', 'on', 'ygrid', 'on')
xlabel('Time, (hours)')
ylabel('% of max ppErk+')
title('media only')
box on
subplot(2,4,7)
hold on
plot(time, g7_c1, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
plot(time, g7_c2, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', [1 0.5 0], 'markersize', 10)
plot(time, g7_c3, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 10)
plot(time, g7_c4, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 20, 'xgrid', 'on', 'ygrid', 'on', 'ylim', [0 100])
xlabel('Time, (hours)')
ylabel('% of max ppErk+')
title('media only, unpulsed')
box on





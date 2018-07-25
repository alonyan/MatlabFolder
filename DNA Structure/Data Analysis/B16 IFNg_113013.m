%B16 IFN-g Jaki expt. 11.30.13

%Cells pulsed with 10nM, 1nM, 100pM, 10pM, 1pM, 0 IFN-g.  At either T0,
%10min, 30 min, 1hr, 2hr, 3hr, 5hr 10uM Jaki (Azd1480) was added.  DMSO
%vehicle added.  

%At 20 hr, cells were harvested and stained with Dapi and anti-H-2Kb Pe

%%

IFNg=[10e-9 1e-9 100e-12 10e-12 1e-12 0];

T0_vehicle=[10770 8206 3258 399 -19 -5.49];
T0_vehicle = T0_vehicle.*(T0_vehicle>1)+ones(1, length(T0_vehicle)).*(T0_vehicle<1);

T0_drug=[-38.5 -25.9 -22.2 -14.5 -45.4 2.18];
T0_drug = T0_drug.*(T0_drug>1)+ones(1, length(T0_drug)).*(T0_drug<1);

T1=[210 138 8.85 -39.7 -43.9 6.77];
T1 = T1.*(T1>1)+ones(1, length(T1)).*(T1<1);


T2=[225 200 71.4 114 -18.6 104];
T2 = T2.*(T2>1)+ones(1, length(T2)).*(T2<1);


T3=[607 394 127 147 -36.6 43.4];
T3 = T3.*(T3>1)+ones(1, length(T3)).*(T3<1);


T4=[545 1125 304 107 -17.9 76.5];
T4 = T4.*(T4>1)+ones(1, length(T4)).*(T4<1);


T5=[1471 1580 801 264 13.5 47.3];
T5 = T5.*(T5>1)+ones(1, length(T5)).*(T5<1);


T6=[2078 1539 610 55 -60.6 32.2];
T6 = T6.*(T6>1)+ones(1, length(T6)).*(T6<1);


figure()
hold on
plot(IFNg, T0_vehicle, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 18)
plot(IFNg, T0_drug, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', [1 0.5 0], 'markersize', 18)
plot(IFNg, T1, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 18)
plot(IFNg, T2, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'g', 'markersize', 18)
plot(IFNg, T3, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 18)
plot(IFNg, T4, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'c', 'markersize', 18)
plot(IFNg, T5, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'k', 'markersize', 18)
plot(IFNg, T6, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'w', 'markersize', 18)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 25, 'xscale', 'log', 'xgrid', 'on', 'ygrid', 'on', 'yscale', 'log')
xlabel('[IFN-\gamma], (M)')
ylabel('log H-2K^b GMFI')
legend('vehicle T0', 'T0 10uM Jaki (Azd1480)', '10m', '30m', '1h', '2h', '3h', '5h')
title('MHC-I upregulation after addition of Jaki at different times post-exposure to IFN-\gamma')
box on

%%
%Scale Ifn-g such that it's value is represented as a number between 0 and
%1.  Then scale time such that time Jaki added is a number between 0 and 1.
% 

tsehvah=['r'
         'm'
         'y'
         'g'
         'b'
         'k' 
         'w'
         'c'];

IFNg=[1 0.1 0.01 0.001 0.0001 0];
%Time was converted to hours, then 20h was considered equivalent to 1, and
%everything was normalized to 1.  
time=[0 0.0083 0.0250 0.05 0.1 0.15 0.25 1];

rel_gam=[0.0000    0.0000    0.0000    0.0000    0.0000         0
         0.0083    0.0008    0.0001    0.0000    0.0000         0
         0.0250    0.0025    0.0003    0.0000    0.0000         0
         0.0500    0.0050    0.0005    0.0001    0.0000         0
         0.1000    0.0100    0.0010    0.0001    0.0000         0
         0.1500    0.0150    0.0015    0.0001    0.0000         0
         0.2500    0.0250    0.0025    0.0003    0.0000         0
         1.0000    0.1000    0.0100    0.0010    0.0001         0];
     
MHC=[  1.0000    1.0000    1.0000    1.0000    1.0000    2.1800
     210.0000  138.0000    8.8500    1.0000    1.0000    6.7700
     225.0000  200.0000   71.4000  114.0000    1.0000  104.0000
     607.0000  394.0000  127.0000  147.0000    1.0000   43.4000
     545.0000  1125.000  304.0000  107.0000    1.0000   76.5000
     1471.000  1580.000  801.0000  264.0000    13.500   47.3000
     2078.000  1539.000  610.0000   55.0000    1.0000   32.2000
     10770     8206     3258       399         1         1];
 
 figure()
 hold on
 for t=1:8
     plot(rel_gam(t,:), MHC(t,:), 'ko', 'markerfacecolor', tsehvah(t,:), 'markersize', 10)
 end
 set(gcf, 'color', 'w')
 set(gca, 'Fontsize', 25, 'xscale', 'log', 'yscale', 'log', 'xgrid', 'on', 'ygrid', 'on')
 xlabel('Relative IFN-\gamma sensed, (a.u.)')
 ylabel('log H-2K^b')
 box on
 
 figure()
 hold on
 plot(rel_gam, MHC, 'ko', 'markerfacecolor', 'b', 'markersize', 20)
  set(gcf, 'color', 'w')
 set(gca, 'Fontsize', 25, 'xscale', 'log', 'yscale', 'log', 'xgrid', 'on', 'ygrid', 'on')
 xlabel('Relative IFN-\gamma sensed, (a.u.)')
 ylabel('log H-2K^b')
 box on
 title('Normalizing data for relative amount of IFN-\gamma sensed')
     

%B16-OT1 Co-culture 9.5.13
%B16s were seeded at different densities (100k, 10k, and 1k per well), then
%pulsed with 100nM OVA in 200uL per well RPMI for 6.5 hours.  At this time, supernatant was
%removed, cells were washed 1x with 100uL PBS, and 10e5 naive OT-1 T cells
%were added to wells in 200uL fresh RPMI.  
%The objectives were: (a) See how different densities of target cells
%affects overall antigenicity, activity, accumulation of IFN-gamma and MHC
%expression.  

%%
%Percent CD69+ over time

%T cells were gated as (1)CFSE+, (2)FSC/SSC, (3)CD8+, (4)DAPI- (5)CD69+

t1=[18.1 8.92 5.49 1.92 1.23 2.12
    19.1 9.1 4.89 1.38 1.55 2.68];

t2=[41.8 22.7 15.4 0.652 0.723 0.831
    39.8 23.4 15.7 0.51 0.737 1.14];

t3=[29 22.6 20.1 0.558 0.625 0.803
    35.8 18.9 11.6 0.331 0.362 0.621];

t4=[30.2 17.9 10.1 0.332 0.616 0.877
    34.8 17.9 6.29 0.418 0.536 0.43];

t5=[22.7 9.92 5.5 0.735 0.506 0.548
    29.6 8.93 4.78 0.883 0.515 0.691];

N1_Ova=[t1(:,1), t2(:,1), t3(:,1), t4(:,1), t5(:,1)]; e1=std(N1_Ova); m1=mean(N1_Ova);
N2_Ova=[t1(:,2), t2(:,2), t3(:,2), t4(:,2), t5(:,2)]; e2=std(N2_Ova); m2=mean(N2_Ova);
N3_Ova=[t1(:,3), t2(:,3), t3(:,3), t4(:,3), t5(:,3)]; e3=std(N3_Ova); m3=mean(N3_Ova);
N1_UP=[t1(:,4), t2(:,4), t3(:,4), t4(:,4), t5(:,4)]; e4=std(N1_UP); m4=mean(N1_UP);
N2_UP=[t1(:,5), t2(:,5), t3(:,5), t4(:,5), t5(:,5)]; e5=std(N2_UP); m5=mean(N2_UP);
N3_UP=[t1(:,6), t2(:,6), t3(:,6), t4(:,6), t5(:,6)]; e6=std(N3_UP); m6=mean(N3_UP);

time=[5.5 17.5 29.5 41.5 53.5];

figure()
hold on
errorbar(time, m1, e1, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 8)
errorbar(time, m2, e2, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 8)
errorbar(time, m3, e3, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 8)
errorbar(time, m4, e4, '--ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 8)
errorbar(time, m5, e5, '--ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 8)
errorbar(time, m6, e6, '--ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 8)
set(gca, 'Fontsize', 20, 'xgrid', 'on', 'ygrid', 'on')
set(gcf, 'color', 'w')
xlabel('Time, (hours)')
ylabel('%CD69+')
legend('10e5 B16 + OVA', '10e4 B16', '10e3 B16', '10e5 B16, Unpulsed', '10e4 B16', '10e3 B16')
title('Percent of OT1 CD69+ over time')
box on

%%

%Percent of OT1 cells alive over time

t1=[92.1 93.6 91.3 94.1 93.1 93.9
    93.2 92.4 92.8 93.1 91.9 90.2];

t2=[94.6 93.4 93.1 94.6 91.7 91.6
    94.4 92.4 91.4 94.3 92.2 88.7];

t3=[88.5 90.4 87.9 86.5 81.4 74
    89.9 88.5 85.6 87.5 80.2 76.2];

t4=[89.9 87.5 79.1 72 92.5 67.7
    90.9 94.8 90.7 79.4 90.8 89.5];

t5=[84.2 85.4 70.2 63.1 77 65.2
    89.3 84 74.4 64.9 69.5 64.8];

N1_Ova=[t1(:,1), t2(:,1), t3(:,1), t4(:,1), t5(:,1)]; e1=std(N1_Ova); m1=mean(N1_Ova);
N2_Ova=[t1(:,2), t2(:,2), t3(:,2), t4(:,2), t5(:,2)]; e2=std(N2_Ova); m2=mean(N2_Ova);
N3_Ova=[t1(:,3), t2(:,3), t3(:,3), t4(:,3), t5(:,3)]; e3=std(N3_Ova); m3=mean(N3_Ova);
N1_UP=[t1(:,4), t2(:,4), t3(:,4), t4(:,4), t5(:,4)]; e4=std(N1_UP); m4=mean(N1_UP);
N2_UP=[t1(:,5), t2(:,5), t3(:,5), t4(:,5), t5(:,5)]; e5=std(N2_UP); m5=mean(N2_UP);
N3_UP=[t1(:,6), t2(:,6), t3(:,6), t4(:,6), t5(:,6)]; e6=std(N3_UP); m6=mean(N3_UP);

time=[5.5 17.5 29.5 41.5 53.5];

figure()
hold on
errorbar(time, m1, e1, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 8)
errorbar(time, m2, e2, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 8)
errorbar(time, m3, e3, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 8)
errorbar(time, m4, e4, '--ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 8)
errorbar(time, m5, e5, '--ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 8)
errorbar(time, m6, e6, '--ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 8)
set(gca, 'Fontsize', 20, 'xgrid', 'on', 'ygrid', 'on')
set(gcf, 'color', 'w')
xlabel('Time, (hours)')
ylabel('%Alive')
legend('10e5 B16 + OVA', '10e4 B16', '10e3 B16', '10e5 B16, Unpulsed', '10e4 B16', '10e3 B16')
title('Percent of OT1 alive over time')
box on

%%
%Percent of B16s alive over time

%B16s were gated by (1)CFSE-, (2)SSC hi, (3)Alive

t1=[97.7 91.5 84 97.8 92.8 90.9
    97.2 93.9 70.7 95.6 92.7 73.9];

t2=[97.2 94.8 76.5 98.1 91.2 80.6
    96.7 90.3 60 97.8 92.8 74.7];

t3=[94.5 94.2 77.1 98.6 95.1 87.1
    93.7 92.4 81.7 97.5 92.1 75.9];

t4=[95.5 96 88.2 96 28.4 88 
    96.8 94.9 87.2 97.7 98.2 91.1];

t5=[92 95.5 90.4 95.6 97.1 91.9
    93.3 95 93.2 96.7 96.5 90.7];

N1_Ova=[t1(:,1), t2(:,1), t3(:,1), t4(:,1), t5(:,1)]; e1=std(N1_Ova); m1=mean(N1_Ova);
N2_Ova=[t1(:,2), t2(:,2), t3(:,2), t4(:,2), t5(:,2)]; e2=std(N2_Ova); m2=mean(N2_Ova);
N3_Ova=[t1(:,3), t2(:,3), t3(:,3), t4(:,3), t5(:,3)]; e3=std(N3_Ova); m3=mean(N3_Ova);
N1_UP=[t1(:,4), t2(:,4), t3(:,4), t4(:,4), t5(:,4)]; e4=std(N1_UP); m4=mean(N1_UP);
N2_UP=[t1(:,5), t2(:,5), t3(:,5), t4(:,5), t5(:,5)]; e5=std(N2_UP); m5=mean(N2_UP);
N3_UP=[t1(:,6), t2(:,6), t3(:,6), t4(:,6), t5(:,6)]; e6=std(N3_UP); m6=mean(N3_UP);

time=[5.5 17.5 29.5 41.5 53.5];

figure()
hold on
errorbar(time, m1, e1, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 8)
errorbar(time, m2, e2, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 8)
errorbar(time, m3, e3, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 8)
errorbar(time, m4, e4, '--ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 8)
errorbar(time, m5, e5, '--ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 8)
errorbar(time, m6, e6, '--ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 8)
set(gca, 'Fontsize', 20, 'xgrid', 'on', 'ygrid', 'on', 'ylim', [0 100])
set(gcf, 'color', 'w')
xlabel('Time, (hours)')
ylabel('% alive')
legend('10e5 B16 + OVA', '10e4 B16', '10e3 B16', '10e5 B16, Unpulsed', '10e4 B16', '10e3 B16')
title('% of B16 alive over time')
box on
%%%GMFI of MHC for B16 cells over time

%B16s were gated by (1)CFSE-, (2)SSC hi, (3)Alive

t1=[929 859 583 974 1023 442
    972 847 491 858 856 492];

t2=[16638 11859 1103 1013 698 464
    11936 9178 851 1045 646 661];

t3=[41730 53543 2337 1497 610 476
    45003 24315 822 1458 581 451];

t4=[76525 68087 4033 1714 421 544
    64445 69588 1604 1382 528 511];

t5=[80831 1.07e5 7003 1917 642 505
    64946 91367 2182 1387 547 575];

N1_Ova=[t1(:,1), t2(:,1), t3(:,1), t4(:,1), t5(:,1)]; e1_M=std(N1_Ova); m1_M=mean(N1_Ova);
N2_Ova=[t1(:,2), t2(:,2), t3(:,2), t4(:,2), t5(:,2)]; e2_M=std(N2_Ova); m2_M=mean(N2_Ova);
N3_Ova=[t1(:,3), t2(:,3), t3(:,3), t4(:,3), t5(:,3)]; e3_M=std(N3_Ova); m3_M=mean(N3_Ova);
N1_UP=[t1(:,4), t2(:,4), t3(:,4), t4(:,4), t5(:,4)]; e4_M=std(N1_UP); m4_M=mean(N1_UP);
N2_UP=[t1(:,5), t2(:,5), t3(:,5), t4(:,5), t5(:,5)]; e5_M=std(N2_UP); m5_M=mean(N2_UP);
N3_UP=[t1(:,6), t2(:,6), t3(:,6), t4(:,6), t5(:,6)]; e6_M=std(N3_UP); m6_M=mean(N3_UP);

time=[5.5 17.5 29.5 41.5 53.5];

figure()
hold on
errorbar(time, m1_M, e1_M, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 8)
errorbar(time, m2_M, e2_M, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 8)
errorbar(time, m3_M, e3_M, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 8)
errorbar(time, m4_M, e4_M, '--ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 8)
errorbar(time, m5_M, e5_M, '--ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 8)
errorbar(time, m6_M, e6_M, '--ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 8)
set(gca, 'Fontsize', 20, 'xgrid', 'on', 'ygrid', 'on', 'yscale', 'log', 'ylim', [10e1 10e4])
set(gcf, 'color', 'w')
xlabel('Time, (hours)')
ylabel('log H-2K^b GMFI')
legend('10e5 B16 + OVA', '10e4 B16', '10e3 B16', '10e5 B16, Unpulsed', '10e4 B16', '10e3 B16')
title('MHC Expression over time')
box on

%%

%GMFI Ova

%B16s were gated by (1)CFSE-, (2)SSC hi, (3)Alive

t1=[362 368 285 384 368 142
    364 396 207 318 315 324];

t2=[538 600 338 360 406 236
    496 511 222 343 392 313];

t3=[988 1766 458 399 425 248
    896 964 198 387 380 287];

t4=[1989 2734 414 216 286 292
    1567 2758 202 238 312 267];

t5=[1690 5282 562 320 396 291
    1474 3802 422 302 390 363];

N1_Ova=[t1(:,1), t2(:,1), t3(:,1), t4(:,1), t5(:,1)]; e1=std(N1_Ova); m1=mean(N1_Ova);
N2_Ova=[t1(:,2), t2(:,2), t3(:,2), t4(:,2), t5(:,2)]; e2=std(N2_Ova); m2=mean(N2_Ova);
N3_Ova=[t1(:,3), t2(:,3), t3(:,3), t4(:,3), t5(:,3)]; e3=std(N3_Ova); m3=mean(N3_Ova);
N1_UP=[t1(:,4), t2(:,4), t3(:,4), t4(:,4), t5(:,4)]; e4=std(N1_UP); m4=mean(N1_UP);
N2_UP=[t1(:,5), t2(:,5), t3(:,5), t4(:,5), t5(:,5)]; e5=std(N2_UP); m5=mean(N2_UP);
N3_UP=[t1(:,6), t2(:,6), t3(:,6), t4(:,6), t5(:,6)]; e6=std(N3_UP); m6=mean(N3_UP);

N1_Norm=m1-m4;
N2_Norm=m2-m5;
N3_Norm=m3-m6;

time=[5.5 17.5 29.5 41.5 53.5];

figure()
hold on
errorbar(time, m1, e1, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 8)
errorbar(time, m2, e2, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 8)
errorbar(time, m3, e3, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 8)
errorbar(time, m4, e4, '--ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 8)
errorbar(time, m5, e5, '--ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 8)
errorbar(time, m6, e6, '--ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 8)
set(gca, 'Fontsize', 20, 'xgrid', 'on', 'ygrid', 'on', 'yscale', 'log')
set(gcf, 'color', 'w')
xlabel('Time, (hours)')
ylabel('log K^b-OVA')
legend('10e5 B16 + OVA', '10e4 B16', '10e3 B16', '10e5 B16, Unpulsed', '10e4 B16', '10e3 B16')
title('B16 Ova presentation over time')
box on

figure()
hold on
plot(m1_M,N1_Norm, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 8)
plot(m2_M,N2_Norm, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 8)
plot(m3_M,N3_Norm, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 8)
set(gca, 'Fontsize', 20, 'xgrid', 'on', 'ygrid', 'on', 'yscale', 'log', 'xscale', 'log')
set(gcf, 'color', 'w')
xlabel('log H-2K^b')
ylabel('log Normalized K^b-OVA')
legend('10e5 B16', '10e4 B16', '10e3 B16')
box on
title('Background subtracted K^b-OVA versus MHC')

figure()
hold on
plot(mhcgamma1_m, gamma1_norm, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 8)
plot(mhcgamma2_m, gamma2_norm, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', [1 0.5 0], 'markersize', 8)
plot(mhcgamma3_m, gamma3_norm, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 8)
plot(mhcgamma4_m, gamma4_norm, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'g', 'markersize', 8)
plot(mhcgamma5_m, gamma5_norm, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 8)
plot(mhcgamma6_m, gamma6_norm, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'c', 'markersize', 8)
plot(m1_M,N1_Norm, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 8)
plot(m2_M,N2_Norm, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 8)
plot(m3_M,N3_Norm, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 8)
set(gca, 'Fontsize', 20, 'yscale', 'log', 'xscale', 'log', 'xgrid', 'on', 'ygrid', 'on')
set(gcf, 'color', 'w')
xlabel('log H-2Kb GMFI')
ylabel('log Normalized Kb-OVA GMFI')
legend('10nM IFN-\gamma', '1nM', '100pM', '10pM', '1pM', '0')
title('Normalized Kb-OVA*MHC fluorescence')
box on

%%
%Number of alive OT1s (proliferation) per 50k events.  Counts of OT1 were
%enumerated then normalized to collection of 50k events.  

t1=[4541 6600 7086 4903 6723 6683
    4072 5251 5806 3256 5540 3848];

t2=[9565 10802 12109 7822 10578 11367
    8324 7853 9325 8133 11064 7795];

t3=[7256 11062 9716 6091 10647 6975 
    7251 10181 9502 4988 9795 8056];

t4=[8992 11399 9880 6170 8681 7699
    5307 8835 8037 3588 5500 7708];

t5=[7735 11594 8452 4287 6031 6566
    7932 10153 6742 2887 5537 5569];

N1_Ova=[t1(:,1), t2(:,1), t3(:,1), t4(:,1), t5(:,1)]; e1=std(N1_Ova); m1=mean(N1_Ova);
N2_Ova=[t1(:,2), t2(:,2), t3(:,2), t4(:,2), t5(:,2)]; e2=std(N2_Ova); m2=mean(N2_Ova);
N3_Ova=[t1(:,3), t2(:,3), t3(:,3), t4(:,3), t5(:,3)]; e3=std(N3_Ova); m3=mean(N3_Ova);
N1_UP=[t1(:,4), t2(:,4), t3(:,4), t4(:,4), t5(:,4)]; e4=std(N1_UP); m4=mean(N1_UP);
N2_UP=[t1(:,5), t2(:,5), t3(:,5), t4(:,5), t5(:,5)]; e5=std(N2_UP); m5=mean(N2_UP);
N3_UP=[t1(:,6), t2(:,6), t3(:,6), t4(:,6), t5(:,6)]; e6=std(N3_UP); m6=mean(N3_UP);

time=[5.5 17.5 29.5 41.5 53.5];

figure()
hold on
errorbar(time, m1, e1, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 8)
errorbar(time, m2, e2, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 8)
errorbar(time, m3, e3, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 8)
errorbar(time, m4, e4, '--ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 8)
errorbar(time, m5, e5, '--ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 8)
errorbar(time, m6, e6, '--ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 8)
set(gca, 'Fontsize', 20, 'xgrid', 'on', 'ygrid', 'on', 'yscale', 'log')
set(gcf, 'color', 'w')
xlabel('Time, (hours)')
ylabel('log Alive OT-1 per 50k events')
legend('10e5 B16 + OVA', '10e4 B16', '10e3 B16', '10e5 B16, Unpulsed', '10e4 B16', '10e3 B16')
title('Number of living OT1 over time')
box on

%%

%Number of OT1s activated (CD69+) per 50k events.  Counts of OT1 were
%enumerated then normalized to collection of 50k events.  

t1=[822.1 588.5 389.2 94.0 83.0 142.0
    778.0 478.0 284.0 45.0 86.0 103.0];


t2=[3997.0 2451.5 1868.5 51.0 76.5 94.5
    3314.5 1834.0 1468.5 41.5 81.5 89.0];

t3=[2107.0 2501.0 1957.5 34.0 66.5 56.0
    2596.5 1928.5 1100.5 16.5 35.5 50.0];

t4=[2712.5 2042.0 1000.5 20.5 53.5 67.5
    1848.5 1577.3 505.2 15.0 29.5 33.1];

t5=[1752.7 1150.0 465.0 31.5 30.5 36.0
    2344.5 906.5 322.5 25.5 28.5 38.5];

N1_Ova=[t1(:,1), t2(:,1), t3(:,1), t4(:,1), t5(:,1)]; e1=std(N1_Ova); m1=mean(N1_Ova);
N2_Ova=[t1(:,2), t2(:,2), t3(:,2), t4(:,2), t5(:,2)]; e2=std(N2_Ova); m2=mean(N2_Ova);
N3_Ova=[t1(:,3), t2(:,3), t3(:,3), t4(:,3), t5(:,3)]; e3=std(N3_Ova); m3=mean(N3_Ova);
N1_UP=[t1(:,4), t2(:,4), t3(:,4), t4(:,4), t5(:,4)]; e4=std(N1_UP); m4=mean(N1_UP);
N2_UP=[t1(:,5), t2(:,5), t3(:,5), t4(:,5), t5(:,5)]; e5=std(N2_UP); m5=mean(N2_UP);
N3_UP=[t1(:,6), t2(:,6), t3(:,6), t4(:,6), t5(:,6)]; e6=std(N3_UP); m6=mean(N3_UP);

time=[5.5 17.5 29.5 41.5 53.5];

figure()
hold on
errorbar(time, m1, e1, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 8)
errorbar(time, m2, e2, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 8)
errorbar(time, m3, e3, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 8)
errorbar(time, m4, e4, '--ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 8)
errorbar(time, m5, e5, '--ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 8)
errorbar(time, m6, e6, '--ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 8)
set(gca, 'Fontsize', 20, 'xgrid', 'on', 'ygrid', 'on', 'yscale', 'log')
set(gcf, 'color', 'w')
xlabel('Time, (hours)')
ylabel('log CD69+ OT-1 per 50k events')
legend('10e5 B16 + OVA', '10e4 B16', '10e3 B16', '10e5 B16, Unpulsed', '10e4 B16', '10e3 B16')
title('Number of activated OT1 over time')
box on

%Try and see how much IfN-g is made per activated T cells
%Experimental values - for H-2Kb

Exp=[1753 1238 877 973 1186 1399 
     2262 1293 1121 1232 1255 1410
     12591 6483 1674 1423 1480 1438
     10779 4437 1787 1535 1107 1396
     32459 17461 3657 1475 1348 1314
     35585 14002 1900 1604 1223 1221
     41374 12452 2433 1390 1177 1141
     36458 10024 1464 1203 1206 1267
     29735 16478 2286 1808 1503 1673
     33951 18665 1693 1483 1320 1361];
 
 %Values from fitted standard curve
T=46132;
B=1205;
E=2.1e-10;

gamma=(Exp-B)./(T-Exp).*E; %interpolate IFN-gamma concentrations from standard curve

gamma=gamma*2; %all supernatants were diluted 2 fold for experiment

time=[5.5 17.5 29.5 41.5 53.5];

N1=[gamma(1:2,1), gamma(3:4,1), gamma(5:6,1), gamma(7:8,1), gamma(9:10,1)];
eN1=std(N1);
mN1=mean(N1);

norm_N1=mN1./m1;

N2=[gamma(1:2,2), gamma(3:4,2), gamma(5:6,2), gamma(7:8,2), gamma(9:10,2)];
eN2=std(N2);
mN2=mean(N2);

norm_N2=mN2./m2;

N3=[gamma(1:2,3), gamma(3:4,3), gamma(5:6,3), gamma(7:8,3), gamma(9:10,3)];
eN3=std(N3);
mN3=mean(N3);

norm_N3=mN3./m3;

N1_UP=[gamma(1:2,4), gamma(3:4,4), gamma(5:6,4), gamma(7:8,4), gamma(9:10,4)];
eN1UP=std(N1_UP);
mN1UP=mean(N1_UP);

norm_N4=mN1UP./m4;

N2_UP=[gamma(1:2,5), gamma(3:4,5), gamma(5:6,5), gamma(7:8,5), gamma(9:10,5)];
eN2UP=std(N2_UP);
mN2UP=mean(N2_UP);

norm_N5=mN2UP./m5;

N3_UP=[gamma(1:2,6), gamma(3:4,6), gamma(5:6,6), gamma(7:8,6), gamma(9:10,6)];
eN3UP=std(N3_UP);
mN3UP=mean(N3_UP);

norm_N6=mN3UP./m6;

figure()
hold on
plot(time, norm_N1, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 8)
plot(time, norm_N2, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 8)
plot(time, norm_N3, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 8)
set(gca, 'Fontsize', 20, 'xgrid', 'on', 'ygrid', 'on', 'yscale', 'log')
set(gcf, 'color', 'w')
xlabel('Time, (hours)')
ylabel('[IFN-\gamma]/CD69+ OT-I')
legend('10e5 B16 + OVA', '10e4 B16', '10e3 B16')
title('IFN-\gamma secretion normalized to number of activated T cells')
box on

%%
%Frequency of OT1s per CFSE peak 

t1=[98.7	0.218	0.291	0.164
98.7	0.25	0.197	0.273
98.5	0.235	0.329	0.353
98.9	0.204	0.163	0.347
98.7	0.372	0.297	0.327
98.4	0.389	0.419	0.314
98.6	0.123	0.319	0.442
98.4	0.248	0.343	0.362
98.7	0.241	0.344	0.258
98.7	0.123	0.369	0.369
98.5	0.235	0.487	0.199
97.7	0.52	0.364	0.572];

t2=[99.2	0.164	0.0662	0.188
99	0.273	0.153	0.273
99	0.264	0.157	0.211
99.3	0.185	0.102	0.192
99.1	0.312	0.175	0.189
99.1	0.264	0.114	0.255
99.1	0.174	0.0901	0.252
98.8	0.242	0.178	0.299
99	0.3	0.161	0.284
99.2	0.252	0.0615	0.191
98.9	0.276	0.145	0.258
98.5	0.308	0.269	0.359];

t3=[96.6	2.25	0.186	0.365
98.8	0.692	0.0904	0.181
98.8	0.597	0.144	0.211
98.8	0.542	0.0985	0.123
98.9	0.39	0.0845	0.263
98.4	0.437	0.186	0.466
99.1	0.517	0.0552	0.069
98.6	0.859	0.128	0.216
98.6	0.763	0.163	0.205
99.2	0.431	0.0501	0.14
99.2	0.398	0.0868	0.117
98.6	0.478	0.168	0.304];

t4=[80.1	17.1	1.52	0.812
68.9	22.6	6.53	1.32
83.1	12	3.09	1.29
95.6	2.01	1.05	0.827
95.8	1.55	1.2	0.864
93.3	3.17	1.4	1.27
75.3	21.2	1.73	1.16
74.2	19.9	4.49	0.851
88.1	8.08	1.88	1.33
90.4	3.48	2.87	2.12
93.7	3.9	0.945	0.907
92.2	5.49	0.927	0.901];

t5=[66.9	22.3	9.02	0.991
54.7	15.9	15	13.1
79.3	12.1	4.67	3.09
95.7	0.886	0.07	1.08
91.7	7.2	0.182	0.332
88.9	10	0.168	0.388
57.9	27.3	12.7	1.52
58.3	17.9	13.6	9.57
81.2	13.7	2.56	1.76
96.5	1.2	0.139	0.312
90.4	8.43	0.163	0.334
87.9	10.7	0.287	0.431];

N1_Ova=[t1(1,:), t2(1,:), t3(1,:), t4(1,:), t5(1,:)
        t1(7,:), t2(7,:), t3(7,:), t4(7,:), t5(7,:)]; e1=std(N1_Ova); m1=mean(N1_Ova);
e1=reshape(e1, 4,5); m1=reshape(m1, 4,5);

N2_Ova=[t1(2,:), t2(2,:), t3(2,:), t4(2,:), t5(2,:)
        t1(8,:), t2(8,:), t3(8,:), t4(8,:), t5(8,:)]; e2=std(N2_Ova); m2=mean(N2_Ova);
e2=reshape(e2, 4,5); m2=reshape(m2, 4,5);
    
N3_Ova=[t1(3,:), t2(3,:), t3(3,:), t4(3,:), t5(3,:)
        t1(9,:), t2(9,:), t3(9,:), t4(9,:), t5(9,:)]; e3=std(N3_Ova); m3=mean(N3_Ova);
e3=reshape(e3, 4,5); m3=reshape(m3, 4,5);

N1_UP=[t1(4,:), t2(4,:), t3(4,:), t4(4,:), t5(4,:)
       t1(10,:), t2(10,:), t3(10,:), t4(10,:), t5(10,:)]; e4=std(N1_UP); m4=mean(N1_UP);
e4=reshape(e4, 4,5);, m4=reshape(m4, 4,5);   
   
N2_UP=[t1(5,:), t2(5,:), t3(5,:), t4(5,:), t5(5,:)
       t1(11,:), t2(11,:), t3(11,:), t4(11,:), t5(11,:)]; e5=std(N2_UP); m5=mean(N2_UP);
e5=reshape(e5, 4,5); m5=reshape(m5, 4,5);
   
N3_UP=[t1(6,:), t2(6,:), t3(6,:), t4(6,:), t5(6,:)
       t1(12,:), t2(12,:), t3(12,:), t4(12,:), t5(12,:)]; e6=std(N3_UP); m6=mean(N3_UP);
e6=reshape(e6, 4,5); m6=reshape(m6, 4,5);
   
peak=[1 2 3 4];

figure()
subplot(2,3,1)
hold on
errorbar(peak, m1(:,1), e1(:,1), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 8)
errorbar(peak, m2(:,1), e2(:,1), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 8)
errorbar(peak, m3(:,1), e3(:,1), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 8)
set(gca, 'Fontsize', 20)
set(gcf, 'color', 'w')
xlabel('CFSE dilution')
ylabel('Frequency of B16')
legend('10e5 B16 + OVA', '10e4 B16', '10e3 B16')
title('T=5.5hours')
box on
subplot(2,3,2)
hold on
errorbar(peak, m1(:,2), e1(:,2), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 8)
errorbar(peak, m2(:,2), e2(:,2), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 8)
errorbar(peak, m3(:,2), e3(:,2), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 8)
set(gca, 'Fontsize', 20)
set(gcf, 'color', 'w')
xlabel('CFSE dilution')
ylabel('Frequency of B16')
title('T=17.5hours')
box on
subplot(2,3,3)
hold on
errorbar(peak, m1(:,3), e1(:,3), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 8)
errorbar(peak, m2(:,3), e2(:,3), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 8)
errorbar(peak, m3(:,3), e3(:,3), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 8)
set(gca, 'Fontsize', 20)
set(gcf, 'color', 'w')
xlabel('CFSE dilution')
ylabel('Frequency of B16')
title('T=29.5hours')
box on
subplot(2,3,4)
hold on
errorbar(peak, m1(:,4), e1(:,4), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 8)
errorbar(peak, m2(:,4), e2(:,4), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 8)
errorbar(peak, m3(:,4), e3(:,4), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 8)
set(gca, 'Fontsize', 20)
set(gcf, 'color', 'w')
xlabel('CFSE dilution')
ylabel('Frequency of B16')
title('T=41.5hours')
box on
subplot(2,3,5)
hold on
errorbar(peak, m1(:,5), e1(:,5), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 8)
errorbar(peak, m2(:,5), e2(:,5), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 8)
errorbar(peak, m3(:,5), e3(:,5), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 8)
set(gca, 'Fontsize', 20)
set(gcf, 'color', 'w')
xlabel('CFSE dilution')
ylabel('Frequency of B16')
title('T=53.5hours')
box on

%Plot the fraction of cells that have undergone 3 or more divisions at each
%time
figure()
hold on
plot(time, m1(3,:)+m1(4,:), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
plot(time, m2(3,:)+m1(4,:), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 10)
plot(time, m3(3,:)+m1(4,:), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
plot(time, m4(3,:)+m1(4,:), '--ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
plot(time, m5(3,:)+m1(4,:), '--ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 10)
plot(time, m6(3,:)+m1(4,:), '--ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
set(gca, 'Fontsize', 20, 'xgrid', 'on', 'ygrid', 'on')
set(gcf, 'color', 'w')
ylabel('% of live OT-1')
xlabel('Time, (hours)')
box on
legend('10e5 B16 + Ova', '10e4', '10e3', '10e5 Unpulsed', '10e4', '10e3')
title('% of OT-1 having undergone >3 Divisions')
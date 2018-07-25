%B16-OT1 Co-culture 9.23.13
%B16s were pulsed with 100nM OVA in a large volume of RPMI rolling in the 37oC incubator for ~3 hours.
%After 3 hours, cells were washed 3x, then seeded in 96 well plates at
%10e5, 10e4, and 10e3 cells per well.  
%10e5, 10e4, or 10e3 naive OT1 t cells were added per well.    
%The objectives were: (a) See how different densities of target cells or T
%cells affects overall antigenicity, activity, accumulation of IFN-gamma and MHC
%expression.  

%%
%Percent CD69+ over time

%T cells were gated as (1)CFSE+, (2)FSC/SSC, (3)CD8+, (4)DAPI- (5)CD69+

    %B1  %B2  %B3
t1=[41   16.8  10.5
    33.3 15.3  7.94 %N1 - 10e5 T cells
    37.7 16.6  6.66
    34.7 12.2  5.06 %N2 - 10e4 T cells
    33   13.9  7.12
    33.3 14.7  4.7  %N3 - 10e3 T cells
    7.36 8.59  7.28
    8.27 7.47  8.04 %N1 - Unpulsed
    4.9  4.43  3.68
    4.18 5.5   4.44 %N2 - Unpulsed
    3.61 4.4   4.15
    4.64 2.2   3.09]; %N3 - Unpulsed

t2=[48.8 16.7 7.29
    45.5 18.3 6.9
    46.9 12.7 4.66
    42.5 11.3 3.9
    41.4 10.9 6.36
    45.3 18   3.24
    7.66 6.59 6.38
    6.87 7.63 6.53
    3.53 3.51 1.64
    2.93 2.34 2.76
    3.36 1.72 2.96
    2.97 2.41 1.72];

t3=[41.5  13.5 6.24
    41.5  12.3 6.84 %Replaced row 2 column 1 with a duplicate from row 1 column 1 even though there was no biological replicate here - for plotting sake. 
    27.5  6.33 3.12
    31.1  6.02 2.05
    53.7  7.34 2.63
    54.2  5.88 5.88
    5.94  4.97 4.24
    6.41  5.29 5.74
    1.27  2.01 2.56
    0.687 1.96 0.891
    3.64  0    1.54
    5     1.14 0];

t4=[32.5 23    8.66
    31.4 21.8  9.79
    18.2 5.18  3.66
    24.4 4.62  2.04
    20.5 4.23  0
    42.5 8.33  0
    8.13 4.78  5.58
    3.68 3.19  5.45
    0.93 0.47  3.55
    1.76 0.877 4.55
    0    0     0
    0    0     0]; 

t5=[37.9 28   29.1
    41.1 26.2 11
    28   11   6.39
    23.7 8.79 2.1
    51.6 12.9 4.17
    47.8 9.62 2.78
    11.8 10.7 10.1
    11.8 10.7 10.1 %Replaced all three numbers in row 8 columns 1 2 and 3 with duplicates of row 7 even though there was no biological replicate. for plotting sake.
    6.45 0.249 1.09 
    8.47 1.64  2.04
    22.2 0     9.09
    0    0     0];

t6=[44   15.9 8.26
    37.1 16.8 5.09
    9.88 3.05 2.68
    9.5  2.2  3.03
    10   25   0
    14.3 0    0
    27.1 7.05 10.1
    27.1 7.05 10.1 %Replaced all three numbers in row 8 columns 1 2 and 3 with duplicates of row 7 even though there was no biological replicate.  for plotting sake.
    16.7 0    0
    0    1.14 0
    0    0    0
    0    0    0];

B1T1_Ova=[t1(1:2,1), t2(1:2,1), t3(1:2,1), t4(1:2,1), t5(1:2,1), t6(1:2,1)]; eB1T1=std(B1T1_Ova); mB1T1=mean(B1T1_Ova);
B2T1_Ova=[t1(1:2,2), t2(1:2,2), t3(1:2,2), t4(1:2,2), t5(1:2,2), t6(1:2,2)]; eB2T1=std(B2T1_Ova); mB2T1=mean(B2T1_Ova);
B3T1_Ova=[t1(1:2,3), t2(1:2,3), t3(1:2,3), t4(1:2,3), t5(1:2,3), t6(1:2,3)]; eB3T1=std(B3T1_Ova); mB3T1=mean(B3T1_Ova);

B1T2_Ova=[t1(3:4,1), t2(3:4,1), t3(3:4,1), t4(3:4,1), t5(3:4,1), t6(3:4,1)]; eB1T2=std(B1T2_Ova); mB1T2=mean(B1T2_Ova);
B2T2_Ova=[t1(3:4,2), t2(3:4,2), t3(3:4,2), t4(3:4,2), t5(3:4,2), t6(3:4,2)]; eB2T2=std(B2T2_Ova); mB2T2=mean(B2T2_Ova);
B3T2_Ova=[t1(3:4,3), t2(3:4,3), t3(3:4,3), t4(3:4,3), t5(3:4,3), t6(3:4,3)]; eB3T2=std(B3T2_Ova); mB3T2=mean(B3T2_Ova);

B1T3_Ova=[t1(5:6,1), t2(5:6,1), t3(5:6,1), t4(5:6,1), t5(5:6,1), t6(5:6,1)]; eB1T3=std(B1T3_Ova); mB1T3=mean(B1T3_Ova);
B2T3_Ova=[t1(5:6,2), t2(5:6,2), t3(5:6,2), t4(5:6,2), t5(5:6,2), t6(5:6,2)]; eB2T3=std(B2T3_Ova); mB2T3=mean(B2T3_Ova);
B3T3_Ova=[t1(5:6,3), t2(5:6,3), t3(5:6,3), t4(5:6,3), t5(5:6,3), t6(5:6,3)]; eB3T3=std(B3T3_Ova); mB3T3=mean(B3T3_Ova);

B1T1_UP=[t1(7:8,1), t2(7:8,1), t3(7:8,1), t4(7:8,1), t5(7:8,1), t6(7:8,1)]; eB1T1_U=std(B1T1_UP); mB1T1_U=mean(B1T1_UP);
B2T1_UP=[t1(7:8,2), t2(7:8,2), t3(7:8,2), t4(7:8,2), t5(7:8,2), t6(7:8,2)]; eB2T1_U=std(B2T1_UP); mB2T1_U=mean(B2T1_UP);
B3T1_UP=[t1(7:8,3), t2(7:8,3), t3(7:8,3), t4(7:8,3), t5(7:8,3), t6(7:8,3)]; eB3T1_U=std(B3T1_UP); mB3T1_U=mean(B3T1_UP);

B1T2_UP=[t1(9:10,1), t2(9:10,1), t3(9:10,1), t4(9:10,1), t5(9:10,1), t6(9:10,1)]; eB1T2_U=std(B1T2_UP); mB1T2_U=mean(B1T2_UP);
B2T2_UP=[t1(9:10,2), t2(9:10,2), t3(9:10,2), t4(9:10,2), t5(9:10,2), t6(9:10,2)]; eB2T2_U=std(B2T2_UP); mB2T2_U=mean(B2T2_UP);
B3T2_UP=[t1(9:10,3), t2(9:10,3), t3(9:10,3), t4(9:10,3), t5(9:10,3), t6(9:10,3)]; eB3T2_U=std(B3T2_UP); mB3T2_U=mean(B3T2_UP);

B1T3_UP=[t1(11:12,1), t2(11:12,1), t3(11:12,1), t4(11:12,1), t5(11:12,1), t6(11:12,1)]; eB1T3_U=std(B1T3_UP); mB1T3_U=mean(B1T3_UP);
B2T3_UP=[t1(11:12,2), t2(11:12,2), t3(11:12,2), t4(11:12,2), t5(11:12,2), t6(11:12,2)]; eB2T3_U=std(B2T3_UP); mB2T3_U=mean(B2T3_UP);
B3T3_UP=[t1(11:12,3), t2(11:12,3), t3(11:12,3), t4(11:12,3), t5(11:12,3), t6(11:12,3)]; eB3T3_U=std(B3T3_UP); mB3T3_U=mean(B3T3_UP);

time=[7 19 31 43 55 67];

figure()
subplot(1,3,1)
hold on
errorbar(time, mB1T1, eB1T1, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 8)
errorbar(time, mB2T1, eB2T1, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 8)
errorbar(time, mB3T1, eB3T1, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 8)
errorbar(time, mB1T1_U, eB1T1_U, '--ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 8)
errorbar(time, mB2T1_U, eB2T1_U, '--ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 8)
errorbar(time, mB3T1_U, eB3T1_U, '--ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 8)
set(gca, 'Fontsize', 20, 'xgrid', 'on', 'ygrid', 'on', 'ylim', [0 60])
set(gcf, 'color', 'w')
xlabel('Time, (hours)')
ylabel('%CD69+')
legend('10e5 B16 + OVA', '10e4 B16', '10e3 B16', '10e5 B16, Unpulsed', '10e4 B16', '10e3 B16')
title('%OT1 CD69+ for 10e5 OT-1')
box on
subplot(1,3,2)
hold on
errorbar(time, mB1T2, eB1T2, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 8)
errorbar(time, mB2T2, eB2T2, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 8)
errorbar(time, mB3T2, eB3T2, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 8)
errorbar(time, mB1T2_U, eB1T2_U, '--ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 8)
errorbar(time, mB2T2_U, eB2T2_U, '--ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 8)
errorbar(time, mB3T2_U, eB3T2_U, '--ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 8)
set(gca, 'Fontsize', 20, 'xgrid', 'on', 'ygrid', 'on', 'ylim', [0 60])
set(gcf, 'color', 'w')
xlabel('Time, (hours)')
ylabel('%CD69+')
title('%OT1 CD69+ for 10e4 OT-1')
box on
subplot(1,3,3)
hold on
errorbar(time, mB1T3, eB1T3, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 8)
errorbar(time, mB2T3, eB2T3, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 8)
errorbar(time, mB3T3, eB3T3, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 8)
errorbar(time, mB1T3_U, eB1T3_U, '--ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 8)
errorbar(time, mB2T3_U, eB2T3_U, '--ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 8)
errorbar(time, mB3T3_U, eB3T3_U, '--ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 8)
set(gca, 'Fontsize', 20, 'xgrid', 'on', 'ygrid', 'on', 'ylim', [0 60])
set(gcf, 'color', 'w')
xlabel('Time, (hours)')
ylabel('%CD69+')
title('%OT1 CD69+ for 10e3 OT-1')
box on
%%

%Percent of OT1 cells alive over time

t1=[3.7 1.8 0.2
    0.8 1.0 0.7
    0.0 4.2 1.7
    0.8 0.7 0.2
    0.0 0.0 0.0
    0.2 0.8 1.8
    1.1 0.2 1.3
    0.7 0.4 0.7
    0.5 0.4 0.3
    0.2 2.7 2.3
    0.0 4.4 0.0
    0.0 0.0 0.0];

t2=[1.8 2.0 0.3
    2.5 2.2 0.5
    0.0 0.0 0.0
    0.5 0.4 1.1
    0.0 0.0 0.0
    0.2 0.0 0.0 
    1.0 1.2 1.0 
    0.5 2.3 1.3
    0.0 0.9 1.1
    0.3 0.3 1.0
    0.0 1.0 0.0
    0.0 40.1 19.7];

t3=[34.3 3.8 2.3
    34.3 2.7 1.6 %Replaced row 2 column 1 with a duplicate from row 1 column 1 even though there was no biological replicate here - for plotting sake. 
    0.4  1.6 1.4
    0.3  0.0 0.5
    0.2  0.0 0.0
    0.0  0.0 0.0
    2.3  0.8 0.3
    2.5  0.7 1.0
    0.2  0.2 0.4
    0.3  0.0 0.5
    0.0  0.0 2.8
    0.2  1.0 0.0];

t4=[91.3 196.5 63.2
    97.8 152.1 60.8
    8.9  18.2  6.1
    11.7 10.0  6.9
    0.8  2.6   8.3
    1.3  0.3   0.0
    13.5 11.3  7.3
    6.2  6.0   1.8
    0.8  0.6   0.5
    3.2  2.0   0.3
    0.0  1.7   0.0
    0.0  0.0   0.0]; 

t5=[290.6 316.4 155.3
    204.6 259.6 89.5
    42.7  57.3  25.5
    28.2  44.5  18.6
    2.3   2.3   20.0
    0.7   1.8   18.5
    27.7  56.2  50.7
    27.7  56.2  50.7 %Replaced all three numbers in row 8 columns 1 2 and 3 with duplicates of row 7 even though there was no biological replicate. for plotting sake.
    1.5   11.5  8.9
    1.0   11.7  9.1
    0.2   0.3   7.5
    0.0   1.2   0.0];

t6=[220.7 90.3 31.3
    209.6 104.0 46.0
    17.2  7.0   9.6
    12.8  5.8   6.2
    0.3   0.0   3.0
    0.8   0.7   1.1
    28.7  26.5  19.8
    28.7  26.5  19.8 %Replaced all three numbers in row 8 columns 1 2 and 3 with duplicates of row 7 even though there was no biological replicate.  for plotting sake. 
    1.0   2.2   4.9
    0.5   3.2   7.9
    0.0   0.2   5.3
    0.2   0.7   1.0];

B1T1_Ova=[t1(1:2,1), t2(1:2,1), t3(1:2,1), t4(1:2,1), t5(1:2,1), t6(1:2,1)]; eB1T1=std(B1T1_Ova); mB1T1=mean(B1T1_Ova);
B2T1_Ova=[t1(1:2,2), t2(1:2,2), t3(1:2,2), t4(1:2,2), t5(1:2,2), t6(1:2,2)]; eB2T1=std(B2T1_Ova); mB2T1=mean(B2T1_Ova);
B3T1_Ova=[t1(1:2,3), t2(1:2,3), t3(1:2,3), t4(1:2,3), t5(1:2,3), t6(1:2,3)]; eB3T1=std(B3T1_Ova); mB3T1=mean(B3T1_Ova);

B1T2_Ova=[t1(3:4,1), t2(3:4,1), t3(3:4,1), t4(3:4,1), t5(3:4,1), t6(3:4,1)]; eB1T2=std(B1T2_Ova); mB1T2=mean(B1T2_Ova);
B2T2_Ova=[t1(3:4,2), t2(3:4,2), t3(3:4,2), t4(3:4,2), t5(3:4,2), t6(3:4,2)]; eB2T2=std(B2T2_Ova); mB2T2=mean(B2T2_Ova);
B3T2_Ova=[t1(3:4,3), t2(3:4,3), t3(3:4,3), t4(3:4,3), t5(3:4,3), t6(3:4,3)]; eB3T2=std(B3T2_Ova); mB3T2=mean(B3T2_Ova);

B1T3_Ova=[t1(5:6,1), t2(5:6,1), t3(5:6,1), t4(5:6,1), t5(5:6,1), t6(5:6,1)]; eB1T3=std(B1T3_Ova); mB1T3=mean(B1T3_Ova);
B2T3_Ova=[t1(5:6,2), t2(5:6,2), t3(5:6,2), t4(5:6,2), t5(5:6,2), t6(5:6,2)]; eB2T3=std(B2T3_Ova); mB2T3=mean(B2T3_Ova);
B3T3_Ova=[t1(5:6,3), t2(5:6,3), t3(5:6,3), t4(5:6,3), t5(5:6,3), t6(5:6,3)]; eB3T3=std(B3T3_Ova); mB3T3=mean(B3T3_Ova);

B1T1_UP=[t1(7:8,1), t2(7:8,1), t3(7:8,1), t4(7:8,1), t5(7:8,1), t6(7:8,1)]; eB1T1_U=std(B1T1_UP); mB1T1_U=mean(B1T1_UP);
B2T1_UP=[t1(7:8,2), t2(7:8,2), t3(7:8,2), t4(7:8,2), t5(7:8,2), t6(7:8,2)]; eB2T1_U=std(B2T1_UP); mB2T1_U=mean(B2T1_UP);
B3T1_UP=[t1(7:8,3), t2(7:8,3), t3(7:8,3), t4(7:8,3), t5(7:8,3), t6(7:8,3)]; eB3T1_U=std(B3T1_UP); mB3T1_U=mean(B3T1_UP);

B1T2_UP=[t1(9:10,1), t2(9:10,1), t3(9:10,1), t4(9:10,1), t5(9:10,1), t6(9:10,1)]; eB1T2_U=std(B1T2_UP); mB1T2_U=mean(B1T2_UP);
B2T2_UP=[t1(9:10,2), t2(9:10,2), t3(9:10,2), t4(9:10,2), t5(9:10,2), t6(9:10,2)]; eB2T2_U=std(B2T2_UP); mB2T2_U=mean(B2T2_UP);
B3T2_UP=[t1(9:10,3), t2(9:10,3), t3(9:10,3), t4(9:10,3), t5(9:10,3), t6(9:10,3)]; eB3T2_U=std(B3T2_UP); mB3T2_U=mean(B3T2_UP);

B1T3_UP=[t1(11:12,1), t2(11:12,1), t3(11:12,1), t4(11:12,1), t5(11:12,1), t6(11:12,1)]; eB1T3_U=std(B1T3_UP); mB1T3_U=mean(B1T3_UP);
B2T3_UP=[t1(11:12,2), t2(11:12,2), t3(11:12,2), t4(11:12,2), t5(11:12,2), t6(11:12,2)]; eB2T3_U=std(B2T3_UP); mB2T3_U=mean(B2T3_UP);
B3T3_UP=[t1(11:12,3), t2(11:12,3), t3(11:12,3), t4(11:12,3), t5(11:12,3), t6(11:12,3)]; eB3T3_U=std(B3T3_UP); mB3T3_U=mean(B3T3_UP);

time=[7 19 31 43 55 67];

figure()
subplot(1,3,1)
hold on
errorbar(time, mB1T1, eB1T1, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 8)
errorbar(time, mB2T1, eB2T1, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 8)
errorbar(time, mB3T1, eB3T1, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 8)
errorbar(time, mB1T1_U, eB1T1_U, '--ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 8)
errorbar(time, mB2T1_U, eB2T1_U, '--ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 8)
errorbar(time, mB3T1_U, eB3T1_U, '--ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 8)
set(gca, 'Fontsize', 20, 'xgrid', 'on', 'ygrid', 'on')
set(gcf, 'color', 'w')
xlabel('Time, (hours)')
ylabel('# proliferating per 5k events')
legend('10e5 B16 + OVA', '10e4 B16', '10e3 B16', '10e5 B16, Unpulsed', '10e4 B16', '10e3 B16')
title('No. of OT1 Proliferating for 10e5 OT-1')
box on
subplot(1,3,2)
hold on
errorbar(time, mB1T2, eB1T2, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 8)
errorbar(time, mB2T2, eB2T2, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 8)
errorbar(time, mB3T2, eB3T2, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 8)
errorbar(time, mB1T2_U, eB1T2_U, '--ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 8)
errorbar(time, mB2T2_U, eB2T2_U, '--ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 8)
errorbar(time, mB3T2_U, eB3T2_U, '--ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 8)
set(gca, 'Fontsize', 20, 'xgrid', 'on', 'ygrid', 'on', 'ylim', [0 350])
set(gcf, 'color', 'w')
xlabel('Time, (hours)')
ylabel('# proliferating per 5k events')
title('No. of OT1 Proliferating for 10e4 OT-1')
box on
subplot(1,3,3)
hold on
errorbar(time, mB1T3, eB1T3, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 8)
errorbar(time, mB2T3, eB2T3, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 8)
errorbar(time, mB3T3, eB3T3, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 8)
errorbar(time, mB1T3_U, eB1T3_U, '--ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 8)
errorbar(time, mB2T3_U, eB2T3_U, '--ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 8)
errorbar(time, mB3T3_U, eB3T3_U, '--ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 8)
set(gca, 'Fontsize', 20, 'xgrid', 'on', 'ygrid', 'on', 'ylim', [0 350])
set(gcf, 'color', 'w')
xlabel('Time, (hours)')
ylabel('# of proliferating per 5k events')
title('No. of OT1 Proliferating for 10e3 OT-1')
box on

%%
%Percent of B16s alive over time

%B16s were gated by (1)CFSE-, (2)SSC hi, (3)Alive
t1=[97.9 86.8 55.2
    96.7 87.7 40.6
    97.3 95.7 88.5
    97.5 95.1 86.9
    97.2 95.3 86.5
    97.4 95.7 93.2
    96.7 87.7 40.9
    96   82.2 40.4
    95.2 93.6 80.5
    94.9 86.2 72.7
    94.4 92.6 87.2 
    92.3 88.9 88.3];

t2=[95.6 55.8 34.3
    96.1 66.6 11.9
    97.7 91.8 65.8
    95.8 92.1 70.2
    97.8 94.6 87.8
    98   95.7 91.8
    94.1 25.3 14.1
    93.5 37.4 6.38
    95.5 92.7 67.6
    95.6 90.7 62.5 
    96.4 94.8 85.5
    96.2 91.5 85.6];

t3=[99.8 44.2 8.67
    99.8 45   9.03   %Replaced row 2 column 1 with a duplicate from row 1 column 1 even though there was no biological replicate here - for plotting sake
    96.8 94   54
    96.2 93.4 58.5
    97.6 96.1 89.3
    97.3 96   87.9
    91.8 41   11.3
    88.9 30.1 8.22
    96.8 89.3 51.5
    96.7 89.4 43.6
    97.6 93.1 91.7
    96.9 94.6 88.5];

t4=[72.9 35.7 12.9
    86   45   8.86
    94.3 93.5 73.6
    94.8 96.2 88.6
    96.1 94   84.1
    94.5 97.6 94.4
    86.4 50.9 13.2 
    89.5 49.9 90.6
    94   69.5 94.6
    92.8 60.9 92.2
    95.9 85.1 97.3
    96.1 89.4 97.3]; 

t5=[76.9 53.9 14.7
    79.4 46.3 14.7
    94.2 97.1 74.2
    94.3 95.8 76.9
    94.4 97.1 91
    95.1 96.6 91.1
    79.5 64   24.1
    79.5 64   24.1  %Replaced all three numbers in row 8 columns 1 2 and 3 with duplicates of row 7 even though there was no biological replicate. for plotting sake.
    92.3 93.8 65.7
    92.6 93   62.1
    94.9 96.5 90.1
    92.2 93.9 93.1];

t6=[89.5 75.9 38.6
    83.5 71.5 63
    95.1 96.9 86.5
    91.7 94.7 89.1
    95.5 96.3 89.2
    94   96.6 88.4
    88.7 84.4 42.6
    88.7 84.5 42.6  %Replaced all three numbers in row 8 columns 1 2 and 3 with duplicates of row 7 even though there was no biological replicate.  for plotting sake. 
    92.6 93.3 76.2
    92.7 95.6 82.2
    92.4 94.6 89.2 
    93.7 94   87.9];

B1T1_Ova=[t1(1:2,1), t2(1:2,1), t3(1:2,1), t4(1:2,1), t5(1:2,1), t6(1:2,1)]; eB1T1=std(B1T1_Ova); mB1T1=mean(B1T1_Ova);
B2T1_Ova=[t1(1:2,2), t2(1:2,2), t3(1:2,2), t4(1:2,2), t5(1:2,2), t6(1:2,2)]; eB2T1=std(B2T1_Ova); mB2T1=mean(B2T1_Ova);
B3T1_Ova=[t1(1:2,3), t2(1:2,3), t3(1:2,3), t4(1:2,3), t5(1:2,3), t6(1:2,3)]; eB3T1=std(B3T1_Ova); mB3T1=mean(B3T1_Ova);

B1T2_Ova=[t1(3:4,1), t2(3:4,1), t3(3:4,1), t4(3:4,1), t5(3:4,1), t6(3:4,1)]; eB1T2=std(B1T2_Ova); mB1T2=mean(B1T2_Ova);
B2T2_Ova=[t1(3:4,2), t2(3:4,2), t3(3:4,2), t4(3:4,2), t5(3:4,2), t6(3:4,2)]; eB2T2=std(B2T2_Ova); mB2T2=mean(B2T2_Ova);
B3T2_Ova=[t1(3:4,3), t2(3:4,3), t3(3:4,3), t4(3:4,3), t5(3:4,3), t6(3:4,3)]; eB3T2=std(B3T2_Ova); mB3T2=mean(B3T2_Ova);

B1T3_Ova=[t1(5:6,1), t2(5:6,1), t3(5:6,1), t4(5:6,1), t5(5:6,1), t6(5:6,1)]; eB1T3=std(B1T3_Ova); mB1T3=mean(B1T3_Ova);
B2T3_Ova=[t1(5:6,2), t2(5:6,2), t3(5:6,2), t4(5:6,2), t5(5:6,2), t6(5:6,2)]; eB2T3=std(B2T3_Ova); mB2T3=mean(B2T3_Ova);
B3T3_Ova=[t1(5:6,3), t2(5:6,3), t3(5:6,3), t4(5:6,3), t5(5:6,3), t6(5:6,3)]; eB3T3=std(B3T3_Ova); mB3T3=mean(B3T3_Ova);

B1T1_UP=[t1(7:8,1), t2(7:8,1), t3(7:8,1), t4(7:8,1), t5(7:8,1), t6(7:8,1)]; eB1T1_U=std(B1T1_UP); mB1T1_U=mean(B1T1_UP);
B2T1_UP=[t1(7:8,2), t2(7:8,2), t3(7:8,2), t4(7:8,2), t5(7:8,2), t6(7:8,2)]; eB2T1_U=std(B2T1_UP); mB2T1_U=mean(B2T1_UP);
B3T1_UP=[t1(7:8,3), t2(7:8,3), t3(7:8,3), t4(7:8,3), t5(7:8,3), t6(7:8,3)]; eB3T1_U=std(B3T1_UP); mB3T1_U=mean(B3T1_UP);

B1T2_UP=[t1(9:10,1), t2(9:10,1), t3(9:10,1), t4(9:10,1), t5(9:10,1), t6(9:10,1)]; eB1T2_U=std(B1T2_UP); mB1T2_U=mean(B1T2_UP);
B2T2_UP=[t1(9:10,2), t2(9:10,2), t3(9:10,2), t4(9:10,2), t5(9:10,2), t6(9:10,2)]; eB2T2_U=std(B2T2_UP); mB2T2_U=mean(B2T2_UP);
B3T2_UP=[t1(9:10,3), t2(9:10,3), t3(9:10,3), t4(9:10,3), t5(9:10,3), t6(9:10,3)]; eB3T2_U=std(B3T2_UP); mB3T2_U=mean(B3T2_UP);

B1T3_UP=[t1(11:12,1), t2(11:12,1), t3(11:12,1), t4(11:12,1), t5(11:12,1), t6(11:12,1)]; eB1T3_U=std(B1T3_UP); mB1T3_U=mean(B1T3_UP);
B2T3_UP=[t1(11:12,2), t2(11:12,2), t3(11:12,2), t4(11:12,2), t5(11:12,2), t6(11:12,2)]; eB2T3_U=std(B2T3_UP); mB2T3_U=mean(B2T3_UP);
B3T3_UP=[t1(11:12,3), t2(11:12,3), t3(11:12,3), t4(11:12,3), t5(11:12,3), t6(11:12,3)]; eB3T3_U=std(B3T3_UP); mB3T3_U=mean(B3T3_UP);

time=[7 19 31 43 55 67];

figure()
subplot(1,3,1)
hold on
errorbar(time, mB1T1, eB1T1, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 8)
errorbar(time, mB2T1, eB2T1, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 8)
errorbar(time, mB3T1, eB3T1, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 8)
errorbar(time, mB1T1_U, eB1T1_U, '--ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 8)
errorbar(time, mB2T1_U, eB2T1_U, '--ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 8)
errorbar(time, mB3T1_U, eB3T1_U, '--ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 8)
set(gca, 'Fontsize', 20, 'xgrid', 'on', 'ygrid', 'on', 'ylim', [0 100])
set(gcf, 'color', 'w')
xlabel('Time, (hours)')
ylabel('%Alive')
legend('10e5 B16 + OVA', '10e4 B16', '10e3 B16', '10e5 B16, Unpulsed', '10e4 B16', '10e3 B16')
title('%B16 Alive for 10e5 OT-1')
box on
subplot(1,3,2)
hold on
errorbar(time, mB1T2, eB1T2, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 8)
errorbar(time, mB2T2, eB2T2, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 8)
errorbar(time, mB3T2, eB3T2, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 8)
errorbar(time, mB1T2_U, eB1T2_U, '--ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 8)
errorbar(time, mB2T2_U, eB2T2_U, '--ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 8)
errorbar(time, mB3T2_U, eB3T2_U, '--ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 8)
set(gca, 'Fontsize', 20, 'xgrid', 'on', 'ygrid', 'on', 'ylim', [0 100])
set(gcf, 'color', 'w')
xlabel('Time, (hours)')
ylabel('%Alive')
title('%B16 Alive for 10e4 OT-1')
box on
subplot(1,3,3)
hold on
errorbar(time, mB1T3, eB1T3, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 8)
errorbar(time, mB2T3, eB2T3, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 8)
errorbar(time, mB3T3, eB3T3, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 8)
errorbar(time, mB1T3_U, eB1T3_U, '--ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 8)
errorbar(time, mB2T3_U, eB2T3_U, '--ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 8)
errorbar(time, mB3T3_U, eB3T3_U, '--ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 8)
set(gca, 'Fontsize', 20, 'xgrid', 'on', 'ygrid', 'on', 'ylim', [0 100])
set(gcf, 'color', 'w')
xlabel('Time, (hours)')
ylabel('%Alive')
title('%B16 Alive for 10e3 OT-1')
box on


%%
%GMFI of MHC for B16 cells over time

t1=[3410 1626 693
    2492 1593 905
    1787 1508 1230 
    1712 1487 1123
    1653 1441 1426 
    1578 1393 1196
    1459 1183 214
    1521 1423 839
    1547 1381 1286
    1520 1430 1059
    1416 1255 1067
    1358 1313 1044];
t1=t1./4.3;

t2=[56959 21257 860
    50017 25687 1171
    13813 3394  1020
    14866 2458  1215
    2518  1055  853
    2876  1077  884
    1829  1574  455
    2341  2285  483
    1413  979   702
    1314  988   800
    1165  1013  874
    1080  874   779];
t2=t2./4.3;

t3=[10917 4625  345
    10917 11144 321  %Replaced row 2 column 1 with a duplicate from row 1 column 1 even though there was no biological replicate here - for plotting sake. 
    7319  2240  280
    7653  2037  365
    884   200   169
    911   185   158
    1401  543   157
    1752  559   148
    315   172   160
    363   165   161
    320   147   154
    358   142   185];

t4=[16108 15117 939
    17426 17777 512
    7439  3462  222
    7290  7809  301
    1490  468   162
    752   194   142
    2364  470   181
    887   338   277
    143   159   357
    152   148   275
    144   164   359
    138   146   359]; 

t5=[14169 31780 2085
    16962 33257 1434
    9800  11633 333
    8128  9571  247
    829   180   198
    970   230   157 
    3730  1789  235
    3730  1789  235  %Replaced all three numbers in row 8 columns 1 2 and 3 with duplicates of row 7 even though there was no biological replicate. for plotting sake.
    392   138   143
    458   154   183
    395   128   142
    456   119   160];

t6=[14987 28323 1200
    18069 8819  922
    8771  5419  212
    8175  4112  264
    592   156   115
    740   156   122
    3699  1676  410
    3699  1676  410 %Replaced all three numbers in row 8 columns 1 2 and 3 with duplicates of row 7 even though there was no biological replicate. for plotting sake.
    412   144   128
    447   144   137
    439   120   130
    417   124   129];

B1T1_Ova=[t1(1:2,1), t2(1:2,1), t3(1:2,1), t4(1:2,1), t5(1:2,1), t6(1:2,1)]; eB1T1=std(B1T1_Ova); mB1T1=mean(B1T1_Ova);
B2T1_Ova=[t1(1:2,2), t2(1:2,2), t3(1:2,2), t4(1:2,2), t5(1:2,2), t6(1:2,2)]; eB2T1=std(B2T1_Ova); mB2T1=mean(B2T1_Ova);
B3T1_Ova=[t1(1:2,3), t2(1:2,3), t3(1:2,3), t4(1:2,3), t5(1:2,3), t6(1:2,3)]; eB3T1=std(B3T1_Ova); mB3T1=mean(B3T1_Ova);

B1T2_Ova=[t1(3:4,1), t2(3:4,1), t3(3:4,1), t4(3:4,1), t5(3:4,1), t6(3:4,1)]; eB1T2=std(B1T2_Ova); mB1T2=mean(B1T2_Ova);
B2T2_Ova=[t1(3:4,2), t2(3:4,2), t3(3:4,2), t4(3:4,2), t5(3:4,2), t6(3:4,2)]; eB2T2=std(B2T2_Ova); mB2T2=mean(B2T2_Ova);
B3T2_Ova=[t1(3:4,3), t2(3:4,3), t3(3:4,3), t4(3:4,3), t5(3:4,3), t6(3:4,3)]; eB3T2=std(B3T2_Ova); mB3T2=mean(B3T2_Ova);

B1T3_Ova=[t1(5:6,1), t2(5:6,1), t3(5:6,1), t4(5:6,1), t5(5:6,1), t6(5:6,1)]; eB1T3=std(B1T3_Ova); mB1T3=mean(B1T3_Ova);
B2T3_Ova=[t1(5:6,2), t2(5:6,2), t3(5:6,2), t4(5:6,2), t5(5:6,2), t6(5:6,2)]; eB2T3=std(B2T3_Ova); mB2T3=mean(B2T3_Ova);
B3T3_Ova=[t1(5:6,3), t2(5:6,3), t3(5:6,3), t4(5:6,3), t5(5:6,3), t6(5:6,3)]; eB3T3=std(B3T3_Ova); mB3T3=mean(B3T3_Ova);

B1T1_UP=[t1(7:8,1), t2(7:8,1), t3(7:8,1), t4(7:8,1), t5(7:8,1), t6(7:8,1)]; eB1T1_U=std(B1T1_UP); mB1T1_U=mean(B1T1_UP);
B2T1_UP=[t1(7:8,2), t2(7:8,2), t3(7:8,2), t4(7:8,2), t5(7:8,2), t6(7:8,2)]; eB2T1_U=std(B2T1_UP); mB2T1_U=mean(B2T1_UP);
B3T1_UP=[t1(7:8,3), t2(7:8,3), t3(7:8,3), t4(7:8,3), t5(7:8,3), t6(7:8,3)]; eB3T1_U=std(B3T1_UP); mB3T1_U=mean(B3T1_UP);

B1T2_UP=[t1(9:10,1), t2(9:10,1), t3(9:10,1), t4(9:10,1), t5(9:10,1), t6(9:10,1)]; eB1T2_U=std(B1T2_UP); mB1T2_U=mean(B1T2_UP);
B2T2_UP=[t1(9:10,2), t2(9:10,2), t3(9:10,2), t4(9:10,2), t5(9:10,2), t6(9:10,2)]; eB2T2_U=std(B2T2_UP); mB2T2_U=mean(B2T2_UP);
B3T2_UP=[t1(9:10,3), t2(9:10,3), t3(9:10,3), t4(9:10,3), t5(9:10,3), t6(9:10,3)]; eB3T2_U=std(B3T2_UP); mB3T2_U=mean(B3T2_UP);

B1T3_UP=[t1(11:12,1), t2(11:12,1), t3(11:12,1), t4(11:12,1), t5(11:12,1), t6(11:12,1)]; eB1T3_U=std(B1T3_UP); mB1T3_U=mean(B1T3_UP);
B2T3_UP=[t1(11:12,2), t2(11:12,2), t3(11:12,2), t4(11:12,2), t5(11:12,2), t6(11:12,2)]; eB2T3_U=std(B2T3_UP); mB2T3_U=mean(B2T3_UP);
B3T3_UP=[t1(11:12,3), t2(11:12,3), t3(11:12,3), t4(11:12,3), t5(11:12,3), t6(11:12,3)]; eB3T3_U=std(B3T3_UP); mB3T3_U=mean(B3T3_UP);

time=[7 19 31 43 55 67];

figure()
subplot(1,3,1)
hold on
errorbar(time, mB1T1, eB1T1, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 8)
errorbar(time, mB2T1, eB2T1, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 8)
errorbar(time, mB3T1, eB3T1, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 8)
errorbar(time, mB1T1_U, eB1T1_U, '--ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 8)
errorbar(time, mB2T1_U, eB2T1_U, '--ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 8)
errorbar(time, mB3T1_U, eB3T1_U, '--ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 8)
set(gca, 'Fontsize', 20, 'xgrid', 'on', 'ygrid', 'on', 'yscale', 'log', 'ylim', [10e1 10e4])
set(gcf, 'color', 'w')
xlabel('Time, (hours)')
ylabel('log H-2K^b GMFI')
legend('10e5 B16 + OVA', '10e4 B16', '10e3 B16', '10e5 B16, Unpulsed', '10e4 B16', '10e3 B16')
title('MHC expression of B16s for 10e5 OT-1')
box on
subplot(1,3,2)
hold on
errorbar(time, mB1T2, eB1T2, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 8)
errorbar(time, mB2T2, eB2T2, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 8)
errorbar(time, mB3T2, eB3T2, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 8)
errorbar(time, mB1T2_U, eB1T2_U, '--ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 8)
errorbar(time, mB2T2_U, eB2T2_U, '--ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 8)
errorbar(time, mB3T2_U, eB3T2_U, '--ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 8)
set(gca, 'Fontsize', 20, 'xgrid', 'on', 'ygrid', 'on', 'yscale', 'log')
set(gcf, 'color', 'w')
xlabel('Time, (hours)')
ylabel('log H-2K^b GMFI')
title('MHC expression of B16s for 10e4 OT-1')
box on
subplot(1,3,3)
hold on
errorbar(time, mB1T3, eB1T3, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 8)
errorbar(time, mB2T3, eB2T3, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 8)
errorbar(time, mB3T3, eB3T3, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 8)
errorbar(time, mB1T3_U, eB1T3_U, '--ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 8)
errorbar(time, mB2T3_U, eB2T3_U, '--ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 8)
errorbar(time, mB3T3_U, eB3T3_U, '--ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 8)
set(gca, 'Fontsize', 20, 'xgrid', 'on', 'ygrid', 'on', 'yscale', 'log','ylim', [10e1 10e4])
set(gcf, 'color', 'w')
xlabel('Time, (hours)')
ylabel('log H-2K^b GMFI')
title('MHC expression of B16s for 10e3 OT-1')
box on


%%

%GMFI Ova

%B16s were gated by (1)CFSE-, (2)SSC hi, (3)Alive

t1=[306 249 345
    286 280 321
    319 264 314
    280 307 280
    289 248 297
    299 235 328 
    225 251 160
    255 301 415
    257 266 331
    269 300 368
    266 265 294
    231 290 313];

t2=[864 540 149
    762 534 369
    469 373 308
    474 359 454
    427 337 334
    439 334 357
    288 326 140 
    337 353 287
    475 309 190 
    428 327 437
    393 424 429
    288 320 399];

t3=[1058 739  180  
    1058 1192 207  %Replaced row 2 column 1 with a duplicate from row 1 column 1 even though there was no biological replicate here - for plotting sake. 
    477  336  289
    497  361  298
    227  263  289
    213  233  258
    260  247  163
    267  260  163
    286  273  327
    191  294  334 
    305  274  326 
    283  247  364];

t4=[1489 3139 378
    1785 3324 268
    502  443  237
    582  1011 248
    280  272  350
    279  234  301
    256  313  192
    252  306  253 
    315  291  291
    351  295  240
    353  411  256
    342  266  256]; 

t5=[1051 7130 659
    1234 7191 456
    675  1526 338
    591  1256 398
    330  361  371
    365  346  386
    286  357  145
    286  357  145  %Replaced all three numbers in row 8 columns 1 2 and 3 with duplicates of row 7 even though there was no biological replicate. for plotting sake.
    216  293  326
    243  301  468 
    218  264  381 
    270  251  248];

t6=[946  6713 340
    1157 2736 336
    431  583  316
    511  460  348
    202  216  248
    222  226  263
    269  247  274
    269  247  274  %Replaced all three numbers in row 8 columns 1 2 and 3 with duplicates of row 7 even though there was no biological replicate. for plotting sake.
    238  338  269
    248  277  319 
    334  271  334
    206  292  307];

B1T1_Ova=[t1(1:2,1), t2(1:2,1), t3(1:2,1), t4(1:2,1), t5(1:2,1), t6(1:2,1)]; eoB1T1=std(B1T1_Ova); moB1T1=mean(B1T1_Ova);
B2T1_Ova=[t1(1:2,2), t2(1:2,2), t3(1:2,2), t4(1:2,2), t5(1:2,2), t6(1:2,2)]; eoB2T1=std(B2T1_Ova); moB2T1=mean(B2T1_Ova);
B3T1_Ova=[t1(1:2,3), t2(1:2,3), t3(1:2,3), t4(1:2,3), t5(1:2,3), t6(1:2,3)]; eoB3T1=std(B3T1_Ova); moB3T1=mean(B3T1_Ova);

B1T2_Ova=[t1(3:4,1), t2(3:4,1), t3(3:4,1), t4(3:4,1), t5(3:4,1), t6(3:4,1)]; eoB1T2=std(B1T2_Ova); moB1T2=mean(B1T2_Ova);
B2T2_Ova=[t1(3:4,2), t2(3:4,2), t3(3:4,2), t4(3:4,2), t5(3:4,2), t6(3:4,2)]; eoB2T2=std(B2T2_Ova); moB2T2=mean(B2T2_Ova);
B3T2_Ova=[t1(3:4,3), t2(3:4,3), t3(3:4,3), t4(3:4,3), t5(3:4,3), t6(3:4,3)]; eoB3T2=std(B3T2_Ova); moB3T2=mean(B3T2_Ova);

B1T3_Ova=[t1(5:6,1), t2(5:6,1), t3(5:6,1), t4(5:6,1), t5(5:6,1), t6(5:6,1)]; eoB1T3=std(B1T3_Ova); moB1T3=mean(B1T3_Ova);
B2T3_Ova=[t1(5:6,2), t2(5:6,2), t3(5:6,2), t4(5:6,2), t5(5:6,2), t6(5:6,2)]; eoB2T3=std(B2T3_Ova); moB2T3=mean(B2T3_Ova);
B3T3_Ova=[t1(5:6,3), t2(5:6,3), t3(5:6,3), t4(5:6,3), t5(5:6,3), t6(5:6,3)]; eoB3T3=std(B3T3_Ova); moB3T3=mean(B3T3_Ova);

B1T1_UP=[t1(7:8,1), t2(7:8,1), t3(7:8,1), t4(7:8,1), t5(7:8,1), t6(7:8,1)]; eoB1T1_U=std(B1T1_UP); moB1T1_U=mean(B1T1_UP);
B2T1_UP=[t1(7:8,2), t2(7:8,2), t3(7:8,2), t4(7:8,2), t5(7:8,2), t6(7:8,2)]; eoB2T1_U=std(B2T1_UP); moB2T1_U=mean(B2T1_UP);
B3T1_UP=[t1(7:8,3), t2(7:8,3), t3(7:8,3), t4(7:8,3), t5(7:8,3), t6(7:8,3)]; eoB3T1_U=std(B3T1_UP); moB3T1_U=mean(B3T1_UP);

B1T2_UP=[t1(9:10,1), t2(9:10,1), t3(9:10,1), t4(9:10,1), t5(9:10,1), t6(9:10,1)]; eoB1T2_U=std(B1T2_UP); moB1T2_U=mean(B1T2_UP);
B2T2_UP=[t1(9:10,2), t2(9:10,2), t3(9:10,2), t4(9:10,2), t5(9:10,2), t6(9:10,2)]; eoB2T2_U=std(B2T2_UP); moB2T2_U=mean(B2T2_UP);
B3T2_UP=[t1(9:10,3), t2(9:10,3), t3(9:10,3), t4(9:10,3), t5(9:10,3), t6(9:10,3)]; eoB3T2_U=std(B3T2_UP); moB3T2_U=mean(B3T2_UP);

B1T3_UP=[t1(11:12,1), t2(11:12,1), t3(11:12,1), t4(11:12,1), t5(11:12,1), t6(11:12,1)]; eoB1T3_U=std(B1T3_UP); moB1T3_U=mean(B1T3_UP);
B2T3_UP=[t1(11:12,2), t2(11:12,2), t3(11:12,2), t4(11:12,2), t5(11:12,2), t6(11:12,2)]; eoB2T3_U=std(B2T3_UP); moB2T3_U=mean(B2T3_UP);
B3T3_UP=[t1(11:12,3), t2(11:12,3), t3(11:12,3), t4(11:12,3), t5(11:12,3), t6(11:12,3)]; eoB3T3_U=std(B3T3_UP); moB3T3_U=mean(B3T3_UP);

time=[7 19 31 43 55 67];

figure()
subplot(1,3,1)
hold on
errorbar(time, moB1T1, eoB1T1, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 8)
errorbar(time, moB2T1, eoB2T1, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 8)
errorbar(time, moB3T1, eoB3T1, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 8)
errorbar(time, moB1T1_U, eoB1T1_U, '--ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 8)
errorbar(time, moB2T1_U, eoB2T1_U, '--ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 8)
errorbar(time, moB3T1_U, eoB3T1_U, '--ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 8)
set(gca, 'Fontsize', 20, 'xgrid', 'on', 'ygrid', 'on', 'yscale', 'log')
set(gcf, 'color', 'w')
xlabel('Time, (hours)')
ylabel('log K^b-Ova GMFI')
legend('10e5 B16 + OVA', '10e4 B16', '10e3 B16', '10e5 B16, Unpulsed', '10e4 B16', '10e3 B16')
title('Ova Presentation of B16s for 10e5 OT-1')
box on
subplot(1,3,2)
hold on
errorbar(time, moB1T2, eoB1T2, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 8)
errorbar(time, moB2T2, eoB2T2, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 8)
errorbar(time, moB3T2, eoB3T2, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 8)
errorbar(time, moB1T2_U, eoB1T2_U, '--ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 8)
errorbar(time, moB2T2_U, eoB2T2_U, '--ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 8)
errorbar(time, moB3T2_U, eoB3T2_U, '--ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 8)
set(gca, 'Fontsize', 20, 'xgrid', 'on', 'ygrid', 'on', 'yscale', 'log')
set(gcf, 'color', 'w')
xlabel('Time, (hours)')
ylabel('log K^b-Ova GMFI')
title('Ova Presentation of B16s for 10e4 OT-1')
box on
subplot(1,3,3)
hold on
errorbar(time, moB1T3, eoB1T3, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 8)
errorbar(time, moB2T3, eoB2T3, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 8)
errorbar(time, moB3T3, eoB3T3, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 8)
errorbar(time, moB1T3_U, eoB1T3_U, '--ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 8)
errorbar(time, moB2T3_U, eoB2T3_U, '--ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 8)
errorbar(time, moB3T3_U, eoB3T3_U, '--ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 8)
set(gca, 'Fontsize', 20, 'xgrid', 'on', 'ygrid', 'on', 'yscale', 'log', 'ylim', [10e1 10e3])
set(gcf, 'color', 'w')
xlabel('Time, (hours)')
ylabel('log K^b-Ova GMFI')
title('Ova Presentation of B16s for 10e3 OT-1')
box on

figure()
subplot(1,3,1)
hold on
plot(mB1T1, moB1T1, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 8)
plot(mB2T1, moB2T1, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 8)
plot(mB3T1, moB3T1, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 8)
%plot(mB1T1_U, moB1T1_U, '--ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 8)
%plot(mB2T1_U, moB2T1_U, '--ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 8)
%plot(mB3T1_U, moB3T1_U, '--ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 8)
set(gca, 'Fontsize', 20, 'xgrid', 'on', 'ygrid', 'on', 'yscale', 'log', 'xscale', 'log', 'ylim', [10e1 10e3])
set(gcf, 'color', 'w')
xlabel('log H-2K^b GMFI')
ylabel('log K^b-Ova GMFI')
legend('10e5 B16 + OVA', '10e4 B16', '10e3 B16', '10e5 B16, Unpulsed', '10e4 B16', '10e3 B16')
title('MHC exp v. Ova pres. for 10e5 OT-1')
box on
subplot(1,3,2)
hold on
plot(mB1T2, moB1T2, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 8)
plot(mB2T2, moB2T2, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 8)
plot(mB3T2, moB3T2, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 8)
%plot(mB1T2_U, moB1T2_U, '--ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 8)
%plot(mB2T2_U, moB2T2_U, '--ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 8)
%plot(mB3T2_U, moB3T2_U, '--ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 8)
set(gca, 'Fontsize', 20, 'xgrid', 'on', 'ygrid', 'on', 'yscale', 'log', 'xscale', 'log', 'ylim', [10e1 10e3])
set(gcf, 'color', 'w')
xlabel('log H-2K^b GMFI')
ylabel('log K^b-Ova GMFI')
title('MHC exp v. Ova pres. for 10e4 OT-1')
box on
subplot(1,3,3)
hold on
plot(mB1T3, moB1T3, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 8)
plot(mB2T3, moB2T3, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 8)
plot(mB3T3, moB3T3, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 8)
%plot(mB1T3_U, moB1T3_U, '--ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 8)
%plot(mB2T3_U, moB2T3_U, '--ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 8)
%plot(mB3T3_U, moB3T3_U, '--ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 8)
set(gca, 'Fontsize', 20, 'xgrid', 'on', 'ygrid', 'on', 'yscale', 'log', 'xscale', 'log', 'ylim', [10e1 10e3], 'xlim', [10e1 10e4])
set(gcf, 'color', 'w')
xlabel('log H-2K^b GMFI')
ylabel('log K^b-Ova GMFI')
title('MHC exp v. Ova pres. for 10e3 OT-1')
box on
%%
%Calibration beads
APC_Cal=[7466 2500 352 157];
APC_Cal=APC_Cal./4.3;
Cal_APCstand=[16801 79927 791383 2266692];

Pe_Cal=[24555 5500 1278 166];
Cal_PEstand=[2147 14975 70770 344668];

figure()
subplot(2,1,1)
plot(Cal_APCstand, APC_Cal, '-ko')
set(gca, 'Fontsize', 20, 'xscale', 'log', 'yscale' , 'log')
set(gcf, 'color', 'w')
xlabel('Log APC Molecules per bead')
ylabel('Log APC fluorescence')
subplot(2,1,2)
plot(Cal_PEstand, Pe_Cal, '-ko')
set(gca, 'Fontsize', 20, 'xscale', 'log', 'yscale' , 'log')
set(gcf, 'color', 'w')
xlabel('Log Pe Molecules per bead')
ylabel('Log Pe fluorescence')

APC=fitlm(Cal_APCstand, APC_Cal)
Pe=fitlm(Cal_PEstand, Pe_Cal)



%%
%Percent of cells having undergone <1 division 

t1=[0.748 0.286 0.0234
    0.303 0.177 0.111
    0     0.708 0.246
    0.597 0.122 0.0379
    0     0     0
    0.901 0.313 0.307
    0.181 0.026 0.187
    0.125 0.063 0.107
    0.229 0.078 0.041
    0.088 0.567 0.406
    0     2.41  0
    0     0     0];

t2=[0.455 0.307 0.0541
    0.624 0.329 0.078
    0     0     0
    0.37  0.1   0.195
    0     0     0
    1.33  0     0
    0.225 0.242 0.219
    0.116 0.506 0.31
    0     0.171 0.185
    0.213 0.068 0.201
    0     0.431 0
    0     46.8  13.2];

t3=[6.24  0.756 0.517
    6.24  0.576 0.367   %Replaced row 2 column 1 with a duplicate from row 1 column 1 even though there was no biological replicate here - for plotting sake. 
    0.50  0.481 0.421
    0.54  0     0.151
    2.13  0     0
    0     0     0
    0.71  0.227 0.105
    0.805 0.187 0.304
    0.164 0.087 0.166
    0.314 0     0.173
    0     0     1.52
    2.38  1.04  0];

t4=[20.3 30.2 14.9
    28.5 29.8 13.9
    13.6 6.92 3.09
    15   6.07 3
    12.8 10.4 14.3
    16.7 1.92 0
    6.38 4    2.79
    3.79 2.41 4.81
    0.59 0.46 1.57
    2.7  1.72 7.69
    0    1.64 0
    0    0    0]; 

t5=[63.1 52.9 38.4
    58.3 47.9 26.5
    46.5 35.9 19.8
    38.9 29.2 16.1 
    40   32.6 26.9
    18.2 20.4 46.7
    18.4 21.7 21.7
    18.4 21.7 21.7   %Replaced all three numbers in row 8 columns 1 2 and 3 with duplicates of row 7 even though there was no biological replicate. for plotting sake.
    12   15.6 18.8
    9.38 14.7 16.4
    8.33 2.78 37.5
    0    11.3 0];

t6=[66.3 29.9 17
    66.8 35   12.6
    45.8 28   13.2
    48.1 19.6 12.5
    18.2 0    18.8
    41.7 50   12.5
    24   14.5 15
    24   14.5 15   %Replaced all three numbers in row 8 columns 1 2 and 3 with duplicates of row 7 even though there was no biological replicate. for plotting sake.
    30   10.5 17.6
    33.3 12   24.6
    33.3 5.56 83.3
    100  17.4 12.5];

B1T1_Ova=[t1(1:2,1), t2(1:2,1), t3(1:2,1), t4(1:2,1), t5(1:2,1), t6(1:2,1)]; eB1T1=std(B1T1_Ova); mB1T1=mean(B1T1_Ova);
B2T1_Ova=[t1(1:2,2), t2(1:2,2), t3(1:2,2), t4(1:2,2), t5(1:2,2), t6(1:2,2)]; eB2T1=std(B2T1_Ova); mB2T1=mean(B2T1_Ova);
B3T1_Ova=[t1(1:2,3), t2(1:2,3), t3(1:2,3), t4(1:2,3), t5(1:2,3), t6(1:2,3)]; eB3T1=std(B3T1_Ova); mB3T1=mean(B3T1_Ova);

B1T2_Ova=[t1(3:4,1), t2(3:4,1), t3(3:4,1), t4(3:4,1), t5(3:4,1), t6(3:4,1)]; eB1T2=std(B1T2_Ova); mB1T2=mean(B1T2_Ova);
B2T2_Ova=[t1(3:4,2), t2(3:4,2), t3(3:4,2), t4(3:4,2), t5(3:4,2), t6(3:4,2)]; eB2T2=std(B2T2_Ova); mB2T2=mean(B2T2_Ova);
B3T2_Ova=[t1(3:4,3), t2(3:4,3), t3(3:4,3), t4(3:4,3), t5(3:4,3), t6(3:4,3)]; eB3T2=std(B3T2_Ova); mB3T2=mean(B3T2_Ova);

B1T3_Ova=[t1(5:6,1), t2(5:6,1), t3(5:6,1), t4(5:6,1), t5(5:6,1), t6(5:6,1)]; eB1T3=std(B1T3_Ova); mB1T3=mean(B1T3_Ova);
B2T3_Ova=[t1(5:6,2), t2(5:6,2), t3(5:6,2), t4(5:6,2), t5(5:6,2), t6(5:6,2)]; eB2T3=std(B2T3_Ova); mB2T3=mean(B2T3_Ova);
B3T3_Ova=[t1(5:6,3), t2(5:6,3), t3(5:6,3), t4(5:6,3), t5(5:6,3), t6(5:6,3)]; eB3T3=std(B3T3_Ova); mB3T3=mean(B3T3_Ova);

B1T1_UP=[t1(7:8,1), t2(7:8,1), t3(7:8,1), t4(7:8,1), t5(7:8,1), t6(7:8,1)]; eB1T1_U=std(B1T1_UP); mB1T1_U=mean(B1T1_UP);
B2T1_UP=[t1(7:8,2), t2(7:8,2), t3(7:8,2), t4(7:8,2), t5(7:8,2), t6(7:8,2)]; eB2T1_U=std(B2T1_UP); mB2T1_U=mean(B2T1_UP);
B3T1_UP=[t1(7:8,3), t2(7:8,3), t3(7:8,3), t4(7:8,3), t5(7:8,3), t6(7:8,3)]; eB3T1_U=std(B3T1_UP); mB3T1_U=mean(B3T1_UP);

B1T2_UP=[t1(9:10,1), t2(9:10,1), t3(9:10,1), t4(9:10,1), t5(9:10,1), t6(9:10,1)]; eB1T2_U=std(B1T2_UP); mB1T2_U=mean(B1T2_UP);
B2T2_UP=[t1(9:10,2), t2(9:10,2), t3(9:10,2), t4(9:10,2), t5(9:10,2), t6(9:10,2)]; eB2T2_U=std(B2T2_UP); mB2T2_U=mean(B2T2_UP);
B3T2_UP=[t1(9:10,3), t2(9:10,3), t3(9:10,3), t4(9:10,3), t5(9:10,3), t6(9:10,3)]; eB3T2_U=std(B3T2_UP); mB3T2_U=mean(B3T2_UP);

B1T3_UP=[t1(11:12,1), t2(11:12,1), t3(11:12,1), t4(11:12,1), t5(11:12,1), t6(11:12,1)]; eB1T3_U=std(B1T3_UP); mB1T3_U=mean(B1T3_UP);
B2T3_UP=[t1(11:12,2), t2(11:12,2), t3(11:12,2), t4(11:12,2), t5(11:12,2), t6(11:12,2)]; eB2T3_U=std(B2T3_UP); mB2T3_U=mean(B2T3_UP);
B3T3_UP=[t1(11:12,3), t2(11:12,3), t3(11:12,3), t4(11:12,3), t5(11:12,3), t6(11:12,3)]; eB3T3_U=std(B3T3_UP); mB3T3_U=mean(B3T3_UP);

time=[7 19 31 43 55 67];

figure()
subplot(1,3,1)
hold on
errorbar(time, mB1T1, eB1T1, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 8)
errorbar(time, mB2T1, eB2T1, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 8)
errorbar(time, mB3T1, eB3T1, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 8)
errorbar(time, mB1T1_U, eB1T1_U, '--ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 8)
errorbar(time, mB2T1_U, eB2T1_U, '--ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 8)
errorbar(time, mB3T1_U, eB3T1_U, '--ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 8)
set(gca, 'Fontsize', 20, 'xgrid', 'on', 'ygrid', 'on', 'ylim', [0 100])
set(gcf, 'color', 'w')
xlabel('Time, (hours)')
ylabel('%dividing')
legend('10e5 B16 + OVA', '10e4 B16', '10e3 B16', '10e5 B16, Unpulsed', '10e4 B16', '10e3 B16')
title('%of OT1 undergone >1 division for 10e5 OT-1')
box on
subplot(1,3,2)
hold on
errorbar(time, mB1T2, eB1T2, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 8)
errorbar(time, mB2T2, eB2T2, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 8)
errorbar(time, mB3T2, eB3T2, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 8)
errorbar(time, mB1T2_U, eB1T2_U, '--ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 8)
errorbar(time, mB2T2_U, eB2T2_U, '--ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 8)
errorbar(time, mB3T2_U, eB3T2_U, '--ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 8)
set(gca, 'Fontsize', 20, 'xgrid', 'on', 'ygrid', 'on', 'ylim', [0 100])
set(gcf, 'color', 'w')
xlabel('Time, (hours)')
ylabel('%dividing')
title('%of OT1 undergone >1 division for 10e4 OT-1')
box on
subplot(1,3,3)
hold on
errorbar(time, mB1T3, eB1T3, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 8)
errorbar(time, mB2T3, eB2T3, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 8)
errorbar(time, mB3T3, eB3T3, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 8)
errorbar(time, mB1T3_U, eB1T3_U, '--ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 8)
errorbar(time, mB2T3_U, eB2T3_U, '--ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 8)
errorbar(time, mB3T3_U, eB3T3_U, '--ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 8)
set(gca, 'Fontsize', 20, 'xgrid', 'on', 'ygrid', 'on', 'ylim', [0 100])
set(gcf, 'color', 'w')
xlabel('Time, (hours)')
ylabel('%dividing')
title('%of OT1 undergone >1 division for 10e3 OT-1')
box on

%%
%Functional Elisa for IFN-g.  B16s were seeded at a density of 100k per
%well.  Then either IFN-g standards or cell supernatants were added to the
%wells.  After 24 hours, cells were harvested, stained with Dapi and
%anti-H-2Kb. Upregulation of H-2Kb is the measure of IFN-g quantity in the
%supernatant.  Cell sups were diluted 1:10.

t1=[657 260 230
    648 288 274
    219 201 204
    284 253 220
    223 212 195
    260 223 201
    199 203 216
    217 224 195
    188 201 217
    203 209 212
    203 204 205
    210 203 209];

t2=[7599 2383 295
    6996 2237 267 
    772  300  214
    658  229  228
    225  231  222
    224  213  212
    238  208  208
    235  210  197
    188  223  210
    190  224  223 
    280  206  208
    211  209  229];

t3=[9626 2863 271
    8990 2934 317
    945  265  225
    1301 287  238
    246  227  207
    263  226  217 
    237  224  207
    271  225  206
    212  217  195
    202  218  214
    208  200  207
    220  219  213];

t4=[10737 2780 279
    10154 3328 346
    928   248  213
    1231  355  221
    228   229  219
    220   222  220
    258   214  218
    224   215  194
    216   228  222
    213   225  214
    226   213  226
    219   218  231]; 

t5=[10581 2173 259
    9562  2060 259
    623   292  205
    544   262  232
    194   204  193
    228   221  212
    217   221  229
    217   221  229  %Replaced all three numbers in row 8 columns 1 2 and 3 with duplicates of row 7 even though there was no biological replicate. for plotting sake.
    212   219  231
    204   222  222
    226   243  236
    236   222  222];

t6=[8447 1503 245
    9798 1806 262
    599  250  225
    456  249  203
    223  219  194
    212  202  215
    237  209  223
    237  209  223  %Replaced all three numbers in row 8 columns 1 2 and 3 with duplicates of row 7 even though there was no biological replicate. for plotting sake.
    202  197  224
    153  178  180
    226  221  207
    195  190  212];

B1T1_Ova=[t1(1:2,1), t2(1:2,1), t3(1:2,1), t4(1:2,1), t5(1:2,1), t6(1:2,1)]; 
B2T1_Ova=[t1(1:2,2), t2(1:2,2), t3(1:2,2), t4(1:2,2), t5(1:2,2), t6(1:2,2)]; 
B3T1_Ova=[t1(1:2,3), t2(1:2,3), t3(1:2,3), t4(1:2,3), t5(1:2,3), t6(1:2,3)]; 

B1T2_Ova=[t1(3:4,1), t2(3:4,1), t3(3:4,1), t4(3:4,1), t5(3:4,1), t6(3:4,1)]; 
B2T2_Ova=[t1(3:4,2), t2(3:4,2), t3(3:4,2), t4(3:4,2), t5(3:4,2), t6(3:4,2)]; 
B3T2_Ova=[t1(3:4,3), t2(3:4,3), t3(3:4,3), t4(3:4,3), t5(3:4,3), t6(3:4,3)]; 

B1T3_Ova=[t1(5:6,1), t2(5:6,1), t3(5:6,1), t4(5:6,1), t5(5:6,1), t6(5:6,1)]; 
B2T3_Ova=[t1(5:6,2), t2(5:6,2), t3(5:6,2), t4(5:6,2), t5(5:6,2), t6(5:6,2)]; 
B3T3_Ova=[t1(5:6,3), t2(5:6,3), t3(5:6,3), t4(5:6,3), t5(5:6,3), t6(5:6,3)]; 

B1T1_UP=[t1(7:8,1), t2(7:8,1), t3(7:8,1), t4(7:8,1), t5(7:8,1), t6(7:8,1)]; 
B2T1_UP=[t1(7:8,2), t2(7:8,2), t3(7:8,2), t4(7:8,2), t5(7:8,2), t6(7:8,2)]; 
B3T1_UP=[t1(7:8,3), t2(7:8,3), t3(7:8,3), t4(7:8,3), t5(7:8,3), t6(7:8,3)]; 

B1T2_UP=[t1(9:10,1), t2(9:10,1), t3(9:10,1), t4(9:10,1), t5(9:10,1), t6(9:10,1)]; 
B2T2_UP=[t1(9:10,2), t2(9:10,2), t3(9:10,2), t4(9:10,2), t5(9:10,2), t6(9:10,2)]; 
B3T2_UP=[t1(9:10,3), t2(9:10,3), t3(9:10,3), t4(9:10,3), t5(9:10,3), t6(9:10,3)]; 

B1T3_UP=[t1(11:12,1), t2(11:12,1), t3(11:12,1), t4(11:12,1), t5(11:12,1), t6(11:12,1)]; 
B2T3_UP=[t1(11:12,2), t2(11:12,2), t3(11:12,2), t4(11:12,2), t5(11:12,2), t6(11:12,2)]; 
B3T3_UP=[t1(11:12,3), t2(11:12,3), t3(11:12,3), t4(11:12,3), t5(11:12,3), t6(11:12,3)]; 


 %Values from fitted standard curve
T=11038;
B=150.4;
E=6.75e-11;

B1T1_Ova=(B1T1_Ova-B)./(T-B1T1_Ova).*E; %interpolate IFN-gamma concentrations from standard curve
B1T1_Ova=B1T1_Ova*10; %all supernatants were diluted 10 fold for experiment
eB1T1=std(B1T1_Ova); mB1T1=mean(B1T1_Ova); TotalB1T1=trapz(mB1T1);

B2T1_Ova=(B2T1_Ova-B)./(T-B2T1_Ova).*E; %interpolate IFN-gamma concentrations from standard curve
B2T1_Ova=B2T1_Ova*10; %all supernatants were diluted 10 fold for experiment
eB2T1=std(B2T1_Ova); mB2T1=mean(B2T1_Ova); TotalB2T1=trapz(mB2T1);

B3T1_Ova=(B3T1_Ova-B)./(T-B3T1_Ova).*E; %interpolate IFN-gamma concentrations from standard curve
B3T1_Ova=B3T1_Ova*10; %all supernatants were diluted 10 fold for experiment
eB3T1=std(B3T1_Ova); mB3T1=mean(B3T1_Ova); TotalB3T1=trapz(mB3T1);

B1T2_Ova=(B1T2_Ova-B)./(T-B1T2_Ova).*E; %interpolate IFN-gamma concentrations from standard curve
B1T2_Ova=B1T2_Ova*10; %all supernatants were diluted 10 fold for experiment
eB1T2=std(B1T2_Ova); mB1T2=mean(B1T2_Ova); TotalB1T2=trapz(mB1T2);

B2T2_Ova=(B2T2_Ova-B)./(T-B2T2_Ova).*E; %interpolate IFN-gamma concentrations from standard curve
B2T2_Ova=B2T2_Ova*10; %all supernatants were diluted 10 fold for experiment
eB2T2=std(B2T2_Ova); mB2T2=mean(B2T2_Ova); TotalB2T2=trapz(mB2T2);

B3T2_Ova=(B3T2_Ova-B)./(T-B3T2_Ova).*E; %interpolate IFN-gamma concentrations from standard curve
B3T2_Ova=B3T2_Ova*10; %all supernatants were diluted 10 fold for experiment
eB3T2=std(B3T2_Ova); mB3T2=mean(B3T2_Ova); TotalB3T2=trapz(mB3T2);

B1T3_Ova=(B1T3_Ova-B)./(T-B1T3_Ova).*E; %interpolate IFN-gamma concentrations from standard curve
B1T3_Ova=B1T3_Ova*10; %all supernatants were diluted 10 fold for experiment
eB1T3=std(B1T3_Ova); mB1T3=mean(B1T3_Ova); TotalB1T3=trapz(mB1T3);

B2T3_Ova=(B2T3_Ova-B)./(T-B2T3_Ova).*E; %interpolate IFN-gamma concentrations from standard curve
B2T3_Ova=B2T3_Ova*10; %all supernatants were diluted 10 fold for experiment
eB2T3=std(B2T3_Ova); mB2T3=mean(B2T3_Ova); TotalB2T3=trapz(mB2T3);

B3T3_Ova=(B3T3_Ova-B)./(T-B3T3_Ova).*E; %interpolate IFN-gamma concentrations from standard curve
B3T3_Ova=B3T3_Ova*10; %all supernatants were diluted 10 fold for experiment
eB3T3=std(B3T3_Ova); mB3T3=mean(B3T3_Ova); TotalB3T3=trapz(mB3T3);

B1T1_UP=(B1T1_UP-B)./(T-B1T1_UP).*E; %interpolate IFN-gamma concentrations from standard curve
B1T1_UP=B1T1_UP*10; %all supernatants were diluted 10 fold for experiment
eB1T1_U=std(B1T1_UP); mB1T1_U=mean(B1T1_UP); TotalB1T1_U=trapz(mB1T1_U);

B2T1_UP=(B2T1_UP-B)./(T-B2T1_UP).*E; %interpolate IFN-gamma concentrations from standard curve
B2T1_UP=B2T1_UP*10; %all supernatants were diluted 10 fold for experiment
eB2T1_U=std(B2T1_UP); mB2T1_U=mean(B2T1_UP); TotalB2T1_U=trapz(mB2T1_U);

B3T1_UP=(B3T1_UP-B)./(T-B3T1_UP).*E; %interpolate IFN-gamma concentrations from standard curve
B3T1_UP=B3T1_UP*10; %all supernatants were diluted 10 fold for experiment
eB3T1_U=std(B3T1_UP); mB3T1_U=mean(B3T1_UP); TotalB3T1_U=trapz(mB3T1_U);

B1T2_UP=(B1T2_UP-B)./(T-B1T2_UP).*E; %interpolate IFN-gamma concentrations from standard curve
B1T2_UP=B1T2_UP*10; %all supernatants were diluted 10 fold for experiment
eB1T2_U=std(B1T2_UP); mB1T2_U=mean(B1T2_UP); TotalB1T2_U=trapz(mB1T2_U);

B2T2_UP=(B2T2_UP-B)./(T-B2T2_UP).*E; %interpolate IFN-gamma concentrations from standard curve
B2T2_UP=B2T2_UP*10; %all supernatants were diluted 10 fold for experiment
eB2T2_U=std(B2T2_UP); mB2T2_U=mean(B2T2_UP); TotalB2T2_U=trapz(mB2T2_U);

B3T2_UP=(B3T2_UP-B)./(T-B3T2_UP).*E; %interpolate IFN-gamma concentrations from standard curve
B3T2_UP=B3T2_UP*10; %all supernatants were diluted 10 fold for experiment
eB3T2_U=std(B3T2_UP); mB3T2_U=mean(B3T2_UP); TotalB3T2_U=trapz(mB3T2_U);

B1T3_UP=(B1T3_UP-B)./(T-B1T3_UP).*E; %interpolate IFN-gamma concentrations from standard curve
B1T3_UP=B1T3_UP*10; %all supernatants were diluted 10 fold for experiment
eB1T3_U=std(B1T3_UP); mB1T3_U=mean(B1T3_UP); TotalB1T3_U=trapz(mB1T2_U);

B2T3_UP=(B2T3_UP-B)./(T-B2T3_UP).*E; %interpolate IFN-gamma concentrations from standard curve
B2T3_UP=B2T3_UP*10; %all supernatants were diluted 10 fold for experiment
eB2T3_U=std(B2T3_UP); mB2T3_U=mean(B2T3_UP); TotalB2T3_U=trapz(mB2T3_U);

B3T3_UP=(B3T3_UP-B)./(T-B3T3_UP).*E; %interpolate IFN-gamma concentrations from standard curve
B3T3_UP=B3T3_UP*10; %all supernatants were diluted 10 fold for experiment
eB3T3_U=std(B3T3_UP); mB3T3_U=mean(B3T3_UP); TotalB3T3_U=trapz(mB3T3_U);

time=[7 19 31 43 55 67];

Standards=[9065  8341 2798 432 221 204 208 162
           12212 8844 2618 390 195 199 175 169];
eSt=std(Standards);
mSt=mean(Standards);
       
gamma1=[10e-9 1e-9 100e-12 10e-12 1e-12 100e-15 10e-15 0];

totals 

figure()
errorbar(gamma1, mSt, eSt, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'k', 'markersize', 10)
set(gca, 'Fontsize', 20, 'xscale', 'log', 'yscale', 'log')
set(gcf, 'color', 'w')
xlabel('log [IFN-\gamma], (M)')
ylabel('log H-2K^b GMFI')
title('IFN-\gamma Functional Elisa Standards')
box on



figure()
errorbar(gamma1, mSt, eSt, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'k', 'markersize', 10)
set(gca, 'Fontsize', 20, 'xscale', 'log', 'yscale', 'log')
set(gcf, 'color', 'w')
xlabel('log [IFN-\gamma], (M)')
ylabel('log H-2K^b GMFI')
title('IFN-\gamma Functional Elisa Standards')
box on

figure()
subplot(1,3,1)
hold on
errorbar(time, mB1T1, eB1T1, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 8)
errorbar(time, mB2T1, eB2T1, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 8)
errorbar(time, mB3T1, eB3T1, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 8)
errorbar(time, mB1T1_U, eB1T1_U, '--ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 8)
errorbar(time, mB2T1_U, eB2T1_U, '--ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 8)
errorbar(time, mB3T1_U, eB3T1_U, '--ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 8)
set(gca, 'Fontsize', 20, 'xgrid', 'on', 'ygrid', 'on', 'yscale', 'log', 'ylim', [10e-13 10e-8])
set(gcf, 'color', 'w')
xlabel('Time, (hours)')
ylabel('log IFN-\gamma, (M)')
legend('10e5 B16 + OVA', '10e4 B16', '10e3 B16', '10e5 B16, Unpulsed', '10e4 B16', '10e3 B16')
title('IFN-\gamma accumulation - 10e5 OT1')
box on
subplot(1,3,2)
hold on
errorbar(time, mB1T2, eB1T2, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 8)
errorbar(time, mB2T2, eB2T2, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 8)
errorbar(time, mB3T2, eB3T2, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 8)
errorbar(time, mB1T2_U, eB1T2_U, '--ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 8)
errorbar(time, mB2T2_U, eB2T2_U, '--ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 8)
errorbar(time, mB3T2_U, eB3T2_U, '--ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 8)
set(gca, 'Fontsize', 20, 'xgrid', 'on', 'ygrid', 'on', 'yscale', 'log', 'ylim', [10e-13 10e-8])
set(gcf, 'color', 'w')
xlabel('Time, (hours)')
ylabel('log IFN-\gamma, (M)')
title('IFN-\gamma accumulation - 10e4 OT1')
box on
subplot(1,3,3)
hold on
errorbar(time, mB1T3, eB1T3, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 8)
errorbar(time, mB2T3, eB2T3, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 8)
errorbar(time, mB3T3, eB3T3, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 8)
errorbar(time, mB1T3_U, eB1T3_U, '--ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 8)
errorbar(time, mB2T3_U, eB2T3_U, '--ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 8)
errorbar(time, mB3T3_U, eB3T3_U, '--ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 8)
set(gca, 'Fontsize', 20, 'xgrid', 'on', 'ygrid', 'on', 'yscale', 'log', 'ylim', [10e-13 10e-8])
set(gcf, 'color', 'w')
xlabel('Time, (hours)')
ylabel('log IFN-\gamma, (M)')
title('IFN-\gamma accumulation - 10e3 OT1')
box on

%GMFI of MHC for B16 cells over time

t1=[3410 1626 693
    2492 1593 905
    1787 1508 1230 
    1712 1487 1123
    1653 1441 1426 
    1578 1393 1196
    1459 1183 214
    1521 1423 839
    1547 1381 1286
    1520 1430 1059
    1416 1255 1067
    1358 1313 1044];
t1=t1./4.3;

t2=[56959 21257 860
    50017 25687 1171
    13813 3394  1020
    14866 2458  1215
    2518  1055  853
    2876  1077  884
    1829  1574  455
    2341  2285  483
    1413  979   702
    1314  988   800
    1165  1013  874
    1080  874   779];
t2=t2./4.3;

t3=[10917 4625  345
    10917 11144 321  %Replaced row 2 column 1 with a duplicate from row 1 column 1 even though there was no biological replicate here - for plotting sake. 
    7319  2240  280
    7653  2037  365
    884   200   169
    911   185   158
    1401  543   157
    1752  559   148
    315   172   160
    363   165   161
    320   147   154
    358   142   185];

t4=[16108 15117 939
    17426 17777 512
    7439  3462  222
    7290  7809  301
    1490  468   162
    752   194   142
    2364  470   181
    887   338   277
    143   159   357
    152   148   275
    144   164   359
    138   146   359]; 

t5=[14169 31780 2085
    16962 33257 1434
    9800  11633 333
    8128  9571  247
    829   180   198
    970   230   157 
    3730  1789  235
    3730  1789  235  %Replaced all three numbers in row 8 columns 1 2 and 3 with duplicates of row 7 even though there was no biological replicate. for plotting sake.
    392   138   143
    458   154   183
    395   128   142
    456   119   160];

t6=[14987 28323 1200
    18069 8819  922
    8771  5419  212
    8175  4112  264
    592   156   115
    740   156   122
    3699  1676  410
    3699  1676  410 %Replaced all three numbers in row 8 columns 1 2 and 3 with duplicates of row 7 even though there was no biological replicate. for plotting sake.
    412   144   128
    447   144   137
    439   120   130
    417   124   129];

B1T1_Ova=[t1(1:2,1), t2(1:2,1), t3(1:2,1), t4(1:2,1), t5(1:2,1), t6(1:2,1)]; eB1T1m=std(B1T1_Ova); mB1T1m=mean(B1T1_Ova);
B2T1_Ova=[t1(1:2,2), t2(1:2,2), t3(1:2,2), t4(1:2,2), t5(1:2,2), t6(1:2,2)]; eB2T1m=std(B2T1_Ova); mB2T1m=mean(B2T1_Ova);
B3T1_Ova=[t1(1:2,3), t2(1:2,3), t3(1:2,3), t4(1:2,3), t5(1:2,3), t6(1:2,3)]; eB3T1m=std(B3T1_Ova); mB3T1m=mean(B3T1_Ova);

B1T2_Ova=[t1(3:4,1), t2(3:4,1), t3(3:4,1), t4(3:4,1), t5(3:4,1), t6(3:4,1)]; eB1T2m=std(B1T2_Ova); mB1T2m=mean(B1T2_Ova);
B2T2_Ova=[t1(3:4,2), t2(3:4,2), t3(3:4,2), t4(3:4,2), t5(3:4,2), t6(3:4,2)]; eB2T2m=std(B2T2_Ova); mB2T2m=mean(B2T2_Ova);
B3T2_Ova=[t1(3:4,3), t2(3:4,3), t3(3:4,3), t4(3:4,3), t5(3:4,3), t6(3:4,3)]; eB3T2m=std(B3T2_Ova); mB3T2m=mean(B3T2_Ova);

B1T3_Ova=[t1(5:6,1), t2(5:6,1), t3(5:6,1), t4(5:6,1), t5(5:6,1), t6(5:6,1)]; eB1T3m=std(B1T3_Ova); mB1T3m=mean(B1T3_Ova);
B2T3_Ova=[t1(5:6,2), t2(5:6,2), t3(5:6,2), t4(5:6,2), t5(5:6,2), t6(5:6,2)]; eB2T3m=std(B2T3_Ova); mB2T3m=mean(B2T3_Ova);
B3T3_Ova=[t1(5:6,3), t2(5:6,3), t3(5:6,3), t4(5:6,3), t5(5:6,3), t6(5:6,3)]; eB3T3m=std(B3T3_Ova); mB3T3m=mean(B3T3_Ova);

B1T1_UP=[t1(7:8,1), t2(7:8,1), t3(7:8,1), t4(7:8,1), t5(7:8,1), t6(7:8,1)]; eB1T1_Um=std(B1T1_UP); mB1T1_Um=mean(B1T1_UP);
B2T1_UP=[t1(7:8,2), t2(7:8,2), t3(7:8,2), t4(7:8,2), t5(7:8,2), t6(7:8,2)]; eB2T1_Um=std(B2T1_UP); mB2T1_Um=mean(B2T1_UP);
B3T1_UP=[t1(7:8,3), t2(7:8,3), t3(7:8,3), t4(7:8,3), t5(7:8,3), t6(7:8,3)]; eB3T1_Um=std(B3T1_UP); mB3T1_Um=mean(B3T1_UP);

B1T2_UP=[t1(9:10,1), t2(9:10,1), t3(9:10,1), t4(9:10,1), t5(9:10,1), t6(9:10,1)]; eB1T2_Um=std(B1T2_UP); mB1T2_Um=mean(B1T2_UP);
B2T2_UP=[t1(9:10,2), t2(9:10,2), t3(9:10,2), t4(9:10,2), t5(9:10,2), t6(9:10,2)]; eB2T2_Um=std(B2T2_UP); mB2T2_Um=mean(B2T2_UP);
B3T2_UP=[t1(9:10,3), t2(9:10,3), t3(9:10,3), t4(9:10,3), t5(9:10,3), t6(9:10,3)]; eB3T2_Um=std(B3T2_UP); mB3T2_Um=mean(B3T2_UP);

B1T3_UP=[t1(11:12,1), t2(11:12,1), t3(11:12,1), t4(11:12,1), t5(11:12,1), t6(11:12,1)]; eB1T3_Um=std(B1T3_UP); mB1T3_Um=mean(B1T3_UP);
B2T3_UP=[t1(11:12,2), t2(11:12,2), t3(11:12,2), t4(11:12,2), t5(11:12,2), t6(11:12,2)]; eB2T3_Um=std(B2T3_UP); mB2T3_Um=mean(B2T3_UP);
B3T3_UP=[t1(11:12,3), t2(11:12,3), t3(11:12,3), t4(11:12,3), t5(11:12,3), t6(11:12,3)]; eB3T3_Um=std(B3T3_UP); mB3T3_Um=mean(B3T3_UP);

%Plot the MHC expression versus IFN-g in the media at a given timepoint.
figure()
subplot(1,3,1)
hold on
plot(mB1T1, mB1T1m, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 8)
plot(mB2T1, mB2T1m, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 8)
plot(mB3T1, mB3T1m, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 8)
plot(mB1T1_U, mB1T1_Um, '--ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 8)
plot(mB2T1_U, mB2T1_Um, '--ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 8)
plot(mB3T1_U, mB3T1_Um, '--ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 8)
set(gca, 'Fontsize', 20, 'xgrid', 'on', 'ygrid', 'on', 'yscale', 'log', 'xscale', 'log', 'xlim', [10e-13 10e-8], 'xtick', [10e-12, 10e-11, 10e-10, 10e-9, 10e-8])
set(gcf, 'color', 'w')
ylabel('log H-2K^b')
xlabel('log IFN-\gamma, (M)')
legend('10e5 B16 + OVA', '10e4 B16', '10e3 B16', '10e5 B16, Unpulsed', '10e4 B16', '10e3 B16')
title('IFN-\gamma versus MHC exp for 10e5 OT1')
box on
subplot(1,3,2)
hold on
plot(mB1T2, mB1T2m, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 8)
plot(mB2T2, mB2T2m, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 8)
plot(mB3T2, mB3T2m, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 8)
plot(mB1T2_U, mB1T2_Um, '--ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 8)
plot(mB2T2_U, mB2T2_Um, '--ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 8)
plot(mB3T2_U, mB3T2_Um, '--ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 8)
set(gca, 'Fontsize', 20, 'xgrid', 'on', 'ygrid', 'on', 'yscale', 'log', 'xscale', 'log', 'xlim', [10e-13 10e-8], 'xtick', [10e-12, 10e-11, 10e-10, 10e-9, 10e-8])
set(gcf, 'color', 'w')
ylabel('log H-2K^b')
xlabel('log IFN-\gamma, (M)')
title('IFN-\gamma versus MHC exp for 10e4 OT1')
box on
subplot(1,3,3)
hold on
plot(mB1T3, mB1T3m, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 8)
plot(mB2T3, mB2T3m, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 8)
plot(mB3T3, mB3T3m, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 8)
plot(mB1T3_U, mB1T3_Um, '--ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 8)
plot(mB2T3_U, mB2T3_Um, '--ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 8)
plot(mB3T3_U, mB3T3_Um, '--ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 8)
set(gca, 'Fontsize', 20, 'xgrid', 'on', 'ygrid', 'on', 'yscale', 'log', 'xscale', 'log', 'xlim', [10e-13 10e-8], 'xtick', [10e-12, 10e-11, 10e-10, 10e-9, 10e-8], 'ylim', [10e1 10e4])
set(gcf, 'color', 'w')
ylabel('log H-2K^b')
xlabel('log IFN-\gamma, (M)')
title('IFN-\gamma versus MHC exp for 10e3 OT1')
box on
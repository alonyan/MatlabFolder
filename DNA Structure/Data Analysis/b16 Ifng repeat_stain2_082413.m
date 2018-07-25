%b16 IFNg repeat - stain2 - in this stain - stained for IFNgR alpha chain
%and pSTAT1. 

%pSTAT1 GMFI at different timepoints

T1=[1036 1083 898 791 751 744 722
    1016 991 852 768 732 704 717];
e1=std(T1);
T1_m=mean(T1);

T2=[1617 1574 1129 925 844 809 845
    1463 1539 1082 930 848 854 860];
e2=std(T2);
T2_m=mean(T2);

T3=[1352 1357 1148 1015 931 841 745
    1065 1008 1029 947 1011 933 924];
e3=std(T3);
T3_m=mean(T3);

T4=[1555 1703 1467 1230 1131 1019 988
    1603 1549 1407 1346 1027 1062 995];
e4=std(T4);
T4_m=mean(T4);

T5=[1513 1526 1335 1269 1128 1104 1052
    1631 1644 1428 1211 1074 991 1062];
e5=std(T5);
T5_m=mean(T5);

T6=[1826 1710 1398 1145 1099 1037 1018
    1771 1658 1412 1267 1063 1120 1092];
e6=std(T6);
T6_m=mean(T6);

gamma=[10e-9 1e-9 100e-12 10e-12 1e-12 100e-15 0];
time=[10.5 21.5 32.5 44.5 56.6 68.5];

figure()
hold on
errorbar(gamma, T1_m, e1, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
errorbar(gamma, T2_m, e2, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', [1 0.5 0.2], 'markersize', 10)
errorbar(gamma, T3_m, e3, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 10)
errorbar(gamma, T4_m, e4, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'g', 'markersize', 10)
errorbar(gamma, T5_m, e5, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
errorbar(gamma, T6_m, e6, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'c', 'markersize', 10)
set(gca, 'Fontsize', 20, 'xscale', 'log')
set(gcf, 'color', 'w')
ylabel('pSTAT1 GMFI')
xlabel('log [IFN-\gamma], (M)')
legend('10.5 hours', '21.5', '32.5', '44.5', '56.5', '68.5')
box on
title('pSTAT1 following media supplementation with IFN')

%%
%pSTAT1 over time
gamma1=[T1(:,1), T2(:,1), T3(:,1), T4(:,1), T5(:,1), T6(:,1)]; gamma2=[T1(:,2), T2(:,2), T3(:,2), T4(:,2), T5(:,2), T6(:,2)]; gamma3=[T1(:,3), T2(:,3), T3(:,3), T4(:,3), T5(:,3), T6(:,3)];
gamma4=[T1(:,4), T2(:,4), T3(:,4), T4(:,4), T5(:,4), T6(:,4)]; gamma5=[T1(:,5), T2(:,5), T3(:,5), T4(:,5), T5(:,5), T6(:,5)]; gamma6=[T1(:,6), T2(:,6), T3(:,6), T4(:,6), T5(:,6), T6(:,6)]; 
gamma7=[T1(:,7), T2(:,7), T3(:,7), T4(:,7), T5(:,7), T6(:,7)];

eg1=std(gamma1); eg2=std(gamma2); eg3=std(gamma3); eg4=std(gamma4); eg5=std(gamma5); eg6=std(gamma6); eg7=std(gamma7);
gamma1=mean(gamma1); gamma2=mean(gamma2); gamma3=mean(gamma3); gamma4=mean(gamma4); gamma5=mean(gamma5); gamma6=mean(gamma6); gamma7=mean(gamma7);

figure()
hold on
errorbar(time, gamma1, eg1, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 8)
errorbar(time, gamma2, eg2, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', [1 0.5 0.2], 'markersize', 8)
errorbar(time, gamma3, eg3, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 8)
errorbar(time, gamma4, eg4, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'g', 'markersize', 8)
errorbar(time, gamma5, eg5, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 8)
errorbar(time, gamma6, eg6, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'c', 'markersize', 8)
errorbar(time, gamma7, eg7, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'k', 'markersize', 8)
set(gca, 'Fontsize', 20)
set(gcf, 'color', 'w')
ylabel('pSTAT1 MFI')
xlabel('Time, (hours)')
legend('10nM IFN-\gamma', '1nM', '100pM', '10pM', '1pM', '100fM', '0')
box on
title('pSTAT1 expression over time')

%Compute the Integral of pSTAT1 over time for each concentration of
%IFN-gamma.

gamma1=gamma1-gamma7;
I_g1=trapz(time, gamma1);
I_g1_t1=trapz(time(1:2), gamma1(1:2)); I_g1_t2=trapz(time(1:3), gamma1(1:3)); I_g1_t3=trapz(time(1:4), gamma1(1:4)); I_g1_t4=trapz(time(1:5), gamma1(1:5)); I_g1_t5=trapz(time(1:6), gamma1(1:6));
Int_gamma1=[I_g1_t1, I_g1_t2, I_g1_t3, I_g1_t4, I_g1_t5];

gamma2=gamma2-gamma7;
I_g2=trapz(time, gamma2);
I_g2_t1=trapz(time(1:2), gamma2(1:2)); I_g2_t2=trapz(time(1:3), gamma2(1:3)); I_g2_t3=trapz(time(1:4), gamma2(1:4)); I_g2_t4=trapz(time(1:5), gamma2(1:5)); I_g2_t5=trapz(time(1:6), gamma2(1:6));
Int_gamma2=[I_g2_t1, I_g2_t2, I_g2_t3, I_g2_t4, I_g2_t5];

gamma3=gamma3-gamma7;
I_g3=trapz(time, gamma3);
I_g3_t1=trapz(time(1:2), gamma3(1:2)); I_g3_t2=trapz(time(1:3), gamma3(1:3)); I_g3_t3=trapz(time(1:4), gamma3(1:4)); I_g3_t4=trapz(time(1:5), gamma3(1:5)); I_g3_t5=trapz(time(1:6), gamma3(1:6));
Int_gamma3=[I_g3_t1, I_g3_t2, I_g3_t3, I_g3_t4, I_g3_t5];

gamma4=gamma4-gamma7;
I_g4=trapz(time, gamma4);
I_g4_t1=trapz(time(1:2), gamma4(1:2)); I_g4_t2=trapz(time(1:3), gamma4(1:3)); I_g4_t3=trapz(time(1:4), gamma4(1:4)); I_g4_t4=trapz(time(1:5), gamma4(1:5)); I_g4_t5=trapz(time(1:6), gamma4(1:6));
Int_gamma4=[I_g4_t1, I_g4_t2, I_g4_t3, I_g4_t4, I_g4_t5];

gamma5=gamma5-gamma7;
I_g5=trapz(time, gamma5);
I_g5_t1=trapz(time(1:2), gamma5(1:2)); I_g5_t2=trapz(time(1:3), gamma5(1:3)); I_g5_t3=trapz(time(1:4), gamma5(1:4)); I_g5_t4=trapz(time(1:5), gamma5(1:5)); I_g5_t5=trapz(time(1:6), gamma5(1:6));
Int_gamma5=[I_g5_t1, I_g5_t2, I_g5_t3, I_g5_t4, I_g5_t5];

gamma6=gamma6-gamma7;
I_g6=trapz(time, gamma6);
I_g6_t1=trapz(time(1:2), gamma6(1:2)); I_g6_t2=trapz(time(1:3), gamma6(1:3)); I_g6_t3=trapz(time(1:4), gamma6(1:4)); I_g6_t4=trapz(time(1:5), gamma6(1:5)); I_g6_t5=trapz(time(1:6), gamma6(1:6));
Int_gamma6=[I_g6_t1, I_g6_t2, I_g6_t3, I_g6_t4, I_g6_t5];

gamma7=gamma7-gamma7;
I_g7=trapz(time, gamma7);
I_g7_t1=trapz(time(1:2), gamma7(1:2)); I_g7_t2=trapz(time(1:3), gamma7(1:3)); I_g7_t3=trapz(time(1:4), gamma7(1:4)); I_g7_t4=trapz(time(1:5), gamma7(1:5)); I_g7_t5=trapz(time(1:6), gamma7(1:6));
Int_gamma7=[I_g7_t1, I_g7_t2, I_g7_t3, I_g7_t4, I_g7_t5];


Integral_pSTAT1=[I_g1, I_g2, I_g3, I_g4, I_g5, I_g6, I_g7];

%Plot the concentration of IFN-gamma at the start against the integral of
%pSTAT1 over time.  How much pSTAT1 does a given concentration of IFN-gamma
%give you over 70 hours?

%Maxima of MHC expressions

MHC=[1.7985e3 1.6840e3 1.4370e3 1.2880e3 1.1010e3 1.0785e3 1.0570e3];

figure()
subplot(1,2,1)
plot(gamma, Integral_pSTAT1, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'c' , 'markersize', 10)
set(gca, 'Fontsize', 20, 'xscale', 'log', 'yscale', 'log', 'xgrid', 'on', 'ygrid', 'on')
set(gcf, 'color', 'w')
xlabel('log IFN-\gamma, (M)')
ylabel('log\int pSTAT1')
box on
title('\int pSTAT1 over time versus initial [IFN-\gamma]')
subplot(1,2,2)
plot(Integral_pSTAT1, MHC, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
set(gca, 'Fontsize', 20, 'xscale', 'log', 'yscale', 'log', 'xgrid', 'on', 'ygrid', 'on')
set(gcf, 'color', 'w')
ylabel('log H-2K^b_m_a_x')
xlabel('log\int pSTAT1')
box on
title('Max MHC expression versus  \int pSTAT1 over time')

%MHC expression --> columns are different gamma concentrations (high to
%low), rows are different timepoints 
MHC_time=[3.9095e3 1.3012e4 1.1281e4 1.4555e4 1.1913e4 1.8333e4
          3.5760e3 1.0740e4 0.7613e4 1.2080e4 1.1912e4 1.7827e4
          2.7930e3 0.7213e4 0.5173e4 0.9622e4 0.9969e4 2.0455e4
          1.6340e3 0.3634e4 0.2447e4 0.4350e4 0.4910e4 0.7724e4
          0.6245e3 0.0995e4 0.0657e4 0.0993e4 0.1769e4 0.2056e4
          0.4740e3 0.0672e4 0.0459e4 0.0590e4 0.0632e4 0.1226e4
          0.4885e3 0.0638e4 0.0430e4 0.0619e4 0.0805e4 0.1620e4];
             
%plot integration of pSTAT1 at each timepoint versus the mhc expression at
%that time. Note that the pSTAT1 values were normalized by subtracting out the "background" or the pSTAT1 values for 0 added IFN-gamma.  
%This isn't ideal - ideal would be to use an isotype since I have not
%verified that B16s do not produce their own ifn-gamma, though literature
%indicates that they do not.  
figure()
hold on
plot(Int_gamma1, MHC_time(1,2:6), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
plot(Int_gamma2, MHC_time(2,2:6), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', [1 0.5 0], 'markersize', 10)
plot(Int_gamma3, MHC_time(3,2:6), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 10)
plot(Int_gamma4, MHC_time(4,2:6), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'g', 'markersize', 10)
plot(Int_gamma5, MHC_time(5,2:6), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
plot(Int_gamma6, MHC_time(6,2:6), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'c', 'markersize', 10)
plot(Int_gamma7, MHC_time(7,2:6), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'k', 'markersize', 10)
set(gca, 'Fontsize', 20, 'xscale' ,'log', 'yscale', 'log', 'xgrid', 'on', 'ygrid', 'on')
set(gcf, 'color', 'w')
xlabel('\int pSTAT1 at each t')
ylabel('H-2K^b expression at each t')
legend('10nM IFN\gamma', '1nM', '100pM', '10pM', '1pM', '100fM')
box on

time=[21.5 32.5 44.5 56.6 68.5];

figure()
hold on
plot(time, Int_gamma1, 'ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
plot(time, Int_gamma2, 'ko', 'markeredgecolor', 'k', 'markerfacecolor', [1 0.5 0], 'markersize', 10)
plot(time, Int_gamma3, 'ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 10)
plot(time, Int_gamma4, 'ko', 'markeredgecolor', 'k', 'markerfacecolor', 'g', 'markersize', 10)
plot(time, Int_gamma5, 'ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
plot(time, Int_gamma6, 'ko', 'markeredgecolor', 'k', 'markerfacecolor', 'c', 'markersize', 10)
plot(time, Int_gamma7, 'ko', 'markeredgecolor', 'k', 'markerfacecolor', 'k', 'markersize', 10)
set(gca, 'Fontsize', 20, 'yscale', 'log', 'xgrid', 'on', 'ygrid', 'on')
set(gcf, 'color', 'w')
ylabel('\int pSTAT1 at each t')
xlabel('Time, (hours)')
legend('10nM IFN\gamma', '1nM', '100pM', '10pM', '1pM', '100fM')
box on
%%
%pSTAT1 normalized to the media control (gamma7 = NO IFN gamma added to media at T0)
gamma1=[T1(:,1), T2(:,1), T3(:,1), T4(:,1), T5(:,1), T6(:,1)]; gamma2=[T1(:,2), T2(:,2), T3(:,2), T4(:,2), T5(:,2), T6(:,2)]; gamma3=[T1(:,3), T2(:,3), T3(:,3), T4(:,3), T5(:,3), T6(:,3)];
gamma4=[T1(:,4), T2(:,4), T3(:,4), T4(:,4), T5(:,4), T6(:,4)]; gamma5=[T1(:,5), T2(:,5), T3(:,5), T4(:,5), T5(:,5), T6(:,5)]; gamma6=[T1(:,6), T2(:,6), T3(:,6), T4(:,6), T5(:,6), T6(:,6)]; 
gamma7=[T1(:,7), T2(:,7), T3(:,7), T4(:,7), T5(:,7), T6(:,7)];

gamma1_norm=gamma1./gamma7; gamma2_norm=gamma2./gamma7; gamma3_norm=gamma3./gamma7; gamma4_norm=gamma4./gamma7; gamma5_norm=gamma5./gamma7; gamma6_norm=gamma6./gamma7;

eg1=std(gamma1_norm); eg2=std(gamma2_norm); eg3=std(gamma3_norm); eg4=std(gamma4_norm); eg5=std(gamma5_norm); eg6=std(gamma6_norm);
gamma1=mean(gamma1_norm); gamma2=mean(gamma2_norm); gamma3=mean(gamma3_norm); gamma4=mean(gamma4_norm); gamma5=mean(gamma5_norm); gamma6=mean(gamma6_norm); 


figure()
hold on
errorbar(time, gamma1, eg1, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
errorbar(time, gamma2, eg2, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', [1 0.5 0.2], 'markersize', 10)
errorbar(time, gamma3, eg3, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 10)
errorbar(time, gamma4, eg4, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'g', 'markersize', 10)
errorbar(time, gamma5, eg5, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
errorbar(time, gamma6, eg6, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'c', 'markersize', 10)
set(gca, 'Fontsize', 20)
set(gcf, 'color', 'w')
ylabel('fold pSTAT1 fluorescence over media control')
xlabel('Time, (hours)')
legend('10nM IFN-\gamma', '1nM', '100pM', '10pM', '1pM', '100fM')
box on
title('Normalized pSTAT1 over time')

%%
%IFN-gRa GMFI at different timepoints

T1=[2839 2959 2590 2396 2472 2341 2269
    2623 2590 2410 2379 2238 2148 2210];
e1=std(T1);
T1_m=mean(T1);

T2=[3836 3689 2789 2502 2447 2265 2491
    3515 3722 2766 2642 2584 2699 2681];
e2=std(T2);
T2_m=mean(T2);

T3=[4089 3725 3202 3003 2979 2648 2396
    2378 2215 1972 2340 3174 2951 2839];
e3=std(T3);
T3_m=mean(T3);

T4=[4367 5191 4311 3959 3851 3360 3272
    4768 4691 4233 4195 3394 3777 3294];
e4=std(T4);
T4_m=mean(T4);

T5=[4396 4547 3814 3812 3632 3761 3423
    4697 4911 4350 3775 3470 3266 3460];
e5=std(T5);
T5_m=mean(T5);

T6=[5213 4501 3731 3337 3493 3468 3083
    4789 4458 3899 3678 3300 3732 3078];
e6=std(T6);
T6_m=mean(T6);

gamma=[10e-9 1e-9 100e-12 10e-12 1e-12 100e-15 0];
time=[10.5 21.5 32.5 44.5 56.6 68.5];

figure()
hold on
errorbar(gamma, T1_m, e1, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
errorbar(gamma, T2_m, e2, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', [1 0.5 0.2], 'markersize', 10)
errorbar(gamma, T3_m, e3, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 10)
errorbar(gamma, T4_m, e4, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'g', 'markersize', 10)
errorbar(gamma, T5_m, e5, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
errorbar(gamma, T6_m, e6, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'c', 'markersize', 10)
set(gca, 'Fontsize', 20, 'xscale', 'log')
set(gcf, 'color', 'w')
ylabel('IFN\gammaR\alpha GMFI')
xlabel('log [IFN-\gamma], (M)')
legend('10.5 hours', '21.5', '32.5', '44.5', '56.5', '68.5')
box on
title('IFN\gammaR\alpha following media supplementation with IFN')

%%
%IFN-gRa MfI over time
gamma1=[T1(:,1), T2(:,1), T3(:,1), T4(:,1), T5(:,1), T6(:,1)]; gamma2=[T1(:,2), T2(:,2), T3(:,2), T4(:,2), T5(:,2), T6(:,2)]; gamma3=[T1(:,3), T2(:,3), T3(:,3), T4(:,3), T5(:,3), T6(:,3)];
gamma4=[T1(:,4), T2(:,4), T3(:,4), T4(:,4), T5(:,4), T6(:,4)]; gamma5=[T1(:,5), T2(:,5), T3(:,5), T4(:,5), T5(:,5), T6(:,5)]; gamma6=[T1(:,6), T2(:,6), T3(:,6), T4(:,6), T5(:,6), T6(:,6)]; 
gamma7=[T1(:,7), T2(:,7), T3(:,7), T4(:,7), T5(:,7), T6(:,7)];

eg1=std(gamma1); eg2=std(gamma2); eg3=std(gamma3); eg4=std(gamma4); eg5=std(gamma5); eg6=std(gamma6); eg7=std(gamma7);
gamma1=mean(gamma1); gamma2=mean(gamma2); gamma3=mean(gamma3); gamma4=mean(gamma4); gamma5=mean(gamma5); gamma6=mean(gamma6); gamma7=mean(gamma7);

figure()
hold on
errorbar(time, gamma1, eg1, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
errorbar(time, gamma2, eg2, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', [1 0.5 0.2], 'markersize', 10)
errorbar(time, gamma3, eg3, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 10)
errorbar(time, gamma4, eg4, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'g', 'markersize', 10)
errorbar(time, gamma5, eg5, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
errorbar(time, gamma6, eg6, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'c', 'markersize', 10)
errorbar(time, gamma7, eg7, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'k', 'markersize', 10)
set(gca, 'Fontsize', 20)
set(gcf, 'color', 'w')
ylabel('IFN\gammaR\alpha MFI')
xlabel('Time, (hours)')
legend('10nM IFN-\gamma', '1nM', '100pM', '10pM', '1pM', '100fM', '0')
box on
title('IFN\gammaR\alpha expression over time')

%%
%IFN-gRa normalized to the media control (gamma7 = NO IFN gamma added to media at T0)
gamma1=[T1(:,1), T2(:,1), T3(:,1), T4(:,1), T5(:,1), T6(:,1)]; gamma2=[T1(:,2), T2(:,2), T3(:,2), T4(:,2), T5(:,2), T6(:,2)]; gamma3=[T1(:,3), T2(:,3), T3(:,3), T4(:,3), T5(:,3), T6(:,3)];
gamma4=[T1(:,4), T2(:,4), T3(:,4), T4(:,4), T5(:,4), T6(:,4)]; gamma5=[T1(:,5), T2(:,5), T3(:,5), T4(:,5), T5(:,5), T6(:,5)]; gamma6=[T1(:,6), T2(:,6), T3(:,6), T4(:,6), T5(:,6), T6(:,6)]; 
gamma7=[T1(:,7), T2(:,7), T3(:,7), T4(:,7), T5(:,7), T6(:,7)];

gamma1_norm=gamma1./gamma7; gamma2_norm=gamma2./gamma7; gamma3_norm=gamma3./gamma7; gamma4_norm=gamma4./gamma7; gamma5_norm=gamma5./gamma7; gamma6_norm=gamma6./gamma7;

eg1=std(gamma1_norm); eg2=std(gamma2_norm); eg3=std(gamma3_norm); eg4=std(gamma4_norm); eg5=std(gamma5_norm); eg6=std(gamma6_norm);
gamma1=mean(gamma1_norm); gamma2=mean(gamma2_norm); gamma3=mean(gamma3_norm); gamma4=mean(gamma4_norm); gamma5=mean(gamma5_norm); gamma6=mean(gamma6_norm); 


figure()
hold on
errorbar(time, gamma1, eg1, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
errorbar(time, gamma2, eg2, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', [1 0.5 0.2], 'markersize', 10)
errorbar(time, gamma3, eg3, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 10)
errorbar(time, gamma4, eg4, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'g', 'markersize', 10)
errorbar(time, gamma5, eg5, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
errorbar(time, gamma6, eg6, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'c', 'markersize', 10)
set(gca, 'Fontsize', 20)
set(gcf, 'color', 'w')
ylabel('fold IFN\gammaR\alpha fluorescence over media control')
xlabel('Time, (hours)')
legend('10nM IFN-\gamma', '1nM', '100pM', '10pM', '1pM', '100fM')
box on
title('Normalized IFN\gammaR\alpha over time')

%Plot the integral of pSTAT1 at each timepoint versus the IFN-gR level at
%that timepoint

figure()
hold on
plot(gamma1(2:6), Int_gamma1, 'ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
plot(gamma2(2:6), Int_gamma2, 'ko', 'markeredgecolor', 'k', 'markerfacecolor', [1 0.5 0], 'markersize', 10)
plot(gamma3(2:6), Int_gamma3, 'ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 10)
plot(gamma4(2:6), Int_gamma4, 'ko', 'markeredgecolor', 'k', 'markerfacecolor', 'g', 'markersize', 10)
plot(gamma5(2:6), Int_gamma5, 'ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
plot(gamma6(2:6), Int_gamma6, 'ko', 'markeredgecolor', 'k', 'markerfacecolor', 'c', 'markersize', 10)
plot(gamma7(2:6), Int_gamma7, 'ko', 'markeredgecolor', 'k', 'markerfacecolor', 'k', 'markersize', 10)
set(gca, 'Fontsize', 20, 'xscale' ,'log', 'yscale', 'log')
set(gcf, 'color', 'w')
ylabel('\int pSTAT1 at each t')
xlabel('IFN\gammaR\alpha at each t')
legend('10nM IFN\gamma', '1nM', '100pM', '10pM', '1pM', '100fM')
box on

%%

%pSTAT1 GMFI
T1_pSTAT1=[1036 1083 898 791 751 744 722
    1016 991 852 768 732 704 717];
e1_pSTAT1=std(T1);
T1_pSTAT1m=mean(T1);

T2_pSTAT1=[1617 1574 1129 925 844 809 845
    1463 1539 1082 930 848 854 860];
e2_pSTAT1=std(T2);
T2_pSTAT1m=mean(T2);

T3_pSTAT1=[1352 1357 1148 1015 931 841 745
    1065 1008 1029 947 1011 933 924];
e3_pSTAT1=std(T3);
T3_pSTAT1m=mean(T3);

T4_pSTAT1=[1555 1703 1467 1230 1131 1019 988
    1603 1549 1407 1346 1027 1062 995];
e4_pSTAT1=std(T4);
T4_pSTAT1m=mean(T4);

T5_pSTAT1=[1513 1526 1335 1269 1128 1104 1052
    1631 1644 1428 1211 1074 991 1062];
e5_pSTAT1=std(T5);
T5_pSTAT1m=mean(T5);

T6_pSTAT1=[1826 1710 1398 1145 1099 1037 1018
    1771 1658 1412 1267 1063 1120 1092];
e6_pSTAT1=std(T6);
T6_pSTAT1m=mean(T6);

%IFNgammaRalpha GMFI
T1_gamma=[2839 2959 2590 2396 2472 2341 2269
    2623 2590 2410 2379 2238 2148 2210];
e1_gamma=std(T1);
T1_gammam=mean(T1);

T2_gamma=[3836 3689 2789 2502 2447 2265 2491
    3515 3722 2766 2642 2584 2699 2681];
e2_gamma=std(T2);
T2_gammam=mean(T2);

T3_gamma=[4089 3725 3202 3003 2979 2648 2396
    2378 2215 1972 2340 3174 2951 2839];
e3_gamma=std(T3);
T3_gammam=mean(T3);

T4_gamma=[4367 5191 4311 3959 3851 3360 3272
    4768 4691 4233 4195 3394 3777 3294];
e4_gamma=std(T4);
T4_gammam=mean(T4);

T5_gamma=[4396 4547 3814 3812 3632 3761 3423
    4697 4911 4350 3775 3470 3266 3460];
e5_gamma=std(T5);
T5_gammam=mean(T5);

T6_gamma=[5213 4501 3731 3337 3493 3468 3083
    4789 4458 3899 3678 3300 3732 3078];
e6_gamma=std(T6);
T6_gammam=mean(T6);

figure()
hold on
plot(T1_gamma, T1_pSTAT1, 'o', 'markeredgecolor', 'k', 'markerfacecolor', 'r')
plot(T2_gamma, T2_pSTAT1, 'o', 'markeredgecolor', 'k', 'markerfacecolor', [1 0.5 0])
plot(T3_gamma, T3_pSTAT1, 'o', 'markeredgecolor', 'k', 'markerfacecolor', 'y')
plot(T4_gamma, T4_pSTAT1, 'o', 'markeredgecolor', 'k', 'markerfacecolor', 'g')
plot(T5_gamma, T5_pSTAT1, 'o', 'markeredgecolor', 'k', 'markerfacecolor', 'b')
plot(T6_gamma, T6_pSTAT1, 'o', 'markeredgecolor', 'k', 'markerfacecolor', 'c')
set(gca, 'Fontsize', 20)
set(gcf, 'color', 'w')
ylabel('pSTAT1 GMFI')
xlabel('IFN-\gammaR\alpha GMFI')
box on
title('Correlation of pSTAT1 with IFN-\gammaR\alpha levels')

%B16 IFN-g Jaki expt. 12.18.13

%Cells pulsed with 10nM, 1nM, 100pM, 10pM, 1pM, 0 IFN-g.  At either T0,
%10min, 30 min, 1hr, 2hr, 3hr, 5hr 10uM Jaki (Azd1480) was added.  DMSO
%vehicle added.  

%At 20 hr, cells were harvested and stained with Dapi and anti-H-2Kb APC

%%
IFNg=[10e-9 1e-9 100e-12 10e-12 1e-12 0]; 

T0_vehicle=[19231 15467 8540 2303 1099 1101 
            19231  15638 9049 2504 1077 972]; T0_v_s=std(T0_vehicle); T0_v_m=mean(T0_vehicle);
AMP_T0_v=T0_v_m-min(T0_v_m);
        
T0_drug=[1054 1075 798 676 698 582
         934  945  783 660 723 693]; T0_d_s=std(T0_drug); T0_d_m=mean(T0_drug);
AMP_T0_d=T0_d_m-min(T0_d_m);

T1=[1262 1371 992 949 896 812
    1205 1251 975 831 848 774]; T1_s=std(T1); T1_m=mean(T1);
AMP_T1=T1_m-min(T1_m);


T2=[1182 1185 1065 899 828  775
    1187 1381 1025 914 1074 769]; T2_s=std(T2); T2_m=mean(T2);
AMP_T2=T2_m-min(T2_m);


T3=[1481 1515 1150 968 871 737
    1574 1428 1086 897 838 749]; T3_s=std(T3); T3_m=mean(T3);
AMP_T3=T3_m-min(T3_m);


T4=[1881 2027 1713 955 842 782
    1709 1953 1406 934 828 773]; T4_s=std(T4); T4_m=mean(T4);
AMP_T4=T4_m-min(T4_m);


T5=[2242 2219 1617 927 788 665
    2484 2257 1727 897 791 567]; T5_s=std(T5); T5_m=mean(T5);
AMP_T5=T5_m-min(T5_m);


T6=[3366 3174 2103 995 754 708 
    3271 3191 2377 958 733 681]; T6_s=std(T6); T6_m=mean(T6);
AMP_T6=T6_m-min(T6_m);

Amp=[AMP_T0_d, AMP_T1, AMP_T2, AMP_T3, AMP_T4, AMP_T5, AMP_T6, AMP_T0_v];

Amp=reshape(Amp, 8,6)';
time=[0 10 30 60 120 180 300 1200];

timegamma1=time(1,1)*IFNg;
timegamma2=time(1,2)*IFNg;
timegamma3=time(1,3)*IFNg;
timegamma4=time(1,4)*IFNg;
timegamma5=time(1,5)*IFNg;
timegamma6=time(1,6)*IFNg;
timegamma7=time(1,7)*IFNg;
timegamma8=time(1,8)*IFNg;

timegamma=[timegamma1
           timegamma2
           timegamma3
           timegamma4
           timegamma5
           timegamma6
           timegamma7
           timegamma8];
timegamma=timegamma;

figure()
for t=8
plot(timegamma, Amp, '+', 'markersize', 10)
end
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 25, 'xscale', 'log', 'yscale', 'log')
xlabel('Time*[Gamma], (min*M)')
ylabel('Amplitude of MHC response')
box on
title('Relationship between dynamic range and time of gamma-sensing')


%%
%T1=10m, T2=30m, T3=1h, T4=2h, T5=3h, T6=5h

figure()
hold on
errorbar(IFNg, T0_v_m, T0_v_s, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 9)
errorbar(IFNg, T0_d_m, T0_v_s, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', [1 0.5 0], 'markersize', 9)
errorbar(IFNg, T1_m, T1_s, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 9)
errorbar(IFNg, T2_m, T2_s, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'g', 'markersize', 9)
errorbar(IFNg, T3_m, T3_s, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 9)
errorbar(IFNg, T4_m, T4_s, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'c', 'markersize', 9)
errorbar(IFNg, T5_m, T5_s, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'k', 'markersize', 9)
errorbar(IFNg, T6_m, T6_s, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'w', 'markersize', 9)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 25, 'xscale', 'log', 'xgrid', 'on', 'ygrid', 'on', 'yscale', 'log', 'xlim', [1e-13 1e-7], 'ylim', [300 22000])
xlabel('[IFN-\gamma], (M)')
ylabel('H-2K^b GMFI')
legend('DMSO T0', 'T0 10uM Jaki', '10m', '30m', '1h', '2h', '3h', '5h')
title('MHC-I upregulation')
box on

T0_v_m=T0_v_m./T0_d_m;
T1_m=T1_m./T0_d_m;
T2_m=T2_m./T0_d_m;
T3_m=T3_m./T0_d_m;
T4_m=T4_m./T0_d_m;
T5_m=T5_m./T0_d_m;
T6_m=T6_m./T0_d_m;

figure()
hold on
plot(IFNg, T0_v_m, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 15)
plot(IFNg, T1_m, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', [1 0.5 0], 'markersize', 15)
plot(IFNg, T2_m, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 15)
plot(IFNg, T3_m, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'g', 'markersize', 15)
plot(IFNg, T4_m, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 15)
plot(IFNg, T5_m, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'c', 'markersize', 15)
plot(IFNg, T6_m, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'k', 'markersize', 15)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 25, 'xscale', 'log', 'xgrid', 'on', 'ygrid', 'on', 'yscale', 'log','xlim', [1e-13 1e-7], 'ylim', [1 17])
xlabel('[IFN-\gamma], (M)')
ylabel('fold expression over Jaki @ T0')
legend('DMSO T0', '10m', '30m', '1h', '2h', '3h', '5h')
title('Fold expression of MHC-I over Jaki administration at T0')
box on


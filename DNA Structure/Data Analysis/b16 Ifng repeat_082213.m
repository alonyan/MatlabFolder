%B16 IFN-gamma repeat 8.22.13.  Repeat of initial experiment looking at MHC
%expression (H-2kb) following addition of different quantities of IFN-g to
%the media at T0.  

%H-2Kb MFI at different timepoints

T1=[3872 3786 3057 1661 643 485 496
    3947 3366 2529 1607 606 463 481];
e1=std(T1);
T1_m=mean(T1);

T2=[14150 11191 7746 3863 1048 705 648
    11873 10289 6680 3405 942 638 627];
e2=std(T2);
T2_m=mean(T2);

T3=[12459 7813 5993 2566 664 479 451
    10104 7413 4354 2327 649 440 408];
e3=std(T3);
T3_m=mean(T3);

T4=[12293 10131 8836 3037 820 484 490
    16818 14028 10408 5663 1167 696 748];
e4=std(T4);
T4_m=mean(T4);

T5=[13883 13681 12476 6183 1586 700 820
    9943 10143 7461 3637 1952 564 790];
e5=std(T5);
T5_m=mean(T5);

T6=[21443 20693 22379 6478 1743 1121 1680
    15223 14960 18531 8971 2368 1330 1561];
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
set(gca, 'Fontsize', 20, 'xscale', 'log', 'yscale', 'log')
set(gcf, 'color', 'w')
ylabel('log H-2Kb MFI')
xlabel('log [IFN-\gamma], (M)')
legend('10.5 hours', '21.5', '32.5', '44.5', '56.5', '68.5')
box on
title('MHC expression following media supplementation with IFN')

%%
%H-2Kb MfI over time
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
set(gca, 'Fontsize', 20, 'yscale', 'log')
set(gcf, 'color', 'w')
ylabel('log H-2Kb MFI')
xlabel('Time, (hours)')
legend('10nM IFN-\gamma', '1nM', '100pM', '10pM', '1pM', '100fM', '0')
box on
title('MHC expression over time')

max_g1=max(gamma1); max_g2=max(gamma2); max_g3=max(gamma3); max_g4=max(gamma4); max_g5=max(gamma5); max_g6=max(gamma6); max_g7=max(gamma7);
maxima=[max_g1, max_g2, max_g3, max_g4, max_g5, max_g6, max_g7];

%%
%H-2Kb expression normalized to the media control (gamma7 = NO IFN gamma added to media at T0)
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
ylabel('fold H-2Kb fluorescence over media control')
xlabel('Time, (hours)')
legend('10nM IFN-\gamma', '1nM', '100pM', '10pM', '1pM', '100fM')
box on
title('Normalized MHC expression over time')

%%
%percent H-2Kb+ --> at later timepoints, the expression of H-2Kb appears to
%be bimodal, making a MFI less than ideal.  

T1=[59.9 58.9 49.7 21.7 1.94 0.487 0.623
    60.5 53.8 42.5 20.5 1.51 0.422 0.406];
e1=std(T1);
T1_m=mean(T1);

T2=[89.9 87.2 77.6 59.2 12.2 2.47 2.22
    88.2 87.3 73.8 53.4 10.3 2.18 2.15];
e2=std(T2);
T2_m=mean(T2);

T3=[88.4 76.5 66.5 44 4.18 0.334 0.175
    84.6 73.8 55.7 40.4 3.1 0.155 0.144];
e3=std(T3);
T3_m=mean(T3);

T4=[85 77.5 71 51.3 8.97 1.21 1.48
    89.8 87.7 77.2 70.2 18.4 4.36 4.45];
e4=std(T4);
T4_m=mean(T4);

T5=[86.6 85.6 82.3 70.2 28.9 4.57 5.37 
    75.4 73.1 69 52.8 33.7 2.02 5.37];
e5=std(T5);
T5_m=mean(T5);

T6=[89.7 89.4 90.7 72.9 35.2 14.9 25.5 
    82.1 80.7 89.7 79.2 45 18.4 22.4];
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
ylabel('%H-2Kb+')
xlabel('log [IFN-\gamma], (M)')
legend('10.5 hours', '21.5', '32.5', '44.5', '56.5', '68.5')
box on
title('MHC expression following media supplementation with IFN')


%%
%Percent H-2kb+
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
ylabel('%H-2Kb+')
xlabel('Time, (hours)')
legend('10nM IFN-\gamma', '1nM', '100pM', '10pM', '1pM', '100fM', '0')
box on
title('MHC expression over time')

%%
%H-2Kb expression (percent H-2Kb+) normalized to the media control (gamma7 = NO IFN gamma added to media at T0)
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
ylabel('fold percent H-2Kb+ over media control')
xlabel('Time, (hours)')
legend('10nM IFN-\gamma', '1nM', '100pM', '10pM', '1pM', '100fM')
box on
title('Normalized MHC expression over time')

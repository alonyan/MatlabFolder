%IFN-gamma OT-1 cell death pilot 082913.  Objective was to analyze how exposure to
%IFN-gamma after T cell activation alters cell death.  Hypothesis is that
%greater concentrations of IFN-g increase or accelerate cell death.  

alive_g1=[97 97 95.2 96.3 94.1 94.8 87.5 87.1 49 43.7];
alive_g1=reshape(alive_g1, 2,5);
e1=std(alive_g1);
mean1=mean(alive_g1);

alive_g2=[97 97 96.5 96 92.9 93.2 87.1 87.7 53.1 48.2];
alive_g2=reshape(alive_g2, 2,5);
e2=std(alive_g2);
mean2=mean(alive_g2);

alive_g3=[97 97 96.1 95.7 95.2 94.5 86.9 88 47.3 48.1];
alive_g3=reshape(alive_g3, 2,5);
e3=std(alive_g3);
mean3=mean(alive_g3);

alive_g4=[97 97 95.9 96 94.6 94.3 86.4 87.3 47.5 45.5];
alive_g4=reshape(alive_g4, 2,5);
e4=std(alive_g4);
mean4=mean(alive_g4);

alive_g5=[97 97 95.5 95.5 95.3 94 86.2 87.9 46.8 44.7];
alive_g5=reshape(alive_g5, 2,5);
e5=std(alive_g5);
mean5=mean(alive_g5);

alive_g6=[97 97 96.3 95.2 94.8 93.9 86.3 85.9 47.2 46.7 ];
alive_g6=reshape(alive_g6, 2,5);
e6=std(alive_g6);
mean6=mean(alive_g6);

time=[0 3 6 12 24];

figure()
hold on
errorbar(time, mean1, e1, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 8)
errorbar(time, mean2, e2, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', [1 0.5 0], 'markersize', 8)
errorbar(time, mean3, e3, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 8)
errorbar(time, mean4, e4, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'g', 'markersize', 8)
errorbar(time, mean5, e5, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 8)
errorbar(time, mean6, e6, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'c', 'markersize', 8)
set(gca, 'Fontsize', 20)
set(gcf, 'color', 'w')
xlabel('Time, (hours)')
ylabel('% Alive')
legend('10nM IFN-\gamma', '1nM', '100pM', '10pM', '1pM', '0')
title('Percent of OT-1 Alive')
box on

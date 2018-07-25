% Model predictions for mRNA lifetime changes
%Predictions for # of molecules of Kb at 24 hours given the following mRNA
%lifetime

Lifetime = [23 17 13 7.5 3 1.5 0.75 0.375 0.185]

A = [5.6e5 5e5 4.5e5 3.4e5 1.6e5 8.4e4 4.2e4 2.1e4 1e4]; %Constant signal

B = [1e5 8.5e4 7e4 4e4 9e3 2.7e3 1.1e3 506 239];

figure()
hold on
plot(Lifetime, A, '-ko', 'markerfacecolor', 'b', 'markersize', 9)
plot(Lifetime, B, '-ko', 'markerfacecolor', 'r', 'markersize', 9)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 25, 'xgrid', 'on', 'ygrid', 'on')
legend('Constant signal', 'Extinguished at 5h')
xlabel('mRNA lifetime, (hr)')
ylabel('No. H-2K^b')
title('Predictions of MHC @24h based on mRNA lifetime')
box on
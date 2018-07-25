%IFN-gamma elisa_081913

absorbance=[0.104	0.098	0.092	0.091	0.089	0.097	0.088	0.088	0.087
0.131	0.121	0.105	0.091	0.09	0.088	0.09	0.092	0.092
0.264	0.389	0.13	0.091	0.094	0.085	0.087	0.089	0.103
1.033	0.744	0.427	0.093	0.093	0.092	0.087	0.085	0.086
1.618	1.677	1.34	0.134	0.135	0.148	0.124	0.13	0.124];

T=2.280;
B=0.04728;
E=7.277e-9;

gamma=(absorbance-B)./(T-absorbance).*E;

%%
%Note that I am changing row 5 columns 1-3 by hand such that these values are multiplied
%by 2.  When doing the first round of elisa, these values were above the
%top of the standard when they were neat.  When I re-did the elisa, I
%diluted them 2 fold so am correcting for that now.  

gamma=[0.0019    0.0017    0.0015    0.0015    0.0014    0.0017    0.0014    0.0014    0.0013
    0.0028    0.0025    0.0019    0.0015    0.0014    0.0014    0.0014    0.0015    0.0015
    0.0078    0.0132    0.0028    0.0015    0.0016    0.0013    0.0013    0.0014    0.0019
    0.0575    0.0330    0.0149    0.0015    0.0015    0.0015    0.0013    0.0013    0.0013
    0.3453    0.3933    0.2002   0.0029    0.0030    0.0034    0.0026    0.0028    0.0026].*10e-8;

time=[9 17 25 32.5 41];

P1N1=gamma(:,1);
P2N1=gamma(:,2);
P3N1=gamma(:,3);

P1N2=gamma(:,4);
P2N2=gamma(:,5);
P3N2=gamma(:,6);

P1N3=gamma(:,7);
P2N3=gamma(:,8);
P3N3=gamma(:,9);

figure()
subplot(1,3,1)
hold on
plot(time, P1N1, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
plot(time, P2N1, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
plot(time, P3N1, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 10)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 20, 'ygrid', 'on', 'xgrid', 'on', 'yscale', 'log')
xlabel('Time, (hours)')
ylabel('[IFN-\gamma], (M)')
legend('100nM Ova', '10nM Ova', '1nM Ova')
title('10e5 OT-1')
box on
subplot(1,3,2)
hold on
plot(time, P1N2, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
plot(time, P2N2, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
plot(time, P3N2, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 10)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 20, 'ygrid', 'on', 'xgrid', 'on', 'yscale', 'log', 'ylim', [10e-11 10e-7])
xlabel('Time, (hours)')
ylabel('[IFN-\gamma], (M)')
title('10e4 OT-1')
box on
subplot(1,3,3)
hold on
plot(time, P1N3, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
plot(time, P2N3, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
plot(time, P3N3, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 10)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 20, 'ygrid', 'on', 'xgrid', 'on', 'yscale', 'log', 'ylim', [10e-11 10e-7])
xlabel('Time, (hours)')
ylabel('[IFN-\gamma], (M)')
title('10e3 OT-1')
box on
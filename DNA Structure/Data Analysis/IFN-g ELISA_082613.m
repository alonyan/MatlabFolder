%IFN-gamma elisa_082613

T=2.626;
B=0;
E=2.631e-9;

absorbance_g1=[2.433	2.244	2.415	2.314	2.441	2.454
2.301	2.553	2.511	2.541	2.553	NaN];
gamma1=(absorbance_g1-B)./(T-absorbance_g1).*E;

absorbance_g2=[0.107	0.099	0.103	0.099	0.104	0.11
0.105	0.099	0.105	0.096	0.106	0.108];
gamma2=(absorbance_g2-B)./(T-absorbance_g2).*E;

absorbance_g3=[0.086	0.085	0.088	0.087	0.087	0.085
0.089	0.087	0.083	0.086	0.082	0.085];
gamma3=(absorbance_g3-B)./(T-absorbance_g3).*E;

absorbance_g4=[0.085	0.084	0.087	0.082	0.083	0.086
0.084	0.088	0.085	0.082	0.083	0.085];
gamma4=(absorbance_g4-B)./(T-absorbance_g4).*E;

absorbance_g5=[0.085	0.082	0.082	0.082	0.081	0.093
0.083	0.082	0.082	0.081	0.081	0.083];
gamma5=(absorbance_g5-B)./(T-absorbance_g5).*E;

absorbance_g6=[0.084	0.083	0.081	0.081	0.082	0.083
0.086	0.081	0.084	0.084	0.082	0.083];
gamma6=(absorbance_g6-B)./(T-absorbance_g6).*E;

absorbance_T0=[2.434	0.177	0.086	0.088	0.082	0.081];
gamma_T0=(absorbance_T0-B)./(T-absorbance_T0).*E;

absorbance_media=[0.085	0.08	0.079	0.082	0.082	0.082];
gamma_media=(absorbance_media-B)./(T-absorbance_media).*E;
%%

e1=std(gamma1); e2=std(gamma2); e3=std(gamma3); e4=std(gamma4); e5=std(gamma5); e6=std(gamma6);

g1_m=mean(gamma1); g2_m=mean(gamma2); g3_m=mean(gamma3); g4_m=mean(gamma4); g5_m=mean(gamma5); g6_m=mean(gamma6);

%%

%Plot decay in IFN-gamma from the media
time=[10.5 21.5 32.5 44.5 56.5 68.5];

figure()
hold on
errorbar(time, g1_m, e1, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r')
errorbar(time, g2_m, e2, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', [1 0.5 0])
errorbar(time, g3_m, e3, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y')
errorbar(time, g4_m, e4, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'g')
errorbar(time, g5_m, e5, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b')
errorbar(time, g6_m, e6, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'c')
set(gca, 'Fontsize', 20, 'yscale', 'log')
set(gcf, 'color', 'w')
ylabel('[IFN-\gamma], (M)')
xlabel('Time, (hours)')
legend('10nM IFN-\gamma', '1nM', '100pM', '10pM', '1pM', '100fM')
title('[IFN-\gamma] consumption from the media')
box on

%%

%Plot IFN-gamma concentration in the measured in the media from the
%initially added stock

IFN=[10e-9 1e-9 100e-12 10e-12 1e-12 100e-15];

figure()
plot(IFN, gamma_T0, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
set(gca, 'Fontsize', 20, 'yscale', 'log', 'xscale', 'log')
set(gcf, 'color', 'w')
ylabel('[IFN-\gamma] measured by elisa, (M)')
xlabel('Calculated [IFN-\gamma] added to media at T0, (M)')
title('[IFN-\gamma] measured in the media versus calculated (T0)')
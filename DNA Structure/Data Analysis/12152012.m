%Bead Elisa_12152012
%Standards GMFI Pe (anti IL2)

Standards=[1.55e5
40646
10411
1708
454
146
84.7
78.3
70.5
65.2];
Standards=Standards-min(Standards);

IL2=[12800 3200 800 200 50 12.5 3.12 0.780 0.195 0];

KO=[682 535];
KO=KO-65.2

WT=[677 403];
WT=WT-65.2

figure()
hold on
plot(IL2, Standards, '-ko', 'linewidth', 2)
plot([0.195 max(IL2)], [616.8 616.8], '-bo', 'linewidth', 2)
plot([0.195 max(IL2)], [489.8 489.8], '--bo', 'linewidth', 2)
plot([0.195 max(IL2)], [611.8000 611.8000], '-ro', 'linewidth', 2)
plot([0.195 max(IL2)], [337.8000, 337.8000], '--ro', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'xscale', 'log', 'yscale', 'log')
title('Bead Elisa 12.15.2012')
ylabel('log GeoMFI Pe (anti-IL2 Pe)')
xlabel('[IL2], (pM)')
legend('Calibration', 'IL2KO 24', 'IL2KO 48', 'WT 24', 'WT 48')
box on

%%
%Interpolating IL2 in spleen homogenates from fit of standards

KO24=616.8;
KO48=469.8;

T=80021;
B=10;
EC50=3136;

IL2KO24=(KO24-B)./(T-KO24).*EC50;
IL2KO48=(KO48-B)./(T-KO24).*EC50;

WT24=611.8;
WT48=337.8;

IL2WT24=(WT24-B)./(T-WT24).*EC50;
IL2WT48=(WT48-B)./(T-WT48).*EC50;

Time=[24 48];

IL2KO=[IL2KO24 IL2KO48];
IL2WT=[IL2WT24, IL2WT48];

%Multiply by two due to dilution of spleen during extraction
IL2KO=IL2KO*2
IL2WT=IL2WT*2

figure()
hold on
plot(Time, IL2KO, '-bo', 'linewidth', 2)
plot(Time, IL2WT, '-ro', 'linewidth', 2)
set(gcf,'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold')
ylabel('[IL2], (pM)')
xlabel('Time, hours')
legend('IL2 KO','IL2 WT')
title('IL2 measured in the spleen by bead elisa')
box on


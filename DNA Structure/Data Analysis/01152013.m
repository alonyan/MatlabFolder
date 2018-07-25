%IL2 injections

A=[360
361
356
248
180
162
160
153];
A=A-min(A);

B=[446
479
394
340
229
239
222
239];
B=B-min(B);

C=[471
574
415
326
247
254
233
257];
C=C-min(C);

D=[445
441
411
318
200
207
187];
D=D-min(D);

IL2=[10000 1000 100 10 1 0.1 0.01 0];

IL2_2=[10000 1000 100 10 0.1 0.01 0];


%%

figure()
subplot(2,2,1)
hold on
plot(IL2, A, '-ko', 'linewidth', 2)
plot([0.01, max(IL2)], [106, 106], '--mo', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'xscale', 'log')
xlabel('log [IL2], (pM)')
ylabel('GMFI pSTAT5')
title('1.5ng IL2')
box on
subplot(2,2,2)
hold on
plot(IL2, B, '-ko', 'linewidth', 2)
plot([0.01, max(IL2)], [322, 322], '--mo', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'xscale', 'log')
title('15pg IL2')
box on
subplot(2,2,3)
hold on
plot(IL2, C, '-ko', 'linewidth', 2)
plot([0.01, max(IL2)], [199, 199], '--mo', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'xscale', 'log')
title('1.5pg IL2')
box on
subplot(2,2,4)
hold on
plot(IL2_2, D, '-ko', 'linewidth', 2)
plot([0.01, max(IL2_2)], [158, 158], '--mo', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'xscale', 'log')
title('No IL2')
box on

%%
%40nM
T=212.4
B=0
E=10.85


IL2=(106-B)./(T-106).*E

%%
%400pM
T=239.8
B=0
E=15.23


IL2=(322-B)./(T-322).*E


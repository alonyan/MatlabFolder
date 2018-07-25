cd 'D:\Oleg\Matlab Programming\FACSanalysis_061011';
IL2 = 10.^(-14:0.1:-8);

NR_1e4_1e4 = IL2Rmodel(IL2, 10000, 10000);
NR_1e5_1e4 = IL2Rmodel(IL2, 1e5, 10000);
%%
semilogx(IL2*1e4, NR_1e4_1e4, IL2*1e5, NR_1e5_1e4);
figure(gcf)
%%
NR_1e5_1e3 = IL2Rmodel(IL2, 1e5, 1000);
semilogx(IL2, NR_1e5_1e4/1e4, IL2, NR_1e5_1e3/1000);
figure(gcf)

%%
NR_1e5_1e2 = IL2Rmodel(IL2, 1e5, 100);
semilogx(IL2, NR_1e5_1e2/1e2, IL2, NR_1e5_1e3/1000, IL2, 1./(1+ 1.58e-12./IL2) );
figure(gcf)

%%
[NR_1e5_2e3, NR_1e5_2e3ap] = IL2Rmodel(IL2, 1e5, 2000);
semilogx(IL2, NR_1e5_2e3, IL2*1.7, NR_1e5_2e3ap, IL2, 2000./(1 + (2e-12./IL2).^1.15) );
figure(gcf)

%%
semilogx(IL2, NR_1e5_1e2/1e2, IL2, NR_1e5_1e3/1000, IL2, NR_1e5_1e4/10000 );
figure(gcf)

%%
[NR_1e4_300] = IL2Rmodel(IL2, 1e4, 300);
semilogx(IL2, NR_1e4_300);
figure(gcf)
%T3 CD25 GMFI Tregs
%hi=1uM K5
%lo=1nM K5

t3hiregcd25=[745
673
655
689
901];

t3loregcd25=[1205
1585
1978
1657
1344];

%T2 CD25 GMFI Tregs

t2hiregcd25=[816
788
767
703
653];

t2loregcd25=[1399
1896
1678
1438
951];

%T1 CD25 GMFI Tregs

t1hiregcd25=[1101
1005
927
1130
977];

t1loregcd25=[953
1040
1112
998
1624];

%%

Ratio=[100 50 20 10 1];

%%
%Tregs

figure()
subplot(3,1,1)
hold on
plot(Ratio, t1hiregcd25, '-ro', 'linewidth', 2)
plot(Ratio, t1loregcd25, '-bo', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'yscale', 'log', 'xscale', 'log')
ylabel('log GMFI CD25')
xlabel('Percentage of Tregs relative to Teffs')
title('GMFI of CD25 for Tregs @ 17 hours')
legend('1uM K5', '1nM K5')
box on
subplot(3,1,2)
hold on
plot(Ratio, t2hiregcd25, '-ro', 'linewidth', 2)
plot(Ratio, t2loregcd25, '-bo', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'yscale', 'log', 'xscale', 'log')
ylabel('log GMFI CD25')
xlabel('Percentage of Tregs relative to Teffs')
title('41 hours')
box on
subplot(3,1,3)
hold on
plot(Ratio, t3hiregcd25, '-ro', 'linewidth', 2)
plot(Ratio, t3loregcd25, '-bo', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'yscale', 'log', 'xscale', 'log')
ylabel('log GMFI CD25')
xlabel('Percentage of Tregs relative to Teffs')
title('48 hours')
box on

%%
%(0.1 is actually NO TREGS)
Ratio2=[100 50 20 10 1 0.1];
%%
%Teffs
%hi=1uM K5
%lo=1nM K5
%T3=48 hrs, T2=41 hrs, T1=17hrs

t3hieffcd25=[10444
13300
13501
15250
14777
9527];

t3loeffcd25=[3738
3712
3966
3906
4623
4415];

t2hieffcd25=[12325
15123
15117
16106
16533
12699];

t2loeffcd25=[6228
6085
6236
6152
5905
6039];

t1hieffcd25=[4841
4789
4443
4611
4323
4466];

t1loeffcd25=[4085
3963
4131
4173
3746
4090];
%%

figure()
subplot(3,1,1)
hold on
plot(Ratio2, t1hieffcd25, '-ro', 'linewidth', 2)
plot(Ratio2, t1loeffcd25, '-bo', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'yscale', 'log', 'xscale', 'log', 'YLim', [1e3 1e5])
ylabel('log GMFI CD25')
xlabel('Percentage of Tregs relative to Teffs')
title('GMFI of CD25 for Teffs @ 17 hours')
legend('1uM K5', '1nM K5')
box on
subplot(3,1,2)
hold on
plot(Ratio2, t2hieffcd25, '-ro', 'linewidth', 2)
plot(Ratio2, t2loeffcd25, '-bo', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'yscale', 'log', 'xscale', 'log')
ylabel('log GMFI CD25')
xlabel('Percentage of Tregs relative to Teffs')
title('GMFI of CD25 for Teffs @ 41 hours')
box on
subplot(3,1,3)
hold on
plot(Ratio2, t3hieffcd25, '-ro', 'linewidth', 2)
plot(Ratio2, t3loeffcd25, '-bo', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'yscale', 'log', 'xscale', 'log')
ylabel('log GMFI CD25')
xlabel('Percentage of Tregs relative to Teffs')
title('GMFI of CD25 for Teffs @ 48 hours')
box on
%%

figure()
subplot(3,1,1)
hold on
plot(Ratio2,t1hieffcd25, '-ro', 'linewidth', 2)
plot(Ratio, t1hiregcd25, '-bo', 'linewidth', 2)
plot(Ratio2, t1loeffcd25, '--ro', 'linewidth', 2)
plot(Ratio, t1loregcd25, '--bo', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'yscale', 'log', 'xscale', 'log', 'YLim', [1e2 1e5])
ylabel('log GMFI CD25')
xlabel('Percentage of Tregs relative to Teffs')
title('GMFI of CD25 for Teffs @ 17 hours')
legend('Teff', 'Treg')
box on
subplot(3,1,2)
hold on
plot(Ratio2,t2hieffcd25, '-ro', 'linewidth', 2)
plot(Ratio, t2hiregcd25, '-bo', 'linewidth', 2)
plot(Ratio2, t2loeffcd25, '--ro', 'linewidth', 2)
plot(Ratio, t2loregcd25, '--bo', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'yscale', 'log', 'xscale', 'log')
ylabel('log GMFI CD25')
xlabel('Percentage of Tregs relative to Teffs')
title('GMFI of CD25 for Teffs @ 41 hours')
box on
subplot(3,1,3)
hold on
plot(Ratio2,t3hieffcd25, '-ro', 'linewidth', 2)
plot(Ratio, t3hiregcd25, '-bo', 'linewidth', 2)
plot(Ratio2, t3loeffcd25, '--ro', 'linewidth', 2)
plot(Ratio, t3loregcd25, '--bo', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'yscale', 'log', 'xscale', 'log')
ylabel('log GMFI CD25')
xlabel('Percentage of Tregs relative to Teffs')
title('GMFI of CD25 for Teffs @ 48 hours')
box on

%%



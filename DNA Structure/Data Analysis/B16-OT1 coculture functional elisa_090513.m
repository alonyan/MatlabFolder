%Supernatant from B16 OT-1 coculture (9.5.13) was reserved.  Since I don't
%have a great conventional elisa going yet, I piloted a functional elisa.
%Seeded 100k B16s per well, then added a standard curve of IFN-gamma and
%then diluted all of my samples 2 fold + fresh rpmi.  After 24 hours, I
%stained with Dapi and for H-2kb.  

%%
%All cells gated for fsc ssc then live/dead, then of live, H-2kb GMFI
%H-2kb fluorescence for standard curves
Standards=[47055 43049 38532 18244 3728 1427 1289 1175
           46321 45791 38418 12969 2930 1215 1236 1128];
eSt=std(Standards);
mSt=mean(Standards);
       
gamma1=[100e-9 10e-9 1e-9 100e-12 10e-12 1e-12 100e-15 0];

figure()
errorbar(gamma1, mSt, eSt, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'k', 'markersize', 10)
set(gca, 'Fontsize', 20, 'xscale', 'log', 'yscale', 'log')
set(gcf, 'color', 'w')
xlabel('log [IFN-\gamma], (M)')
ylabel('log H-2K^b GMFI')
title('IFN-\gamma Functional Elisa Standards')
box on

%Values from fitted standard curve
T=46132;
B=1205;
E=2.1e-10;

%%
%Experimental values - for H-2Kb

Exp=[1753 1238 877 973 1186 1399 
     2262 1293 1121 1232 1255 1410
     12591 6483 1674 1423 1480 1438
     10779 4437 1787 1535 1107 1396
     32459 17461 3657 1475 1348 1314
     35585 14002 1900 1604 1223 1221
     41374 12452 2433 1390 1177 1141
     36458 10024 1464 1203 1206 1267
     29735 16478 2286 1808 1503 1673
     33951 18665 1693 1483 1320 1361];
 
 %Values from fitted standard curve
T=46132;
B=1205;
E=2.1e-10;

gamma=(Exp-B)./(T-Exp).*E; %interpolate IFN-gamma concentrations from standard curve

gamma=gamma*2; %all supernatants were diluted 2 fold for experiment

time=[5.5 17.5 29.5 41.5 53.5];

N1=[gamma(1:2,1), gamma(3:4,1), gamma(5:6,1), gamma(7:8,1), gamma(9:10,1)];
eN1=std(N1);
mN1=mean(N1);

N2=[gamma(1:2,2), gamma(3:4,2), gamma(5:6,2), gamma(7:8,2), gamma(9:10,2)];
eN2=std(N2);
mN2=mean(N2);

N3=[gamma(1:2,3), gamma(3:4,3), gamma(5:6,3), gamma(7:8,3), gamma(9:10,3)];
eN3=std(N3);
mN3=mean(N3);

N1_UP=[gamma(1:2,4), gamma(3:4,4), gamma(5:6,4), gamma(7:8,4), gamma(9:10,4)];
eN1UP=std(N1_UP);
mN1UP=mean(N1_UP);

N2_UP=[gamma(1:2,5), gamma(3:4,5), gamma(5:6,5), gamma(7:8,5), gamma(9:10,5)];
eN2UP=std(N2_UP);
mN2UP=mean(N2_UP);

N3_UP=[gamma(1:2,6), gamma(3:4,6), gamma(5:6,6), gamma(7:8,6), gamma(9:10,6)];
eN3UP=std(N3_UP);
mN3UP=mean(N3_UP);

figure()
hold on
errorbar(time, mN1, eN1, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
errorbar(time, mN2, eN2, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 10)
errorbar(time, mN3, eN3, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
errorbar(time, mN1UP, eN1UP, '--ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
errorbar(time, mN2UP, eN2UP, '--ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 10)
errorbar(time, mN3UP, eN3UP, '--ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
set(gca, 'Fontsize', 20, 'yscale', 'log', 'ylim', [10e-14, 10e-9], 'ygrid', 'on', 'xgrid', 'on')
set(gcf, 'color', 'w')
xlabel('Time, (hours)')
ylabel('[IFN-\gamma], (M)')
title('IFN-\gamma Accumulation')
legend('10e5 B16 + 100nM Ova', '10e4', '10e3', '10e5 B16 - Unpulsed', '10e4', '10e3')
box on

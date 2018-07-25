%DC IFNg stimulation experiment 1.7.14
%Stimulated DC's that gregoire harvested from a B10a CD3-/- mouse bone
%marrow and grew for a few days in GM-CSF.  I ficolled to separate dead
%cells/debris, then washed and stimulated cells with gamma titration over
%night.  

%%

%Cells were gated as singlets, live, CD11c+ and then gmfi of
%H-2Dd was calculated.  
%Group A=DMSO vehicle from T0;
%Group B=Jaki from T0 (AZD1480 @ 10uM)
%Group C=Jaki from T=5hr

A=[4816 4416 4076 3270 2669 2279 2360 2331
   4244 4191 3716 3263 2492 2062 2101 2058];

B=[2686 2733 2498 2480 2493 2495 2522 2602
   2639 2559 2592 2488 2351 2350 2418 2580];

C=[3760 3654 3594 2981 2769 2157 2096 2375
   3744 3801 3494 3330 2512 2461 2187 2282];

gamma=[10e-9 2e-9 400e-12 80e-12 16e-12 3.2e-12 640e-15 0];

tsevah=['r', 'y', 'b'];

c=[A B C];

m=zeros(10, 10);

for i=[1:3];
    m=mean(c);
end

m=reshape(m, 8,3)';

s=zeros(10, 10);

for i=[1:3];
    s=std(c);
end

s=reshape(s, 8,3)';

figure()
hold on
for x=1:3;
errorbar(gamma, m(x,:), s(x,:), '-ko', 'markerfacecolor', tsevah(:,x), 'markersize', 10)
end
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 25, 'xscale', 'log', 'yscale', 'log', 'ylim', [2000 6000], 'xgrid', 'on', 'ygrid', 'on')
xlabel('[IFN-\gamma], (M)')
ylabel('H-2D^d GMFI')
box on
legend('DMSO ctrl', 'Jaki from T0', 'Jaki from 5h')
title('Effect of Jaki on MHC I upregulation in DCs')

%%

%Cells were gated as singlets, live, CD11c+ and then g%+ of MHC II (I-Ek was calculated) 
%Group A=DMSO vehicle from T0;
%Group B=Jaki from T0 (AZD1480 @ 10uM)
%Group C=Jaki from T=5hr

A=[64.5 46.7 35   28   24.7 23.2 21.1 24
   63.2 45.5 33.1 24.9 21.6 21.4 17.8 19.2];

B=[32.9 34.1 34 36.5 36.7 34.8 31.2 36.3 
   35.8 38.5 35 39.9 34.1 32.8 33.5 32.7];

C=[43.1 43.2 35.2 35.1 34   28.5 28   27.9
   44.3 40.3 33.2 36.7 33.3 30.1 22.5 26.7];

gamma=[10e-9 2e-9 400e-12 80e-12 16e-12 3.2e-12 640e-15 0];

tsevah=['r', 'y', 'b'];

c=[A B C];

m=zeros(10, 10);

for i=[1:3];
    m=mean(c);
end

m=reshape(m, 8,3)';

s=zeros(10, 10);

for i=[1:3];
    s=std(c);
end

s=reshape(s, 8,3)';

figure()
hold on
for x=1:3;
errorbar(gamma, m(x,:), s(x,:), '-ko', 'markerfacecolor', tsevah(:,x), 'markersize', 10)
end
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 25, 'xscale', 'log', 'ylim', [0 100], 'xgrid', 'on', 'ygrid', 'on')
xlabel('[IFN-\gamma], (M)')
ylabel('%I-E^k+')
box on
legend('DMSO ctrl', 'Jaki from T0', 'Jaki from 5h')
title('Effect of Jaki on MHC II upregulation in DCs')





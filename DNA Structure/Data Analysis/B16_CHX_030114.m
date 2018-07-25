% B16 IFN-g Protein Synthesis Expt. 1.3.14
% Object to test whether the memory of MHC for IFNg at early timepoints is
% dependent upon being able to make new proteins during this time window.  

%%

%Group A: DMSO controls
%Group B: Jaki @ 4 hours
%Group C: CHX for 4 hours then Jaki
%Group D: CHX from T0
%Group E: Jaki from T0

gamma=[10e-9 2.5e-9 625e-12 156e-12 39e-12 9.75e-12 2.4e-12 609e-15 0];

tsevah=['r', 'y', 'g', 'b', 'c'];

A=[15488 16006 9741 4015 1384 758 539 541 532
   15488 14624 9841 3486 1237 528 471 490 533]; %Note that the first 2 replicates are the same b/c I accidentally collected Replicate 1 at a different H-2kb voltage. 

B=[1755 1300 959  600 395 389 359 395 380
   1713 1547 1109 710 486 357 390 436 460];

C=[919  1338 1056 566 492 438 382 440 384
   1301 1239 767  689 523 410 432 434 383];

D=[276 280 271 293 307 305 302 304 315
   259 262 278 280 299 309 300 309 314];

E=[484 448 408 384 459 496 350 547 438
   416 415 419 355 355 360 491 373 414];

c=[A B C D E];

m=zeros(50, 50);

for i=[1:5];
    m=mean(c);
end

m=reshape(m, 9,5)';

s=zeros(50, 50);

for i=[1:5];
    s=std(c);
end

s=reshape(s, 9,5)';

figure()
hold on
for x=1:5;
errorbar(gamma, m(x,:), s(x,:), '-ko', 'markerfacecolor', tsevah(:,x), 'markersize', 10)
end
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 25, 'xscale', 'log', 'yscale', 'log', 'xlim', [1e-13 1e-7], 'ylim', [200 20000], 'xgrid', 'on', 'ygrid', 'on')
xlabel('[IFN-\gamma], (M)')
ylabel('H-2K^b GMFI')
box on
legend('DMSO ctrl', 'Jaki @ 4hr', 'CHX then Jaki @ 4hr', 'CHX from T0', 'Jaki from T0')
title('Effects of early CHX on subsequent MHC upregulation')

%%
%Percentage of B16s alive
gamma=[10e-9 2.5e-9 625e-12 156e-12 39e-12 9.75e-12 2.4e-12 609e-15 0];

tsevah=['r', 'y', 'g', 'b', 'c'];

pA=[89.8 96   79.2 74.9 81   81.2 51.3 86.3 75.6
    87.6 86.5 83   92.3 85.6 89.3 91.7 85.8 50.3]; 

pB=[81.1  88.7  74.6  90.7  86.7  85   87.6  88.7  86.9
    81.9  83.2  86.7  84.4  82.2  78.9 87.5  84.6  64.5];

pC=[89.9  92.9  85.5  90.5  85   85.8  87.3  84.4  86.3
    90.3  92.4  84.9  85.4  82.2 84.2  81.4  83.5  84.6];

pD=[80.3  74.2  75.4  75   75.2  72.6  75.3  68.2  71.2
    80.3  78.3  76    76.6 74.6  72.6  74.2  68.9  68.5];

pE=[60.2  78.1  65.9  76   74.5  75.7  75   66.4  62.6
    79    74.5  74.7  79.9 79.6  77.6  60.2 75.2  71.5];

l=[pA pB pC pD pE];

pm=zeros(50, 50);

for i=[1:5];
    pm=mean(l);
end

pm=reshape(pm, 9,5)';

ps=zeros(50, 50);

for i=[1:5];
    ps=std(l);
end

ps=reshape(ps, 9,5)';

figure()
hold on
for x=1:5;
errorbar(gamma, pm(x,:), ps(x,:), '-ko', 'markerfacecolor', tsevah(:,x), 'markersize', 10)
end
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 25, 'xscale', 'log', 'xgrid', 'on', 'ygrid', 'on', 'ylim', [0 100])
xlabel('[IFN-\gamma], (M)')
ylabel('%Alive')
box on
legend('DMSO ctrl', 'Jaki @ 4hr', 'CHX then Jaki @ 4hr', 'CHX from T0', 'Jaki from T0')
title('Effects of treatment on B16 death')
    
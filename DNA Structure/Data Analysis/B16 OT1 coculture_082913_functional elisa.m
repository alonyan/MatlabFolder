%Supernatant from B16 OT-1 coculture (8.29.13) was reserved.  Since I don't
%have a great conventional elisa going yet, I piloted a functional elisa.
%Seeded 100k B16s per well, then added a standard curve of IFN-gamma and
%then diluted all of my samples 2 fold + fresh rpmi.  After 24 hours, I
%stained with Dapi and for H-2kb.  

%%
%All cells gated for fsc ssc then live/dead, then of live, H-2kb GMFI
%H-2kb fluorescence for standard curves
Standards=[58140 45257 51215 36808 13967 3976 2729 2258
           55393 52687 47557 28800 14552 4432 2482 1840];
eSt=std(Standards);
mSt=mean(Standards);
       
gamma1=[100e-9 18.8e-9 3.3e-9 600e-12 109e-12 20e-12 3.6e-12 0];

figure()
errorbar(gamma1, mSt, eSt, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'k', 'markersize', 10)
set(gca, 'Fontsize', 20, 'xscale', 'log', 'yscale', 'log')
set(gcf, 'color', 'w')
xlabel('log [IFN-\gamma], (M)')
ylabel('log H-2K^b GMFI')
title('IFN-\gamma Functional Elisa Standards')
box on

%Values from fitted standard curve
T=53866;
B=2148;
E=3.9e-10;

%%
%Experimental values - for H-2Kb

Exp=[2236 1651 1799 1527
     2253 1890 2084 1900
     2249 2144 1873 1977
     2324 2131 1889 1993 
     2866 2231 1925 1885 
     2848 2014 2011 2140
     2547 2124 2075 2049 
     2283 1804 1894 1785
     1990 1651 1705 1922 
     1784 1797 1720 1783 
     2538 1886 1856 1951
     2018 1939 1977 2058
     1897 1864 1779 2026 
     2084 1950 1858 1901
     2388 2111 1888 659 
     2677 2120 1893 2077];
 
 %Values from fitted standard curve
T=53866;
B=2148;
E=3.9e-10;

gamma=(Exp-B)./(T-Exp).*E; %interpolate IFN-gamma concentrations from standard curve

gamma=gamma*2; %all supernatants were diluted 2 fold for experiment

time=[12 24 36 48 60 72 84 96];

Ova_hi=[gamma(1:2,1), gamma(3:4,1), gamma(5:6,1), gamma(7:8,1), gamma(9:10,1), gamma(11:12,1), gamma(13:14,1), gamma(15:16,1)];
error=std(Ova_hi);
mean=mean(Ova_hi);

figure()
errorbar(time, mean, error, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'k', 'markersize', 10)
set(gca, 'Fontsize', 20, 'yscale', 'log')
set(gcf, 'color', 'w')
xlabel('Time, (hours)')
ylabel('[IFN-\gamma], (M)')
title('IFN-\gamma Accumulation for 100nM Ova')
box on


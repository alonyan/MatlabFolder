%% Data to be fit (from B16 stimulation done 11.18.13)

MHC = [134689.858877585,134689.858877585,134689.858877585,134689.858877585,134689.858877585,134689.858877585;208204.791598293,175057.433541188,145520.183787332,131736.133902199,123859.533967837,118608.467344929;440236.297998031,321759.107318674,177354.775188710,119264.850672793,101214.309156547,90712.1759107319;810108.303249098,563964.555300296,234788.316376764,106793.567443387,89071.2175910732,90712.1759107319;1173088.28355760,718542.829012143,288611.749261569,119593.042336725,88743.0259271415,78240.8926813259;1773350.83688874,1165539.87528717,366721.365277322,143551.033803741,106137.184115523,93009.5175582540;1812405.64489662,1613521.49655399,421201.181489990,139284.542172629,93665.9008861175,88743.0259271415;]

time = [0 5 10 12.5 15 17.5 25.5].*60.*60;

gamma = [10e-9 1e-9 100e-12 10e-12 1e-12 0];

%%
range = 1:6;
tsevah = ['r', 'm', 'y', 'g', 'b'];

for i = 1:5;

    dMHC = (MHC(:,i)-MHC(:,6))';

    fixed = [false true];

    initparam = [1, gamma(i)];

    [param r err] = mod_lsqcurvefit(fixed, time(range), dMHC(range), @AnalyticMHC, initparam);
    
        
    t = 0:30*60*60;
    
    figure(1)
    subplot(1,2,1)
    hold on
    plot(time/3600, dMHC, 'o', t/3600, AnalyticMHC(param,t), '-k', 'linewidth', 1, 'markerfacecolor', tsevah(:,i), 'markeredgecolor', 'k', 'markersize', 10)
    set(gcf, 'color', 'w')
    set(gca, 'Fontsize', 25, 'ylim', [1e3 5e6], 'yscale', 'log', 'xgrid', 'on', 'ygrid', 'on')
    xlabel('Time, (hours)')
    ylabel('\Delta H-2K^b')
    %legend('10nM IFN-\gamma', 'fit', '1nM', 'fit', '100pM', 'fit', '10pM', 'fit', '1pM', 'fit')
    title('Data fits using Analytical')
    box on
    subplot(1,2,2)
    hold on
    plot(time/3600, dMHC, 'o', t/3600, AnalyticMHC(param,t), '-k', 'linewidth', 1, 'markerfacecolor', tsevah(:,i), 'markeredgecolor', 'k', 'markersize', 10)
    set(gcf, 'color', 'w')
    set(gca, 'Fontsize', 25, 'ylim', [1e3 2e6],'xgrid', 'on', 'ygrid', 'on')
    xlabel('Time, (hours)')
    ylabel('\Delta H-2K^b')
    legend('10nM IFN-\gamma', 'fit', '1nM', 'fit', '100pM', 'fit', '10pM', 'fit', '1pM', 'fit')
    title('Data fits using Analytical')
    box on
  
    figure(2)
    subplot()
    hold on
    plot(time(2:7)/3600, r, '-ko','markerfacecolor', tsevah(:,i), 'markeredgecolor', 'k', 'markersize', 10)
    set(gcf, 'color', 'w')
    set(gca, 'Fontsize', 25)
    xlabel('Time, (hrs)')
    ylabel('Residuals')
    title('Residuals plot')
    box on
end
%%
    alpha = [0.6899e-6 0.4521e-6 0.1869e-6 0.1412e-6 0.2876e-6];

    figure(2)
    plot(gamma(1:5), alpha, '-ko', 'markerfacecolor', 'b', 'markersize', 10)
    set(gcf, 'color', 'w')
    set(gca, 'Fontsize', 25, 'xscale', 'log', 'xgrid', 'on', 'ygrid', 'on', 'yscale', 'log', 'ylim', [1e-7 1e-6])
    xlabel('IFN-\gamma, (M)')
    ylabel('\alpha')
    title('\alpha versus IFN-\gamma')
    box on
  
%%
    range = 1:6;
    
    i = 5;

    dMHC = (MHC(:,i)-MHC(:,6))';

    fixed = [false true];

    initparam = [1, gamma(i)];

    param = mod_lsqcurvefit(fixed, time(range), dMHC(range), @AnalyticMHC, initparam)

    

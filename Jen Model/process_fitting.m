%%
argin = {'GammaStop', '5'};

MHC = [154158.038181221,154158.038181221,154158.038181221,154158.038181221,154158.038181221,154158.038181221;667515.467999403,535866.286489959,445868.823424181,311244.519168761,177735.885943082,118382.187160858;1297497.70945985,675697.055550837,540328.970608923,371490.754774778,212991.090482899,166132.907233775;1095189.36273347,430249.429007806,349177.334179957,251742.064249238,179223.447316070,135489.142950221;532147.383057489,307525.615736291,259923.651800673,199751.794263305,146720.231316281,120241.638877093;329095.255644618,228461.728761975,185768.717357218,152075.452259038,122844.871279822,108043.635618591;317938.545347207,215594.322885628,201164.977567644,164273.455517540,140174.961275133,134299.093851830;332814.159077088,244973.660002143,214478.651855887,181380.411306903,156910.026721249,147687.146208723];

time = [0 19 45 70.5 90.5 115.5 139.5 166.5].*60.*60;

gamma = [10e-9 1e-9 100e-12 10e-12 1e-12 0];


dMHC = (MHC-repmat(MHC(:,6),1,size(MHC,2)))';

%% 
range = 1:6;
tsevah = ['r', 'm', 'k', 'g', 'b'];

%% For IFN-gamma at 5 hours fit

for i = 1:5;

    
    fixed = [false true false]; %Last entry is for MHC mRNA halflife

    initparam = [1, gamma(i), 20]; %Last entry is for MHC mRNA halflife

    argin = {'GammaStop', '5'};
    
    
    [param r err] = mod_lsqcurvefit_v2(fixed, time(range), dMHC(i,range), @AnalyticMHC_v4, initparam, argin{:})
%     
    k1(i) = param(1);
    r1(i) = r(1);
    life(i) = param(3);
%     
%     
    %param = [k1', gamma(1:5)'];
            
    t = 0:168*60*60;
  
    figure(1)
    hold on
    plot((time/3600/24), dMHC(i,:),'o', 'markerfacecolor', tsevah(:,i), 'markeredgecolor', 'k', 'markersize', 20);
    plot((t/3600/24), AnalyticMHC_v4(param,t,argin{:}), '-', 'color', tsevah(:,i), 'linewidth', 4)
    set(gcf, 'color', 'w')
    set(gca, 'Fontsize', 35, 'xlim', [0 7], 'xgrid', 'on', 'ygrid', 'on', 'ylim', [1e4 2e6])
    xlabel('Time, (days)')
    ylabel('\Delta H-2K^b')
    legend('10nM IFN-\gamma', 'fit', '1nM', 'fit', '100pM', 'fit', '10pM', 'fit', '1pM', 'fit')
    title('Data fits-IFN-\gamma extinguished @ 5h')
    box on

    
      %y = AnalyticMHCWith5h_v1(param, time);
     %[R,P] = corrcoef(dMHC,y);
    
end


%% Start global fitting, keeping halflife similar for all - Prepare data in nice cell arrays
dMHC = (MHC-repmat(MHC(:,6),1,size(MHC,2)))';
dMHC = dMHC(1:5,:);
timeArray = repmat(time, size(dMHC,1),1);
dMHC = (mat2cell(dMHC,ones(size(dMHC,1),1),size(dMHC,2)))';
timeArray = (mat2cell(timeArray,ones(size(timeArray,1),1),size(timeArray,2)))';



%% prepare fitting functions in nice cell array

MHCFit1 = @(beta,time) AnalyticMHC_v4([beta(2) gamma(1) beta(1)],time,'GammaStop', '5')
MHCFit2 = @(beta,time) AnalyticMHC_v4([beta(3) gamma(2) beta(1)],time,'GammaStop', '5')
MHCFit3 = @(beta,time) AnalyticMHC_v4([beta(4) gamma(3) beta(1)],time,'GammaStop', '5')
MHCFit4 = @(beta,time) AnalyticMHC_v4([beta(5) gamma(4) beta(1)],time,'GammaStop', '5')
MHCFit5 = @(beta,time) AnalyticMHC_v4([beta(6) gamma(5) beta(1)],time,'GammaStop', '5')

MHCCell = {MHCFit1, MHCFit2, MHCFit3, MHCFit4 ,MHCFit5}

beta0 = [mean(life) k1]  %initial guestimate via non global fit
%% Fit...

[beta,r,J,Sigma,mse] = nlinmultifit(timeArray, dMHC, MHCCell, beta0);

%%  Plot
for i = 1:5;

    figure(1)
    hold on
    plot((time/3600/24), dMHC{i},'o', 'markerfacecolor', tsevah(:,i), 'markeredgecolor', 'k', 'markersize', 20);
    plot((t/3600/24), MHCCell{i}(beta,t), '-', 'color', tsevah(:,i), 'linewidth', 4)
    set(gcf, 'color', 'w')
    set(gca, 'Fontsize', 35, 'xlim', [0 7], 'xgrid', 'on', 'ygrid', 'on', 'ylim', [1e4 2e6],'yscale','log')
    xlabel('Time, (days)')
    ylabel('\Delta H-2K^b')
    legend('10nM IFN-\gamma', 'fit', '1nM', 'fit', '100pM', 'fit', '10pM', 'fit', '1pM', 'fit')
    title('Data fits-IFN-\gamma extinguished @ 5h')
    box on
end
	
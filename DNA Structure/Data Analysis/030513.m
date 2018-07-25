%% Load xml file with uniform Treg gates (in the future you won't need to load multiple times)

fpath='/Users/labuser/Desktop/Jen/Experiments/3:13/030213_AdTr WT v IL2KO/fcs files';

[CGData CompensationMatrix WorkSp groupInd gateInd] = LoadFACSfromFlowJoWorkspace_v4( fpath,'Group',3,'gate',4);


%% Overlay CD25 histograms for CD4+FoxP3+

xbins=linspace(0,5,100)
CD25_channel=4;

figure(1)

for i=1:size(CGData,2)

CD25(i).data=hist(log10(CGData(i).data(:,CD25_channel)),xbins);
CD25(i).name=CGData(i).name;

legend{i}=CGData(i).name
hold on
if floor(i/2)==i/2
plot(10.^xbins,CD25(i).data,'-','color', [0 0 1] , 'linewidth', 3)
else
    plot(10.^xbins,CD25(i).data,'-','color', [1 0 0], 'linewidth', 3)

end

hold off

end

set(gca,'xscale','log','yscale','lin','box','on', 'Fontsize', 16, 'Fontweight', 'bold')
set(gcf, 'color', 'w')
xlabel('IL-2R\alpha (a.u.)')
ylabel('Number of Cells')
title('Treg IL2R\alpha Distribution')

%% Compute total amount of CD25 in system for Tregs

integral=0;

for i=1:size(CGData,2)
    CD25(i).total=sum(10.^xbins.*CD25(i).data);
    [CD25(i).name ' ' num2str(CD25(i).total,3)]
end

%% Load XML file with uniform Adoptive transfer gates * for cleaner gates in order to look at the percent occupancy, look at the old gates (different between 24 and 48 hours due to the degree of CFSE dilution)
fpath='/Users/labuser/Desktop/Jen/Experiments/1:13/Treg Jaki AdTr_01172013/FoxP3 stained/fcs files_2';

[CGData CompensationMatrix WorkSp groupInd gateInd] = LoadFACSfromFlowJoWorkspace_v4( fpath,'Group',3,'gate',3);
%% Overlay CD25 histograms for CD4+FoxP3+

xbins=linspace(0,5,100)
%Number of bins is 200.  If you make this bigger, the plot lines get more
%jaggedy.  If you make it smaller, the line gets smoother
CD25_channel=4;

figure(1)

for i=1:size(CGData,2)

CD25(i).data=hist(log10(CGData(i).data(:,CD25_channel)),xbins);
CD25(i).name=CGData(i).name;

legend{i}=CGData(i).name
hold on
if floor(i/2)==i/2
plot(10.^xbins,CD25(i).data,'-','color', [0 0.7 0], 'linewidth', 3)
else
    plot(10.^xbins,CD25(i).data,'-','color', [1 0 0], 'linewidth', 3)

end

hold off

end

set(gca,'xscale','log','yscale','lin','box','on', 'Fontsize', 16, 'Fontweight', 'bold')
set(gcf, 'color', 'w')
xlabel('IL-2R\alpha (a.u.)')
ylabel('Number of Cells')
title('Teffector IL2R\alpha Distribution')



%% Compute total mount of CD25 in system for Teffs

integral=0;

for i=1:size(CGData,2)
    CD25(i).total=sum(10.^xbins.*CD25(i).data);
    [CD25(i).name ' ' num2str(CD25(i).total, 3)]
end


%% Plot total amount of CD25 in system

Time=[24 48];


Jaki_Reg=[3.28e+07 2.19e+07];
Vehicle_Reg=[1.95e+08 1.7e+08];



Jaki_Eff=[3.22e+06 2.5e+06];
Vehicle_Eff=[7.97e+06 2.15e+07];


Jaki_Rel=[Jaki_Reg./Jaki_Eff];

Vehic_Rel=[Vehicle_Reg./Vehicle_Eff];





figure()
hold on
plot(Time, Jaki_Reg, '--ro', 'linewidth', 2)
plot(Time, Vehicle_Reg, '--bo' ,'linewidth', 2)
plot(Time, Jaki_Eff, '-ro', 'linewidth', 2)
plot(Time, Vehicle_Eff, '-bo' ,'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'xscale', 'lin', 'yscale', 'log')
xlabel('Time, hrs')
ylabel('Integral(IL2R\alpha*No. of Cells)')
title('Total amount of IL2R\alpha in the System')
%%
x=[1 2];

figure()
subplot(2,2,1)
hold on
bar(Jaki_Reg, 0.4, 'r')
bar(Jaki_Eff, 0.3, 'b')
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'yscale', 'log', 'YLim', [10e5, 10e8])
ylabel('log CD25 fluorescence *No. of Cells')
title('Quantity of CD25 for Jaki')
box on
subplot(2,2,2)
hold on
bar(Vehicle_Reg, 0.4, 'r')
bar(Vehicle_Eff, 0.3, 'b')
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'yscale', 'log', 'YLim', [10e5, 10e8])
box on
ylabel('log CD25 fluorescence *No. of Cells')
title('Quantity of CD25 for Vehicle')
subplot(2,2,3)
hold on
bar(Jaki_Rel, 0.4, 'r')
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'yscale', 'log')
ylabel('log Treg/Teff')
title('Ratio CD25 in Treg v Teff - Jaki')
box on
subplot(2,2,4)
bar(Vehic_Rel, 0.4, 'b')
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'yscale', 'log')
ylabel('log Treg/Teff')
title('Ratio CD25 in Treg v Teff - Vehicle')
box on



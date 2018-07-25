%% Load xml file with uniform Treg gates (in the future you won't need to load multiple times)

fpath='/Users/labuser/Desktop/Jen/Experiments/3:13/030213_AdTr WT v IL2KO/fcs files';

[CGData CompensationMatrix WorkSp groupInd gateInd] = LoadFACSfromFlowJoWorkspace_v4( fpath)%,'Group',3,'gate',4);


%% Overlay CD25 histograms for CD4+FoxP3+ WT Tregs

xbins=linspace(0,5,500);


for i=1:size(CGData(1).ListofChannelsWithLabels,1)
    temp=strfind(CGData(1).ListofChannelsWithLabels(i),'CD25');
    if temp{1}>0
CD25_channel=i;
    end
end
CD25_channel

figure(1)

for i=1:size(CGData, 2)

CD25(i).data=hist(log10(CGData(i).data(:,CD25_channel)),xbins);
CD25(i).name=CGData(i).name;

legend{i}=CGData(i).name;
hold on
if floor(i/2)==i/2
plot(10.^xbins,CD25(i).data,'-','color', [0 0 1] , 'linewidth', 3)
else
    plot(10.^xbins,CD25(i).data,'-','color', [1 0 0], 'linewidth', 3)

end

hold off

end

set(gca,'xscale','log','yscale','lin','box','on', 'Fontsize', 16, 'Fontweight', 'bold', 'ylim', [0, 750])
set(gcf, 'color', 'w')
xlabel('IL-2R\alpha (a.u.)')
ylabel('Number of Cells')
title('Treg IL2R\alpha Distribution for 100ug K5')

%% Compute total amount of CD25 in system for Tregs WT

integral=0;

for i=1:size(CGData,2)
    CD25(i).total=sum(10.^xbins.*CD25(i).data);
    [CD25(i).name ' ' num2str(CD25(i).total,3)]
end

%% Load XML file with uniform Adoptive transfer gates * for cleaner gates in order to look at the percent occupancy, look at the old gates (different between 24 and 48 hours due to the degree of CFSE dilution)
fpath='/Users/labuser/Desktop/Jen/Experiments/3:13/030213_AdTr WT v IL2KO/fcs files';

[CGData CompensationMatrix WorkSp groupInd gateInd] = LoadFACSfromFlowJoWorkspace_v4( fpath,'Group',3,'gate',3);
%% Overlay CD25 histograms for CD4+FoxP3+ KO Tregs

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



%% Compute total mount of CD25 in system for KO Tregs

integral=0;

for i=1:size(CGData,2)
    CD25(i).total=sum(10.^xbins.*CD25(i).data);
    [CD25(i).name ' ' num2str(CD25(i).total, 3)]
end


%% Load XML file with uniform Adoptive transfer gates * for cleaner gates in order to look at the percent occupancy, look at the old gates (different between 24 and 48 hours due to the degree of CFSE dilution)
fpath='/Users/labuser/Desktop/Jen/Experiments/3:13/030213_AdTr WT v IL2KO/fcs files';

[CGData CompensationMatrix WorkSp groupInd gateInd] = LoadFACSfromFlowJoWorkspace_v4( fpath,'Group',3,'gate',3);
%% Overlay CD25 histograms for Effectors
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
plot(10.^xbins,CD25(i).data,'-','color', [0 0 1], 'linewidth', 3)
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



%% Compute total mount of CD25 in system for effectors

integral=0;

for i=1:size(CGData,2)
    CD25(i).total=sum(10.^xbins.*CD25(i).data);
    [CD25(i).name ' ' num2str(CD25(i).total, 3)]
end
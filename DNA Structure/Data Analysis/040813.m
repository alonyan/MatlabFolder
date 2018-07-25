%% Load xml file

fpath='/Users/labuser/Desktop/Jen/Experiments/3:13/031613_WTKO_Cotransfer/fcs files';

[CGData CompensationMatrix WorkSp groupInd gateInd] = LoadFACSfromFlowJoWorkspace_v4( fpath)%,'Group',3,'gate',4);


%% Overlay CFSE histograms

xbins=logspace(0,5,10000);


for i=1:size(CGData(1).ListofChannelsWithLabels,1)
    temp=strfind(CGData(1).ListofChannelsWithLabels(i),'CFSE');
    if temp{1}>0
CFSE_channel=i;
    end
end
CFSE_channel

figure(1)

for i=1:size(CGData, 2)

CFSE(i).data=hist((CGData(i).data(:,CFSE_channel)),xbins);
CFSE(i).name=CGData(i).name;

legend{i}=CGData(i).name;
hold on
if floor(i/2)==i/2
plot(xbins,cumsum(CFSE(i).data),'-','color', [0 0 1] , 'linewidth', 3)
else
    plot(xbins,cumsum(CFSE(i).data),'-','color', [1 0 0], 'linewidth', 3)

end

hold off

end

set(gca,'xscale','log','yscale','log','box','on', 'Fontsize', 16, 'Fontweight', 'bold','XLim', [10e2, 10e4], 'YLim', [0, 10e4])
set(gcf, 'color', 'w')
xlabel('CFSE (a.u.)')
ylabel('Number of Cells')
title('100ug K5')

%% %Plot cumsum WT v KO

xbins=logspace(0,5,1000);


for i=1:size(CGData(1).ListofChannelsWithLabels,1)
    temp=strfind(CGData(1).ListofChannelsWithLabels(i),'CFSE');
    if temp{1}>0
CFSE_channel=i;
    end
end
CFSE_channel

figure(1)

for i=1:size(CGData, 2)

CFSE(i).data=hist((CGData(i).data(:,CFSE_channel)),xbins);
CFSE(i).name=CGData(i).name;

legend{i}=CGData(i).name;
hold on
if floor(i/2)==i/2
plot(cumsum(CFSE(i).data),cumsum(CFSE(i/2).data),'-' , 'linewidth', 3)
plot(cumsum(CFSE(i).data),cumsum(CFSE(i).data),'-','color', [0 0 0] , 'linewidth', 3)

end

hold off

end

set(gca,'xscale','log','yscale','log','box','on', 'Fontsize', 16, 'Fontweight', 'bold', 'XLim', [0, 10e4], 'YLim', [0, 10e4])
set(gcf, 'color', 'w')
xlabel('Cumsum CFSE (WT)')
ylabel('Cumsum CFSE (KO)')
title('LPS')

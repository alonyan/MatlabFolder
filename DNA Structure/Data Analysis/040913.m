%% Load xml file

fpath='/Users/labuser/Desktop/Jen/Experiments/3:13/031613_WTKO_Cotransfer/fcs files/';


[CGData_WT CompensationMatrix WorkSp groupInd gateInd] = LoadFACSfromFlowJoWorkspace_v4( fpath,'Group',5,'gate',2); %CFSE

[CGData_KO CompensationMatrix WorkSp groupInd gateInd] = LoadFACSfromFlowJoWorkspace_v4( fpath,'Group',5,'gate',3); %CTV

%% Overlay CFSE histograms

xbins=logspace(0,5,10000);


for i=1:size(CGData_WT(1).ListofChannelsWithLabels,1)
    temp=strfind(CGData_WT(1).ListofChannelsWithLabels(i),'CFSE');
    if temp{1}>0
CFSE_channel=i;
    end
end
CFSE_channel


for i_2=1:size(CGData_KO(1).ListofChannelsWithLabels,1)
    temp=strfind(CGData_KO(1).ListofChannelsWithLabels(i_2),'CTV');
    if temp{1}>0
CTV_channel=i_2;
    end
end
CTV_channel

figure(1)

for i=1:size(CGData_WT)
for i_2=1:size(CGData_KO)

CFSE(i).data=hist((CGData_WT(i).data(:,CFSE_channel)),xbins);
CFSE(i).name=CGData_WT(i).name;
CTV(i_2).data=hist((CGData_KO(i_2).data(:,CTV_channel)),xbins);
CTV(i_2).name=CGData_KO(i_2).name;

legend{i}=CGData_WT(i).name;
legend{i_2}=CGData_KO(i_2).name;

hold on
plot(xbins,cumsum(CFSE(i).data),'-','color', [0 0 1] , 'linewidth', 3)
plot(xbins,cumsum(CTV(i_2).data),'-','color', [1 0 0], 'linewidth', 3)

end
end

set(gca,'xscale','log','yscale','log','box','on', 'Fontsize', 16, 'Fontweight', 'bold')
set(gcf, 'color', 'w')
xlabel('Fluoresence (a.u.)')
ylabel('Number of Cells')
title('100ug K5')

%% %Plot cumsum WT v KO

xbins=logspace(0,5,1000);


for i=1:size(CGData_WT(1).ListofChannelsWithLabels,1)
    temp=strfind(CGData_WT(1).ListofChannelsWithLabels(i),'CFSE');
    if temp{1}>0
CFSE_channel=i;
    end
end
CFSE_channel

for i_2=1:size(CGData_KO(1).ListofChannelsWithLabels,1)
    temp=strfind(CGData_KO(1).ListofChannelsWithLabels(i_2),'CTV');
    if temp{1}>0
CTV_channel=i_2;
    end
end
CTV_channel

figure(1)

for i=1:size(CGData_WT, 2)
for i_2=1:size(CGData_KO)
    
CFSE(i).data=hist((CGData_WT(i).data(:,CFSE_channel)),xbins);
CFSE(i).name=CGData_WT(i).name;
CTV(i_2).data=hist((CGData_KO(i_2).data(:,CTV_channel)),xbins);
CTV(i_2).name=CGData_KO(i_2).name;

legend{i}=CGData_WT(i).name;
legend{i_2}=CGData_KO(i_2).name;

hold on
plot(cumsum(CFSE(i).data),cumsum(CTV(i_2).data),'-' , 'linewidth', 3)
plot(cumsum(CTV(i_2).data),cumsum(CTV(i_2).data),'-','color', [0 0 0] , 'linewidth', 3)

end
end


set(gca,'xscale','log','yscale','log','box','on', 'Fontsize', 16, 'Fontweight', 'bold')
set(gcf, 'color', 'w')
xlabel('Cumsum CFSE (WT)')
ylabel('Cumsum CTV (KO)')
title('100ug K5')



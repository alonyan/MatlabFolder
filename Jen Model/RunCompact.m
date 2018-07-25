%% % Parameter sensitivity - first, vary HS kon
clear all;
close all;

%%

%% 
%Initial parameters
close all
clear gamma;
clear TSPAN;
steps = 40;
for i=0:steps;
parameters.nA = 6.23e23;                  %Avogadro # 
parameters.vol = 2e-4;                    %L assay volume
parameters.ncell = 3.5e4;                 %Number of cells seeded in experiment
parameters.EC50 = 3e-12;
parameters.IFNgR = (1000*ncell)/(nA*vol);  %M Amount of IFNgR
parameters.IFNg = 10e-9;                  %M Initial amount of IFNg (before wash)
parameters.HS = (1E4*ncell)/(nA*vol);     %M Amount of HS

parameters.nA = 6.23e23;             %Avogadro no.
parameters.kon = 7.3e6/nA;           %M-1*s-1 IFNg-IFNgR association
parameters.koff = 5e-3;              %s-1 IFNg-IFNgR dissociation

parameters.HSkoff = 5*10^(-(3+i/10));         %s-1 IFNg-HS debinding - ADJUSTED FOR 33.5pM KD
parameters.HSkon = parameters.HSkoff./33.5e-12/nA;           %M-1*s-1 IFNg-HS association - ADJUSTED FOR 33.5pM KD

parameters.kendo = 1/(10*60);             %s-1 Rate of IFNgRc endocytosis
parameters.krec =  parameters.kendo;            %s-1 Rate of IFNgR repopulating --> compensates for loss of IFNgR during endocytosis
parameters.kcyc = log(2)/(20*60*60); %s-1 Rate of cell cycling
%parameters.kcyc = 0;

%
[gamma(i+1,:), TSPAN]=CompactModelGamma(parameters);

%Calculate pSTAT1

pSTAT1(i+1,:) = 1./(1+EC50./(gamma(i+1,:)./nA));
end;



%%
TSPAN2 = 18050:50:6e5

set(gcf,'Position',[400 400 500 500],'color','w')
hold all
h = plot(TSPAN2/86400,pSTAT1(:,362:end)*100, '-', 'linewidth', 1.5);
    HSkoff = 5*10.^([-3:-0.1:-3-0.1*steps]);

    tzeva = makeColorMap([0 1 0], [0 0 1],steps+1);
    
    Ne = 31;
    Ns = 25;
    tzeva(Ns:Ne,:) = makeColorMap([1 0.4 0], [1 0 0],[1 0.4 0],Ne-Ns+1);
    
    for i=1:length(1:5:steps+1)
    YTickl{i} = sprintf('%.2g', HSkoff(1+(i-1)*5));
    end
    
for i=1:steps+1
set(h(i),'color', tzeva(i,:));
end;
colormap(tzeva)
cb = colorbar;

set(gca, 'Fontsize', 20,'xlim', [0 4])
ylabel('pSTAT1, (% of max)')
xlabel('Time, (day)')
format short;

set(cb,'ydir','reverse', 'YTick',[1:5:steps+1],'YTicklabel',YTickl, 'Fontsize', 12)

%legend('[]')

box on

%%
save('/Users/Alonyan/GoogleDrive/IFNg-PS Paper/Alon/ModelFigs.mat')
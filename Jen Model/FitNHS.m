%%   parameters
close all
clear gamma;
clear gammaMeasuredparam;
clear TSPAN;

parameters.nA = 6.23e23;                  %Avogadro # 
parameters.vol = 2e-4;                    %L assay volume
parameters.ncell = 3.5e4;                 %Number of cells seeded in experiment
parameters.EC50 = 3e-12;
parameters.IFNgR = (2000*parameters.ncell)/(parameters.nA*parameters.vol);  %M Amount of IFNgR
parameters.IFNg = 10e-9;                  %M Initial amount of IFNg (before wash)
parameters.HS = (5000*parameters.ncell)/(parameters.nA*parameters.vol);     %M Amount of HS

parameters.nA = 6.23e23;             %Avogadro no.
parameters.kon = 7.3e6/parameters.nA;           %M-1*s-1 IFNg-IFNgR association
parameters.koff = 5e-3;              %s-1 IFNg-IFNgR dissociation

parameters.HSkoff = 3.7222e-05;         %s-1 IFNg-HS debinding - ADJUSTED FOR 33.5pM KD
parameters.HSkon = parameters.HSkoff./340e-12/parameters.nA;           %M-1*s-1 IFNg-HS association - ADJUSTED FOR 33.5pM KD

%parameters.kendo = 1/(10*60);             %s-1 Rate of IFNgRc endocytosis
%parameters.krec =  parameters.kendo;            %s-1 Rate of IFNgR repopulating --> compensates for loss of IFNgR during endocytosis
parameters.kcyc = log(2)/(24*60*60); %s-1 Rate of cell cycling
%parameters.kcyc = 0;

%
[gammaMeasuredparam(1,:), TSPAN]=CompactModelGamma(parameters);

%% Calculate pSTAT1
tim = 5.02:0.001:200;
pSTAT1Measuredparam = pSTAT1MeasuredparamFit(5000, tim);

% measured values
%TSPAN2 = 18050:50:6e5

%axes('Position',[0.65 0.78 0.25 0.18])

h = plot(tim,pSTAT1Measuredparam, '-', 'linewidth', 1.5);
hold on;
   % tzeva = makeColorMap([0 1 0], [0 0 1],steps+1);
    
   % Ne = 30;
   % Ns = 25;
   % tzeva(Ns:Ne,:) = makeColorMap([1 0.5 0], [1 0 0],[1 0.5 0],Ne-Ns+1);
    

    %YTickl{1} = [YTickl{1} ' - receptor off-rate'];
%set(h(1),'color', tzeva(26,:));



%set(gca, 'Fontsize', 15,'xlim', [0 5],'ylim', [0 60],'xtick',[0:1:7])
ylabel('pSTAT1, (% of max)')
xlabel('Time, (h)')
format short;


%legend('[]')

time4 = [0 5 6 7 19 24 29.5 43 48 53.5 67 72 91 96]; %h from expt. "long term pSTAT1_02122016.m"
 
pSTAT1Meas = [558 6185 2610 1265 1320 1438 1823 1706 1594 1214 808  837 622 353
          558 6185 2139 1286 1278 1561 1377 987  1389 1031 1101 523 617 445
          558 6185 2231 1238 1467 1950 1466 1326 1257 998  760  700 681 510]./ 6185;
      
mpSTAT1 = mean(pSTAT1Meas);
stdSTAT1 = std(pSTAT1Meas);

hh = errorbar(time4(4:end),mpSTAT1(4:end)*100,stdSTAT1(4:end)*100,'ko');shg;
set(hh,'linewidth', 1.5)
box on

     set(gcf, 'PaperPositionMode','auto')

%% unweighted fit
%lsqcurvefit(@HillFunction,BETA0,10^12*C_IL2(range),DataToFit);

Nhs = lsqcurvefit(@pSTAT1MeasuredparamFit, 5000, time4(4:end), mpSTAT1(4:end)*100)
%% weighted fit
BETA = nlinfitWeight2(time4(4:end), mpSTAT1(4:end)*100,@pSTAT1MeasuredparamFit,5000, 100*stdSTAT1(4:end), [])
%%
Nhs = BETA.beta
err_Nhs = BETA.errBeta
%%
%% Calculate pSTAT1
tim = 5.02:0.001:200;
pSTAT1Measuredparam = pSTAT1MeasuredparamFit(Nhs, tim);

% measured values
%TSPAN2 = 18050:50:6e5

%axes('Position',[0.65 0.78 0.25 0.18])

h = plot(tim,pSTAT1Measuredparam, '-', 'linewidth', 1.5);
hold on;
   % tzeva = makeColorMap([0 1 0], [0 0 1],steps+1);
    
   % Ne = 30;
   % Ns = 25;
   % tzeva(Ns:Ne,:) = makeColorMap([1 0.5 0], [1 0 0],[1 0.5 0],Ne-Ns+1);
    

    %YTickl{1} = [YTickl{1} ' - receptor off-rate'];
%set(h(1),'color', tzeva(26,:));



%set(gca, 'Fontsize', 15,'xlim', [0 5],'ylim', [0 60],'xtick',[0:1:7])
ylabel('pSTAT1, (% of max)')
xlabel('Time, (h)')
format short;


%legend('[]')

time4 = [0 5 6 7 19 24 29.5 43 48 53.5 67 72 91 96]; %h from expt. "long term pSTAT1_02122016.m"
 
pSTAT1Meas = [558 6185 2610 1265 1320 1438 1823 1706 1594 1214 808  837 622 353
          558 6185 2139 1286 1278 1561 1377 987  1389 1031 1101 523 617 445
          558 6185 2231 1238 1467 1950 1466 1326 1257 998  760  700 681 510]./ 6185;
      
mpSTAT1 = mean(pSTAT1Meas);
stdSTAT1 = std(pSTAT1Meas);

hh = errorbar(time4(4:end),mpSTAT1(4:end)*100,stdSTAT1(4:end)*100,'ko');shg;
set(hh,'linewidth', 1.5)
box on

     set(gcf, 'PaperPositionMode','auto')

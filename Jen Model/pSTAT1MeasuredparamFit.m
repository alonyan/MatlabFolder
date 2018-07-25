function pSTAT1Measuredparam =pSTAT1MeasuredparamFit(HS, tim)

parameters.nA = 6.23e23;                  %Avogadro # 
parameters.vol = 2e-4;                    %L assay volume
parameters.ncell = 3.5e4;                 %Number of cells seeded in experiment
parameters.EC50 = 3e-12;
parameters.IFNgR = (2000*parameters.ncell)/(parameters.nA*parameters.vol);  %M Amount of IFNgR
parameters.IFNg = 10e-9;                  %M Initial amount of IFNg (before wash)
parameters.HS = (HS*parameters.ncell)/(parameters.nA*parameters.vol);     %M Amount of HS

parameters.nA = 6.23e23;             %Avogadro no.
parameters.kon = 7.3e6/parameters.nA;           %M-1*s-1 IFNg-IFNgR association
parameters.koff = 5e-3;              %s-1 IFNg-IFNgR dissociation

parameters.HSkoff = 3e-05;         %s-1 IFNg-HS debinding - ADJUSTED FOR 33.5pM KD
parameters.HSkon = parameters.HSkoff./340e-12/parameters.nA;           %M-1*s-1 IFNg-HS association - ADJUSTED FOR 33.5pM KD

%parameters.kendo = 1/(10*60);             %s-1 Rate of IFNgRc endocytosis
%parameters.krec =  parameters.kendo;            %s-1 Rate of IFNgR repopulating --> compensates for loss of IFNgR during endocytosis
parameters.kcyc = log(2)/(24*60*60); %s-1 Rate of cell cycling
%parameters.kcyc = 0;

%
[gammaMeasuredparam(1,:), TSPAN]=CompactModelGamma(parameters);

gammaMeasuredparam = interp1(TSPAN./3600, gammaMeasuredparam, tim);
%Calculate pSTAT1

pSTAT1Measuredparam = 100*1./(1+parameters.EC50./(gammaMeasuredparam(1,:)./parameters.nA));

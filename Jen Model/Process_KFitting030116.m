%% % Parameter sensitivity - first, vary HS kon
clear all;
close all;
tsevah = ['r', 'y', 'g', 'b', 'c'];

%% 
%Initial parameters
nA = 6.23e23;                  %Avogadro # 
vol = 2e-4;                    %L assay volume
ncell = 3.5e4;                 %Number of cells seeded in experiment
EC50 = 3e-12;
IFNgR = (3e3*ncell)/(nA*vol);  %M Amount of IFNgR
IFNg = 10e-9;                  %M Initial amount of IFNg (before wash)
HS = (1e4*ncell)/(nA*vol);     %M Amount of HS

parameters.nA = 6.23e23;             %Avogadro no.
parameters.kon = 7.3e6/nA;           %M-1*s-1 IFNg-IFNgR association
parameters.koff = 5e-3;              %s-1 IFNg-IFNgR dissociation
parameters.HSkon = 4e5/nA;         %M-1*s-1 IFNg-HS association - ADJUSTED FOR 5fM KD
parameters.HSkoff = 1.5e-5;         %s-1 IFNg-HS debinding - ADJUSTED FOR 5fM KD    
parameters.kendo = 1/(10*60);             %s-1 Rate of IFNgRc endocytosis
parameters.krec =  parameters.kendo;            %s-1 Rate of IFNgR repopulating --> compensates for loss of IFNgR during endocytosis
parameters.kcyc = log(2)/(20*60*60); %s-1 Rate of cell cycling
%parameters.kcyc = 0;


%%
%Time
TSPAN = [0 18000];                %Timespan of model run   

%Function
EndParam = [];
fun = @(t,x) ModelJen2(t,x,parameters);
[T,X]=ode45(fun,TSPAN,[IFNg HS 0 IFNgR 0].*nA); %free gamma, HS, HSc, IFNgR, IFNgRc
EndParam = [EndParam; 0 X(end,2:5)];
EndParam = EndParam./nA;
TSPAN = [0:50:6e5];   %Timespan of model run
gamma = [];
[T,X]=ode45(fun,TSPAN,[EndParam.*nA]);  %free gamma, HS, HSc, IFNgR, IFNgRc
gamma = [gamma; X(:,1)'];

pSTAT1 = 1./(1+EC50./(gamma./nA));

%% Determine mRNA and protein
%set time
TSPAN = [0:50:6e5];

%lsqcurvefit(@(k) solveModelJen(t,),k0)

%%

[mRNA]  = mRNAsolveModelJen(k0 ,TSPAN,pSTAT1);
plot(TSPAN/86400,mRNA)
shg
%%

h2k1 = [0 3.6169 4.9014 3.8167]; %mRNA from sequencing data, log2fch
h2k1_fold = 2.^(h2k1);

time2 =[0 0.9792 2.0000 3.7917].*86400;%mRNA time


%kb = [191 1973 2465 821 768 390 184]; %protein data from same source as above

%%
k0 = .0013;

k = nlinfit(time2,h2k1_fold,@(k,time2) mRNAsolveModelJen(k,time2,interp1(TSPAN,pSTAT1,time2)),k0);

plot(time2,h2k1_fold,'o',TSPAN,mRNAsolveModelJen(k ,TSPAN,pSTAT1)); shg
%k = nlinfitWeight2(time2,h2k1_fold,@(k0,time2) mRNAsolveModelJen(k0,time2,interp1(TSPAN,pSTAT1,time2)),k0, errors)
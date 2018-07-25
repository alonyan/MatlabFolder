% Parameter sensitivity
clear all;
close all;

ListOfVariables={'[IFN-g]free (Mol)','#HS','#HS-IFNg','#IFNgR','#IFNgR-IFNg','#Total Gamma','pSTAT1','#mhc mRNA/cell','#MHC proteins/cell'};

%Initial parameters
nA = 6*10^23;
volume = 200*10^-6;

EC50 = 3e-12;   %EC50 for IFN-g in Mol
IFNgR = 2e3/nA/volume;  %number of IFNgR per cell
HS = 1e5/nA/volume;    %number of HS molecules per cell

parameter_scan=10.^(-2:1:2);    %Fold range for parameter scan
IFNg = EC50*parameter_scan;    %M Initial amount of IFNg (before wash)

parameters.nA = 6.23e23;             %Avogadro number
parameters.ncell = 3.5e4;            %Number of cells seeded in experiment
parameters.volume = 200e-6;               %assay volume (in liters)
parameters.kon = 7.3e6/nA;           %M-1*s-1 IFNg-IFNgR association
parameters.koff = 5e-3;              %s-1 IFNg-IFNgR dissociation
parameters.HSkon = 2.5e8/nA;         %M-1*s-1 IFNg-HS association - Diffusion limited
parameters.HSkoff = 50e-4;          %s-1 IFNg-HS debinding - ADJUSTED FOR 50fM KD
parameters.k_endocytosis = 1e-2;             %s-1 Rate of IFNgRc endocytosis = consumption of IFN-g after binding
                                   %Also rate of IFNgR recycling --> compensates for loss of IFNgR during endocytosis
parameters.k_cellcycle = log(2)/(20*60*60); %s-1 Rate of cell cycling
parameters.cellcapacity = 1e6;   %Maximal number of cells in the culture (implement Gompertz law to saturate cell proliferation

parameters.mhc_mRNA_decay = 1/(25*60*60); %Rate of mhc mRNA decay (1/s)
parameters.MHC_protein_decay = 1/(3*60*60); %Rate of MHC protein decay (1/s)
parameters.mhc_transcription = 1; %Rate of mhc transcription (1/s)
parameters.MHC_translation = 0.1021; %Rate of MHC translation (#/s)

%%
time_wash=5;     %Exposure time to IFN-g (in hrs)
TSPAN1 = (0:0.1:time_wash)*3600;                %Timespan of IFNg exposure
TSPAN2 = (time_wash:4:7*24)*3600;   %Timespan after IFNg exposure (up to 7 days)
TSPAN=[TSPAN1(1:end-1) TSPAN2];

Model = @(t,x) RateMatrix_WithCellProliferation_v2(t,x,parameters);
%%
for i = 1:length(parameter_scan)
    
    InitialConditions_1=[IFNg(i)*nA HS*nA 0 IFNgR*nA 0]; %[free gamma], #HS, #HSc, #IFNgR, #IFNgRc, #Cells
    [T1,X1]=ode45(Model,TSPAN1,InitialConditions_1);
    
    InitialConditions_2=[0 X1(end,2:5)];
    [T2,X2]=ode45(Model,TSPAN2-max(TSPAN1),InitialConditions_2);  %free gamma, HS, HSc, IFNgR, IFNgRc
    
    for j=1:5
        output(:,j,i)=[X1(1:end-1,j);X2(:,j)];
    end
    
    % Determine pSTAT1 output
    gamma(:,i)=[X1(1:end-1,1);X2(:,1)];
    pSTAT1(:,i) = 1./(1+EC50./gamma(:,i));
    output(:,7,i)=100./(1+EC50./output(:,1,i)); %Beware: percentages in output
        output(:,6,i)=output(:,1,i)+output(:,3,i)+output(:,5,i); %Beware: percentages in output

    %% Determine mRNA and protein (outputs 8 and 9)

    conversion=@(t,x) GeneExpression(t,x,TSPAN,pSTAT1(:,i),parameters);
    [T,Y]=ode45(conversion,TSPAN,[1 1000]);
    output(:,8,i) = Y(:,1);
    output(:,9,i) = Y(:,2);
end





%%Display
figure(1)
set(gcf,'Position',[100 100 1200 800],'color','w')
hold all

for plotted_variable=1:9;
    
subplot(3,3,plotted_variable)
hold all
for i=1:length(parameter_scan)
    couleur(i,:)=[i/length(parameter_scan) 0 1-i/length(parameter_scan)];
    plot(TSPAN/24/3600,output(:,plotted_variable,i),'color',couleur(i,:),'LineWidth',2)
end
xlabel('Time (days)')
ylabel(ListOfVariables{plotted_variable})
if plotted_variable<7
    set(gca,'box','on','yscale','log')
else    
    set(gca,'box','on','yscale','lin')
end

end

%%%%%%%%%%%%%%%%%
%%B16-OTI Model%%
%%%%%%%%%%%%%%%%%
%%JEO - Author%%%
%%%L.U.-9.7.13%%%

%Total Antigen = Density of Ag per cell*No. of tumor cells
%Density of Ag per cell = Quantity of MHC*Fraction of MHC occupied by Ag(Ova)
%Total T cells = Number added to culture at T0
%Probability of activation given a certain Total antigen = %CD69+

%Define Initial Parameters

AgD=1; %Antigen Density = Scale of 0-1, represented as the fraction of a cell's MHC molecules expressing Ova.
InitMHC=1; %Initial quantity of MHC on cell surface relative to the baseline (10e3)
B16=1; %Number of B16 seeded relative to the max - (max is 100k)
Agicity=(AgD*InitMHC)*B16; %Total antigenicity is determined by the fraction of MHC molecules bound by Ova times the number of B16 cells.

OTI=1; %Number of OTI precursors added relative to the max - (max is 10e5)
pAct=[0:1];

%Define how antigenicity alters probability of a T cell becoming
%activated. Fit CD69 experimental data and use that
%function to describe Antigenicity.

if Agicity <=0.001
    pAct=0; 
end
if Agicity == 0.01
    pAct=0.1;
end
if (0.01 < Agicity) && (Agicity >= 0.1)
    pAct=0.25;
end
if  (0.1 < Agicity) && (Agicity >=0.65)
    pAct=0.3;
end
if (0.65 < Agicity) && (Agicity >=1)
    pAct=0.4;
end

Active_OTI=OTI*pAct; %The fraction of OT-I that are activated based on the probability of activation pAct

if Active_OTI <=0.2
    MHC=InitMHC*1000
else MHC=InitMHC*1
end


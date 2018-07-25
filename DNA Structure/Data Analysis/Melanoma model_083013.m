%%%IFN-gamma, OT-1, B16 model development%%%
%%%8.30.13%%%

%%%Assumptions%%%
% 1.) IFN-gamma is produced by activated T cells
% 2.) The quantity of IFN-gamma is crucial to promote further T cell activation
% and tumor clearance
% 3.) The amount of IFN-gamma produced depends on:
        % a.) The initial # of CD8 precursors
        % b.) The quantity of antigen, which is given by:
                % i.)  Ag presentation per tumor cell
                % ii.) # of tumor cells
% 4.)  IFN-gamma feeds back on CD8 T cells to promote productive T
%cell-tumor interactions and subsequent killing.
% 5.)  IFN-gamma feeds back on CD8 T cells to promote apoptosis following
% activation.
% 6.)  IFN-gamma feeds back onto B16 cells to promote MHC expression and Ag
% presentation 
% 7.)  IFN-gamma feeds back onto B16 cells to promote apoptosis.
% 8.)  Sensing IFN-gamma made by T cells promotes expression of IFN-gamma
% receptor & increases sensitivity to the cytokine.
% 9.)  Sensing IFN-gamma by B16 cells promotes expression of IFN-gamma
% receptor & increases sensitivity.
% 10.) After activation, T cells expand exponentially.
% 11.) B16 tumor cells grow exponentially.
% 12.) There are 2 possible outcomes, either the tumor is regressed or
% outgrows.  

%%%Crucial Parameters%%%
% 1.)  T(t) = tumor cell population at time, t
% 2.)  L(t) = CD8 T lymphocyte population at time, t
% 3.)  A(t) = concentration of antigen at time, t
% 4.)  g(t) = concentration of IFN-gamma in the media at time, t

%%%Equations%%%
% 1.)  Tumor cell growth = growth-death
% 2.)  CD8+ lymphocyte growth = growth-death
% 3.)  Accumulation of IFN-gamma = production - consumption

%%

%Create cell array
Cells = [100000, 3]; %Start of death, %Cause of death, %End of life

%Define parameters & initial players
CD8 = 100000; %Initial number CD8s added to culture
B16 = 250000; %Number of seeded B16s
Ag = 1.2e13; %Initial number of Ova molecules added to the culture
M = 100; %Initial number of MHC (H-2Kb) molecules on B16 cell surface at T0
gT = 5.1e-1; %growth rate of the tumor (unit is per day)
dT = 
gL = 
dL = 2e-2; %death rate of the CD8 T cell (unit is per day)







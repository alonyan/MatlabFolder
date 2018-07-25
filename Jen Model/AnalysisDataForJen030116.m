%%
fpath = '/Users/Alonyan/Google Drive/Experiments/IL2 screening/ScreeningIL2_280715'

%%

MixTop{1,:} = LoadFACSfromFlowJoWorkspace_v6(fpath, 'GroupInd', 8, 'GateInd', 1,'NoDemonstration');




%% Lets look at beads
LinearRange = 150
proc_PEBeads = HistAsinh3(Beads, 'Tag', 'APC', 'ProcDataIn', 'Nbins', 400,'LinearRange',LinearRange);

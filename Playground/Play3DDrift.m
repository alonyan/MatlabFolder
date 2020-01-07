%% This script loads the raw image stacks, creates SAR, makes drift correction, creates 2d EDoF projections,
%%makes a new MD for these, run a batch PIV analysis for the sequence and
%%do post analysis
BaseStr = regexprep([char(ispc.*'Z:\Images2019\') char(isunix.*'/RazorScopeData/RazorScopeImages/')],char(0),'');
Usr = 'Alon';
Project = 'CorneaHSV';
Dataset = 'Infection48hHwithOUT_TNF_Region_2019Nov19';
acquisition = 3;

%% Get MD of raw data
acqname = ['acq_' num2str(acquisition)];
fpath = [BaseStr Usr filesep Project filesep Dataset filesep acqname];
MD=Metadata(fpath);
Wells = unique(MD.getSpecificMetadata('Position'),'stable');
frames = unique(cell2mat(MD.getSpecificMetadata('frame')));
Channels = MD.unique('Channel');
%%
MD.CalculateDriftCorrection3D(Wells(1),'allToOne',true, 'resize', 0.25)



%%
frames = unique(cell2mat(MD.getSpecificMetadata('frame','acq','acq_3')));

DataPre = stkread(MD,'Channel',Channel, 'flatfieldcorrection', false, 'frame', frames(end),'resize', 0.25,'acq', 'acq_3');

DataPost = stkread(MD,'Channel',Channel, 'flatfieldcorrection', false, 'frame', 1,'resize', 0.25,'acq', 'acq_4');


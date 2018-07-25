addpath(genpath('/Users/oleg/Documents/MATLAB/General Utilities'));
addpath(genpath('/usr/local/Cellar/openslide'));
addpath(genpath('/Users/oleg/Documents/MATLAB/openslide-matlab-master'));
addpath(genpath('/Users/oleg/Documents/MATLAB/OpenSlideProject'));
%%
openslide_load_library

%% set PathNchannels structure
clear chanName
MainFPath = '/Users/Alonyan/Documents/School/Experiments/Microscopy Data/InVivo/ALON DAPI 2015.03.15 NP/';
fname = '1M05.mrxs'
PathNchannels(1).fpath = [MainFPath 'ALON 647 2015.03.20 NP/' fname];
PathNchannels(1).chanName = '647-DDAO';
PathNchannels(2).fpath = [MainFPath 'ALON DAPI 2015.03.15 NP/' fname];
PathNchannels(2).chanName = 'DAPI';
PathNchannels(3).fpath = [MainFPath 'ALON FITC 2015.03.15 NP/1M05_15.03.2015_18.54.59.mrxs'];
PathNchannels(3).chanName = 'FITC-pSTAT5';
PathNchannels(4).fpath = [MainFPath 'ALON TRITC 2015.03.17 NP/' fname];
PathNchannels(4).chanName = 'TRITC-foxp3';

%%
FigHdl = OpenSlideGUI_v5(PathNchannels);
%%
ImData = guidata(FigHdl); %get data



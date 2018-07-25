% load from structure

TI_0_060806 = LoadMultipleCorrFunc_v2({TI_0a_2912.correlation TI_0b_2912.correlation TI_0c_2912.correlation TI_0d_2912.correlation}, 'Rejection', 4, 'Range', [2e-4 1e-3], 'ErrorEstimateType', 'Ratio to plateau');

% load from files

TAE_noise = LoadMultipleCorrFunc_v2( '\\Fcs1-roman\D\Experiments\280806\', {'TAE1x'}, 'Rejection', 4, 'Range', [2e-4 1e-3], 'ErrorEstimateType', 'Ratio to plateau');

% extract

TI_5_060806 = ExtractWithoutNoiseStructures_v3(TI_5_060806.correlation, TAE_noise, 'Average', [8e-4 2e-3], 'Rh6G calibration', {Rh_1701a_060806 Rh_1701a_060806 30000 [0.002 1000] 'Selection'}, 'Create Model', {'diff3D'})
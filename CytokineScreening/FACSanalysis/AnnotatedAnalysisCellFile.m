%% An example of processing FACS measurements: here experiments on auto/paracrine signalling on 13/07/11

% Provide below paths to data and processing files: remember about the file
% separator differences ('/' vs '\')between Mac and PC platforms: use
% 'filesep' if not sure
fpath = 'D:\Oleg\Experiments\MSKCC\20110713_AutoParaCrine'  % provide here a correct path to data files
cd  'D:\Oleg\Matlab Programming\FACSanalysis'  % provide here  a correct path to my processing files 

%% Start loading files using LoadFACSfromFlowJoWorkspace_v4: 
% learn  the function description and its options with 
% > help LoadFACSfromFlowJoWorkspace_v4
% command

% I usually firstrun the function with only the PATH argument to see all of
% the groups and the gates and pick the needed group and the gates from the
% prompt
Dilute_5CC7 = LoadFACSfromFlowJoWorkspace_v4(fpath)

%% Then for documentation I either run or just record in the cell file the
% LoadFACSfromFlowJoWorkspace_v4 function with the group and the gate
% numbers defined explicitely as below
Dilute_5CC7 = LoadFACSfromFlowJoWorkspace_v4(fpath, 'GroupInd', 4, 'GateInd', 4);

%% Load some other groups
ExposedToIL2_TAC = LoadFACSfromFlowJoWorkspace_v4(fpath, 'GroupInd', 3, 'GateInd', 7);
ExposedToIL2_5CC7 = LoadFACSfromFlowJoWorkspace_v4(fpath, 'GroupInd', 3, 'GateInd', 4);

%% Start analysis: we are interested in  PE data on all channels

ExposedToIL2_5CC7_PE = GetFACSdataFromMatLabStructByTag( ExposedToIL2_5CC7, 'PE');

%% Estimate background noise from ExposedToIL2_5CC7_PE(0) - data without
% capture antibody
[H1, X1] = hist(ExposedToIL2_5CC7_PE(1).PE, 1000);
plot(X1, H1)
figure(gcf)

%% remove small percentage of outliers at each edge
outliers = 2e-3;
H1 = H1/sum(H1);

cH1 = cumsum(H1);
J = min(find(cH1 > outliers)) : max(find(cH1 < (1-outliers)));

plot(X1, H1, X1(J), H1(J)); figure(gcf)

%% Fit with Gaussian

pos = H1(J)*X1(J)'
stdev = sqrt(H1(J)*X1(J).^2' - pos^2)
amp = max(H1(J))*sqrt(2*pi)*stdev


BETA = lsqcurvefit(@GaussianFit, [amp pos stdev] ,X1(J), H1(J),[0 -inf 0], [inf inf inf])

plot(X1(J), H1(J), 'o', X1(J), GaussianFit(BETA, X1(J)));
figure(gcf)

LinearRange = abs(BETA(2)) + pi*BETA(3);
%% Calculate histograms in order to evaluate total number of capture
% antiboies
[H, Hnorm, X, Xtrue, proc_ExposedToIL2_5CC7, LinearRange] = HistAsinh(ExposedToIL2_5CC7, 'Tag','PE', 'Linear Range', LinearRange);

%% Fit with Gaussians

[BETA proc_ExposedToIL2_5CC7] = AutoFitFACSdata( proc_ExposedToIL2_5CC7 , 'PE', @GaussianFit, 'InitParamFunc', 'EstimateGaussFitParam', 'Lower Bounds', [0 -inf 0], 'Upper Bounds', [inf inf inf]);
%% Processing experiments on auto/paracrine signalling on 10/02/12(First Data in Bash!)



fpath = '/Users/Alonyan/Documents/School/Experiments/20121210 AutoParacrine/Autocrine'
cd  '/Users/Alonyan/Documents/MATLAB/FACSanalysis'

histSizeX = 19;
histSizeY = 20;
Ncontours = 20; 


%% Background

BG = LoadFACSfromFlowJoWorkspace_v4(fpath, 'GroupInd', 5, 'GateInd', 4);%this should be your negative control, BG estimator

%% Maximal concentration

Exposed = LoadFACSfromFlowJoWorkspace_v4(fpath, 'GroupInd', 5, 'GateInd', 4);%this should be your positive control, estimator for total # of capture receptors

%% Beads

Beads = LoadFACSfromFlowJoWorkspace_v4(fpath, 'GroupInd', 4, 'GateInd', 0, 'NameFilter', '_beads');

%%  Samples

Samples = LoadFACSfromFlowJoWorkspace_v4(fpath, 'GroupInd', 5, 'GateInd', 4); %these should be your samples

%% Estimate background noise from BG - data without
% capture antibody
BG_PE = GetFACSdataFromMatLabStructByTag(BG, 'PE');

[H1, X1] = hist(BG_PE.PE, 300);
plot(X1, H1)
figure(gcf)

%% remove small percentage of outliers at each edge
outliers = 1e-2;
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

LinearRange = abs(BETA(2)) + pi*BETA(3) %this is the linear range in your measurement. Should be a few hundreds

[H, Hnorm, X, Xtrue, proc_BG, LinearRange] = HistAsinh(BG, 'Tag','PE', 'Linear Range', LinearRange);

%% Have a look at the Beads
[H, Hnorm, X, Xtrue, proc_Beads, LinearRange] = HistAsinh(Beads, 'Tag','PE', 'Linear Range', LinearRange);

%% 
BETA_beads_330000 = AutoFitFACSdata( proc_Beads , 'PE', @GaussianFit, 'InitParamFunc', 'EstimateGaussFitParam', 'Lower Bounds', [0 -inf 0], 'Upper Bounds',...
    [inf inf inf], 'Range', asinh([30000 100000]/LinearRange)); %you should pick a range so that the highest fluorescing beads are in it(top peak)

LinearRange*sinh(BETA_beads_330000(2, :))
PEmolec_per_unit_fluoresc = LinearRange*sinh(BETA_beads_330000(2, 1))/330000

%%
BETA_beads_76000 = AutoFitFACSdata( proc_Beads , 'PE', @GaussianFit, 'InitParamFunc', 'EstimateGaussFitParam', 'Lower Bounds', [0 -inf 0], 'Upper Bounds',...
    [inf inf inf], 'Range', asinh([5000 20000]/LinearRange));%you should pick a range so that the second highest fluorescing beads are in it(second peak)

LinearRange*sinh(BETA_beads_76000(2, :))
PEmolec_per_unit_fluoresc(2) = LinearRange*sinh(BETA_beads_76000(2, 1))/76000

display('similar values from 2 types of beads?')

%% Estimate total capture on the cells
Exposed_PE = GetFACSdataFromMatLabStructByTag(Exposed, 'PE');

[H, Hnorm, X, Xtrue, proc_Exposed, LinearRange] = HistAsinh(Exposed, 'Tag','PE', 'Linear Range', LinearRange);

[BETA, proc_Exposed] = AutoFitFACSdata( proc_Exposed , 'PE', @GaussianFit, 'InitParamFunc', 'EstimateGaussFitParam', 'Lower Bounds', [0 -inf 0], 'Upper Bounds', [inf inf inf]);

C_capture = 0.1 ;%for 1:10 capture ab

CaptureAB = (proc_Exposed.PE.meanD - proc_BG.PE.meanD(1))/mean(PEmolec_per_unit_fluoresc)% # of capture ABs on your Samples.




%% Now to the real thing: Samples
Nbins = 150;%you can change the bin size depending on data

[H, Hnorm, X, Xtrue, proc_Samples, LinearRange] = HistAsinh(Samples, 'Tag','PE', 'Linear Range', LinearRange, 'Nbins', Nbins);
pause;

%% Fit IL2 captured by 5CC7 in dilute solutions. This is only so we have initial values before global fit

[BETA proc_Samples] = AutoFitFACSdata( proc_Samples , 'PE', @DoubleGaussianFit_v2, 'InitParamFunc', 'EstimateDoubleGaussFitParam', 'Lower Bounds', [0 -inf 0 0 -inf 0], 'Upper Bounds', [inf inf inf inf inf inf]);



%%
save([fpath filesep ''])%put filename

%% Might end here?



%% Global Fit
data = proc_Samples.PE;


beta0= median(data.fitParam(1, :)./(data.fitParam(1, :)+data.fitParam(4, :)));

tempbeta0 = [(data.fitParam(1, :)+data.fitParam(4, :)); data.fitParam([2 3 5 6], :)];


beta0 = [beta0; tempbeta0(:)]';

figure;

lowerBounds = [0 repmat([0 -inf 0 -inf 0], 1, size(data.H, 2))];
upperBounds = [1 repmat([inf inf inf inf inf], 1, size(data.H, 2))];
GlobalFitParam = lsqcurvefit(@GlobalGaussianFitWithFractionConstrains, beta0, data.X, data.H(:), lowerBounds, upperBounds)



histFit = GlobalGaussianFitWithFractionConstrains(GlobalFitParam, data.X);
histFit = reshape(histFit, length(data.X), length(histFit)/length(data.X));
%allhist = reshape(allhist, length(xbins), length(allhist)/length(xbins));

for i = 1:size(data.H, 2),
   
    plot(data.X, data.H(:, i), 'o', data.X, histFit(:, i));
    title(j)

    hold all;
%     plot(xbins, GaussianFit([betaVeryGl1(3 + ((i-1)*numT + j-1)*4) betaVeryGl1(1) betaVeryGl1(2)], xbins), xbins, GaussianFit(betaVeryGl1((4:6) + ((i-1)*numT + j-1)*4), xbins));
% 
%     title([fldnames{i}  '    Time point No.' num2str(j)])
    figure(gcf)
    pause
    hold off;
   
 end;
 

data.GlobalFitParam = GlobalFitParam;

GlobalFitParamTemp = reshape(GlobalFitParam(2:length(GlobalFitParam)), 5, size(data.H, 2))

J = find(GlobalFitParamTemp(2, :) > GlobalFitParamTemp(4, :)); % switched positions of the first and second peaks
temp = GlobalFitParamTemp([2 3], J);
GlobalFitParamTemp([2 3], J) = GlobalFitParamTemp([4 5], J);
GlobalFitParamTemp([4 5], J) = temp;

data.producers_frac = 1- data.GlobalFitParam(1);
data.posPeak1 = GlobalFitParamTemp(2, :);
data.posPeak2 = GlobalFitParamTemp(4, :);
data.stdPeak1 = GlobalFitParamTemp(3, :);
data.stdPeak2 = GlobalFitParamTemp(5, :);

data.IL2_producers = data.LinearRange*(sinh(data.posPeak2) - sinh(data.posPeak1))/mean(PEmolec_per_unit_fluoresc)



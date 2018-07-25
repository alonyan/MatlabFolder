%%
fpath = '/Users/Alonyan/Downloads/Jen Files'
cd  '/Users/Alonyan/Documents/MATLAB/FACSanalysis'

histSizeX = 19;
histSizeY = 20;
Ncontours = 20; 

Timepoints = 5;

%%
%BG = LoadFACSfromFlowJoWorkspace_v4(fpath)
%% Background

BG = LoadFACSfromFlowJoWorkspace_v4(fpath, 'GroupInd', 4, 'GateInd', 8);%this should be your negative control, BG estimator

close all;

%% Estimate background noise from BG - data without
% capture antibody
BG_APC = GetFACSdataFromMatLabStructByTag(BG, 'APC');

[H1, X1] = hist(BG_APC(2).APC, 80);
plot(X1, H1)
figure(gcf)

%% remove small percentage of outliers at each edge
outliers = 5e-3;
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

[H, Hnorm, X, Xtrue, proc_BG, LinearRange] = HistAsinh(BG(1), 'Tag','APC', 'Linear Range', LinearRange,'Nbins', 100);

pause;

[BETA, proc_BG] = AutoFitFACSdata( proc_BG , 'APC', @DoubleGaussianFit_v2, 'InitParamFunc', 'EstimateDoubleGaussFitParam', 'Lower Bounds', [0 -inf 0 0 -inf 0], 'Upper Bounds', [inf inf inf inf inf inf]);


ProdThresh = BETA(5);





%if you only want fractions, skip all this
%% Maximal concentration

%Exposed = LoadFACSfromFlowJoWorkspace_v4(fpath, 'GroupInd', 6);%this should be your positive control, estimator for total # of capture receptors

%% Beads

Beads = LoadFACSfromFlowJoWorkspace_v4(fpath, 'GroupInd', 4, 'GateInd', 0, 'NameFilter', '_beads');

Timepoints = 5;
Preperations = 6;
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









% if you dont care about exact numbers, and only about prod fraction, you
% can start here.

%% Now to the real thing:  Samples

Samples = LoadFACSfromFlowJoWorkspace_v4(fpath, 'GroupInd', 3, 'GateInd', 8); %these should be your samples
%%
Nbins = 100;%you can change the bin size depending on data

[H, Hnorm, X, Xtrue, proc_Samples, LinearRange] = HistAsinh(Samples, 'Tag','APC', 'Linear Range', LinearRange, 'Nbins', Nbins);
pause;

%% Fit captured cytokine in MA. 

[BETA proc_Samples] = AutoFitFACSdata( proc_Samples , 'APC', @DoubleGaussianFit_v2, 'InitParamFunc', 'EstimateDoubleGaussFitParam', 'Lower Bounds', [0 -inf 0 0 -inf 0], 'Upper Bounds', [inf inf inf inf inf inf]);
%%
for i=1:size(proc_Samples.APC.fitParam,2)
proc_Samples.APC.histFit(:,i) = DoubleGaussianFit_v2(proc_Samples.APC.fitParam(:, i), proc_Samples.APC.X);
end;

%% calculate Producers Fraction

proc_Samples.APC.ProducersFrac = (1- proc_Samples.APC.fitParam(1, :)./(proc_Samples.APC.fitParam(1, :)+proc_Samples.APC.fitParam(4, :))).*(proc_Samples.APC.fitParam(5, :)>ProdThresh)

%% Present fits and individual gaussians one by one
for dataNum = 1:length(proc_Samples.APC.ProducersFrac)
    if(proc_Samples.APC.ProducersFrac(dataNum))
        h = plot(proc_Samples.APC.X, proc_Samples.APC.H(:,dataNum),'.k', ...
            proc_Samples.APC.X, proc_Samples.APC.histFit(:,dataNum),...
            proc_Samples.APC.X, GaussianFit(proc_Samples.APC.fitParam(1:3, dataNum), proc_Samples.APC.X),...
            proc_Samples.APC.X, GaussianFit(proc_Samples.APC.fitParam(4:6, dataNum), proc_Samples.APC.X));
    else
        h = plot(proc_Samples.APC.X, proc_Samples.APC.H(:,dataNum),'.k', ...
            proc_Samples.APC.X,proc_Samples.APC.histFit(:,dataNum));
    end;
        
annotation('textbox', [0.5 .7 .1 .1], 'String', ['Producer Fraction = ' num2str(proc_Samples.APC.ProducersFrac(dataNum))]);
title(dataNum)
set(h,'LineWidth',1.2)
figure(gcf)
pause;
close;
end
%%

[r,c] = size(proc_Samples.APC.H);

X = proc_Samples.APC.X;
H = reshape(proc_Samples.APC.H,[r, c/Timepoints,Timepoints]);
histFit = reshape(proc_Samples.APC.histFit,[r, c/Timepoints,Timepoints]);
ProducersFrac = reshape(proc_Samples.APC.ProducersFrac, [c/Timepoints,Timepoints]);

%% Present fits by Preperations
T = 60*40; % experiment time in sec (right now set to 40 minutes)


order =  [1:Timepoints];
  for j = 1:(c/Timepoints)
    for i = 1:Timepoints
    subplot(round(Timepoints/2), 2, i); h = plot(X, H(:, j,order(i)), 'o', X, histFit(:,j, order(i)),'-');
    set(h, 'MarkerSize', 4)
    title( ['T =  ' num2str(order(i))]);  
    v= axis;
    
    Th = text(2.2, v(4)*0.8,  ['Producer % =  ' num2str(round(100*(ProducersFrac(j,i))))]); 
    
    a1 = - 1:0.1:0.9;
    a2 =(1:9)'*10.^(0:2);
    a = [a1(:); a2(:); 1000];
    
    emptyStr = {''; ''; '';''; ''; ''; ''; ''};
    XTickLabel = ['-1'; emptyStr; {''}; '0'; {''}; emptyStr; '1'; emptyStr; '10'; emptyStr; '100'; emptyStr; '1000'];
%if you have a measurement of APC beads this can give you actual numbers of
%captured molecules per unit time
 %   XTicks = asinh(a*mean(PEmolec_per_unit_fluoresc)/LinearRange*T);
    
%    set(gca, 'XTick', XTicks, 'XTickLabel', XTickLabel, 'Xlim', [-1 6]);
 %   set(gca, 'XTick', XTicks, 'XTickLabel', XTickLabel, 'Xlim', [-1 6]);
    xlabel('captured IFN-\gamma (molec/cell/s)')
    ylabel('probability')
    
    end
     figure(gcf)

  pause;  
  end;

 
 %% save
 
 save([fpath filesep ''])%put filename
 
%% Present fits by Timepoint
T = 50*40; % experiment time in sec


order =  [1:Timepoints];
    for i = 1:Timepoints
    for j = 1:(c/Timepoints)
    subplot(round(c/Timepoints/2), 2, j); h = plot(X, H(:, j,order(i)), 'o', X, histFit(:,j, order(i)),'-');
    set(h, 'MarkerSize', 4)
    title( ['Preparation =  ' num2str(j)]);  
    v= axis;
    
    Th = text(2.2, v(4)*0.8,  ['Producer % =  ' num2str(round(100*(ProducersFrac(j,i))))]); 
    
    a1 = - 1:0.1:0.9;
    a2 =(1:9)'*10.^(0:2);
    a = [a1(:); a2(:); 1000];
    
    emptyStr = {''; ''; '';''; ''; ''; ''; ''};
    XTickLabel = ['-1'; emptyStr; {''}; '0'; {''}; emptyStr; '1'; emptyStr; '10'; emptyStr; '100'; emptyStr; '1000'];

 %   XTicks = asinh(a*mean(PEmolec_per_unit_fluoresc)/LinearRange*T);
    
%    set(gca, 'XTick', XTicks, 'XTickLabel', XTickLabel, 'Xlim', [-1 6]);
 %   set(gca, 'XTick', XTicks, 'XTickLabel', XTickLabel, 'Xlim', [-1 6]);
    xlabel('captured IFN-\gamma (molec/cell/s)')
    ylabel('probability')
    
    end
     figure(gcf)

  pause;  
  end;

 


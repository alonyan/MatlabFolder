%% Created by Alon Yaniv - 1.1.14
%Source the blot containing the housekeeping gene
data=imread('/Users/labuser/Desktop/Jen/Experiments/2013/12_13/201213_pSTAT1_IRF1_MHC/Westerns/Plots of GAPDH_T1_141213.tif');
data = data==0;
topmargin = 18;
widthlane = size(data,2)-2;
data = data(topmargin:length(data)-1,2:widthlane+1);

Nlanes = 8;
hightlane = 325;



%%
clear lane;
for i = 1: Nlanes;
lane(i,:,:) = data(hightlane*(i-1)+1:hightlane*(i)-1,:);
end;
%%
Lane = 324*ones(Nlanes,widthlane);%"324*ones" was changed from "zeros"
for i = 1: Nlanes;
for j=1:widthlane;
ind = find(lane(i,:,j),1,'first');
if ind
Lane(i,j) = 324-ind ;
end
end;
end;



%% Calculate areas for housekeeping protein
clear HKArea;
Range = [1 2 3 4 5 6 7 8] %Change this based on the number of histograms or histograms you want to analyze
for i=1:length(Range)
plot(Lane(Range(i),:)); figure(gcf)
zoom on;
X = 1:length(Lane(Range(i),:));
H = Lane(Range(i),:);
pause;
title('select gaussian area for housekeeping protein')
J= InAxes;
curAx = axis;

H1 = Lane(Range(i),J);

pos = median(J)
stdev = std(J)
amp = max(H1)*sqrt(2*pi)*stdev

[BETA,RESNORM,RESIDUAL,EXITFLAG] = lsqcurvefit(@GaussianFit, [amp pos stdev] ,J, Lane(Range(i),J),[0 -inf 0], [inf inf inf])
if EXITFLAG>=0;
plot(X, H, '-.', X, GaussianFit(BETA, X));
figure(gcf)
pause;
HKArea(i)=BETA(1);
HKHeight(i) = BETA(1)/(sqrt(2*pi)*BETA(3));
else
HKArea(i)=0;
HKHeight(i)=0;
end;

close all;
end;

%% Source the other blot containing pSTAT1
data=imread('/Users/labuser/Desktop/Jen/Experiments/2013/12_13/201213_pSTAT1_IRF1_MHC/Westerns/Plots of 301213_pSTAT1.tif');
data = data==0;
topmargin = 18;
widthlane = size(data,2)-2;
data = data(topmargin:length(data)-1,2:widthlane+1);

Nlanes = 8;
hightlane = 325;



%%
clear lane;
for i = 1: Nlanes;
lane(i,:,:) = data(hightlane*(i-1)+1:hightlane*(i)-1,:);
end;
%%
Lane = zeros(Nlanes,widthlane);
for i = 1: Nlanes;
for j=1:widthlane;
ind = find(lane(i,:,j),1,'first');
if ind
Lane(i,j) = 324-ind ;
end
end;
end;


%% Calculate areas for protein of interest
clear ProtArea;
for i=1:length(Range)
plot(Lane(Range(i),:)); figure(gcf)
zoom on;
X = 1:length(Lane(Range(i),:));
H = Lane(Range(i),:);
figure(gcf)
pause;
title('select gaussian area for your protein')
J= InAxes;
curAx = axis;

H1 = Lane(Range(i),J);

pos = median(J)
stdev = std(J)
amp = max(H1)*sqrt(2*pi)*stdev

[BETA,RESNORM,RESIDUAL,EXITFLAG] = lsqcurvefit(@GaussianFit, [amp pos stdev] ,J, Lane(Range(i),J),[0 -inf 0], [inf inf inf])
if EXITFLAG>0
plot(X, H, '-.', X, GaussianFit(BETA, X));
figure(gcf)
pause;
ProtArea(i)=BETA(1);
ProtHeight(i) = BETA(1)/(sqrt(2*pi)*BETA(3));
else
    ProtArea(i)=0;
    ProtHeight(i) = 0;
end;

close all;
end;
%%
IFNg=[10e-9 2e-9 400e-12 80e-12 16e-12 3.2e-12 640e-15 125e-15]
values = ProtArea./HKArea;
%values = ProtHeight./HKHeight;

%Normalize ratio of Protein Area
%values=values-min(values)./max(values);
values=values(1:7);
IFNg=IFNg(1:7);

%Estimate EC50
a = (IFNg*(values==median(values))');

EC50 = lsqcurvefit(@hillfunction, [a], IFNg, values, [0 -Inf 0])
HalfLife = log(2)/BETA(2);
i=-15:0.01:-5;
i=10.^i;
semilogx(IFNg, values, 'o', i, hillfunction(EC50, i), '-k', 'linewidth', 1.5)
set(gca, 'color', 'w')
set(gca, 'Fontsize', 25)
ylabel('GAPDH-normalized pSTAT1 intensity (a.u.)')
xlabel('[IFN-\gamma], (M)')
text(40, max(values)  , ['EC50 =' num2str(EC50) ' minutes.'], 'Color', 'k','FontSize',16, 'FontWeight', 'bold');
title('Fitted pSTAT1 signal')
figure(gcf)
%% Created by Alon Yaniv - 1.1.14
data=imread('/Users/labuser/Desktop/Jen/Experiments/2013/12_13/141213_pSTAT1 Western/Plots of pSTAT1_14122013.tif');
data = data==0;
topmargin = 18;
widthlane = size(data,2)-2;
data = data(topmargin:length(data)-1,2:widthlane+1);

Nlanes = 7;
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



%% Calculate areas for housekeeping protein
clear HKArea;
Range = [1 4 5 6 7]
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
times = 0:15:60;
values = ProtArea./HKArea;
%values = ProtHeight./HKHeight;

amp0 = max(values);
lambda0 = 1/(times*(values==median(values))');
BETA = lsqcurvefit(@Exponent, [amp0 lambda0] ,times, values)
HalfLife = log(2)/BETA(2);
t=0:0.1:100;
plot(times, values, 'o', t, Exponent(BETA, t),'-k', 'linewidth', 1.5)
set(gca, 'color', 'w','XTick', 0:20:100)
set(gca, 'Fontsize', 25)
ylabel('GAPDH-normalized pSTAT1 intensity (a.u.)')
xlabel('Time post-Jaki, (min)')
text(40, max(values)  , ['halflife =' num2str(HalfLife) ' minutes.'], 'Color', 'k','FontSize',16, 'FontWeight', 'bold');
title('Fitted pSTAT1 decay')
figure(gcf)
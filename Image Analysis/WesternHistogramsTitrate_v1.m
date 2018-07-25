%% load HK
data=imread('/Users/Alonyan/Downloads/Plots of GAPDH_T1_141213.tif');
data = data==0;
topmargin = 18;
widthlane = size(data,2)-2;
data = data(topmargin:length(data)-1,2:widthlane+1);

Nlanes = 8;
hightlane = 325;




clear lane;
for i = 1: Nlanes;
lane(i,:,:) = data(hightlane*(i-1)+1:hightlane*(i)-1,:);
end;

Lane = 324*ones(Nlanes,widthlane);
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
Range = [1:8];
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

pos = median(J);
stdev = std(J);
amp = max(H1)*sqrt(2*pi)*stdev;
bg = min(H1);

[BETA,RESNORM,RESIDUAL,EXITFLAG] = lsqcurvefit(@GaussianFitWithBG, [amp pos stdev bg] ,J, Lane(Range(i),J),[0 -inf 0 0], [inf inf inf 10])
if EXITFLAG>=0;
plot(X, H, '-.', X, GaussianFitWithBG(BETA, X));
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

%% load data
data=imread('/Users/Alonyan/Downloads/Plots of 301213_pSTAT1.tif');
data = data==0;
topmargin = 18;
widthlane = size(data,2)-2;
data = data(topmargin:length(data)-1,2:widthlane+1);

Nlanes = 8;
hightlane = 325;




clear lane;
for i = 1: Nlanes;
lane(i,:,:) = data(hightlane*(i-1)+1:hightlane*(i)-1,:);
end;

Lane = 324*ones(Nlanes,widthlane);
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
bg = min(H1);


[BETA,RESNORM,RESIDUAL,EXITFLAG] = lsqcurvefit(@GaussianFitWithBG, [amp pos stdev bg] ,J, Lane(Range(i),J),[0 -inf 0 0], [inf inf inf 10])
if EXITFLAG>0
plot(X, H, '-.', X, GaussianFitWithBG(BETA, X));
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
%times = 0:15:60;
conc = [10e-9*(1/5).^[0:5] 0 0];
values = ProtArea./HKArea;
%values = ProtHeight./HKHeight;
%values=values/max(values);


BETA0 = [max(values) median(conc)];
BETA = lsqcurvefit(@HillFunction,  BETA0 ,conc(1:7), values(1:7));
x=-13:0.01:-6; %say to have a range from 10^-15 to 10^-4
x=10.^x;

EC50 = BETA(2);

semilogx(conc(1:7), values(1:7), 'o', x, HillFunction(BETA, x),'-k', 'linewidth', 1.5)
%set(gca, 'color', 'w','XTick', 0:20:100)
set(gca, 'Fontsize', 25)
ylabel('pSTAT1 decay')
xlabel('Time post-Jaki, (min)')
text(10^-13,  10 , ['The EC50 is ' num2str(EC50) ' M.'], 'Color', 'k','FontSize',16);
title('Fitted pSTAT1')
figure(gcf)
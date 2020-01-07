
%Untreated
 ptrn1 = '[BC]0[7-9]'
 ix1 = regexp(R.PosNames, ptrn1);
 ptrn1 = ['[BC]10']
 ix2 = regexp(R.PosNames, ptrn1);
 ix=logical(~cellfun('isempty',ix1) + ~cellfun('isempty',ix2)) ;
 posListDo = R.PosNames(ix);

 
% %TNF:
%   ptrn1 = ['[BC]0[3-6]']
%   ix1 = regexp(R.PosNames, ptrn1);
%   ix=~cellfun('isempty',ix1);
%   posListDo = R.PosNames(ix);



%%
Tracks = R.getTracks(posListDo)

dt=5;
if ~rem(dt,2)
    error('Neighborhood must be odd')
end

frames = R.Frames;
%deal with outliers
%deathThresh = exp(triThreshImg(log(cat(2,Tracks.DeathTrack))));
%highRatioThresh = nanmean(cat(2,Tracks.RatioTrack))+3*nanstd(cat(2,Tracks.RatioTrack));
%Potential outliers have a signal 3sigma above mean
%A = arrayfun(@(x) x.RatioTrack>highRatioThresh,Tracks,'UniformOutput', false);
%Live cells shouldnt have such high ratios
%B = arrayfun(@(x) x.DeathTrack<deathThresh,Tracks,'UniformOutput', false);

%A = cellfun(@times, A,B,'uniformoutput',false);
%A = cellfun(@(x) ~x, A,'uniformoutput',false);

%[Tracks.('inliers')]=A{:};
%inxToUse = arrayfun(@(x) range(x.RatioTrack(x.inliers))./(nanmean(x.RatioTrack(x.inliers))-nanmin(x.RatioTrack(x.inliers))),Tracks)>3;
inxToUse = cat(2,Tracks.CellDies);

Tracks = Tracks(find(~inxToUse'));

close all
for trackNum = 1:numel(Tracks);
    %cla


YY = [InterpNANs(Tracks(trackNum).RatioTrack(1:end))];%./Tracks(trackNum).NucTrack(1:end))];
XX = [ones(1,numel(Tracks(trackNum).T))', Tracks(trackNum).T'/3];


mSlope = [];
linFitParams = [];
rng = floor(dt/2)+1:length(YY)-floor(dt/2);
for i=1:numel(rng)
    t0=rng(i);
    y= YY(t0-floor(dt/2):t0+floor(dt/2));
    x= XX(t0-floor(dt/2):t0+floor(dt/2),:);
theta = (x'*x)\x'*y;%linear fit
linFitParams = [linFitParams, theta] ;
mSlope = [mSlope theta(2)];
end

Tracks(trackNum).slope = mSlope;

figure(1)
subplot(1,2,1)
plot(XX(rng,2),mSlope,'-k')
hold all
h = scatter(XX(rng,2), mSlope,[],exp([Tracks(trackNum).DeathTrack(rng)]'),'filled');
set(h,'MarkerFaceAlpha', 0.5)
colormap(makeColorMap([0,0,1],[1,0,0]));
xlabel('time(h)')
ylabel('slope')
set(gca,'ylim', [-0.1, 0.5], 'clim', exp([0,0.08]))
%shg
tzeva = viridis(numel(mSlope));
%hold off;
ax1 = gca;
subplot(1,2,2)

for i=1:numel(rng)
    t0=rng(i);
    y= YY(t0-floor(dt/2):t0+floor(dt/2));
    x= XX(t0-floor(dt/2):t0+floor(dt/2),2);
    p=linFitParams(:,i);

 h = plot(x,polyval(flipud(p),x),'-','markerEdgeColor', 'none','markerFaceColor', tzeva(i,:)','Color', tzeva(i,:)');
 h(1).Color(4)=0.5;
 hold all;
 
end

h = scatter(XX(1:rng(1)-1,2), YY(1:rng(1)-1),[],tzeva(1,:),'filled');
set(h,'MarkerFaceAlpha', 0.5)
hold on;
h = scatter(XX(rng(end)+1:end,2), YY(rng(end)+1:end),[],tzeva(end,:),'filled');
set(h,'MarkerFaceAlpha', 0.5)
hold on;
h = scatter(XX(rng,2), YY(rng),[],tzeva,'filled');
set(h,'MarkerFaceAlpha', 0.5)

xlabel('time(h)')
ylabel('Ratio')
set(gca,'ylim', [-0.05 3])
set(ax1,'xlim',get(gca,'xlim'));
shg
%pause;%(0.3)

end


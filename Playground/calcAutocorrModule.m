%% Untreated dead - one example
Tracks = R.getTracks(posListDo)

dt=5;
if ~rem(dt,2)
    error('Neighborhood must be odd')
end


frames = R.Frames;
inxToUse = cat(2,Tracks.CellDies);
Tracks = Tracks(find(~inxToUse'));

figure(2)
set(gcf,'Position',[151 288 776 310], 'color', 'w')

tzeva = colormap(lines(numel(Tracks)));
for trackNum = 1;
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
autoCorr = calculateAutocorrelation(mSlope)

Tracks(trackNum).slope = mSlope;

subplot(1,2,1)
plot(XX(rng,2), mSlope,'color',tzeva(trackNum,:)'); shg;
xlabel('time(h)','interpreter', 'latex','fontsize', 14)
ylabel('Slope $\frac{dR_{Cas8}}{dt}$','interpreter', 'latex','fontsize', 14)
hold all

subplot(1,2,2)
h = ploterr(autoCorr.Bins/3,autoCorr.Corr,[],autoCorr.errCorr,'-o'); shg;
h(1).Color = tzeva(trackNum,:)';
h(2).Color = tzeva(trackNum,:)';
xlabel('time(h)','interpreter', 'latex','fontsize', 14)
ylabel('Autocorrelation: $G(t)=\frac{\langle R(0)R(t)\rangle}{\langle R(0)\rangle^2}$','interpreter', 'latex','fontsize', 14)

hold all
end


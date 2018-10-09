x = 1:0.1:100;
a = sin(x);

b = randn(1,length(x));
T1 = [0:size(a,2)]';
a = (a-nanmean(a(:)))./nanstd(a(:));
a(isnan(a))=0;
b = (b-nanmean(b(:)))./nanstd(b(:));
b(isnan(b))=0;


CorrCoeffs = (a'*b);%




xCorr=[]; for i=-size(a,2):size(a,2) xCorr = [xCorr nanmean(diag(CorrCoeffs,i))]; end
xCorrErr=[]; for i=-size(a,2):size(a,2) xCorrErr = [xCorrErr nanstd(diag(CorrCoeffs,i))/sqrt(numel(diag(CorrCoeffs,i)))]; end

 ploterr([-flipud(T1(2:end));T1],xCorr,[],xCorrErr); shg
 set(gca,'ylim',[-10,10])
 ylabel('xcorrelation')
 xlabel('time')
hold all
pause(0.1)

%%
%% xcorr
j=1
Tracks = R.getTracks(R.PosNames{j});
%xCorrs = {};
%xCorrsErr = {};
%Ts = {};
for ind = 249%:numel(Tracks)
    ind
%close all
cla
a = Smoothing(Tracks(ind).DensityTrack(1:end-1),'neigh',5);

b = Smoothing(Tracks(ind).Speed','neigh',5);
T1 = [0:size(a,2)]';
a = (a-nanmean(a(:)))./nanstd(a(:));
a(isnan(a))=0;
b = (b-nanmean(b(:)))./nanstd(b(:));
b(isnan(b))=0;


CorrCoeffs = (a'*b);%




xCorr=[]; for i=-size(a,2):size(a,2) xCorr = [xCorr nanmean(diag(CorrCoeffs,i))]; end
xCorrErr=[]; for i=-size(a,2):size(a,2) xCorrErr = [xCorrErr nanstd(diag(CorrCoeffs,i))/sqrt(numel(diag(CorrCoeffs,i)))]; end

 ploterr([-flipud(T1(2:end));T1],xCorr,[],xCorrErr); shg
 %set(gca,'ylim',[-10,10])
 ylabel('xcorrelation')
 xlabel('time')
hold all
pause(0.1)

end
%% xcorr
j=3
Tracks = R.getTracks(R.PosNames{j});
%xCorrs = {};
%xCorrsErr = {};
%Ts = {};

T = 0:numel(R.TimeVecs{1});
T = [-fliplr(T(2:end)),T];
xCorrs = nan(numel(Tracks), numel(T));
xCorrsErr = nan(numel(Tracks), numel(T));

for ind = 1:numel(Tracks)
    ind
%close all
%cla
a = Smoothing(Tracks(ind).DensityTrack(1:end-1));

b = Smoothing(Tracks(ind).Speed');
T1 = [0:size(a,2)]';
a = (a-nanmean(a(:)))./nanstd(a(:));
a(isnan(a))=0;
b = (b-nanmean(b(:)))./nanstd(b(:));
b(isnan(b))=0;


CorrCoeffs = (a'*b);%

xCorr=[]; for i=-size(a,2):size(a,2) xCorr = [xCorr nanmean(diag(CorrCoeffs,i))]; end
xCorrErr=[]; for i=-size(a,2):size(a,2) xCorrErr = [xCorrErr nanstd(diag(CorrCoeffs,i))/sqrt(numel(diag(CorrCoeffs,i)))]; end

% ploterr([-flipud(T(2:end));T],xCorr,[],xCorrErr); shg
 %set(gca,'ylim',[0,1])
% ylabel('xcorrelation')
% xlabel('time')
%hold all
%pause(0.1)

%xCorrs{ind} = xCorr;
%xCorrsErr{ind} = xCorrErr;
T1 = [-flipud(T1(2:end));T1]';
J = ismember(T,T1);
xCorrs(ind,J) = xCorr;
xCorrsErr(ind,J) = xCorrErr;
end


%% Speeds

j=1
Tracks = R.getTracks(R.PosNames{j});
%xCorrs = {};
%xCorrsErr = {};
%Ts = {};

T = 1:numel(R.TimeVecs{1})-1;
%T = [-fliplr(T(2:end)),T];
Speeds = nan(numel(Tracks), numel(T));
Dists = nan(numel(Tracks), numel(T));

for ind = 1:numel(Tracks)
    ind
%close all
%cla
a = (Tracks(ind).RadialVelocity');
b = (Tracks(ind).DistFromWound(1:end-1)');

T1 = Tracks(ind).T;
T1 = T1(1:end-1);
%a = (a-nanmean(a(:)))./nanstd(a(:));
%a(isnan(a))=0;
%b = (b-nanmean(b(:)))./nanstd(b(:));
%b(isnan(b))=0;


J = ismember(T,T1);
Speeds(ind,J) = a;
Dists(ind,J) = b;

end





%% V/D
figure
Twin = 3;
Start = 1
for i=0:50

    J = find(~isnan(nanmean(Speeds(:,Start-1 + Twin*i+[1:Twin]),2)))
[Xb, Yb, stdXb, stdYb, steXb, steYb] = BinData_v1(nanmean(Dists(J,Start-1 + Twin*i+[1:Twin]),2), nanmean(Speeds(J,Start-1 +Twin*i+[1:Twin]),2), 10);
ploterr(Xb*PixelSize,Yb,steXb,steYb);
hold all
shg
xlabel('Distance From Wound')
ylabel('Radial Velocity')
%pause
end
set(gca,'xtick',[30:60:600]/PixelSize, 'xticklabel',30:60:600)
set(gca,'ylim',[-5,5],'xlim',[0,600])

Ch = get(gca,'Children');
tzeva = flipud(plasma(size(Ch,1)/3));
for i=0:size(Ch,1)/3-1
    for j=1:3
        Ch(3*i+j).Color = tzeva(i+1,:);
        Ch(3*i+j).Color(4) = 0.4;
        Ch(3*i+j).LineWidth = 1.5
    end
end

cb = colorbar(gca)
cb.Direction = 'reverse'
colormap(flipud(plasma(size(Ch,1))))
cb.Ticks = 0:(1/11):1
cb.TickLabels = 110:-10:0
xlabel(cb,'Time (h)')


%% V/T at D
figure

for D = 50:25:950;

inds = find((Dists<D+50).*(Dists>D));
[~,iy] = ind2sub(size(Dists),inds);
S1 = Speeds(inds);

[Xb, Yb, stdXb, stdYb, steXb, steYb] = BinData_v1(iy, S1, 220);
ploterr(Xb,Yb,steXb,steYb,'-');
hold all;
end

 set(gca,'ylim',[-10,10],'xlim',[0,220],'xtick',[0:20:220], 'xticklabel',[0:20:220]/2)
shg
xlabel('Time(h)')
ylabel('Radial Velocity (\mum/h)')


Ch = get(gca,'Children');
tzeva = flipud(plasma(size(Ch,1)/3));
for i=0:size(Ch,1)/3-1
    for j=1:3
        Ch(3*i+j).Color = tzeva(i+1,:);
        Ch(3*i+j).Color(4) = 0.4;
        Ch(3*i+j).LineWidth = 1.5
    end
end
cb = colorbar(gca)
cb.Direction = 'reverse'
colormap(flipud(plasma(size(Ch,1))))
cb.TickLabels = 570:-60:30
xlabel(cb,'Distance From Wound (\mum)')



%% V/D at T ribbons
figure
Ybs = [];
Xbs = [];
for D = 50:25:900;

inds = find((Dists<D+50).*(Dists>D));
[~,iy] = ind2sub(size(Dists),inds);
S1 = Speeds(inds);

[Xb, Yb, stdXb, stdYb, steXb, steYb] = BinData_v1(iy, S1, 220);
Xbs = [Xbs ; Xb];
Ybs = [Ybs ; Yb];

hold all;
end

h = ribbon(Xbs', Ybs')
for i=1:numel(h)
    h(i).FaceAlpha=0.6;
end
ylabel('Time (h)')
xlabel('Distance from wound (\mum)')
zlabel('Radial Velocity')
set(gca,'ytick',[0:20:220], 'yticklabel',[0:20:220]/2,'xtick',25\[30:60:600]/PixelSize, 'xticklabel',30:60:600)
colormap(flipud(plasma))
%% V/D at T heatmap
figure
imagesc(Ybs)
colormap(flipud(inferno))
set(gca,'clim',[-5,5])
cb = colorbar
xlabel('T (h)')
ylabel('Distance from wound (\mum)')
set(gca,'xtick',[0:20:220], 'xticklabel',[0:20:220]/2,'ytick',25\[30:60:600]/PixelSize, 'yticklabel',30:60:600)
xlabel(cb,'Radial Velocity')
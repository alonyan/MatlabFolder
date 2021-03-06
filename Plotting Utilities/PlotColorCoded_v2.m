function [h ,Density,Bins, Color] = PlotColorCoded_v2(XX, YY, Jxx, Jyy, JumpX, JumpY)

NbinsY = round((max(YY) - min(YY))/JumpY);
NbinsX = round((max(XX) - min(XX))/JumpX);


Jxy = Jxx&Jyy;
%prepare colorcoding
[DensityMatrix, Bins] = hist3([XX(Jxy) YY(Jxy)], [NbinsX NbinsY]);
DensityMatrix = DensityMatrix./mean(DensityMatrix(:));
DensityMatrix = imgaussfilt(DensityMatrix,1);
Color = interp2(Bins{2}, Bins{1}, DensityMatrix, YY(Jxy), XX(Jxy), 'spline');
colormap(plasma);
%h = scatter(XX(Jxy), YY(Jxy), 1.5, Color,'fill');
h = fastscatter(XX(Jxy), YY(Jxy),Color, 'markersize',10);%AOY
grid off;

axis tight
hold on;
% now plot outliers
Xlim = get(gca, 'Xlim');
Xtemp = XX(~Jxx);
Ytemp = YY(~Jxx);
Jtemp = (Xtemp < Xlim(1));
plot(Xlim(1)*ones(1, sum(Jtemp)), Ytemp(Jtemp), 'x');
Jtemp = (Xtemp > Xlim(2));
plot(Xlim(2)*ones(1, sum(Jtemp)), Ytemp(Jtemp), 'x');

Ylim = get(gca, 'Ylim');
Xtemp = XX(~Jyy);
Ytemp = YY(~Jyy);
Jtemp = (Ytemp < Ylim(1));
plot(Xtemp(Jtemp), Ylim(1)*ones(sum(Jtemp), 1), 'x');
Jtemp = (Ytemp > Ylim(2));
plot(Xtemp(Jtemp), Ylim(2)*ones(sum(Jtemp), 1), 'x');
hold off;


Density = DensityMatrix;
Bins = Bins;

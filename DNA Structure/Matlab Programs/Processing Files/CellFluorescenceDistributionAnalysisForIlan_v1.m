%clear
close all
NormRange = [1e-3 2e-3];
filepath = 'D:\Oleg\Students\Ilan\Experiment\020210\'

%%  Load picture
picName =  's_224_2mkW_30m_c_4.mat'
load([filepath picName]);
ScanParam
[Pict1, Norm1, Pict2, Norm2, PixSize, LineScaleV, Counts] = ReconstructImage_v4(AI, Cnt, 1, ScanParam);
pic1 = Pict1./Norm1;pic2 = Pict2./Norm2;
 meanPic = mean([pic1(find(~isnan(pic1))); pic2(find(~isnan(pic2)))])
stdPic = std([pic1(find(~isnan(pic1))); pic2(find(~isnan(pic2)))])
% range =meanPic+ stdPic*[-1 3];
range =[ min(min(pic1(:)), min(pic2(:))) max(max(pic1(:)), max(pic2(:))) ]; % change made by ilan 09/02/2010 17:47
subplot(1, 2, 1); imagesc(pic1, range);axis image; axis off;  subplot(1, 2, 2); imagesc(pic2, range);axis image; axis off; colorbar; figure(gcf);
%%
figure;
imagesc(pic1, range);axis image; axis off;
title('Draw line in the center of the cell -  right-click and choose Create Mask');
[BW, xi, yi] = roipoly;

%  normal to the center line 
w_um = 2; % width in um
step = 1; % in pixels
w = w_um/PixSize;  % to pixels
dx = (xi(2) - xi(1))/sqrt( (xi(2) - xi(1))^2 + (yi(2) - yi(1))^2);
dy = (yi(2) - yi(1))/sqrt( (xi(2) - xi(1))^2 + (yi(2) - yi(1))^2);
nx = dy;
ny = -dx;
Xc = xi(1) : (step*dx) : xi(2);
Yc = yi(1) : (step*dy) : yi(2);
Xc = Xc(:);
Yc = Yc(:);


w = w_um/PixSize; % to pixels
X =Xc *[1 1]  + w.*nx*ones(size(Xc))*[1 -1];
Y =Yc *[1 1]  + w.*ny*ones(size(Yc))*[1 -1];


clear I cx cy steps;
for i = 1:length(Xc),
    [cx, cy,I(:, i)]=improfile(pic1, X(i, :), Y(i, :), w);
    %plot(I)
    %figure(gcf)
    %size(I);
    steps(i) = sqrt(mean(diff(cx).^2+diff(cy).^2));
    %pause;
end;
%%
if find(abs(diff(step)) > 1e-10),
    error('step sizes are different in between different profiles!!!');
end;

profile_vector = ((1:size(I, 1)) - size(I, 1)/2)*step(1)*PixSize;
plot(profile_vector, I)
figure(gcf)

%%  Fit

for i=1:size(I, 2),
    k = find(~isnan(I(:, i)));
    %FP = fit(profile_vector(k)', I(k, i), 'gauss1');
    plot(profile_vector', I(:, i));
    title('Zoom into fitting range');
    figure(gcf)
    pause
    k = InAxes;
    beta = nlinfitWeight1(profile_vector(k)', I(k, i), @MembraneBulkBacteriaDistributionTableFit, [max(I(k, i))/4 max(I(k, i))/2 0.3 0], ones(size(I(k, i))), LookUpCell);
    plot(profile_vector', [I(:, i) MembraneBulkBacteriaDistributionTableFit(beta, profile_vector', LookUpCell)]);
    figure(gcf);
    pause;
   % FitParam.widths(i) = FP.c1;
%     FitParam.widths(i) = beta(3);
%     cB1(i, :) = cR(i, :) + FitParam.widths(i)*normVect(i, :); 
%     cB2(i, :) = cR(i, :) - FitParam.widths(i)*normVect(i, :);     
end;


%% Create table
x = -2:0.05:2; % in um
R = 0.2:0.025:0.8;
length(R)
% sample surface distributions
for i = 1: length(R), 
    i
    SI(i, :) = MembraneBulkBacteriaDistribution([1 0 R(i) 0], x, [0.25 30 1 1 1]);
    BI(i, :) = MembraneBulkBacteriaDistribution([0 1 R(i) 0], x, [0.25 30 1 1 1]);
end;

LookUpCell.SI = SI;
LookUpCell.BI = BI;
LookUpCell.x = x;
LookUpCell.R = R;
LookUpCell.wXY = 0.25;
LookUpCell.wSq = 30;
LookUpCell.stringSI = 'MembraneBulkBacteriaDistribution([1 0 R(i) 0], x, [0.25 30 1 1 1]);';
LookUpCell.stringBI = 'MembraneBulkBacteriaDistribution([0 1 R(i) 0], x, [0.25 30 1 1 1]);';


[xx, RR] = meshgrid(LookUpCell.x, LookUpCell.R);
LookUpCell.xx = xx;
LookUpCell.RR = RR;

save 'D:\Oleg\Matlab Programming\DLSreadProject\Fits\LookUpCell' LookUpCell

%%


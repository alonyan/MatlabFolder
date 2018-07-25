%clear
close all
NormRange = [1e-2 3e-2];
fpath = 'D:\People\Manish\Experiments\220410\'
scrsz = get(0,'ScreenSize'); 
fig1 = figure('PaperSize',[20.98 29.68], 'Position', scrsz + [0 34 1440 -108]);
fig2 = figure('PaperSize',[20.98 29.68], 'Position', scrsz + [0 34 1440 -108]);


%%  Load single picture
%picNum = 86;
%picName = fnames(picNum).name
picName = 'Rh6gel_imag_1.mat';
load([fpath picName]);
ScanParam
[Pict1, Norm1, Pict2, Norm2, PixSize, LineScaleV, Counts] = ReconstructImage_v4(AI, Cnt, 3, ScanParam, 0.05);
pic1 = Pict1./Norm1;pic2 = Pict2./Norm2;
 meanPic = mean([pic1(find(~isnan(pic1))); pic2(find(~isnan(pic2)))])
stdPic = std([pic1(find(~isnan(pic1))); pic2(find(~isnan(pic2)))])
% range =meanPic+ stdPic*[-1 3];
range =[ min(min(pic1(:)), min(pic2(:))) max(max(pic1(:)), max(pic2(:))) ]; % change made by ilan 09/02/2010 17:47
subplot(1, 2, 1); imagesc(pic1, range);axis image; axis off;  subplot(1, 2, 2); imagesc(pic2, range);axis image; axis off; colorbar; figure(gcf);

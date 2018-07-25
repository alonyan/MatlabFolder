%%  Load single picture
fpath = 'D:\People\Manish\Experiments\190410\'
picName = 'temp1'
load([fpath picName]);
ScanParam
[Pict1, Norm1, Pict2, Norm2, PixSize, LineScaleV, Counts] = ReconstructImage_v4(AI, Cnt, 1, ScanParam);
pic1 = Pict1./Norm1;pic2 = Pict2./Norm2;
 meanPic = mean([pic1(find(~isnan(pic1))); pic2(find(~isnan(pic2)))])
stdPic = std([pic1(find(~isnan(pic1))); pic2(find(~isnan(pic2)))])
% range =meanPic+ stdPic*[-1 3];
range =[ min(min(pic1(:)), min(pic2(:))) max(max(pic1(:)), max(pic2(:))) ]; % change made by ilan 09/02/2010 17:47
subplot(1, 2, 1); imagesc(pic1, range);axis image; axis off;  subplot(1, 2, 2); imagesc(pic2, range);axis image; axis off; colorbar; figure(gcf);
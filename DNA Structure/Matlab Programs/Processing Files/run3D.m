%%  Load picture
clear pic1 pic2 Pict1 Norm1 Pict2 Norm2 LineScaleV Counts V
filepath = 'D:\Oleg\Students\Ilan\Experiment\GL_3D'
picName = 'gl_mind_egfp_525_7.mat'
load([filepath '\' picName]);
ScanParam
for i=1:ScanParam.Planes,
    [ Pict1, Norm1, Pict2, Norm2, PixSize, LineScaleV, Counts] = ReconstructImage_v4(AI, Cnt, i, ScanParam);
    pic1 = Pict1./Norm1;pic2 = Pict2./Norm2;
   % meanPic = mean([pic1(find(~isnan(pic1))); pic2(find(~isnan(pic2)))])
   % stdPic = std([pic1(find(~isnan(pic1))); pic2(find(~isnan(pic2)))])
   % range =meanPic+ stdPic*[-1 3];
  % size(pic1)
   V(:, :, i) = pic1;
end;
%%
%rescaling 
V =  (V - min(V(:)))/(max(V(:)) - min(V(:)));
viewer3d(V)
%%
imagesc(V(:, :, 10));figure(gcf)
BW = roipoly;

%%
for i = 1:ScanParam.Planes,
    V(:, :, i) =  V(:, :, i) .*BW;
end
V =  (V - min(V(:)))/(max(V(:)) - min(V(:)));
%%
viewer3d(V)

%%
%%  Load picture
clear pic1 pic2 Pict1 Norm1 Pict2 Norm2 LineScaleV Counts V
filepath = 'D:\Oleg\Students\Ilan\Experiment\GL_3D'
picName = 'gl_mind_egfp_b2.mat'
load([filepath '\' picName]);
ScanParam
for i=1:ScanParam.Planes,
    [ Pict1, Norm1, Pict2, Norm2, PixSize, LineScaleV, Counts] = ReconstructImage_v4(AI, Cnt, i, ScanParam);
    pic1 = Pict1./Norm1;pic2 = Pict2./Norm2;
   % meanPic = mean([pic1(find(~isnan(pic1))); pic2(find(~isnan(pic2)))])
   % stdPic = std([pic1(find(~isnan(pic1))); pic2(find(~isnan(pic2)))])
   % range =meanPic+ stdPic*[-1 3];
  % size(pic1)
   V(:, :, i) = pic1;
end;
%%
%rescaling 
V =  (V - min(V(:)))/(max(V(:)) - min(V(:)));
viewer3d(V)
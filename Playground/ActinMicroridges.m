%img = imread('/Volumes/STORE N GO/temp/raw cut.tif');
%img = double(img);
figure();
imagesc(img)
shg
%%
[res, theta, nms, rotations] = steerableDetector(steerableDetector(img, 2, 1.5),4, 1.5);
imagesc(res.*theta);
shg
%%
[h,x]= hist(res(:),200);
h(x<=0)=[];
x(x<=0)=[];
Thresh = triangleThresh(h,x)
%
figure()
maskAfter = res>Thresh;
se = strel('disk',1);
se2 = strel('disk',2)

maskAfter = imclose(maskAfter,se);
subplot(1,2,1)
imagesc(maskAfter.*img)

subplot(1,2,2)
imagesc(maskBefore.*img)
%%
figure()
imagesc(bwmorph(maskAfter,'skel',inf))

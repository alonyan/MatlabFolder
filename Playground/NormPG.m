
filename = '/RazorScopeData/RazorScopeSets/Jen/CorneaWound/CorneaWound_HetHet_2019Feb04/acq_2/fused_tp_0_ch_1.tif';

warning('off')
info = imfinfo(filename);
warning('on')
num_images = numel(info);

blnk = zeros([info(1).Height info(1).Width]);
siz = [size(blnk),num_images];
img = zeros(siz,'single');

for k = 1:num_images
    img1 = imread(filename, k, 'Info', info);
    img1=single(img1)/2^16;
        
    img(:,:,k) = img1; %add to singlefilestac
end


%%
img = img.*(img>32);
import ij.IJ
%Threshold image
Thresh = exp(meanThresh(log(img)));
mask1 = img>Thresh;

%find fill ratio in each slice
fillRatio = squeeze(mean(mean(mask1)));

%only scale image if there's sample there
fillThresh = 0.1; %max(0.1, otsuThreshImg(fillRatio));
idxToScale = fillRatio>fillThresh;


S = Smoothing(squeeze(mean(mean(single(mask1).*img))),'neigh',10); 
intensityAtPlato = median(S(find(S==max(S))-20:find(S==max(S))+20));
scalingFactor = (intensityAtPlato./S);
scalingFactor(~idxToScale)=1;

C = permute(bsxfun(@times, permute(img, [3 1 2]), scalingFactor), [2 3 1]);




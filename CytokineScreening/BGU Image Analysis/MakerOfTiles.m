%% Load Data

Prods100 = load('/Users/Alonyan/Google Drive/Experiments/Microscopy Data BGU/070515/10_Prods_3big.mat','scan')

%10_Prods_3big (1)


%% Put images in one matrix
clear A;
scanData = Prods100.scan(1);
for i=1:length(scanData.Point)
    for Fnum=1:length(scanData.Point(1).Filter)
     A(:,:,i,Fnum) = scanData.Point(i).Filter(Fnum).Pic';
    end;
end
A(:,:,:,:) = A(end:-1:1,:,:,:);
%% Combine to one frame 
Chan = 1; %use DAPI channel for alignment
Im = MakeImage_v4(A,Chan,10, [1, 0.1], [0.1, 1]);
%%
figure();
imagesc(Im(:,:,3),[250, 40000]);
colormap('gray');
figure(gcf)



%%

MakeImage_v3(A,4,10, [1, 0.1], [0.1, 1])
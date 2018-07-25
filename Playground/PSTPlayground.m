clc  % clear screen
clear all  % clear all variables
close all   % close all figures
%%

%% Set all parameters and run PST
% low-pass filtering (also called localization) parameter
I = imread('/Users/Alonyan/Downloads/PST code released march 07 2016/PST code released march 07 2016/lena_gray_512.tif');
handles.LPF=0.5; % Gaussian low-pass filter sigma 

% PST parameters
handles.Phase_strength=1;  % PST  kernel Phase Strength (0 to 1)
handles.Warp_strength=100;  % PST Kernel Warp Strength

% Thresholding parameters (for post processing)
handles.Thresh_min=-1;      % minimum Threshold  (a number between 0 and -1)
handles.Thresh_max=1;  % maximum Threshold  (a number between 0 and 1)

% choose to compute the analog or digital edge
Morph_flag = 0 ; %  Morph_flag=0 to compute analog edge and Morph_flag=1 to compute digital edge.

% Apply PST and find features (sharp transitions)
tic
[Edge1 PST_Kernel]= PST(I,handles,Morph_flag);
toc

%%
figure
[D_PST_Kernel_x D_PST_Kernel_y]=gradient(PST_Kernel);
mesh(sqrt(D_PST_Kernel_x.^2+D_PST_Kernel_y.^2))
title('PST Kernel phase Gradient')
%% Make some 3D figure
I = imread('/Users/Alonyan/Downloads/PST code released march 07 2016/PST code released march 07 2016/lena_gray_512.tif');
I = double(I);
I = padarray(I,[2,2],0)
g1 = Gaussian([1,50,3],1:100);

g1(g1>0.05)=0.05;
g1(g1<0.01)=0;

g1 = g1./sum(g1);
g = permute(repmat(g1',1,size(I,1),size(I,2)),[2,3,1]);
I = I.*g;
I = I./max(I(:));

%%
II = tiffread29('/Users/Alonyan/Documents/Expt/OpenSPIM_Drosophila_11/tiff/spim_TL10_Angle1.tif');
I = zeros(size(II(1).data,1),size(II(1).data,2),size(II,2));
nFrames = size(II,2);
for i=1:size(I,2)
I(:,:,i) = getfield(II(i),'data');
end;
I = mat2gray(I);
%I = (I-min(I(:)))/(max(I(:))-min(I(:)));


%%
figure
for i=1:size(I,2)
    
    imagesc(I(:,:,i))
shg
pause(0.1)
title('Image')
end


%% Set all parameters and run PST
% low-pass filtering (also called localization) parameter
handles.LPF=1;%.0015; % Gaussian low-pass filter sigma 

% PST parameters
handles.Phase_strength=1;  % PST  kernel Phase Strength
handles.Warp_strength=30;  % PST Kernel Warp Strength

% Thresholding parameters (for post processing)
handles.Thresh_min=-1;      % minimum Threshold  (a number between 0 and -1)
handles.Thresh_max=1;  % maximum Threshold  (a number between 0 and 1)

% choose to compute the analog or digital edge
Morph_flag = 0 ; %  Morph_flag=0 to compute analog edge and Morph_flag=1 to compute digital edge.

AspectRatio = [1 1 1]
% Apply PST and find features (sharp transitions)
tic
[Edge PST_Kernel]= PST3D(I,AspectRatio,handles,Morph_flag);
toc


  %%
  close all;
figure
for i=1:nFrames
    
    imagesc(Edge(:,:,i))
    %imagesc((squeeze(Edge(200:800,600:800,i))-mean(Edge(:)))>0.01)
axis equal
shg
title(['Image  ' num2str(i)])
pause(0.1)
end
    
%%

Edge2D = zeros(size(Edge));
tic
for i=1:63
[Edge2D(:,:,i) PST_Kernel]= PST(I(:,:,i),handles,Morph_flag);
end
toc;
  %%
  close all;
figure
for i=1:nFrames
    
    imagesc(Edge2D(:,:,i)./max(Edge2D(:)))
shg
title(['Image  ' num2str(i)])
pause(0.1)
end
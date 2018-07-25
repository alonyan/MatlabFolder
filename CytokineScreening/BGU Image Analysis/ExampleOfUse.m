%% path to files

fpath = '/Users/Alonyan/GoogleDrive/Experiments/Microscopy Data BGU/240615';

%% Load Data
fname = 'ProdsBottom100'; 

Data=struct;
nameTemp = '100_Prods';%template of files to load
flist = dir(fpath);
flist = {flist.name};
scans = struct;


ix=regexp(flist, nameTemp);
ix=~cellfun('isempty',ix);
flistDo = flist(ix);
flistDo' %prints files that will open

DataTemp = load([fpath filesep flistDo{1}],'scan');
scans = DataTemp.scan(:);
for i=1:length(flist(ix))
    DataTemp = load([fpath filesep flistDo{i}],'scan');
    scans = [scans; DataTemp.scan(:)];
end


Data.(fname).scans = scans;
clear DataTemp scans

%% Make images from tiles

for scanNo = 1:length(Data.(fname).scans)
    scanNo
    scanData = Data.(fname).scans(scanNo);
    if ~isempty(scanData.Point)
    for i=1:length(scanData.Point);
        if ~isempty(Data.(fname).scans(scanNo).Point(i).Filter);
            for Fnum=1:length(scanData.Point(1).Filter)
                A(:,:,i,Fnum) = scanData.Point(i).Filter(Fnum).Pic';%makes big matrix of tiles
            end;
        end
    end
    A(:,:,:,:) = A(end:-1:1,:,:,:);
    % Combine to one frame 

   Data.(fname).scans(scanNo).A = A; %tiles
    Chan = 1; %use BF channel for alignment
    Data.(fname).scans(scanNo).Im = MakeImage_v4(A,Chan,sqrt(size(A,3)), [1, 0.1], [0.1, 1]);%full image
    clear A;
    end

end;
empty_elems = arrayfun(@(s) isempty(s.Point),Data.(fname).scans)%remove empties (scanning bugs, etc.)
Data.(fname).scans(empty_elems) = [];

%% Again, a bit clumsy, Giving each of the channels its own color. MATLAB is a bit of a pain sometimes 
fname = 'ProdsBottom100';

for scanNo = 1:length(Data.(fname).scans)
scanNo
ImToShow = Data.(fname).scans(scanNo).Im;%5 channels in this example
outlierFraci = [5.0000e-04 1.0000e-05 5.0000e-03 8.0000e-03 3.0000e-04];%remove small fraction of outliers (hot pixels) the more "sparse" the image, the smaller this number is
Cmin = [1000 250 3100 200 250];%background fluorescence (contrast)

for i=1:5;

outlierFrac = outlierFraci(i);
resIM = reshape(ImToShow(:,:,i),1,[]);
resIM(resIM==0)=[];
[h1,x1] = hist(log(resIM),10000);
Cmax(i) = exp(x1(find(cumsum(h1)/sum(h1)>=(1-outlierFrac),1)));

Crange(i) = round(Cmax(i)-Cmin(i));%color range
 
ClimsI{i} = (0:round(Cmax(i)-Cmin(i)))./Crange(i);
 
[Ilow,Jlow]=ind2sub(size(ImToShow(:,:,i)), find(ImToShow(:,:,i)<=Cmin(i)));
[Ihigh,Jhigh]=ind2sub(size(ImToShow(:,:,i)), find(ImToShow(:,:,i)>=Cmax(i)));

if numel(Ilow)>0
for cnt = 1:length(Ilow)
    ImToShow(Ilow(cnt), Jlow(cnt), i)= Cmin(i);
end
end
if numel(Ihigh)>0
for cnt = 1:length(Ihigh)
    ImToShow(Ihigh(cnt), Jhigh(cnt), i)= Cmax(i);
end
end
end;


colorMaps{1} = repmat([1 1 1],length(ClimsI{1}),1)'.*repmat(ClimsI{1},3,1);%white
colorMaps{2} = repmat([0 1 0],length(ClimsI{2}),1)'.*repmat(ClimsI{2},3,1);%green
colorMaps{3} = repmat([0 0 1],length(ClimsI{3}),1)'.*repmat(ClimsI{3},3,1);%blue
colorMaps{4} = repmat([1 0 0],length(ClimsI{4}),1)'.*repmat(ClimsI{4},3,1);%red
colorMaps{5} = repmat([1 0 1],length(ClimsI{5}),1)'.*repmat(ClimsI{5},3,1);%magenta

for i=1:5
Channel{i} = ind2rgb(round(ImToShow(:,:,i)-Cmin(i)),colorMaps{i}');%make each channel an RGB so you can combine later
end


%Data.(fname).scans(scanNo).colorMaps = colorMaps;
Data.(fname).scans(scanNo).Channel = Channel;
end
%% show full RGB figures


for scanNo = 1:length(Data.(fname).scans);
    scanNo
Channel = Data.(fname).scans(scanNo).Channel;
hFig = figure('Name','Full RGB image','Position', [800 100 512 512]);

%set(hFig, 'Position', [50        50       512        512]);

RGB=zeros(size(Channel{1}));

Brightness = [0 1 0.5 0.5 1];%what channels to show? You can play with brightness [0.2 0.5 0.7 0.5 0.8]
for i=1:5
RGB = RGB+Brightness(i).*Channel{i};
end;

imshow(RGB)
set(gca,'Position' ,[0 0 1 1])
figure(gcf)

Data.(fname).scans(scanNo).RGB = RGB;
pause
close all;
end

%% You can now look at whatever RGB image you want
scanNo = 7
imshow(Data.(fname).scans(scanNo).RGB)

%% don't forget to save!
ProdsBottom100 = Data.ProdsBottom100;
save([fpath filesep 'Data240615_100_clusts'], 'ProdsBottom100','-v7.3')






%%    Segmentation For 100% screeners, no need to do CD25 analysis, all cells are responsive.
fname = 'ProdsBottom100';

for scanNo = Data.(fname).keep;
clear I gradmag2 fgm bgm; 
f = fspecial('sobel');
colormap('gray')


ROICD25 = (Data.(fname).scans(scanNo).Channel{4}(:,:,1));%CD25 Channel, red (1)
ROIpSTAT5 = (Data.(fname).scans(scanNo).Channel{2}(:,:,2));%pSTAT5 channel, green (2)
ROIDAPI = (Data.(fname).scans(scanNo).Channel{3}(:,:,3)); %DAPI Channel, blue (3)

GMDAPI = GradMag_v1(ROIDAPI); %use DAPI for segmentation

se = strel('disk', 3);
%following http://www.mathworks.com/help/images/examples/marker-controlled-watershed-segmentation.html

IobrDAPI = imreconstruct(imerode(ROIDAPI, se), ROIDAPI); %open-by-reconstruction

%imagesc(IobrDAPI);figure(gcf) %if you want to see step by step, remove %s
%pause

IobrcbrDAPI = imcomplement(imreconstruct(imcomplement(imdilate(IobrDAPI, se)), imcomplement(IobrDAPI)));%close-by-reconstruction
fgm = imregionalmax(IobrcbrDAPI); %find regional maxima

%imagesc(fgm);figure(gcf)
%pause;

I = ROIDAPI;
I(fgm) = 1; %highlight regional maxima on original

%imagesc(I);figure(gcf)
%pause;

%level = graythresh(I);
ROIDAPIBW = im2bw(I,0.8); %find individual objects

%  imagesc(ROIDAPIBW); figure(gcf)

D = bwdist(ROIDAPIBW);%distance transform

DL = watershed(D); %find watershed lines
bgm = DL == 0;
I(bgm) = 1; %highlight watershed lines bw objects, (segmentation)
%imagesc(I);figure(gcf)
%pause;

%If you feel the need to find specific outlines, do this:

%gradmag2 = imimposemin(GMDAPI, bgm | fgm);
%L = watershed(gradmag2);

%otherwise, basically done

I = ROICD25;
I(fgm | bgm) = 1;
% imagesc(ROICD25);figure(gcf)
% pause
imagesc(I);figure(gcf)

% pause;
% Stats on each region

stats = regionprops(DL>=3, ROIpSTAT5, 'WeightedCentroid','MeanIntensity', 'Area');%pSTAT5
statsCD25 = regionprops(DL>=3, ROICD25, 'WeightedCentroid','MeanIntensity', 'Area');%CD25

centroids = cat(1, stats.WeightedCentroid);
Mass = cell2mat({stats.Area}').*cell2mat({stats.MeanIntensity}');

MassCD25 = cell2mat({statsCD25.Area}').*cell2mat({statsCD25.MeanIntensity}'); %if you want to look only at CD25+ later...


%remove NANs
nocent = isnan(centroids);
centroids(nocent(:,1),:)=[];
Mass(nocent(:,1))=[];
MassCD25(nocent(:,1))=[];

Data.(fname).scans(scanNo).centroids = centroids;
Data.(fname).scans(scanNo).Mass = Mass;
Data.(fname).scans(scanNo).MassCD25 = MassCD25;


% presentation
figure('Position',[360   278   1200   400])
subplot(1,2,1)

scatter(centroids(:,1), centroids(:,2), Mass,'MarkerFaceColor', 'b','MarkerEdgeColor', 'b'); set(gca,'Ydir','reverse'); figure(gcf)


Xcm = Mass'*centroids(:,1)./sum(Mass);
Ycm = Mass'*centroids(:,2)./sum(Mass);

Data.(fname).scans(scanNo).CM = [Xcm Ycm];% projected position of producer

hold on;
scatter(Xcm, Ycm, 100,'MarkerFaceColor', 'k','MarkerEdgeColor', 'k'); 

axis equal;
hold off;

subplot(1,2,2)
Channel = Data.(fname).scans(scanNo).Channel;

RGB=zeros(size(Channel{1}));

Brightness = [0 2 0.5 1 1];
for i=1:5
RGB = RGB+Brightness(i).*Channel{i};
end;



imshow(RGB)
pause
close all;
%end
end;
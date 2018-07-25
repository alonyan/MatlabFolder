function R = AnalyzeRegionsInRonFiles_v1(centersTregs, pSTAT5sum, mask, varargin)

% v1 Similar to AnalyzeRegion_v6 but works on Rons files

Pix_um = 1;
figure;
debugSource = 0;
ThreshSources = 110; %74;
SourceRadiusPix = 12;
dilateDiskRadius = 5; % not much difference between 3 and 5
minSourceArea = 5; 

debugTregs = 0;
ThreshTregs = ParseInputs('Threshold Tregs', 70, varargin);
TregRadiusPix = 10;
dilateDiskRadius = 5; % not much difference between 3 and 5
minTregArea = 5; 

SourceTopPercentage = 0.2;

minDistance = 5;
DistBinSize =ParseInputs('Distance Bin Size', 5, varargin);
MaxDistance = 300; %in microns
CloseNeighborDistance = 20; %in microns


 %if isfield(S, 'mask'),
     R.stats.mask = mask;
     R.stats.area_um = polyarea(mask(:,1), mask(:,2))*Pix_um^2;
     R.stats.Treg_density = size(centersTregs, 1)/R.stats.area_um;
 %    R.stats.Source_density = length(Sources)/R.stats.area_um;
% end
 
% calculate areas for pair distribution functions
%AreasTreg = AreasForPairDistFunction(centersTregs, mask, DistBinSize/Pix_um, MaxDistance/Pix_um)*Pix_um.^2;
%AreasSources = AreasForPairDistFunction(centersSources, mask, DistBinSize/Pix_um, MaxDistance/Pix_um)*Pix_um.^2;

  
 %Now to analysis
 
 % get pSTAT5 data

    
 R.stats.Treg_ave_pSTAT5 = mean([pSTAT5sum]);
% R.Tregs =  Tregs;
% R.Sources = Sources;

  

 


% spatial correlations in pSTAT5 level between different Tregs
[X1, X2] =  meshgrid(centersTregs(:, 1));
[Y1, Y2] = meshgrid(centersTregs(:, 2));
distances_Tregs = sqrt((X1 - X2).^2 + (Y1 - Y2).^2)*Pix_um;
clear X1 X2 Y1 Y2;
prodSTAT5 = pSTAT5sum(:)*pSTAT5sum(:)';
%J = find((tril(distances_Tregs)>0)&(tril(distances_Tregs) < MaxDistance));
%distances_Tregs = distances_Tregs(J);
%prodSTAT5 = prodSTAT5(J);

len = ceil(MaxDistance/DistBinSize);
BinNo = ceil(distances_Tregs/DistBinSize);


DistBins = (0.5+(0:(len-1)))*DistBinSize;
corr_pSTAT5 = zeros(size(DistBins));
error_corr = zeros(size(DistBins));


for i = 1:len,
    %i
    [I, J] = find(BinNo == i);
    ind = sub2ind(size(BinNo), I, J);
    Nbin(i) = length(J);
    if Nbin(i) > 0, 
        corr_pSTAT5(i) = mean(prodSTAT5(ind)) - mean(pSTAT5sum(J))^2;
        error_corr(i) = std(prodSTAT5(J))/sqrt(Nbin(i))*sqrt(2); % multiply by sqrt(2) since pairs are not independent

    end
end

R.autocorr_pSTAT5.r = DistBins;
R.autocorr_pSTAT5.G = corr_pSTAT5; % - mean([Tregs.pSTAT5sum])^2;
R.autocorr_pSTAT5.error_G = error_corr;
R.autocorr_pSTAT5.Nbin = Nbin;

%PairDist.r = DistBins;
%PairDist.Treg_Treg = Nbin./AreasTreg/R.stats.Treg_density;
%PairDist.error_Treg_Treg = sqrt(Nbin)./AreasTreg/R.stats.Treg_density/sqrt(2); % double counting of pairs

%R.PairDist = PairDist;


function Areas = AreasForPairDistFunction(coords, mask, DistBinSize, MaxDistance)
[xmask, ymask] = poly2cw(mask(:, 1), mask(:, 2)); %mask to clockwise order
Npoly = 100; % number of edges in a polygon approximation of a circle
% create circles/polygons
len = ceil(MaxDistance/DistBinSize);
Areas = zeros(1, len);
theta = linspace(0, 2*pi, Npoly);
x1 = cos(theta);
y1 = -sin(theta); 
for i = 1:len,
    crcl(i).x = i*DistBinSize*x1;
    crcl(i).y = i*DistBinSize*y1;    
end

%place circles on each cell and find cross section area with the LN mask
for j = 1:size(coords, 1),
    if mod(j, 10) == 0,
        disp(['Analyzing areas ' num2str(j) ' out of ' num2str(size(coords, 1))]);
    end
    for i = 1:len,
        [xb, yb] = polybool('intersection', xmask, ymask, ...
            coords(j, 1) + crcl(i).x, coords(j, 2)+ crcl(i).y);
        area1(i) = polyarea(xb, yb);
    end
    Areas = Areas + diff([0 area1]);
end




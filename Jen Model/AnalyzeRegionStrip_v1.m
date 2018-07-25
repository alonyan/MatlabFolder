function R = AnalyzeRegionStrip_v1(S, varargin)
% 14.10.15
% v3 similar to AnalyzeRegion_v2 but works with saved images step by step
% v4 added correlation analysis for each source
% v5 changed pSTAT5 correlation calculus: measuring average pSTAT5 for each
% distance bin
% added varargin couples
% 'Threshold Tregs' ThreshTregs
% 'Distance Bin Size' DistBinSize
% v6 calculates pair distribution functions


Pix_um = 1;
debugTregs = 0;
TregChannel = find(~cellfun('isempty', strfind({S.Channel}, 'FoxP3GFP')));
ThreshTregs = ParseInputs('Threshold Tregs', 30, varargin);
TregRadiusPix = 10;
dilateDiskRadius = 5; % not much difference between 3 and 5
minTregArea = 5; 

%SourceTopPercentage = 0.2;

minDistance = 5;
DistBinSize = 5%ParseInputs('Distance Bin Size', 10, varargin);%Alon
MaxDistance = 500; %in microns%Alon
CloseNeighborDistance = 20; %in microns


pSTAT5Channel = find(~cellfun('isempty', strfind({S.Channel}, 'pSTAT5')));


 %Now to Tregs
 % image Tregs
 Im_Tregs = double(S(TregChannel).data(:, :))/255;
 Im(:, :, 1) = Im_Tregs;
 
 %if isempty(SourceChannel)
 Im_sources = zeros(size(Im_Tregs));

 
 Im(:, :, 2) = zeros(size(Im_sources));
 Im(:, :, 3) = zeros(size(Im_sources));
 
 imagesc(Im);
 axis image
 set(gca, 'Ydir', 'normal', 'FontSize', 14);
 title('Tregs: original image: hit any key', 'FontSize', 14);
 figure(gcf)
 if debugTregs, 
     pause;
 end

 %close image
 dilateDisk =  strel('disk', dilateDiskRadius);
 Im_Tregs = imclose(Im_Tregs, dilateDisk);
 Im(:, :, 2) = Im_Tregs;
 imagesc(Im);
 set(gca, 'Ydir', 'normal');
 axis image
 title('Tregs: original+closed image: hit any key');
 figure(gcf)
 if debugTregs, 
     pause;
 end
 
 %threshold image
 Im_Tregs = im2bw(Im_Tregs, ThreshTregs/255);
 Im(:, :, 3) = Im_Tregs;
 imagesc(Im);
 set(gca, 'Ydir', 'normal');
 axis image
 title('Tregs: original+closed+thresholded image: hit any key');
 figure(gcf)
 if debugTregs, 
     pause;
 end
 
 v = axis;

 % find Tregs
 Tregs = bwconncomp(Im_Tregs, 8);
 Tregs = regionprops(Tregs, 'Centroid', 'Area', 'MajorAxisLength','BoundingBox');
 length(Tregs)
 centersTregs = reshape([Tregs.Centroid], 2, length(Tregs))';
 length(Tregs)
 
  % find several joined Tregs
 majAxTregs = [Tregs.MajorAxisLength];
 
 J = find(majAxTregs > 2*TregRadiusPix);
 length(J)
 for i = J,
    x1 = Tregs(i).BoundingBox(1);
    y1 = Tregs(i).BoundingBox(2);
    x2 = x1 + Tregs(i).BoundingBox(3);
    y2 = y1 + Tregs(i).BoundingBox(4);

    x1 = round(max(x1, 1));
    x2 = round(min(x2, size(Im_Tregs, 2)));
    y1 = round(max(y1,1));
    y2 = round(min(y2, size(Im_Tregs, 1)));               

    %rgn = Im_Tregs(y1:y2, x1:x2);
    % try thresholding the original image (without closing)
    orig = double(S(TregChannel(1)).data(y1:y2, x1:x2))/255;
    rgn = im2bw(orig, ThreshTregs/255);
    rgnTregs = bwconncomp(rgn, 8);
    rgnTregs = regionprops(rgnTregs, 'MajorAxisLength');
    majAx = max([rgnTregs.MajorAxisLength]);
    counter = 0;
  

    while (majAx > 2*TregRadiusPix)&(counter<5),
        counter = counter+1;
        orig = imerode(orig, strel('disk', 1));
        rgn = im2bw(orig, ThreshTregs/255);
        rgnTregs = bwconncomp(rgn, 8);
        rgnTregs = regionprops(rgnTregs, 'MajorAxisLength');
        majAx = max([rgnTregs.MajorAxisLength]);
    end
    
    %if this does not work start raising the threshold
    counter = 1;
    while (majAx > 2*TregRadiusPix)&(counter<30),
        counter = counter+1;
        rgn = im2bw(orig, (ThreshTregs+counter)/255);
        rgnTregs = bwconncomp(rgn, 8);
        rgnTregs = regionprops(rgnTregs, 'MajorAxisLength');
        majAx = max([rgnTregs.MajorAxisLength]);
    end

    
%     imagesc(rgn);
%     figure(gcf);
%     title(i)
%     pause;

    Im_Tregs(y1:y2, x1:x2) = rgn;
 end

% now find Tregs one more time 
 Tregs = bwconncomp(Im_Tregs, 8);
 Tregs = regionprops(Tregs, 'Centroid', 'Area', 'MajorAxisLength','BoundingBox');
 Tregs([Tregs.Area] < minTregArea) = [];
 centersTregs = reshape([Tregs.Centroid], 2, length(Tregs))';
 majAxTregs = [Tregs.MajorAxisLength];
 J = find(majAxTregs > 2*TregRadiusPix);
 size(J)
 length(Tregs)

 
 if debugTregs,
     hold on
     viscircles(centersTregs, repmat(TregRadiusPix, length(Tregs), 1), 'EdgeColor', 'y');
     hold off
 end;
 
 
 % look at everything together
 % remove Tregs that are too close to Sources (sources leaking into Treg channel)
 
 TregsPos = reshape([Tregs.Centroid], 2, length(Tregs))';
 TregsArea = [Tregs.Area]';
 

 centersTregs = reshape([Tregs.Centroid], 2, length(Tregs))';

 
 
 
 hold on
 %viscircles(centersSources, repmat(SourceRadiusPix, length(Sources), 1), 'EdgeColor', 'r');
 viscircles(centersTregs, repmat(TregRadiusPix, length(Tregs), 1), 'EdgeColor', 'g');
 hold off
 %pause;
 
 R.Tregs =  Tregs;
 %R.Sources = Sources;
 %R.stats.area_est_um = sum(sum(sum(S(TregChannel).data(:, :),3) >0))*Pix_um^2;

 %if isfield(S, 'mask'),
%      R.stats.mask = S.mask;
%      R.stats.area_um = polyarea(S.mask(:,1), S.mask(:,2))*Pix_um^2;
%      R.stats.Treg_density = length(Tregs)/R.stats.area_um;
%      %R.stats.Source_density = length(Sources)/R.stats.area_um;
%  else
%      R.stats.Treg_density = length(Tregs)/R.stats.area_est_um;
%      %R.stats.Source_density = length(Sources)/R.stats.area_est_um;
%  end
%  %%
% % calculate areas for pair distribution functions
% %mask1(:, 1) =  S.mask(:, 1)-S.position(1);  
% %mask1(:, 2) = S.mask(:, 2) - S.position(2); 
% %AreasTreg = AreasForPairDistFunction(centersTregs, mask1, DistBinSize/S.Pix_um, MaxDistance/S.Pix_um)*S.Pix_um.^2;
% %AreasSources = AreasForPairDistFunction(centersSources, mask1, DistBinSize/S.Pix_um, MaxDistance/S.Pix_um)*S.Pix_um.^2;
% 
%   
%  %Now to analysis
%  
%  % get pSTAT5 wild type
% CellMask = strel('disk', TregRadiusPix, 0);
% Im_pSTAT5 = double(S(pSTAT5Channel).data(:, :))/255;
% for i = 1:length(Tregs), 
%     Jy = max((round(Tregs(i).Centroid(2))-TregRadiusPix), 1):min((round(Tregs(i).Centroid(2))+TregRadiusPix), size(Im_Tregs, 1));
%     Jx = max((round(Tregs(i).Centroid(1))-TregRadiusPix), 1):min((round(Tregs(i).Centroid(1))+TregRadiusPix), size(Im_Tregs, 2));
%     CellMaskAr = CellMask.getnhood;
%     TempImage = Im_pSTAT5(Jy, Jx).*CellMaskAr(Jy-round(Tregs(i).Centroid(2))+TregRadiusPix+1, Jx-round(Tregs(i).Centroid(1))+TregRadiusPix+1);
%     Tregs(i).pSTAT5sum = sum(TempImage(:));
%     Tregs(i).threshold = ThreshTregs;
% %    pSTAT5mean(i) = mean(Im_pSTAT5(Tregs.PixelIdxList{i}));
% end
%     
%  R.stats.Treg_ave_pSTAT5 = mean([Tregs.pSTAT5sum]);
%  R.Tregs =  Tregs;
%  %R.Sources = Sources;
% 
%   
% 
%  
% 
% 
% % spatial correlations in pSTAT5 level between different Tregs
% [X1, X2] =  meshgrid(centersTregs(:, 1));
% [Y1, Y2] = meshgrid(centersTregs(:, 2));
% distances_Tregs = sqrt((X1 - X2).^2 + (Y1 - Y2).^2)*S.Pix_um;
% clear X1 X2 Y1 Y2;
% prodSTAT5 = [Tregs.pSTAT5sum]'*[Tregs.pSTAT5sum];
% %J = find((tril(distances_Tregs)>0)&(tril(distances_Tregs) < MaxDistance));
% %distances_Tregs = distances_Tregs(J);
% %prodSTAT5 = prodSTAT5(J);
% 
% len = ceil(MaxDistance/DistBinSize);
% BinNo = ceil(distances_Tregs/DistBinSize);
% 
% 
% DistBins = (0.5+(0:(len-1)))*DistBinSize;
% corr_pSTAT5 = zeros(size(DistBins));
% error_corr = zeros(size(DistBins));
% 
% 
% for i = 1:len,
%     %i
%     [I, J] = find(BinNo == i);
%     ind = sub2ind(size(BinNo), I, J);
%     Nbin(i) = length(J);
%     if Nbin(i) > 0, 
%         corr_pSTAT5(i) = mean(prodSTAT5(ind)) - mean([Tregs(J).pSTAT5sum])^2;
%         error_corr(i) = std(prodSTAT5(J))/sqrt(Nbin(i))*sqrt(2); % multiply by sqrt(2) since pairs are not independent
% 
%     end
% end
% 
% R.autocorr_pSTAT5.r = DistBins;
% R.autocorr_pSTAT5.G = corr_pSTAT5; % - mean([Tregs.pSTAT5sum])^2;
% R.autocorr_pSTAT5.error_G = error_corr;
% R.autocorr_pSTAT5.Nbin = Nbin;
% 
% PairDist.r = DistBins;
% PairDist.Treg_Treg = Nbin./AreasTreg/R.stats.Treg_density;
% PairDist.error_Treg_Treg = sqrt(Nbin)./AreasTreg/R.stats.Treg_density/sqrt(2); % double counting of pairs
% 
% 
% % % spatial correlations between sources and pSTAT5 level of Tregs
% 
% if ~isempty(Sources),
%     [X1, X2] =  meshgrid(centersTregs(:, 1), SourcesPos(:, 1));
%     [Y1, Y2] = meshgrid(centersTregs(:, 2),  SourcesPos(:, 2));
%     distances_Tregs = sqrt((X1 - X2).^2 + (Y1 - Y2).^2)*S.Pix_um;
%     clear X1 X2 Y1 Y2;
%     pSTAT5matrix = repmat([Tregs.pSTAT5sum], length(Sources), 1);
%     %J = find(distances_Tregs < MaxDistance);
%     %distances_Tregs = distances_Tregs(J);
%     %pSTAT5matrix = pSTAT5matrix(J);
% 
%     len = ceil(MaxDistance/DistBinSize);
%     BinNo = ceil(distances_Tregs/DistBinSize);
%     DistBins = (0.5+(0:(len-1)))*DistBinSize;
% 
%     for i = 1:length(Sources),
%         for j = 1:len,
%             J = find(BinNo(i, :) == j);        
%             Nbin(i, j) = length(J);
%             bin_pSTAT5(i, j) = mean(pSTAT5matrix(i, J));        
%             error_pSTAT5(i, j) = std(pSTAT5matrix(i, J))/sqrt(Nbin(i, j));
%             if isnan(bin_pSTAT5(i, j)),
%                 bin_pSTAT5(i, j) = 0;
%                 error_pSTAT5(i, j) = 0;
%             end
%         end
%     end
% else
%     bin_pSTAT5 = zeros(size(DistBins));
%     Nbin = zeros(size(DistBins));
%     error_pSTAT5 = zeros(size(DistBins));
% end
% 
% R.corrSourceTreg_pSTAT5.r = DistBins;
% R.corrSourceTreg_pSTAT5.Gall = bin_pSTAT5;
% R.corrSourceTreg_pSTAT5.Nbin_all =  Nbin;
% R.corrSourceTreg_pSTAT5.error_all = error_pSTAT5;
% 
% if ~isempty(Sources),
%     R.corrSourceTreg_pSTAT5.Gbg = sum(bin_pSTAT5.*Nbin)./sum(Nbin); % with background
%     R.corrSourceTreg_pSTAT5.G = R.corrSourceTreg_pSTAT5.Gbg - mean([Tregs.pSTAT5sum]);
%     R.corrSourceTreg_pSTAT5.error_G =  sqrt(sum(error_pSTAT5.^2.*Nbin.^2))./sum(Nbin);
%     R.corrSourceTreg_pSTAT5.Nbin = sum(Nbin);
% else
%     R.corrSourceTreg_pSTAT5.Gbg = zeros(size(DistBins)); % with background
%     R.corrSourceTreg_pSTAT5.G = zeros(size(DistBins));
%     R.corrSourceTreg_pSTAT5.error_G =  zeros(size(DistBins));
%     R.corrSourceTreg_pSTAT5.Nbin = zeros(size(DistBins));
% end
% 
% PairDist.Source_Treg = R.corrSourceTreg_pSTAT5.Nbin./AreasSources/R.stats.Treg_density;
% PairDist.error_Source_Treg = sqrt(R.corrSourceTreg_pSTAT5.Nbin)./AreasSources/R.stats.Treg_density;
% 
% % Source-Source pair dist function
% if ~isempty(Sources),
% [X1, X2] =  meshgrid(centersSources(:, 1));
% [Y1, Y2] = meshgrid(centersSources(:, 2));
% distances_SoSo = sqrt((X1 - X2).^2 + (Y1 - Y2).^2)*S.Pix_um;
% clear X1 X2 Y1 Y2;
% BinNo = ceil(distances_SoSo/DistBinSize);
% clear Nbin;
% 
% for i = 1:len,
%     %i
%     [I, J] = find(BinNo == i);
%     Nbin(i) = length(J);
% end
% PairDist.Source_Source = Nbin./AreasSources/R.stats.Source_density;
% PairDist.error_Source_Source = sqrt(Nbin)./AreasSources/R.stats.Source_density/sqrt(2); % double counting of pairs
% end;
% 
% R.PairDist = PairDist;
% 
% % try to identify sources that really produce by percentages on short
% % distances
% 
% % closebins = find(DistBins < CloseNeighborDistance);
% % close_pSTAT5 = sum(bin_pSTAT5(:, closebins).*Nbin(:, closebins), 2)./sum(Nbin(:, closebins), 2);
% % [~, J] = sort(close_pSTAT5, 'descend');
% % Jactive = J(1:round(length(Sources)*SourceTopPercentage));
% % R.corrSourceTreg_pSTAT5.Jactive = Jactive;
% % R.Sources = Sources;
% % hold on
% % viscircles( centersSources(Jactive, :), repmat(SourceRadiusPix, length(Jactive), 1), 'EdgeColor', 'y');
% % hold off
% % 
% % R.corrSourceTreg_pSTAT5.GactiveBG = sum(bin_pSTAT5(Jactive, :).*Nbin(Jactive, :))./sum(Nbin(Jactive, :)); % with background
% % R.corrSourceTreg_pSTAT5.Gactive = R.corrSourceTreg_pSTAT5.GactiveBG - mean([Tregs.pSTAT5sum]);
% % R.corrSourceTreg_pSTAT5.error_Gactive = sqrt(sum(error_pSTAT5(Jactive, :).^2.*Nbin(Jactive, :).^2))./sum(Nbin(Jactive, :));;
% % R.corrSourceTreg_pSTAT5.Nbin_active = sum(Nbin(Jactive, :));
% 
% % 
% % %Tregs.pSTAT5mean = pSTAT5mean;
% % 
% % % clear Xcm Ycm area pSTAT5sum pSTAT5mean;
% % % for i = 1:length(Sources.PixelIdxList),
% % %     [I, J] = ind2sub(size(NewImArray(:, :, 1)), Sources.PixelIdxList{i});
% % % %    IJK = sub2ind(size(NewImArray), I, J, 2*ones(size(I)));
% % % %    TempArray(IJK) = 1;
% % %     Xcm(i) = mean(J);
% % %     Ycm(i) = mean(I);
% % %     area(i) = length(Sources.PixelIdxList{i}); 
% % %     pSTAT5sum(i) = sum(Im_pSTAT5(Sources.PixelIdxList{i}));
% % %     pSTAT5mean(i) = mean(Im_pSTAT5(Sources.PixelIdxList{i}));
% % % end
% % % Sources.Xcm = Xcm(:);
% % % Sources.Ycm = Ycm(:);
% % % Sources.area = area(:);
% % % Sources.pSTAT5sum = pSTAT5sum;
% % % Sources.pSTAT5mean = pSTAT5mean;
% % % 
% % % [X1, X2] =  meshgrid(Tregs.Xcm, Sources.Xcm);
% % % [Y1, Y2] = meshgrid(Tregs.Ycm, Sources.Ycm);
% % % 
% % % distances_Treg_Sources = sqrt((X1 - X2).^2 + (Y1 - Y2).^2);
% % % 
% % % % find minimal distance to source:
% % % if Sources.NumObjects > 1,
% % %     Tregs.minDistToSource = min(distances_Treg_Sources);
% % % else
% % %     Tregs.minDistToSource = distances_Treg_Sources;
% % % end
% % 
% % 
% 
% function Areas = AreasForPairDistFunction(coords, mask, DistBinSize, MaxDistance)
% [xmask, ymask] = poly2cw(mask(:, 1), mask(:, 2)); %mask to clockwise order
% Npoly = 100; % number of edges in a polygon approximation of a circle
% % create circles/polygons
% len = ceil(MaxDistance/DistBinSize);
% Areas = zeros(1, len);
% theta = linspace(0, 2*pi, Npoly);
% x1 = cos(theta);
% y1 = -sin(theta); 
% for i = 1:len,
%     crcl(i).x = i*DistBinSize*x1;
%     crcl(i).y = i*DistBinSize*y1;    
% end
% 
% %place circles on each cell and find cross section area with the LN mask
% for j = 1:size(coords, 1),
%     if mod(j, 10) == 0,
%         disp(['Analyzing areas ' num2str(j) ' out of ' num2str(size(coords, 1))]);
%     end
%     for i = 1:len,
%         [xb, yb] = polybool('intersection', xmask, ymask, ...
%             coords(j, 1) + crcl(i).x, coords(j, 2)+ crcl(i).y);
%         area1(i) = polyarea(xb, yb);
%     end
%     Areas = Areas + diff([0 area1]);
% end




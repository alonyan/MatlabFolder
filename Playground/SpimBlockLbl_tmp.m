classdef SpimBlockLbl < handle %class of single cell processing of a whole cornea at a single timepoint
    properties
        PartitionNameList
        Frame
        pth
        ImageDims
        tForms
        channelNames
        tile
        
        Centroids
        Intensities
        Int90Prctile
        localEntropyScore
        useInMerge
        NuclearChannel

        num
        
        %TopoZ
        %Properties related to tracking
        %Link12Mat
        %Link21Mat
        
    end
    
    properties (Transient = true)
        verbose = true;
    end
    
    properties (Dependent = true)
        filenames
    end
    
    
    
    methods
        
        %         function epiRank = epiRank(W)
        %             [h,x] = hist(W.epiScore,250);
        %             dataCDF = cumsum(h)/sum(h);
        %             epiRank = interp1(x,dataCDF,W.epiScore);
        %             epiRank(isnan(W.epiScore))=NaN;
        %         end
        
        function Blocklbl = SpimBlockLbl(fpath, partitionInfo,timepoint,tile,NuclearChannel)%constructor
            channelNames = partitionInfo.channelNames;
            %Blocklbl = SpimBlockLbl;
            Blocklbl.pth = fpath;
            Blocklbl.Frame = timepoint;
            Blocklbl.tile = tile;
            Blocklbl.NuclearChannel = NuclearChannel;
            %find partitions that correspond to this position and timepoint
            partNameList = partitionInfo.name(find((partitionInfo.timepoint==timepoint).*(partitionInfo.tile==tile)));
            %make sure N files = N channels
            assert(numel(partNameList) == numel(partitionInfo.channelNames));
            Blocklbl.PartitionNameList = partNameList;
            
            
            %Load and process affine transforms
            %each block has a set of corresponding affinetransformations.
            %the transformations should be applied in reverse order (i.e.
            % 5->4->3->2->1). Affine transformations are associative but
            % not commutative, so order must be maintained. 
                
            %get all transforms (cell array, 1xnchannels)
            tForms = partitionInfo.tForms(find((partitionInfo.timepoint==timepoint).*(partitionInfo.tile==tile)));
            %find the transforms that are the same for all colors
%             sameTforms = [];
%             for i=length(tForms{1}):-1:1
%                 tFormNames = [];
%                 for j=1:length(tForms) tFormNames = [tFormNames 'tForms{' num2str(j) '}{' num2str(i) '} ,']; end
%                 sameTforms = [ eval(['isequaln(' tFormNames(1:end-1) ')']) sameTforms];
%             end
%             
            %Use associativity of affine transforms to create a single global transform matrix;
%             globT = eye(4);
%             for i=find(sameTforms)
%                 globT = globT*reshape([str2double(strsplit(tForms{1}{i}.affine.Text)), 0 0 0 1]',4,4);
%             end
%             globT = globT';
            
            %get per-channel tranforms
            ChT = cell(numel(tForms),1);
            for j=1:numel(tForms)
                ChT{j} = eye(4);
                for i=1:numel(tForms{j})
                    ChT{j} = ChT{j}*reshape([str2double(strsplit(tForms{j}{i}.affine.Text)), 0 0 0 1]',4,4)';
                end
            end

            
            
            
            %Load channels
            options = struct('level', 1,'waitbar',0);
            %Channels = cell(numel(partNameList),1);
            Ints = cell(numel(partNameList),1);
            Ints90P = cell(numel(partNameList),1);
            
            
            %Start calling cells, look at Nuc channel
            indChNuc = find(strcmp(channelNames,NuclearChannel));
            %Data = Channels{indChNuc};
            Data = loadBigDataViewerFormat([fpath filesep partNameList{indChNuc}],options);
            Data = squeeze(single(Data)/2^12);
            
            localEntropy = 0;%blockproc3(Data,[50 50, 50],@(x) simpEntropy(x));
            Blocklbl.ImageDims = size(Data);
            
            % Gaussian smoothen and find regional max
            
            imgG = imgaussian3(Data,[4,1]);
            %imghMaxima = imhmax(imgG, 0.00001);
            %imgGRegMax = imregionalmax(imgG);
            
                                    
            localMax = dlmread(fullfile(fpath, [partitionInfo.beadsFile{find((partitionInfo.timepoint==timepoint).*(partitionInfo.tile==tile).*(partitionInfo.channel==indChNuc))}]),'\t',2,1);
            localMax((localMax(:,2)<1),1)=1;
            localMax((localMax(:,1)<1),2)=1;
            localMax((localMax(:,3)<1),3)=1;
            localMax((localMax(:,2)>size(Data,1)),2)=size(Data,1);
            localMax((localMax(:,1)>size(Data,2)),1)=size(Data,2);
            localMax((localMax(:,3)>size(Data,3)),3)=size(Data,3);
            
            linearInd = sub2ind(size(Data), round(localMax(:,2)), round(localMax(:,1)), round(localMax(:,3)));
            imgGRegMax = zeros(size(Data));
            imgGRegMax(linearInd)=1;
            % Expand regional max to a sphere of radius=4
            [xx,yy,zz] = ndgrid(-3:3);
            nhood = sqrt(xx.^2 + yy.^2+zz.^2) <= 3.0;
            ExpandedPeaks = imdilate(imgGRegMax,nhood);
            clear imgGRegMax  nhood
            % Filter peaks with low signal using triangle thresholding
            somePix = imgG(logical(ExpandedPeaks));
            %[h,x]=hist(log(somePix),100);
            %ThreshVal = exp(triangleThresh(h,x));
            ThreshVal = exp(meanThresh(log(somePix)));
            %ThreshVal = (meanThresh((somePix)));
            nuclearSeeds = ExpandedPeaks.*(imgG>ThreshVal);
            %nuclearSeedsSignal = Data.*nuclearSeeds;
            clear ExpandedPeaks imgG  
            % Find connected components
            CC = bwconncomp(nuclearSeeds);
            clear nuclearSeeds          
            % get region props in each channel
            S = regionprops(CC,Data,'WeightedCentroid','Area');
            clear CC;
            %RI = imref3d(size(Data));
            
            % filter CC keep only cells with volume in some range
            Areas = cat(1, S.Area);
            %Intensities = cat(1, S.MeanIntensity).*Areas;
            %Int90Prctile = arrayfun(@(x) prctile(x.PixelValues(x.PixelValues~=0),90),S);
            Centroids = cat(1,S.WeightedCentroid);
            %remove specks
            J = Areas>=120;
            Areas = Areas(J);
            %Intensities = Intensities(J);
            %Int90Prctile = Int90Prctile(J);
            Centroids = Centroids(J,:);
   
            
            
            
            
            linearInd = sub2ind(Blocklbl.ImageDims, round(Centroids(:,2)), round(Centroids(:,1)), round(Centroids(:,3)));
            imgGRegMax = zeros(Blocklbl.ImageDims);
            imgGRegMax(linearInd)=1:size(Centroids,1);
            [xx,yy,zz] = ndgrid(-3:3);
            nhood = sqrt(xx.^2 + yy.^2+zz.^2) <= 3.0;
            ExpandedPeaks = imdilate(imgGRegMax,nhood);
            clear imgGRegMax nhood;
            
            S = regionprops(ExpandedPeaks,Data,'MeanIntensity','Area','PixelValues');
            clear Data ExpandedPeaks

            Areas = cat(1, S.Area);
            Intensities = cat(1, S.MeanIntensity);
            Int90Prctile = arrayfun(@(x) prctile(x.PixelValues(x.PixelValues~=0),90),S);
            
            
            
            
            %Add to Int cell array
            Ints{indChNuc}=Intensities;
            Ints90P{indChNuc}= Int90Prctile;
            
            localEntropyScore = 0;
            

                        
            %%TODO, add transformation per color:
            %one possible way is to find the diff tansform compared to
            %deepblue, then apply it to the single channel data after reading it.
            %Now the other channels
            indOtherChannels = find(~strcmp(channelNames,NuclearChannel));
            for i=indOtherChannels
                %Data = Channels{i};
                %while Blocklbl.freeMem<100000;
                %    disp('waiting for memory')
                %    pause(30)
                %end
                Data = loadBigDataViewerFormat([fpath filesep partNameList{i}],options);
                Data = squeeze(single(Data)/2^12);
                
                %trying different approach
                %transform the centroids to other channel coordinates
                tform = inv(ChT{i})*ChT{indChNuc};
                tempCents = (tform*[Centroids ones(1,size(Centroids,1))']')';
                %deal with edges and round to nearest pixel
                localMax = tempCents(:,1:3);
                
                localMax((localMax(:,2)<1),2)=1;
                localMax((localMax(:,1)<1),1)=1;
                localMax((localMax(:,3)<1),3)=1;
                localMax((localMax(:,2)>size(Data,1)),2)=size(Data,1);
                localMax((localMax(:,1)>size(Data,2)),1)=size(Data,2);
                localMax((localMax(:,3)>size(Data,3)),3)=size(Data,3);
                
                linearInd = sub2ind(size(Data), round(localMax(:,2)), round(localMax(:,1)), round(localMax(:,3)));
                %make new mask
                imgGRegMax = zeros(size(Data));
                imgGRegMax(linearInd)=1:size(Centroids,1);
                [xx,yy,zz] = ndgrid(-3:3);
                nhood = sqrt(xx.^2 + yy.^2+zz.^2) <= 3.0;
                ExpandedPeaks = imdilate(imgGRegMax,nhood);
                clear imgGRegMax  nhood localMax
                
                
                
                
                
                %tform = inv(ChT{indChNuc})*ChT{i};
            
                
                %warning('Alon, MAKE SURE THE TRANSFORMS ARE RIGHT!');
                %while Blocklbl.freeMem<100000;
                %    disp('waiting for memory')
                %    pause(45)
                %end
                %Data = imwarp(Data,RI,affine3d(tform')); 
                
                %pad missing bits with zeros
                %wXYZ = size(Data);
                %dwXYZ = CC.ImageSize-wXYZ;
                %padSize = dwXYZ.*(dwXYZ>0);
                %Data = padarray(Data,padSize,0,'post');
                %crop extra bits
                %Data = Data(1:CC.ImageSize(1),1:CC.ImageSize(2),1:CC.ImageSize(3));
                
                S = regionprops(ExpandedPeaks,Data,'MeanIntensity','PixelValues');
                Intensities = cat(1, S.MeanIntensity);
                Int90Prctile = arrayfun(@(x) prctile(x.PixelValues(x.PixelValues~=0),90),S);
                %J is still the index of no specky cells
                Ints{i}=Intensities;
                Ints90P{i}= Int90Prctile;
                clear Data ExpandedPeaks;
            end
            clear RI;
            
            
            
            %Apply global transformations to centroids!
            tempCents = (ChT{indChNuc}*[Centroids ones(1,size(Centroids,1))']')';
            Centroids = tempCents(:,1:3);
            
            
            Blocklbl.Centroids = Centroids;
            Blocklbl.Intensities = Ints;
            Blocklbl.Int90Prctile = Ints90P;
            Blocklbl.localEntropyScore = localEntropyScore;
            Blocklbl.useInMerge = ones(numel(Ints),1);
            
            Blocklbl.tForms = tForms;
            Blocklbl.channelNames = channelNames;
            Blocklbl.num = size(Centroids,1);
            %Blocklbl.DistFromManifold = DistFromManifold;
            %Blocklbl.TopoZ = TopoZ;
            %Blocklbl.GridZ = zz;
            %Blocklbl.CC = CC;
            tile
        end
        
        function bb = boundingBox(W)
            bb = [min(W.Centroids)' max(W.Centroids)'];
        end
        
        
        function E = simpEntropy(J1)
            h = histcounts(J1,'Normalization','probability');
            
            E = -nansum(h.*log(h));
        end
        
        
        function mem = freeMem(W)
            [~,out]=system('vmstat -s -S M | grep "free memory"');
            
            mem=sscanf(out,'%f  free memory');
        end
        
        
        function scatter3(W,varargin)
            
            channelToShow = ParseInputs('channel', [], varargin);
            channelDenom = ParseInputs('channel2', [], varargin);

            ratio = ParseInputs('ratio', false, varargin);
            Jplot = ParseInputs('range', 1:W.num, varargin);
            dz = ParseInputs('dz', 0, varargin);

            %first, decide which points to plot
            if strcmp(Jplot,'useInMerge')
                Jplot = find(W.useInMerge);
            end
            if any(Jplot>W.num)
                Jplot = Jplot(Jplot<=W.num);
                disp('Range out of bounds, drawing all valid points.')
            end
            
            %next, decide on channel
            
            if isempty(channelToShow); 
                tzeva = viridis(numel(Jplot));
            elseif ~ratio
                indChNuc = find(strcmp(W.channelNames,channelToShow));
                %tzeva = viridis(length(W.Centroids));
                tzeva = W.Intensities{indChNuc};
                tzeva = tzeva(Jplot);
            else
                if isempty(channelDenom)
                    error('need 2 channels for ratio')   
                end
                indChNuc = find(strcmp(W.channelNames,channelToShow));
                indChDenom = find(strcmp(W.channelNames,channelDenom));

                %tzeva = viridis(length(W.Centroids));
                tzeva = W.Intensities{indChNuc}./W.Intensities{indChDenom};
                tzeva = tzeva(Jplot);
            end
            
                scatter3(W.Centroids(Jplot,1),W.Centroids(Jplot,2),dz-W.Centroids(Jplot,3),[],tzeva);
            
        end
        
        
        
        
        function scatter(W,varargin)
            tzeva = viridis(length(W.Centroids));
            if nargin==1
                scatter(W.Centroids(:,1),W.Centroids(:,2),[],tzeva);
            else
                range = varargin{1};
                if strcmp(range,'epi')
                    tzeva = viridis(length(W.Jepi));
                    if nargin>=3;
                        range = varargin{2};
                        if any(~ismember(range,W.Jepi))
                            range = range(ismember(range,W.Jepi));
                            if ~isempty(range)
                                disp('some of the range points are not in the epithelium, drawing the ones that are.')
                            else
                                disp('all of the range points are not in the epithelium, drawing entire epithelium.')
                                range = W.Jepi;
                            end
                        end
                    else
                        range = W.Jepi;
                    end
                    if any(range>max(W.Jepi))
                        range = W.Jepi;
                        disp('range out of bounds, drawing all points.')
                        scatter(W.Centroids(range,1),W.Centroids(range,2),[],tzeva((ismember(W.Jepi,range)),:));
                    else
                        scatter(W.Centroids(range,1),W.Centroids(range,2),[],tzeva((ismember(W.Jepi,range)),:));
                    end;
                else
                    if any(range>W.num)
                        range = range(1):W.num;
                        disp('range out of bounds, drawing all points up to the total # of cells.')
                        scatter(W.Centroids(range,1),W.Centroids(range,2),[],tzeva(range,:));
                    else
                        scatter(W.Centroids(range,1),W.Centroids(range,2),[],tzeva(range,:));
                    end;
                end
            end
            %scatter(Centroids(:,1),Centroids(:,2),[],parula(length(Centroids)));
            %set(gca,'xlim',[-200 3000],'ylim',[-200 2500])
            %hold on
            shg
            
        end
        
        
        
        
        
        function stkshow(W)
            MD=Metadata(W.pth);
            
            Data =  stkread(MD,'Channel','DeepBlue', 'flatfieldcorrection', false, 'frame', W.Frame, 'Position', W.PosName,'register',false);
            RChannel=Data;
            GChannel=Data;
            BChannel=Data;
            [h,x] = hist(log(datasample(Data(:),min(1000000,numel(Data(:))))),1000);
            maxC = exp(x(find(cumsum(h)./sum(h)>0.995,1,'first')));
            cmap = parula(W.CC.NumObjects)*maxC*1.5;%scale colormap so that data and centroids are all visible
            
            for i=1:W.CC.NumObjects
                indexToChange = W.CC.PixelIdxList{i};
                RChannel(indexToChange)=cmap(i,1); %Replace actual pixel values with relevant RGB value
                GChannel(indexToChange)=cmap(i,2);
                BChannel(indexToChange)=cmap(i,3);
                i
            end
            RGB = cat(3,RChannel,GChannel,BChannel);%combine into a single RGB image and show. stkshow is sloooooooooooowing me down.
            stkshow(RGB);
            MIJ.selectWindow('RGB');
            MIJ.run('Stack to Hyperstack...', ['order=xyzct channels=3 slices=' num2str(size(Data,3)) ' frames=1 display=Composite']);
            %stkshow(RChannel)
            %stkshow(GChannel)
            %stkshow(BChannel)
            %MIJ.run('Merge Channels...', 'c1=RChannel c2=GChannel c3=BChannel create');
        end
        
        
        function scattershow(W,varargin)
            MD=Metadata(W.pth);
            
            Data =  stkread(MD,'Channel','DeepBlue', 'flatfieldcorrection', false, 'frame', W.Frame, 'Position', W.PosName,'register',false);
            RChannel=zeros(size(Data));
            GChannel=zeros(size(Data));
            BChannel=zeros(size(Data));
            [h,x] = hist(log(datasample(Data(:),min(1000000,numel(Data(:))))),1000);
            maxC = exp(x(find(cumsum(h)./sum(h)>0.995,1,'first')));
            if strcmp(varargin{1},'epi')
                range = W.Jepi'
            else
                range = 1:W.CC.NumObjects;
            end
            cmap = viridis(numel(range))*maxC*1.5;%scale colormap so that data and centroids are all visible
            
            for i=1:numel(range)
                indexToChange = W.CC.PixelIdxList{range(i)};
                RChannel(indexToChange)=cmap(i,1); %Replace actual pixel values with relevant RGB value
                GChannel(indexToChange)=cmap(i,2);
                BChannel(indexToChange)=cmap(i,3);
                i
            end
            RGB = cat(3,RChannel,GChannel,BChannel);%combine into a single RGB image and show. stkshow is sloooooooooooowing me down.
            stkshow(RGB);
            MIJ.selectWindow('RGB');
            MIJ.run('Stack to Hyperstack...', ['order=xyzct channels=3 slices=' num2str(size(Data,3)) ' frames=1 display=Composite']);
        end
        
    end
end

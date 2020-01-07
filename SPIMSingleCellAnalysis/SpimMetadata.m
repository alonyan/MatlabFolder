classdef SpimMetadata < handle %class of single cell processing of a whole cornea at a single timepoint
    properties
        partitionInfo
        pth
    end
    
    properties (Transient = true)
    end
    
    properties (Dependent = true)
        filenames
    end
    
    
    
    methods
        
        
        
        function W = SpimMetadata(fpath,varargin)%constructor
            override = ParseInputs('override', false, varargin);
            foldname = fpath;
            filename = sprintf('SpimMD.mat');
            filename = fullfile(foldname,filename);
            if exist(filename,'file') && ~override
                s=load(filename);
                W = s.W;
            else
                W.pth = fpath;
                W.partitionInfo = getPartitionInfo(W);
                W.save()
            end
        end
        
        function partitionInfo = getPartitionInfo(W)
            MD=Metadata(W.pth);
            
            channelNames = arrayfun(@(x) MD.getSpecificMetadataByIndex('Channel', x), 1:numel(MD.unique('Channel')));
            info = xml2struct([W.pth filesep 'hdf5_dataset.xml']);
            partitionInfo = struct;
            partitionInfo.('id') = cellfun(@(x) str2double(x.setups.Text),info.SpimData.SequenceDescription.ImageLoader.partition);
            partitionInfo.('name') = cellfun(@(x) x.path.Text,info.SpimData.SequenceDescription.ImageLoader.partition, 'UniformOutput',false);
            partitionInfo.('timepoint') = cellfun(@(x) str2double(x.timepoints.Text),info.SpimData.SequenceDescription.ImageLoader.partition);
            partitionInfo.('tForms') = cellfun(@(x) x.ViewTransform, info.SpimData.ViewRegistrations.ViewRegistration, 'UniformOutput',false);
            
            
            beadInfo = struct;
            beadInfo.('filename') = cellfun(@(x) x.Text, info.SpimData.ViewInterestPoints.ViewInterestPointsFile, 'UniformOutput',false);
            beadInfo.('id') = cellfun(@(x) x.Attributes.setup, info.SpimData.ViewInterestPoints.ViewInterestPointsFile, 'UniformOutput',false);
            beadInfo.('timepoint') = cellfun(@(x) x.Attributes.timepoint, info.SpimData.ViewInterestPoints.ViewInterestPointsFile, 'UniformOutput',false);
            beadInfo.('label') = cellfun(@(x) x.Attributes.label, info.SpimData.ViewInterestPoints.ViewInterestPointsFile, 'UniformOutput',false);
            %make sure to only take the relevant interest points
            J = find(cellfun(@(x) strcmp(x,'beads'), beadInfo.label));
            beadInfo.filename = {beadInfo.filename{J}};
            beadInfo.id = {beadInfo.id{J}};
            beadInfo.timepoint = {beadInfo.timepoint{J}};
            beadInfo.label = {beadInfo.label{J}};
            
            partitionInfo.beadsFile = cell(size(partitionInfo.id));
            
            ids = str2double(beadInfo.id);
            tps = str2double(beadInfo.timepoint);
            
            for i=unique(tps)
                for j=unique(ids)
                    partitionInfo.beadsFile{logical((partitionInfo.id==j).*(partitionInfo.timepoint==i))}= [beadInfo.filename{logical((ids==j).*(tps==i))} '.ip.txt'];
                end
            end
            
            
            setupInfo.id = cellfun(@(x) str2double(x.id.Text), info.SpimData.SequenceDescription.ViewSetups.ViewSetup);
            setupInfo.tile = cellfun(@(x) str2double(x.attributes.tile.Text), info.SpimData.SequenceDescription.ViewSetups.ViewSetup);
            setupInfo.channel = cellfun(@(x) str2double(x.attributes.channel.Text), info.SpimData.SequenceDescription.ViewSetups.ViewSetup);
            setupInfo.angle = cellfun(@(x) str2double(x.attributes.angle.Text), info.SpimData.SequenceDescription.ViewSetups.ViewSetup);
            
            partitionInfo.tile = zeros(size(partitionInfo.id));
            partitionInfo.channel = zeros(size(partitionInfo.id));
            partitionInfo.angle = zeros(size(partitionInfo.id));
            for i=setupInfo.id
                partitionInfo.tile(partitionInfo.id==i) = setupInfo.tile(setupInfo.id==i);
                partitionInfo.channel(partitionInfo.id==i) = setupInfo.channel(setupInfo.id==i);
                partitionInfo.angle(partitionInfo.id==i) = setupInfo.angle(setupInfo.id==i);
            end
            clear setupInfo
            partitionInfo.channelNames = channelNames;
            
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
        
        function save(W)
            foldname = fullfile(W.pth,'SingleCellSPIMTimepoints');
            if ~exist(foldname,'dir')
                mkdir(foldname)
            end
            filename = sprintf('SpimMD.mat');
            filename = fullfile(foldname,filename);
            save(filename, 'W');
        end
        
        function D = stkread(W,timepoint,tile,Ch,varargin)
            register = ParseInputs('register', true, varargin);
            refTP = ParseInputs('refTP', 0, varargin);
            refTile = ParseInputs('refTile', tile, varargin);
            
            channelNames = W.partitionInfo.channelNames;
            indCh = find(strcmp(channelNames,Ch));

            partNameList = W.partitionInfo.name(find((W.partitionInfo.timepoint==timepoint).*(W.partitionInfo.tile==tile).*(W.partitionInfo.channel==indCh)));
            
            try
                options = struct('level', 1,'waitbar',0);
                D = loadBigDataViewerFormat([W.pth filesep partNameList{1}],options);
                D = squeeze(single(D)/2^12);
            catch
                D = cell(numel(channelNames),1);
                warning('Missing tile on timepoint %d tile %d', timepoint, tile)
            end
            
            if register == true
                tForms = W.partitionInfo.tForms(find((W.partitionInfo.timepoint==refTP).*(W.partitionInfo.tile==refTile).*(W.partitionInfo.channel==1)));
                ChT = eye(4);
                for i=1:numel(tForms{1})
                    ChT = ChT*reshape([str2double(strsplit(tForms{1}{i}.affine.Text)), 0 0 0 1]',4,4)';
                end
                ChT0 = ChT;
                
                tForms = W.partitionInfo.tForms(find((W.partitionInfo.timepoint==timepoint).*(W.partitionInfo.tile==tile).*(W.partitionInfo.channel==indCh)));
                ChT = eye(4);
                for i=1:numel(tForms{1})
                    ChT = ChT*reshape([str2double(strsplit(tForms{1}{i}.affine.Text)), 0 0 0 1]',4,4)';
                end
                
                msg = 'Registering... ';
                fprintf(msg)

                Tform = affine3d((ChT0\ChT)');
                D = imwarp(D,Tform,'OutputView',imref3d(round(size(D))));
                msg = '...done\n';
                fprintf(msg)
              
            end
        end
        
    end
    
end


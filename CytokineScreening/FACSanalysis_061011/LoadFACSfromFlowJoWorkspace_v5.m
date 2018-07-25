function [CGData CompensationMatrix WorkSp groupInd gateInd] = LoadFACSfromFlowJoWorkspace_v5( fpath, varargin)

% Loads compensated data based on information in FlowJo Workspace .xml file and original FACS
% data. The required parameter 
% fpath  - should point to the directory where .xml file resides. If the
% program fails to find .xml file there or finds more than one file it will
% open a File Open dialog box and request you to point to the Workspace
% file directly. By default the program then will produce the list of
% groups in your data and prompt you (in the Command Window) to pick one
% group by its number in the list.
%  Then the program displays the numbered and tabulated list of gates in the group
%  ("group gates"). The tabulation refelcts the nested character of
%  the gates (this is an improvment over LoadFACSfromFlowJoWorkspace_v2
%  version). You should pick a gate by its single defining number (again
%  this is the difference with LoadFACSfromFlowJoWorkspace_v2 version).
%  The program will use group gate names but will attempt to read the
%  gate coordinates from samples: this is important if you adjusted the
%  group gates for some samles (improvement over
%  LoadFACSfromFlowJoWorkspace_v2 version).  If you choose "0" as a gate
%  number, then the program takes you to loading each sample one by one
%  with its sample gates: if your samples have individual (not group) gates
%  use this option.
% 
%The program then shows an example of loading file and of the application of gates on the first file.
%If parameter 'NoDemonstration' is added then no demonstration of gate
% application is shown. 
%
% A compensation matrix is applied to the data. If more than one
% compensation Matrix is found, the user is prompted to choose one from the
% array by its number.
%
% The output is an array of structures, each entry in the array corresponding
% to a single loaded file. Each structure contains the following fields
% 'name' : a file name of the loaded file
% 'ListofChannelsWithLabels' : well, what it says it is
% 'data' : the compensated data, columns corresponding to different
%  channels.
%
% Other parameters are optional and come in pairs: first parameter
% descriptive name and second the parameter value.
% The list of parameters:
% 'GroupInd'    followed by integer number GroupInd : skip group listing and  use this GroupInd to
%               load the group.
% 'GateInd'     followed an integer number GateInd: skip gate listing
%               and use GateInd to apply gates.
%
% 'PathToDataFiles' followed by the filepath provides path to .fcs FACS files in case they are not in the same directory as Workspace .xml file
%
% 'NameFilter'      followed by a string template: applies regular
%                   expression template to the file names. Allows to select only the files
%                   with a certain name template.
%
% 'WorkSpaceFilename' followed by the  file name
%
% Other optional output parameters 
%       CompensationMatrix
%       
%       WorkSp -  The FlowJo workspace as loaded by ReadFlowJoXMLfile_v6. See the description there.
%       groupInd - group index as introduced on prompt;
%       gateInd - gate index as introduced on prompt
%
% Examples of application
%
% [Data100XsmallV, CM] = LoadFACSfromFlowJoWorkspace_v4(fpath)
% [Data100XsmallV, CM] = LoadFACSfromFlowJoWorkspace_v4(fpath, 'GroupInd', 6, 'GateInd', 3)
% [IL2calibrations, CM] = LoadFACSfromFlowJoWorkspace_v4(fpath, 'PathToDataFiles', [fpath filesep '20101203 IL2penetration' filesep 'Calibration'], 'NameFilter', 'IL2-5CC7-IL2KO_G')
% [IL2calibrations, CM] = LoadFACSfromFlowJoWorkspace_v4(fpath, 'PathToDataFiles', [fpath filesep '20101203 IL2penetration' filesep 'Calibration'], 'NameFilter', 'IL2-5CC7-IL2KO_G', 'GroupInd', 4, 'GateInd', 3)


% // Oleg Krichevsky, okrichev@bgu.ac.il
% version 2 - Dec. 2010.
% version 3  - Sept, 2011 . 
% version 4 -  Oct, 2011 : improving graphical representation when loading
%                           gates. Changing to asinh axes
%
% Jan. 2013: changed ReadFlowJoXMLfile_v5 for ReadFlowJoXMLfile_v6 for
% added compatibility with earlier versions of FlowJo.
%
% version 5 - Feb. 2014 Improve graphics using density color coded scatter plots. Introduce ScatterPlotFACS_v1 into
%               the program


histSizeX = 199;
histSizeY = 201;
Ncontours = 20;
    

    j1=find(strcmp(varargin, 'NameFilter'));
    if length(j1)>1,
        error('Too many NameFilter inputs!')
    elseif length(j1)==1,
        NameFilter = varargin{j1+1};
    else %default
        NameFilter = '';
    end;
    
    j1=find(strcmp(varargin, 'NoDemonstration'));
    if length(j1)>1,
        error('Too many NoDemonstration inputs!')
    elseif length(j1)==1,
        Demonstration = 0;
    else %default
        Demonstration = 1;
    end;
    
    j1=find(strcmp(varargin, 'WorkSpaceFilename'));
    if length(j1)>1,
        error('Too many WorkSpaceFilename inputs!')
    elseif length(j1)==1,
        workspace_file = dir([fpath filesep varargin{j1+1}]);
    else %default
        workspace_file = dir([fpath filesep '*.xml']);
        tempnames = {workspace_file.name}';
        for i=1:length(tempnames), 
            if strcmp(tempnames{i}(1:2), '._'), 
                 workspace_file(i) =[]; % delete temporary .xml file: recognized by Windows, but not Mac
            end;
        end;
    end;
    
    
    if length(workspace_file) == 1,
        WorkSp = ReadFlowJoXMLfile_v6([fpath filesep workspace_file.name]);
    elseif length(workspace_file) == 0,
        he = errordlg('XML workspace file was not found. Please point to the file');
        WorkSp = ReadFlowJoXMLfile_v6;
        close(he);
    elseif length(workspace_file) > 1,
        he = errordlg('More than one XML workspace file was found. Please point to the correct file');
        WorkSp = ReadFlowJoXMLfile_v6;
        close(he);
    end;
  
    
%     
%     ListOfFiles = dir([fpath filesep '*' nametemplate '.fcs']);
%     ListOfFCSFiles = {ListOfFiles.name};
    
    
     % Show the list of groups and ask which ones to load
    disp('Found the following groups:');
    disp('   ');
    for i=1:length(WorkSp.Group),
        disp([num2str(i) ') group "' WorkSp.Group(i).name '"']);
   
    end;  
    disp('    ');
    
    
    j1=find(strcmp(varargin, 'GroupInd'));
    if length(j1)>1,
        error('Too many GroupInd inputs!')
    elseif length(j1)==1,
        groupInd = varargin{j1+1};
        disp(['Loading group No: ' num2str(groupInd)]);
    else %default
        groupInd = input('Which group to load? ');
    end;
    
    disp('    ');

    disp('Found the following gates in this group:');
    disp('    ');
    for j=1:length(WorkSp.Group(groupInd).Population),
        disp([repmat(char(9), 1, length(WorkSp.Group(groupInd).Population(j).tree)) num2str(j) ') gate "' WorkSp.Group(groupInd).Population(j).name '"']);
    end;  
    
    disp('   ');
    
    j1=find(strcmp(varargin, 'GateInd'));
    if length(j1)>1,
        error('Too many GroupInd inputs!')
    elseif length(j1)==1,
        gateInd = varargin{j1+1};
        disp(['Loading gates No: ' num2str(gateInd)]);
    else %default
        gateInd = input('What gates to use? (single gate number). 0 to go to sample gates, -1 for no gates ');
    end;
    
    if length(gateInd)~=1,
        error('Use single gate number to describe the gates!');
    end;
    
    if gateInd==0,
        GatesToLoad = 'SampleGates';
    elseif gateInd == -1,
        GatesToLoad = 'NoGates';
        gateInd = [];
    else 
        GatesToLoad = 'GroupGates';
        gateInd = WorkSp.Group(groupInd).Population(gateInd).tree;
    end;
    
    disp('    ');
    
    
    j1=find(strcmp(varargin, 'PathToDataFiles'));
    if length(j1)>1,
        error('Too many PathToDataFiles inputs!')
    elseif length(j1)==1,
        fpath = varargin{j1+1};
        disp(['Files will be searched in ' fpath]);
    end;
   

    if length(WorkSp.CompMatrix) ~= 1,
        %error('More than one or no Compensation Matrices was found!');
        CompMatInd = input(['More than one Comp Matr was found. Which should I use? (num <=' num2str(length(WorkSp.CompMatrix)) ') : ']);
    else
        CompMatInd = 1;
    end;

    CompensationMatrix=WorkSp.CompMatrix(CompMatInd).Matrix;
    % old stuff
    %CompensationMatrix = 2*eye(size(CompensationMatrix))-CompensationMatrix;
    
    NcompChann = length(WorkSp.CompMatrix(CompMatInd).ChannelNames);
    if size(CompensationMatrix, 1) ~= NcompChann,
        errordlg('Mismatch in matrix size. Doing patch. Check the consistency of channel names between different CM.');
        CompensationMatrix = CompensationMatrix(1:NcompChann, 1:NcompChann);       
    end;

    %load the file with the larges number of events;
    %show the application of gates
    %get the channel names
    
    GroupSamples = WorkSp.Samples(WorkSp.sampleID2sampleInd(WorkSp.Group(groupInd).SampleID));
     [temp, I] = max([GroupSamples.count]);
     filename = GroupSamples(I).fname;
     filename
    
    if isfield(GroupSamples(I), 'plateName'),
        plateName = GroupSamples(I).plateName;
    end;
    
    
    tempname = [fpath filesep filename];
        if exist(tempname, 'file'),
            [fcsdat, fcshdr] = fca_readfcs_v2(tempname);
        elseif exist('plateName', 'var'),
            tempname = [fpath filesep plateName filesep filename];
            [fcsdat, fcshdr, fcsdatscaled] = fca_readfcs_v2(tempname);
        end;
        clear fcsdat;
    
    %[fcsdat, fcshdr, fcsdatscaled] = fca_readfcs_v1([fpath filesep filename]);
    'all channels'
    ListOfChannels={fcshdr.par.name}
    'compensated channels'
    WorkSp.CompMatrix.ChannelNames

    % match channels between the Compensation Matrix and the measurement and
    % create channel names
    
    
    
    for i = 1:NcompChann,
        Jcomp(i) = find(strcmp(ListOfChannels, WorkSp.CompMatrix(CompMatInd).ChannelNames{i}));
        ChannelNames{i} = ['<' WorkSp.CompMatrix(CompMatInd).ChannelNames{i} '>: ' fcshdr.par(Jcomp(i)).tag];
    end;
    
    'ChannelNames'
    ChannelNames'
    
    CombinedListofChannels = ListOfChannels;
    ListofChannelsWithLabels = ListOfChannels;
    CombinedListofChannelsComp = ListOfChannels;
    for i=1:length(Jcomp),
        CombinedListofChannelsComp{Jcomp(i)} = ['Comp-' CombinedListofChannelsComp{Jcomp(i)}];
        CombinedListofChannels{Jcomp(i)} = ['<' CombinedListofChannels{Jcomp(i)} '>'];
        ListofChannelsWithLabels{Jcomp(i)} = ChannelNames{i};
    end;
    
    'CombinedListofChannels'
    CombinedListofChannels
    'CombinedListofChannelsComp'
    CombinedListofChannelsComp

    ListOfFCSFiles = {GroupSamples.fname};
    if isfield(WorkSp.Samples(1), 'plateName'),
        ListOfPlateNames = {GroupSamples.plateName};
    end;
    
    
    if ~isempty(NameFilter), % apply name filter
        removeInd = [];
        match = regexp(ListOfFCSFiles, NameFilter);
        for j=1:length(ListOfFCSFiles),
            if isempty(match{j}),
                removeInd = [removeInd j];             
            end;
        end;
        ListOfFCSFiles(removeInd) = [];
        GroupSamples(removeInd) = [];
        
        
        if exist('ListOfPlateNames', 'var'),
            ListOfPlateNames(removeInd) = [];
        end;
    end;
    
    
    length(ListOfFCSFiles)
    
    

    for j = 1:length(ListOfFCSFiles),
        tempname = [fpath filesep ListOfFCSFiles{j}];
        tempname
        if exist(tempname, 'file'),
            fcsdata = fca_readfcs_v2(tempname);
        elseif exist('ListOfPlateNames', 'var'),
            tempname = [fpath filesep ListOfPlateNames{j} filesep ListOfFCSFiles{j}];
            fcsdata = fca_readfcs_v2(tempname);
        end;
            

        fcsdata(:, Jcomp)=(fcsdata(:, Jcomp)*inv(CompensationMatrix)); % stored in xml file is in fact a spilover matrix, not a compensation matrix
         
        disp(['FileNo = ', num2str(j), '   File name: ', ListOfFCSFiles{j}]);
        disp(['total data points: ' num2str(size(fcsdata, 1))]);

        if strcmp(GatesToLoad, 'SampleGates'), %loading sample gates
            close all;
            disp('Found the following gates in this sample:');
            disp('    ');
                       
            for k=1:length(GroupSamples(j).Population),
                disp([repmat(char(9), 1, length(GroupSamples(j).Population(k).tree)) num2str(k) ') gate "' GroupSamples(j).Population(k).name '"']);
            end;  
            disp('   ');
            gateInd = input('What gates to use? (single gate number) ');
            disp('    ');
            gateInd = GroupSamples(j).Population(gateInd).tree;
            Gates = GroupSamples(j).Population(gateInd);
        elseif strcmp(GatesToLoad, 'GroupGates'),  % match sample gates to group gates and load data from sample gates
            matchingGates = [];
            for k=1:length(GroupSamples(j).Population),
                if size({GroupSamples(j).Population(GroupSamples(j).Population(k).tree).name}' ) == size({WorkSp.Group(groupInd).Population(gateInd).name}'),
                     if strcmp({GroupSamples(j).Population(GroupSamples(j).Population(k).tree).name}' , {WorkSp.Group(groupInd).Population(gateInd).name}'),
                        matchingGates = [matchingGates k];
                     end;
                end;
            end;
            
            if length(matchingGates) < 1, 
                    errordlg(['No matching gates were found in the sample: ' GroupSamples(j).fname '. Loading with group gates. Should not have happened. ']);
                    Gates = WorkSp.Group(groupInd).Population(gateInd);
            elseif length(matchingGates) > 1, 
                    errordlg(['More than one matching gates were found in the sample: ' GroupSamples(j).fname '. Loading with the first match. Should not have happened. ']);
                    Gates = GroupSamples(j).Population(GroupSamples(j).Population(matchingGates(1)).tree);
            else %normal
                    Gates = GroupSamples(j).Population(GroupSamples(j).Population(matchingGates).tree);
            end;

        end;            

        for i=1:length(gateInd),
            
            gate = Gates(i);
            %match X axis to channel list
            gate
            CombinedListofChannels

            if WorkSp.version >= 2
                xInd = find(strcmp(CombinedListofChannels, gate.xAxis))
                yInd = find(strcmp(CombinedListofChannels, gate.yAxis))
            else        
                xInd = find(strcmp(CombinedListofChannelsComp, gate.xAxis))
                yInd = find(strcmp(CombinedListofChannelsComp, gate.yAxis))
            end;
            
            if ~isempty(xInd),
                Xdata = fcsdata(:, xInd);
            end
            if ~isempty(yInd),
                Ydata = fcsdata(:, yInd);
            end
            
 
            
            if strcmp(gate.xAxis, 'Time'),
                gate.X = gate.X*100;
            end;
            
            if strcmp(gate.yAxis, 'Time'),
                gate.Y = gate.Y*100;
            end;


            if strcmp(gate.selectionType, 'PolyRect'),
                Xgate = gate.X;
                Ygate = gate.Y;

               %if ((j==1)&Demonstration)|strcmp(GatesToLoad, 'SampleGates'),
                if (Demonstration)|strcmp(GatesToLoad, 'SampleGates'),
                   figure;
                   LogXscale = ismember(xInd, Jcomp);
                   LogYscale = ismember(yInd, Jcomp);
                   h = ScatterPlotFACS_v1(Xdata, Ydata, 'LogXscale', LogXscale, 'LogYscale', LogYscale,...
                       'PlotGate', [Xgate Ygate])
                   

                   xlabel(gate.xAxis);
                   ylabel(gate.yAxis);
                   title(gate.name);
                   pause;
               end;

               % now gating

               Xmin = min(Xgate);
               Xmax = max(Xgate);
               Ymin = min(Ygate);
               Ymax = max(Ygate);
                
              
               
               gateVal = (Xdata >= Xmin) & (Xdata <= Xmax) & (Ydata >= Ymin) & (Ydata <= Ymax);
               
              
               fcsdata = fcsdata(gateVal, :);
               disp(['data points in ' gate.name ' gate: ' num2str(size(fcsdata, 1))]);

            elseif (strcmp(gate.selectionType, 'Range') & isempty(yInd)), %Histogram plot
                Xgate = gate.X;
                if (j==1)&Demonstration, 
                   figure;
                   LogXscale = ismember(xInd, Jcomp);
                   h = ScatterPlotFACS_v1(Xdata, [], 'LogXscale', LogXscale,'PlotGate', Xgate)
                   
                   xlabel(gate.xAxis);
                   ylabel(gate.yAxis);
                   title(gate.name);
                   pause;
                end;

               % now gating

               Xmin = min(Xgate);
               Xmax = max(Xgate);
               


               gateVal = (Xdata >= Xmin) & (Xdata <= Xmax);
               fcsdata = fcsdata(gateVal, :);
               disp(['data points in ' gate.name ' gate: ' num2str(size(fcsdata, 1))]);

            elseif strcmp(gate.selectionType, 'Polygon'),
     %            Xdata = fcsdata(:, xInd);
                Xgate = gate.X;

      %          Ydata = fcsdata(:, yInd);
                Ygate = gate.Y;

               if ((j==1)&Demonstration)|strcmp(GatesToLoad, 'SampleGates'), 
                   figure;
                   LogXscale = ismember(xInd, Jcomp);
                   LogYscale = ismember(yInd, Jcomp);
                   h = ScatterPlotFACS_v1(Xdata, Ydata, 'LogXscale', LogXscale, 'LogYscale', LogYscale,...
                       'PlotGate', [Xgate Ygate])
                   xlabel(gate.xAxis);
                   ylabel(gate.yAxis);
                   title(gate.name);
                   pause;
               end;

               [gateVal ON] = inpolygon(Xdata, Ydata, Xgate, Ygate);
               fcsdata = fcsdata(gateVal, :);
               disp(['data points in ' gate.name ' gate: ' num2str(size(fcsdata, 1))]);
            else
                error('This gate is not taken care of yet. Tell Oleg!')

            end;
            figure(gcf);

        end;
        ListOfFCSFiles{j}
        CGData(j).name = ListOfFCSFiles{j};
        CGData(j).ListofChannelsWithLabels = ListofChannelsWithLabels(:);
        CGData(j).data = fcsdata;

        
        disp(' ')
        disp('')
        disp('')
        
    end;


end


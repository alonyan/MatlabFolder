function [WorkSpNoPointers, WorkSp, theTree, SampleNodeObj, GroupsObj] = ReadFlowJoXMLfile_v6(varargin)
% This function uses XMLREAD to load the Workspace xml object as saved by
% FlowJo and then navigates it to extract neccessary (not all) information
% and puts that into a WorkSp data structure. The other output parameters
% are xml objects useful mostly to explore other stored information:
% theTree  - is the top object in the hierarchy that points to the Workspace
% SampleNodeObj - is the object pointing to an array of Sample Nodes
% GroupsObj - points to the groups in the Workspace.
%
% The function takes variable arguments:
%       1) if no arguments are supplied then the function will ask you  to point to
%                   the .xml file.
%       2) a single string argument describing full path to the .xml file
%       3) two string arguments, the first one pointing to the path to the
%       folder and the second containing an .xml file name. The folder path
%       parameter has to have a file separator at the end ('/' or '\',
%       depending on the platform, Mac or PC. Use FILESEP if not sure.
%
% The WorkSp output contains the following fields:
%       1) Group - an array of group structures. Each entry in the group
%       (referenced as WorkSp.Group(i), where i - is an array index)
%       contains the fields:
%               1.1) name - that's a corresponding group name
%               1.2) Population - this is an array of structures each of
%               which describes a group gate. The fields in each of those
%               structures are
%                       1.2.1) name - the gate name
%                       1.2.2) selection type - polygon, rectangle etc
%                       1.2.3-4) xAxis and yAxis - the names of the axes for
%                       the gates
%                       1.2.5-6) X and Y - the gate coordinates
%                       1.2.7) tree - a vector with gate numbers in the
%                       order of application of the nested gates. Say, if
%                       the gates in a group in FlowJo appear as
%
%                       "Whatever Group"
%                               CD4-
%                               CD4+
%                                       CD25+
%                                              LiveCells
%                                               DeadCells
%
%                       then WorkSp will have a group named "Whatever
%                       Group" which will have 5 populations in the order
%                       of appearance in FlowJo with the following trees:
%                       1) CD4-  tree: 1
%                       2) CD4+ tree: 2
%                               3) CD25+  tree: [2 3]
%                                              4) LiveCells tree: [2 3 4]
%                                               5) DeadCells tree: [2 3 5]
%
%                   
%                       1.2.8) pointer - pointer to the Population xml object for  further exploration and debugging
%                       1.2.9) owning group - the owning group name
%                       1.2.10) Parent - the name of the parent gate in the
%                       nested gates hierarchy
%                           'end of Population description'
%               1.3) SampleID: the sample IDs of the samples in a group as
%               assigned by FlowJo at the time of file loading
%                   'end of Group description'
%       2) CompMatrix - Compensation Matrix structure or and array of Compensation
%       Matrix structures. Each structure in the array contains two fields
%               2.1) the cell array of channel names
%               2.2) the matrix itself
%
%       3)  Samples - an array of sample structures each containing the
%       following fields
%               3.1) fname - the file name of the sample
%               3.2) SampleID
%               3.3) count - the total number of measured cells in the
%               sample
%               3.4) Population - the array of structures  describing the
%               gates applied to the sample, either through the Group gates
%               or individually. The structures have the same fields as
%               Populations in the Group.
%
%       4) sampleID2sampleInd  -  the SampleIDs are not the same as sample
%       index int the WorkSp.Samples array : only the creators of FlowJo
%       may know why. This field provides the conversion between the two
%       numbers.
%
%       If any futher information from the Workspace is needed, one can try
%       to explore theTree object using the routines within this file as
%       the example.
%
% Oleg Krichevsky, Dec. 2010.
% 
% Added loading sample gates, Apr. 2011 
% cleared pointers in first output, AY Feb12

    switch length(varargin)
        case 0,
            [filename, fpath] = uigetfile('.xml', 'Open FlowJo XML file:') ;            
            if filename==0,
                S = [];
                error('No file was selected!');
            else
                  fname = [fpath filename];
            end;
        case 1,
            fname = varargin{1};
        case 2,
            fpath  = varargin{1};
            filename = varargin{2};
            fname = [fpath filename];
        otherwise
            S = [];
            error('Either provide nothing, full file path, or file path and file name!')                      
    end;

    fid = fopen(fname, 'r');
    
    if fid == -1,
        error('Cannot find the file!');
    end;
    
    theTree = xmlread(fname);
    WorkspaceObj = theTree.getChildNodes.item(1);
    
    for i=0:(WorkspaceObj.getChildNodes.getLength-1), 
        if strcmp(WorkspaceObj.getChildNodes.item(i).getNodeName, 'Groups'),
            GroupsObj = WorkspaceObj.getChildNodes.item(i);
        elseif strcmp(WorkspaceObj.getChildNodes.item(i).getNodeName, 'CompensationMatrices'),
            CompensationMatricesObj = WorkspaceObj.getChildNodes.item(i);
        elseif strcmp(WorkspaceObj.getChildNodes.item(i).getNodeName, 'SampleList'),
            SampleListObj = WorkspaceObj.getChildNodes.item(i);
        end;           
    
    end;
    
    %look for groups
    GroupObj = GroupsObj.getElementsByTagName('GroupNode');
    
    
    Group = [];
    %look for populations and Sample numbers
    for i=0:(GroupObj.getLength - 1),
        NewGroup.name = char(GroupObj.item(i).getAttribute('name'));
        NewGroup.Population = [];
        PopulationObj = GroupObj.item(i).getElementsByTagName('Population');
        
        if PopulationObj.getLength,            
            for j=0:(PopulationObj.getLength-1),
                NewGroup.Population(j+1).name = char(PopulationObj.item(j).getAttribute('name'));
                PolygonObj = PopulationObj.item(j).getElementsByTagName('PolygonGate').item(0).getElementsByTagName('Polygon'); 
                Polygon = PolygonObj.item(PolygonObj.getLength -1); 
            % there should be one defined polygon selection per
            % PolygonGate. If there are two this means that the first
            % polygon object defines the selection type (Other selection types are PolyRect or Range)
            
                NewGroup.Population(j+1).selectionType = char(Polygon.getParentNode.getNodeName);           
                NewGroup.Population(j+1).xAxis = char(Polygon.getParentNode.getAttribute('xAxisName'));
                NewGroup.Population(j+1).yAxis = char(Polygon.getParentNode.getAttribute('yAxisName'));
            
            %get verteces
                X = []; Y = [];
                VertecesObj = Polygon.getElementsByTagName('Vertex');
                for k=0:(VertecesObj.getLength-1),
                    X = [X; str2num(VertecesObj.item(k).getAttribute('x'))];
                    Y = [Y; str2num(VertecesObj.item(k).getAttribute('y'))];
                end;
            
                NewGroup.Population(j+1).X = X;
                NewGroup.Population(j+1).Y = Y;
                NewGroup.Population(j+1).tree = j+1;
                NewGroup.Population(j+1).pointer = PopulationObj.item(j);
                
                if strcmp(PopulationObj.item(j).getParentNode.getNodeName,  'Population'),
                     NewGroup.Population(j+1).Parent = char(PopulationObj.item(j).getParentNode.getAttribute('name'));
                     %PopulationObj.item(j).getParentNode
                     %[NewGroup.Population.pointer]
                     %Jparent = find(PopulationObj.item(j).getParentNode == {NewGroup.Population.pointer})
                     for k=1:length(NewGroup.Population),
                         if PopulationObj.item(j).getParentNode == NewGroup.Population(k).pointer,
                             Jparent = k;
                         end;
                     end;
                     NewGroup.Population(j+1).tree = [NewGroup.Population(Jparent).tree j+1];
                end;
                NewGroup.Population(j+1).owningGroup = char(PopulationObj.item(j).getAttribute('owningGroup'));
            end;
        end;
        
        %look for sample references
        NewGroup.SampleID = [];
        SampleObj = GroupObj.item(i).getElementsByTagName('SampleRef');
        for j=0:(SampleObj.getLength - 1),
            NewGroup.SampleID(j+1) = str2num(SampleObj.item(j).getAttribute('sampleID'));
        end;
        Group = [Group; NewGroup];
        
    end;
    
    WorkSp.Group = Group;
    
    %get compensation matrix
    CompMatrxObj = theTree.getElementsByTagName('CompensationMatrix');
    CompMatrxObj.getLength
    
    for i=0:(CompMatrxObj.getLength-1),
        ChannelList = CompMatrxObj.item(i).getElementsByTagName('Channel');
        ChannelNames = {};
        for j=0:(ChannelList.getLength-1),
            ChannelNames = [ChannelNames; char(ChannelList.item(j).getAttribute('name'))];
            ChannelValues = ChannelList.item(j).getElementsByTagName('ChannelValue');
            for k=0:(ChannelValues.getLength-1),
                CompMatrix(j+1, k+1) = str2num(ChannelValues.item(k).getAttribute('value'));
            end;
        end;
        WorkSp.CompMatrix(i+1).ChannelNames = ChannelNames;
        WorkSp.CompMatrix(i+1).Matrix = CompMatrix;

    end;
    
    %get sample information
    SampleNodeObj = SampleListObj.getElementsByTagName('SampleNode');
    for i=0:(SampleNodeObj.getLength-1), 
 
        Samples(i+1).fname = char(SampleNodeObj.item(i).getAttribute('name'));
        Samples(i+1).SampleID = str2num(SampleNodeObj.item(i).getAttribute('sampleID'));
        Samples(i+1).count = str2num(SampleNodeObj.item(i).getAttribute('count'));
        
        
        KeywordsObj = SampleNodeObj.item(i).getParentNode.getElementsByTagName('Keyword');
        if i==0, % check on the first sample the position of the "Plate Name" keyword. For others just verify whether this is correct
            for j=0:(KeywordsObj.getLength - 1),
                if strcmp(KeywordsObj.item(j).getAttribute('name'), 'PLATE NAME'),
                    Jplatename = j;
                    Samples(i+1).plateName = char(KeywordsObj.item(j).getAttribute('value'));
                    break;
                end;
            end;
        else %i>0
            if exist('Jplatename'),              
                if strcmp(KeywordsObj.item(Jplatename).getAttribute('name'), 'PLATE NAME'), %use the found "Plate Name" keyword
                        Samples(i+1).plateName = char(KeywordsObj.item(Jplatename).getAttribute('value'));
                else %look for a new one
                    'should not be here'
                    for j=0:(KeywordsObj.getLength - 1),
                        if strcmp(KeywordsObj.item(j).getAttribute('name'), 'PLATE NAME'),
                            Jplatename = j;
                            Samples(i+1).plateName = char(KeywordsObj.item(j).getAttribute('value'));
                            break;
                        end;
                    end;
                end;
            end;
            
        end; %Keywords
        
       
        SamplePopulationObj = SampleNodeObj.item(i).getElementsByTagName('Population');
       
        
        if SamplePopulationObj.getLength,            
            for j=0:(SamplePopulationObj.getLength-1),
                Samples(i+1).Population(j+1).name = char(SamplePopulationObj.item(j).getAttribute('name'));
                PolygonObj = SamplePopulationObj.item(j).getElementsByTagName('PolygonGate').item(0).getElementsByTagName('Polygon'); 
                Polygon = PolygonObj.item(PolygonObj.getLength -1); 
            % there should be one defined polygon selection per
            % PolygonGate. If there are two this means that the first
            % polygon object defines the selection type (Other selection types are PolyRect or Range)
            
                Samples(i+1).Population(j+1).selectionType = char(Polygon.getParentNode.getNodeName);           
                Samples(i+1).Population(j+1).xAxis = char(Polygon.getParentNode.getAttribute('xAxisName'));
                Samples(i+1).Population(j+1).yAxis = char(Polygon.getParentNode.getAttribute('yAxisName'));
            
            %get verteces
                X = []; Y = [];
                VertecesObj = Polygon.getElementsByTagName('Vertex');
                for k=0:(VertecesObj.getLength-1),
                    X = [X; str2num(VertecesObj.item(k).getAttribute('x'))];
                    Y = [Y; str2num(VertecesObj.item(k).getAttribute('y'))];
                end;
            
                Samples(i+1).Population(j+1).X = X;
                Samples(i+1).Population(j+1).Y = Y;
                Samples(i+1).Population(j+1).tree = j+1;
                Samples(i+1).Population(j+1).pointer = SamplePopulationObj.item(j);
                Samples(i+1).Population(j+1).owningGroup = char(SamplePopulationObj.item(j).getAttribute('owningGroup'));
                
                if strcmp(SamplePopulationObj.item(j).getParentNode.getNodeName,  'Population'),
                     Samples(i+1).Population(j+1).Parent = char(SamplePopulationObj.item(j).getParentNode.getAttribute('name'));
                     %PopulationObj.item(j).getParentNode
                     %[NewGroup.Population.pointer]
                     %Jparent = find(PopulationObj.item(j).getParentNode == {NewGroup.Population.pointer})
                     for k=1:length(Samples(i+1).Population),
                         if SamplePopulationObj.item(j).getParentNode == Samples(i+1).Population(k).pointer,
                             Jparent = k;
                         end;
                     end;
                     Samples(i+1).Population(j+1).tree = [Samples(i+1).Population(Jparent).tree j+1];
                     if ~strcmp(Samples(i+1).Population(Jparent).owningGroup, Samples(i+1).Population(j+1).owningGroup),
                         Samples(i+1).Population(j+1).owningGroup = [];
                     end;
                end;                
            end;
        end;
        
        
        
    end;
    [temp, I]=sort([Samples.SampleID]);
    WorkSp.Samples = Samples(I);
    WorkSp.sampleID2sampleInd([WorkSp.Samples.SampleID]) = 1:length([WorkSp.Samples.SampleID]);
    WorkSp.Samples
    
    WorkSp1 = WorkSp;
   for i=1:length(WorkSp.Samples)
        if ~isempty(WorkSp.Samples(i).Population)
            WorkSp1.Samples(i).Population = rmfield(WorkSp.Samples(i).Population, 'pointer');
        end;
   end;
    
   for i=1:length(WorkSp.Group)
        if ~isempty(WorkSp.Group(i).Population)
            WorkSp1.Group(i).Population = rmfield(WorkSp.Group(i).Population, 'pointer');
        end;
   end;
            

    
        
    WorkSpNoPointers = WorkSp1;
  
end

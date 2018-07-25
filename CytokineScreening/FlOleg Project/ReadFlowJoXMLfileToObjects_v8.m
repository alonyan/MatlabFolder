   function [WorkSpNoPointers, FlOlegWorkSpace, WorkSp, theTree, SampleNodeObj, GroupsObj] = ReadFlowJoXMLfileToObjects_v8(varargin)
% This function uses XMLREAD to load the Workspace xml object as saved by
% FlowJo and then navigates it to extract neccessary (not all) information
% and puts that into a WorkSp data structure. The other output parameters
% are xml objects useful mostly to explore other stored information:
% theTree  - is the top object in the hierarchy that points to the
% Workspace
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
% Added WorkSp without pointers to xml structures as the first output: the
% other WorkSp (now a second output) does not save easily somehow 09/02/12.
%
% Jan. 2013:  Adding a treatment of the old version of FlowJo files (v 1.61)
% added "version" field to WorkSp
%
% Feb. 2014: Modifying the program to create objects for FlOleg
%
% Apr. 2014: Adding Workspace version 3 support. AY

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
    
    
    FlOlegWorkSpace = WorkSpObj;
    AddObjToList(FlOlegWorkSpace, FlOlegWorkSpace);
    
    theTree = xmlread(fname);    
    WorkspaceObj = theTree.getDocumentElement; 
    version = str2num(WorkspaceObj.getAttribute('version'));
    if version == 3,
        CompMatToken = 'CompensationMatrices';
        SampListToken = 'Samples';
    elseif version == 2,
        CompMatToken = 'CompensationMatrices';
        SampListToken = 'SampleList';
    else
        CompMatToken = 'CompensationEditor';
        SampListToken = 'SampleList';
    end;
    
    for i=0:(WorkspaceObj.getChildNodes.getLength-1), 
        if strcmp(WorkspaceObj.getChildNodes.item(i).getNodeName, 'Groups'),
            GroupsObj = WorkspaceObj.getChildNodes.item(i);
        elseif strcmp(WorkspaceObj.getChildNodes.item(i).getNodeName, CompMatToken),
            CompensationMatricesObj = WorkspaceObj.getChildNodes.item(i);
        elseif strcmp(WorkspaceObj.getChildNodes.item(i).getNodeName, SampListToken),
            SampleListObj = WorkspaceObj.getChildNodes.item(i);
        end;           
    
    end;
    
    %look for groups
    if version == 3,
        PolygonGateToken = 'PolygonGate';
        PolygonToken = 'Polygon';
        VertexToken = 'Vertex';
        NameToken = 'nodeName';
    elseif version == 2,
        PolygonGateToken = 'PolygonGate';
        PolygonToken = 'Polygon';
        VertexToken = 'Vertex';
        NameToken = 'name';
    else
        PolygonGateToken = 'Gate';
        PolygonToken = 'gating:PolygonGate';
        VertexToken = 'gating:vertex';
        NameToken = 'name';
    end;

    GroupObj = GroupsObj.getElementsByTagName('GroupNode');
    Group = [];
    %look for populations and Sample numbers
    for i=0:(GroupObj.getLength - 1),
        NewGroup.name = char(GroupObj.item(i).getAttribute(NameToken));
        NewGroup.Population = [];
        
        FlOlegNewGroup = FlOlGroupObj;
        set(FlOlegNewGroup, 'name', NewGroup.name, 'ParentHndl', FlOlegWorkSpace);
        AddObjToList(FlOlegWorkSpace, FlOlegNewGroup);
        
        PopulationObj = GroupObj.item(i).getElementsByTagName('Population');
        
        
        if PopulationObj.getLength,            
            for j=0:(PopulationObj.getLength-1),
                NewGroup.Population(j+1).name = char(PopulationObj.item(j).getAttribute(NameToken));
                PolygonObj = PopulationObj.item(j).getElementsByTagName(PolygonGateToken).item(0).getElementsByTagName(PolygonToken); 
                RectObj = PopulationObj.item(j).getElementsByTagName(PolygonGateToken).item(0).getElementsByTagName('gating:RectangleGate'); 
            % there should be one defined polygon selection per
            % PolygonGate. If there are two this means that the first
            % polygon object defines the selection type (Other selection types are PolyRect or Range)
            
                if version >=2,
                    Polygon = PolygonObj.item(PolygonObj.getLength -1);
                    NewGroup.Population(j+1).selectionType = char(Polygon.getParentNode.getNodeName);           
                    NewGroup.Population(j+1).xAxis = char(Polygon.getParentNode.getAttribute('xAxisName'));
                    NewGroup.Population(j+1).yAxis = char(Polygon.getParentNode.getAttribute('yAxisName'));
                else
                   if PolygonObj.getLength,
                       Polygon = PolygonObj.item(PolygonObj.getLength -1);
                        NewGroup.Population(j+1).selectionType = 'Polygon'; 
                   elseif RectObj.getLength,
                       Polygon = RectObj.item(RectObj.getLength -1);
                        NewGroup.Population(j+1).selectionType = 'PolyRect';                        
                   end;
                    if Polygon.getElementsByTagName('data-type:parameter').getLength>2,
                        error('Too many data-type:parameter -s')
                    end;
                    ParameterObj = Polygon.getElementsByTagName('data-type:parameter');
                    NewGroup.Population(j+1).xAxis = char(ParameterObj.item(0).getAttribute('data-type:name'));
                    if (ParameterObj.getLength == 1), % Range selection
                        NewGroup.Population(j+1).selectionType = 'Range';
                    else % PolyRect selection
                        NewGroup.Population(j+1).yAxis = char(Polygon.getElementsByTagName('data-type:parameter').item(1).getAttribute('data-type:name'));
                    end;
                end;
            
   %         get verteces
                X = []; Y = [];
                VertecesObj = Polygon.getElementsByTagName(VertexToken);
                if VertecesObj.getLength,
                    for k=0:(VertecesObj.getLength-1),
                        if version>= 2,
                            x1 = str2num(VertecesObj.item(k).getAttribute('x'));
                            y1 = str2num(VertecesObj.item(k).getAttribute('y'));
                        else
                            x1 = str2num(VertecesObj.item(k).getChildNodes.item(1).getAttribute('data-type:value'));
                            y1 = str2num(VertecesObj.item(k).getChildNodes.item(3).getAttribute('data-type:value'));
                        end;
                        X = [X; x1];
                        Y = [Y; y1];
                    end;
                elseif (version < 2)&strcmp(NewGroup.Population(j+1).selectionType, 'PolyRect'),
                    DimObj = Polygon.getElementsByTagName('gating:dimension');
                    Xmin = str2num(DimObj.item(0).getAttribute('gating:min'));
                    Xmax =str2num( DimObj.item(0).getAttribute('gating:max'));
                    Ymin = str2num(DimObj.item(1).getAttribute('gating:min'));
                    Ymax = str2num(DimObj.item(1).getAttribute('gating:max'));
                    X = [Xmin; Xmin; Xmax; Xmax];
                    Y = [Ymin; Ymax; Ymax; Ymin]; 
                  elseif  (version < 2)&strcmp(NewGroup.Population(j+1).selectionType, 'Range'),
                    DimObj = Polygon.getElementsByTagName('gating:dimension');
                    Xmin = str2num(DimObj.item(0).getAttribute('gating:min'));                    
                    Xmax =str2num( DimObj.item(0).getAttribute('gating:max'));    
                    if isempty(Xmax),
                        Xmax = inf;
                    end;
                    if isempty(Xmin),
                        Xmin = -inf;
                    end;
                    X = [Xmin; Xmax];
                    Y = [];                 
                else
                    error('This gate is not yet taken care of: check!!!')
                end;
            
                NewGroup.Population(j+1).X = X;
                NewGroup.Population(j+1).Y = Y;
                NewGroup.Population(j+1).tree = j+1;
                NewGroup.Population(j+1).pointer = PopulationObj.item(j);
                
                
                
                if version >= 2,
                    ParentPopulation = PopulationObj.item(j).getParentNode;
                else
                    ParentPopulation = PopulationObj.item(j).getParentNode.getParentNode; %early version have extra node <Subpopulation>
                end;
                
                FlOlegNewPopulation = GateObj(NewGroup.Population(j+1));
                set(FlOlegNewPopulation, 'OwnerHndl', FlOlegNewGroup, 'treeHndl', FlOlegNewPopulation);
                AddObjToList(FlOlegWorkSpace, FlOlegNewPopulation);
                AddPopulation(FlOlegNewGroup, FlOlegNewPopulation);
                    
                if strcmp(ParentPopulation.getNodeName,  'Population'),
                     NewGroup.Population(j+1).Parent = char(ParentPopulation.getAttribute(NameToken));
                     %PopulationObj.item(j).getParentNode
                     %[NewGroup.Population.pointer]
                     %Jparent = find(PopulationObj.item(j).getParentNode == {NewGroup.Population.pointer})
                     for k=1:length(NewGroup.Population),
                         if ParentPopulation == NewGroup.Population(k).pointer,
                             Jparent = k;
                         end;
                     end;
                     NewGroup.Population(j+1).tree = [NewGroup.Population(Jparent).tree j+1];
                     set(FlOlegNewPopulation, 'ParentHndl', FlOlegNewGroup.PopulationHndl(Jparent),...
                         'treeHndl', [FlOlegNewGroup.PopulationHndl(Jparent).treeHndl FlOlegNewPopulation]);
                     addDependentGate(FlOlegNewPopulation.ParentHndl, FlOlegNewPopulation);
                else
                    set(FlOlegNewPopulation, 'ParentHndl', FlOlegNewGroup);
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
    if version == 3,
        CompMatToken = 'CompensationMatrix';
        ChannelListToken = 'Channel';
        ChannelNamesToken = 'name';
        ChannelValuesToken = 'ChannelValue';
        ValueToken = 'spillValue';
    elseif version == 2,
        CompMatToken = 'CompensationMatrix';
        ChannelListToken = 'Channel';
        ChannelNamesToken = 'name';
        ChannelValuesToken = 'ChannelValue';
        ValueToken = 'value';
    else
        CompMatToken = 'comp:spilloverMatrix';
        ChannelListToken = 'comp:spillover';
        ChannelNamesToken = 'comp:parameter';
        ChannelValuesToken = 'comp:coefficient';
        ValueToken = 'comp:value';
    end;
    
    CompMatrxObj = CompensationMatricesObj.getElementsByTagName(CompMatToken);
    CompMatrxObj.getLength;
  
    
    for i=0:(CompMatrxObj.getLength-1),
        ChannelList = CompMatrxObj.item(i).getElementsByTagName(ChannelListToken);
        ChannelNames = {};
        for j=0:(ChannelList.getLength-1),
            ChannelNames = [ChannelNames; char(ChannelList.item(j).getAttribute(ChannelNamesToken))];
            ChannelValues = ChannelList.item(j).getElementsByTagName(ChannelValuesToken);
            for k=0:(ChannelValues.getLength-1),
                CompMatrix(j+1, k+1) = str2num(ChannelValues.item(k).getAttribute(ValueToken));
            end;
        end;
        WorkSp.CompMatrix(i+1).ChannelNames = ChannelNames;
        WorkSp.CompMatrix(i+1).Matrix = CompMatrix;

    end;
    
 %get sample information
    SampleNodeObj = SampleListObj.getElementsByTagName('SampleNode');
    for i=0:(SampleNodeObj.getLength-1), 
 
       % Samples(i+1).fname = char(SampleNodeObj.item(i).getAttribute('name'));
        Samples(i+1).fname = char(SampleNodeObj.item(i).getAttribute(NameToken));
        Samples(i+1).SampleID = str2num(SampleNodeObj.item(i).getAttribute('sampleID'));
        Samples(i+1).count = str2num(SampleNodeObj.item(i).getAttribute('count'));
        
        
        KeywordsObj = SampleNodeObj.item(i).getParentNode.getElementsByTagName('Keyword');
        if i==0, 
            % check on the first sample the position of the "Plate Name" keyword. For others just verify whether this is correct
            % the same for the file name position
            for j=0:(KeywordsObj.getLength - 1),
                if strcmp(KeywordsObj.item(j).getAttribute(NameToken), 'PLATE NAME'),
                    Jplatename = j;
                    Samples(i+1).plateName = char(KeywordsObj.item(j).getAttribute('value'));
                elseif strcmp(KeywordsObj.item(j).getAttribute(NameToken), '$FIL'),
                    Jfilename = j;
                    Samples(i+1).fname = char(KeywordsObj.item(j).getAttribute('value'));
                end;
            end;
        else %i>0
            if exist('Jplatename'),              
                if strcmp(KeywordsObj.item(Jplatename).getAttribute(NameToken), 'PLATE NAME'), %use the found "Plate Name" keyword
                        Samples(i+1).plateName = char(KeywordsObj.item(Jplatename).getAttribute('value'));
                else %look for a new one
                    'should not be here'
                    for j=0:(KeywordsObj.getLength - 1),
                        if strcmp(KeywordsObj.item(j).getAttribute(NameToken), 'PLATE NAME'),
                            Jplatename = j;
                            Samples(i+1).plateName = char(KeywordsObj.item(j).getAttribute('value'));
                            break;
                        end;
                    end;
                end;
            end;
            
            if exist('Jfilename'),              
                if strcmp(KeywordsObj.item(Jfilename).getAttribute(NameToken), '$FIL'), %use the found "Plate Name" keyword
                        Samples(i+1).fname = char(KeywordsObj.item(Jfilename).getAttribute('value'));
                else %look for a new one
                    'should not be here'
                    for j=0:(KeywordsObj.getLength - 1),
                        if strcmp(KeywordsObj.item(j).getAttribute(NameToken), '$FIL'),
                            Jfilename = j;
                            Samples(i+1).fname = char(KeywordsObj.item(j).getAttribute('value'));
                            break;
                        end;
                    end;
                end;
            end;
            
        end; %Keywords
        
       
        SamplePopulationObj = SampleNodeObj.item(i).getElementsByTagName('Population');   
        if SamplePopulationObj.getLength,            
            for j=0:(SamplePopulationObj.getLength-1),
                Samples(i+1).Population(j+1).name = char(SamplePopulationObj.item(j).getAttribute(NameToken));
                
                PolygonObj = SamplePopulationObj.item(j).getElementsByTagName(PolygonGateToken).item(0).getElementsByTagName(PolygonToken); 
                RectObj = SamplePopulationObj.item(j).getElementsByTagName(PolygonGateToken).item(0).getElementsByTagName('gating:RectangleGate'); 
%                 PolygonObj = SamplePopulationObj.item(j).getElementsByTagName('PolygonGate').item(0).getElementsByTagName('Polygon'); 
%                 Polygon = PolygonObj.item(PolygonObj.getLength -1); 
            % there should be one defined polygon selection per
            % PolygonGate. If there are two this means that the first
            % polygon object defines the selection type (Other selection types are PolyRect or Range)
                 if version >=2,
                    Polygon = PolygonObj.item(PolygonObj.getLength -1);
                    Samples(i+1).Population(j+1).selectionType = char(Polygon.getParentNode.getNodeName);           
                    Samples(i+1).Population(j+1).xAxis = char(Polygon.getParentNode.getAttribute('xAxisName'));
                    Samples(i+1).Population(j+1).yAxis = char(Polygon.getParentNode.getAttribute('yAxisName'));
                else
                   if PolygonObj.getLength,
                       Polygon = PolygonObj.item(PolygonObj.getLength -1);
                        Samples(i+1).Population(j+1).selectionType = 'Polygon'; 
                   elseif RectObj.getLength,
                       Polygon = RectObj.item(RectObj.getLength -1);
                        Samples(i+1).Population(j+1).selectionType = 'PolyRect';                        
                   end;
                    if Polygon.getElementsByTagName('data-type:parameter').getLength>2,
                        error('Too many data-type:parameter -s')
                    end;
                    ParameterObj = Polygon.getElementsByTagName('data-type:parameter');
                    Samples(i+1).Population(j+1).xAxis = char(ParameterObj.item(0).getAttribute('data-type:name'));
                    if (ParameterObj.getLength == 1), % Range selection
                        Samples(i+1).Population(j+1).selectionType = 'Range';
                    else % PolyRect selection
                        Samples(i+1).Population(j+1).yAxis = char(Polygon.getElementsByTagName('data-type:parameter').item(1).getAttribute('data-type:name'));
                    end;
                end;
%                 Samples(i+1).Population(j+1).selectionType = char(Polygon.getParentNode.getNodeName);           
%                 Samples(i+1).Population(j+1).xAxis = char(Polygon.getParentNode.getAttribute('xAxisName'));
%                 Samples(i+1).Population(j+1).yAxis = char(Polygon.getParentNode.getAttribute('yAxisName'));
            
            %get verteces
            X = []; Y = [];
                VertecesObj = Polygon.getElementsByTagName(VertexToken);
                if VertecesObj.getLength,
                    for k=0:(VertecesObj.getLength-1),
                        if version>= 2,
                            x1 = str2num(VertecesObj.item(k).getAttribute('x'));
                            y1 = str2num(VertecesObj.item(k).getAttribute('y'));
                        else
                            x1 = str2num(VertecesObj.item(k).getChildNodes.item(1).getAttribute('data-type:value'));
                            y1 = str2num(VertecesObj.item(k).getChildNodes.item(3).getAttribute('data-type:value'));
                        end;
                        X = [X; x1];
                        Y = [Y; y1];
                    end;
                elseif (version < 2)&strcmp(Samples(i+1).Population(j+1).selectionType, 'PolyRect'),
                    DimObj = Polygon.getElementsByTagName('gating:dimension');
                    Xmin = str2num(DimObj.item(0).getAttribute('gating:min'));
                    Xmax =str2num( DimObj.item(0).getAttribute('gating:max'));                 
                    Ymin = str2num(DimObj.item(1).getAttribute('gating:min'));
                    Ymax = str2num(DimObj.item(1).getAttribute('gating:max'));
                    X = [Xmin; Xmin; Xmax; Xmax];
                    Y = [Ymin; Ymax; Ymax; Ymin]; 
                elseif  (version < 2)&strcmp(Samples(i+1).Population(j+1).selectionType, 'Range'),
                    DimObj = Polygon.getElementsByTagName('gating:dimension');
                    Xmin = str2num(DimObj.item(0).getAttribute('gating:min'));                    
                    Xmax =str2num( DimObj.item(0).getAttribute('gating:max'));    
                    if isempty(Xmax),
                        Xmax = inf;
                    end;
                    if isempty(Xmin),
                        Xmin = -inf;
                    end;
                    X = [Xmin; Xmax];
                    Y = [];                 
                else
                    error('This gate is not yet taken care of: check!!!')
                end;
            
%                 X = []; Y = [];
%                 VertecesObj = Polygon.getElementsByTagName('Vertex');
%                 for k=0:(VertecesObj.getLength-1),
%                     X = [X; str2num(VertecesObj.item(k).getAttribute('x'))];
%                     Y = [Y; str2num(VertecesObj.item(k).getAttribute('y'))];
%                 end;
   
                Samples(i+1).Population(j+1).X = X;
                Samples(i+1).Population(j+1).Y = Y;
                Samples(i+1).Population(j+1).tree = j+1;
                Samples(i+1).Population(j+1).pointer = SamplePopulationObj.item(j);
                Samples(i+1).Population(j+1).owningGroup = char(SamplePopulationObj.item(j).getAttribute('owningGroup'));
         
                if strcmp(SamplePopulationObj.item(j).getParentNode.getNodeName,  'Population'),
                     Samples(i+1).Population(j+1).Parent = char(SamplePopulationObj.item(j).getParentNode.getAttribute(NameToken));
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
                
                if version >= 2,
                    ParentPopulation = SamplePopulationObj.item(j).getParentNode;
                else
                    ParentPopulation = SamplePopulationObj.item(j).getParentNode.getParentNode; %early version have extra node <Subpopulation>
                end;
                    
                if strcmp(ParentPopulation.getNodeName,  'Population'),
                     Samples(i+1).Population(j+1).Parent = char(ParentPopulation.getAttribute(NameToken));
                     %PopulationObj.item(j).getParentNode
                     %[NewGroup.Population.pointer]
                     %Jparent = find(PopulationObj.item(j).getParentNode == {NewGroup.Population.pointer})
                     for k=1:length(Samples(i+1).Population),
                         if ParentPopulation == Samples(i+1).Population(k).pointer,
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
    WorkSp.Samples;
    WorkSp.version = version;
    
    WorkSpNoPointers = WorkSp;
    for i=1:length(WorkSp.Group),
        if ~isempty(WorkSp.Group(i).Population),
            WorkSpNoPointers.Group(i).Population = rmfield(WorkSp.Group(i).Population, 'pointer');
        end;
    end;
   
    for i=1:length(WorkSp.Samples),
        if ~isempty(WorkSp.Samples(i).Population),
             WorkSpNoPointers.Samples(i).Population = rmfield(WorkSp.Samples(i).Population, 'pointer');
        end;
    end;
    
end
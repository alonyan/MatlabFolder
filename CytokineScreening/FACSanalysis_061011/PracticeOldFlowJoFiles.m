fname = 'D:\Oleg\Experiments\FACS quantification\20121211AAutocrine.xml'
%fname = 'D:\Oleg\Experiments\MSKCC\20110713_AutoParaCrine\20110713_AutoParaCrine.xml'
theTree = xmlread(fname);
WorkspaceObj = theTree.getDocumentElement;
 %WorkspaceObj = theTree.getChildNodes.item(1);
version = str2num(WorkspaceObj.getAttribute('version'))

%% 
  if version>= 2,
        CompMatToken = 'CompensationMatrices';
    else
        CompMatToken = 'CompensationEditor';
    end;
    
    for i=0:(WorkspaceObj.getChildNodes.getLength-1), 
        if strcmp(WorkspaceObj.getChildNodes.item(i).getNodeName, 'Groups'),
            GroupsObj = WorkspaceObj.getChildNodes.item(i);
        elseif strcmp(WorkspaceObj.getChildNodes.item(i).getNodeName, CompMatToken),
            CompensationMatricesObj = WorkspaceObj.getChildNodes.item(i);
        elseif strcmp(WorkspaceObj.getChildNodes.item(i).getNodeName, 'SampleList'),
            SampleListObj = WorkspaceObj.getChildNodes.item(i);
        end;           
    
    end;
         
    
    if version>= 2,
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
    CompMatrxObj.getLength
  
    
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
%%
    if version>= 2,
        PolygonGateToken = 'PolygonGate';
        PolygonToken = 'Polygon';
        VertexToken = 'Vertex';
    else
        PolygonGateToken = 'Gate';
        PolygonToken = 'gating:PolygonGate';
        VertexToken = 'gating:vertex';
    end;

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
                            y1 = str2num(VertecesObj.item(k).getAttribute('y'))
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
                    
                if strcmp(ParentPopulation.getNodeName,  'Population'),
                     NewGroup.Population(j+1).Parent = char(ParentPopulation.getAttribute('name'));
                     %PopulationObj.item(j).getParentNode
                     %[NewGroup.Population.pointer]
                     %Jparent = find(PopulationObj.item(j).getParentNode == {NewGroup.Population.pointer})
                     for k=1:length(NewGroup.Population),
                         if ParentPopulation == NewGroup.Population(k).pointer,
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
    
%%
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
                            y1 = str2num(VertecesObj.item(k).getAttribute('y'))
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
                
                if version >= 2,
                    ParentPopulation = SamplePopulationObj.item(j).getParentNode;
                else
                    ParentPopulation = SamplePopulationObj.item(j).getParentNode.getParentNode; %early version have extra node <Subpopulation>
                end;
                    
                if strcmp(ParentPopulation.getNodeName,  'Population'),
                     Samples(i+1).Population(j+1).Parent = char(ParentPopulation.getAttribute('name'));
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
    
    
%%  
 %%%%%%%%%%%%   
     PopulationObj = GroupObj.item(i).getElementsByTagName('Population');
        
        if PopulationObj.getLength,            
            for j=0:(PopulationObj.getLength-1),
                 NewGroup.Population(j+1).name = char(PopulationObj.item(j).getAttribute('name'));
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
                    NewGroup.Population(j+1).xAxis = char(Polygon.getElementsByTagName('data-type:parameter').item(0).getAttribute('data-type:name'));
                    NewGroup.Population(j+1).yAxis = char(Polygon.getElementsByTagName('data-type:parameter').item(1).getAttribute('data-type:name'));
                end;
            
   %         get verteces
                X = []; Y = [];
                VertecesObj = Polygon.getElementsByTagName(VertexToken);
                if VertecesObj.getLength,
                    for k=0:(VertecesObj.getLength-1),
                        if version>= 2,
                            x1 = str2num(VertecesObj.item(k).getAttribute('x'));
                            y1 = str2num(VertecesObj.item(k).getAttribute('y'))
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
                    
                if strcmp(ParentPopulation.getNodeName,  'Population'),
                     NewGroup.Population(j+1).Parent = char(ParentPopulation.getAttribute('name'));
                     %PopulationObj.item(j).getParentNode
                     %[NewGroup.Population.pointer]
                     %Jparent = find(PopulationObj.item(j).getParentNode == {NewGroup.Population.pointer})
                     for k=1:length(NewGroup.Population),
                         if ParentPopulation == NewGroup.Population(k).pointer,
                             Jparent = k;
                         end;
                     end;
                     NewGroup.Population(j+1).tree = [NewGroup.Population(Jparent).tree j+1];
                end;
                NewGroup.Population(j+1).owningGroup = char(PopulationObj.item(j).getAttribute('owningGroup'));
            end;
        end;
    
   
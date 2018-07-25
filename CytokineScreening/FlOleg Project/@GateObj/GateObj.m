classdef GateObj < handle
    properties
        name
        selectionType
        xAxis
        yAxis
        X
        Y
        tree
        treeHndl
        owningGroup
        OwnerHndl
        Parent
        ParentHndl
        PrevObj
        NextObj
        DependentGates
    end
    
    methods
        function obj = GateObj(varargin)
            if (length(varargin)==1), % expect a structure with named fields
                if isstruct(varargin{1}),
                    GateStruc = varargin{1};
                    fldnames = fieldnames(GateStruc);
                    for i=1:length(fldnames),
                       if ismember(fldnames{i}, properties('GateObj')),
                           obj.(fldnames{i}) = GateStruc.(fldnames{i}); 
                       else
                           warning(['A field ' fldnames{i} ...
                               ' does not have a counterpart in the Gate Object!!!'])
                       end;

                    end;
                else
                    error('Expect a single stucture parameter with properly named fields!!!')
                end;
            elseif (length(varargin)==0), % create an empty Group object
                obj.name  = '';
                obj.selectionType = '';
                obj.xAxis = '';
                obj.yAxis = '';
                obj.X = [];
                obj.Y = [];
                obj.tree = [];
%                 obj.owningGroup = NULL;
%                 obj.OwnerHndl
%                 obj.Parent
%                 obj.ParentHndl
%                 obj.PrevGate
%                 obj.NextGate
            else
                error('Expect a single stucture parameter with properly named fields!!!')
            end
        end % end constructor
        
        function obj = set(obj, varargin)
            % expect pairs of 'Property' - property value
            Jchar = find(cellfun(@ischar, varargin));
            J = find(ismember(varargin(Jchar), properties('GateObj')));
            for i = Jchar(J),
                obj.(varargin{i}) = varargin{i+1};
            end          
        end
        
        function obj = addDependentGate(obj, DepGate)
            obj.DependentGates = [obj.DependentGates DepGate];
        end
        
    end
end
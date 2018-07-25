classdef WorkSpObj < handle
    properties
        name
        Groups
        Samples
        ObjList
        NextObj
    end
    methods
        function obj = WorkSpObj(varargin)
            if (length(varargin)==1), % expect a structure with named fields
                if isstruct(varargin{1}),
                    WorkSpStruc = varargin{1};
                    % add groups
                    for i=1:length(WorkSpStruc.Group),
                        newGroupObj = GroupObj(WorkSpStruc.Group(i));
                        for j=1:length(WorkSpStruc.Group(i).Population),
                        end
                    end
                elseif ischar(varargin{1}),
                    [temp, obj] = ReadFlowJoXMLfileToObjects_v7(varargin{1});
                else
                    error('Expect a single stucture parameter with properly named fields!!!')
                end;
            elseif (length(varargin)==0), % create an empty WorkSp object
                obj.name  = '';
                obj.Groups = [];
                obj.Samples = [];
                obj.ObjList = {};
                obj.NextObj = [];
            else
                error('Expect a single stucture parameter with properly named fields!!!')
            end
        end % end constructor
        
        function obj = AddObjToList(obj, NewObj)
            if ~isempty(obj.ObjList),
                obj.ObjList{end}.NextObj =  NewObj;
                NewObj.PrevObj = obj.ObjList(end);
            end; 
            obj.ObjList = [obj.ObjList {NewObj}]
            if strcmp(class(NewObj), 'FlOlGroupObj'),
                obj.Groups = [obj.Groups NewObj];
            end;
        end
        
        function LastObj = GetLastObjInList(obj)
            LastObj = obj.ObjList(end);
        end
        
        function obj = set(obj, varargin)
            % expect pairs of 'Property' - property value
            Jchar = find(cellfun(@ischar, varargin));
            J = find(ismember(varargin(Jchar), properties('WorkSpObj')));
            for i = Jchar(J),
                obj.(varargin{i}) = varargin{i+1};
            end
            
        end
    end
end
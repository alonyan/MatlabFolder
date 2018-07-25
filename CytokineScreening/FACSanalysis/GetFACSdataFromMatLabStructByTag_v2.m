function TagData = GetFACSdataFromMatLabStructByTag_v2(Data, varargin)
% This function separates data of a particular FACS channel as defined by
% 'Tag' from the data structure array  Data created with LoadFACSfromFlowJoWorkspace_v2
% procedure: the data from the same channel are organized in a single
% matrix field with the name of the 'Tag'. So, use Tag names that are
% eligible to be the field names (e.g. should not contain minus sign etc).
% Otherwise Tag can be any piece of the name of the needed channel in the
% Data.ListofChannelsWithLabels . that defines that channel unambigously.
% Examles of application.
% 20022013 v2 - AY - Added option to upload multiple channels at once. using (,'Tag', 'name',...)
% ExposedToIL2_5CC7_data = GetFACSdataFromMatLabStructByTag(ExposedToIL2_5CC7,'Tag', 'PE','Tag', 'APC','Tag', 'You're it!');
Tags = {};
j=find(strcmp(varargin, 'Tag'))

if isempty(j)
    error('You have to supply Tag input!')
else
    for i = 1:length(j)
    %    varargin{j(i)+1}
          Tags{i} = varargin{j(i)+1};
    end;


    for I = 1:length(Tags)
    match1 = strfind(Data(1).ListofChannelsWithLabels , [Tags{I}]);

        for i=1:length(Data(1).ListofChannelsWithLabels),
            if(~isempty(match1{i})), 
                ch1 = i,
                Data(1).ListofChannelsWithLabels(i)

            end;
        end;


        for i=1:length(Data),
            TagData(i).([Tags{I}]) = Data(i).data(:, ch1);
            TagData(i).name = Data(i).name;
            TagData(i).Tags = Tags;
        end
    end

end;

function TagData = GetFACSdataFromMatLabStructByTag( Data, Tag)
% This function separates data of a particular FACS channel as defined by
% 'Tag' from the data structure array  Data created with LoadFACSfromFlowJoWorkspace_v2
% procedure: the data from the same channel are organized in a single
% matrix field with the name of the 'Tag'. So, use Tag names that are
% eligible to be the field names (e.g. should not contain minus sign etc).
% Otherwise Tag can be any piece of the name of the needed channel in the
% Data.ListofChannelsWithLabels . that defines that channel unambigously.
% Examles of application
% ExposedToIL2_5CC7_PE = GetFACSdataFromMatLabStructByTag(ExposedToIL2_5CC7, 'PE');

match1 = strfind(Data(1).ListofChannelsWithLabels , Tag);

for i=1:length(Data(1).ListofChannelsWithLabels),
    if(~isempty(match1{i})), 
        ch1 = i,
        Data(1).ListofChannelsWithLabels(i)
        
    end;
end;


for i=1:length(Data),
    TagData(i).(Tag) = Data(i).data(:, ch1);
    TagData(i).name = Data(i).name;
end


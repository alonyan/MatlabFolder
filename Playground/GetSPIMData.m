fpath = '/RazorScopeData/RazorScopeSets/Jen/CorneaHSV/HSVSpread_p65V_2018Aug17/acq_1/';
MD = Metadata(fpath)
channelNames = arrayfun(@(x) MD.getSpecificMetadataByIndex('Channel', x), 1:numel(MD.unique('Channel')));
info = xml2struct([fpath 'hdf5_dataset.xml']);
partitionInfo = struct;
partitionInfo.('id') = cellfun(@(x) str2double(x.setups.Text),info.SpimData.SequenceDescription.ImageLoader.partition);
partitionInfo.('name') = cellfun(@(x) x.path.Text,info.SpimData.SequenceDescription.ImageLoader.partition, 'UniformOutput',false);
partitionInfo.('timepoint') = cellfun(@(x) str2double(x.timepoints.Text),info.SpimData.SequenceDescription.ImageLoader.partition);
partitionInfo.('tForms') = cellfun(@(x) x.ViewTransform, info.SpimData.ViewRegistrations.ViewRegistration, 'UniformOutput',false);

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

%%

timepoint = 50;
tile = 0;
tForms = partitionInfo.tForms(find((partitionInfo.timepoint==timepoint).*(partitionInfo.tile==tile)));

T = eye(4);
for i=1:numel(tForms{1})
T = T*reshape([str2double(strsplit(tForms{1}{i}.affine.Text)), 0 0 0 1]',4,4);
end
partNameList = partitionInfo.name(find((partitionInfo.timepoint==timepoint).*(partitionInfo.tile==tile)));
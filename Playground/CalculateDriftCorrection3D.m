function CalculateDriftCorrection3D(MD, pos, varargin)
resize = 0.25;

%default channel is deepblue, but can specify otherwise
Channel = ParseInputs('Channel', 'Red', varargin);

frames = unique(cell2mat(MD.getSpecificMetadata('frame')));

driftXY.dX = 0;
driftXY.dY = 0;
driftXY.dZ = 0;

    DataPre = stkread(MD,'Channel',Channel, 'flatfieldcorrection', false, 'frame', frames(1), 'Position', pos);
    DataPre = imresize3D(DataPre,resize);
for i=1:numel(frames)-1
    %load all data from frames 1:n-1
    %DataPre = stkread(MD,'Channel',Channel, 'flatfieldcorrection', false, 'frame', frames(i), 'Position', pos);
    %DataPre = imresize3D(DataPre,resize);
    %load all data from frames 2:n
    DataPost = stkread(MD,'Channel',Channel, 'flatfieldcorrection', false, 'frame', frames(i+1), 'Position', pos);
    DataPost = imresize3D(DataPost,resize);

    datasize = size(DataPre);

    imXcorr = convnfft(bsxfun(@minus, DataPre ,mean(mean(DataPre))),bsxfun(@minus, flip(flip(flip(DataPost,1),2),3) ,mean(mean(DataPost))) ,'shape','same', 'dims', 1:3,'UseGPU', true);
    XX = find(bsxfun(@eq, imXcorr ,max(imXcorr(:))));
    [maxCorrX,maxCorrY,maxCorrZ] = ind2sub(size(imXcorr),XX);
    
    driftXY.dX = [driftXY.dX,  (maxCorrX-size(imXcorr,1)/2)/resize]
    driftXY.dY = [driftXY.dY, (maxCorrY-size(imXcorr,2)/2)/resize]
    driftXY.dZ = [driftXY.dZ, (maxCorrZ-size(imXcorr,3)/2)/resize]
end


CummulDriftXY.dX = cumsum(driftXY.dX);
CummulDriftXY.dY = cumsum(driftXY.dY);
CummulDriftXY.dZ = cumsum(driftXY.dZ);

%% Add drift to MD
Typ = MD.Types;
Vals = MD.Values;

if ~any(strcmp('driftTform',Typ))
    Typ{end+1}='driftTform'; %Will become a standard in MD.
end
Ntypes = size(Typ,2);
% put the right drift displacements in the right place
for i=1:numel(frames)
    i
    inds = MD.getIndex({'frame', 'Position'},{i, pos});
    for j1=1:numel(inds)
        Vals{inds(j1),Ntypes} = [1 0 0 0 , 0 1 0 0, 0 0 1 0, CummulDriftXY.dZ(i), CummulDriftXY.dY(i), CummulDriftXY.dX(i), 1];
    end
end
MD.Types = Typ;
MD.Values = Vals;
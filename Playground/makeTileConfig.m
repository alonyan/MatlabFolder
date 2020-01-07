function makeTileConfig(MD)
configFileName = fullfile(MD.pth,'TileConfiguration.txt');
fid = fopen( configFileName, 'wt' );
fprintf( fid, '%s\n', '# Define the number of dimensions we are working on');
fprintf( fid, '%s\n', 'dim = 3');
fprintf( fid, '%s\n', '# Define the image coordinates (in pixels)');

Tiles = MD.unique('Tile');
Channels = MD.unique('Channel');
frames = MD.unique('frame');
for indFrame = 1:numel(frames)
    for indCh=1:numel(Channels)
        XYZ = [cell2mat(MD.getSpecificMetadata('XY','frame',frames(1),'Channel',Channels{indCh})), cell2mat(MD.getSpecificMetadata('Z','frame',frames(1),'Channel',Channels{indCh}))]./unique(cell2mat(MD.getSpecificMetadata('PixelSize')));
        for indTile=1:numel(Tiles)
            stkStr = [num2str((indCh-1)*numel(Tiles)+indTile-1) '; ' num2str(indFrame-1) '; (' num2str(XYZ(indTile,1)) ', ' num2str(XYZ(indTile,2)) ', ' num2str(XYZ(indTile,3)) ')' ];
            fprintf( fid, '%s\n', stkStr);
        end
    end
end

fclose(fid);
end
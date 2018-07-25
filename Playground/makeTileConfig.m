function makeTileConfig(Scp)
configFileName = fullfile(Scp.pth,Scp.MD.acqname,'TileConfiguration.txt');
fid = fopen( configFileName, 'wt' );
fprintf( fid, '%s\n', '# Define the number of dimensions we are working on');
fprintf( fid, '%s\n', 'dim = 3');
fprintf( fid, '%s\n', '# Define the image coordinates (in pixels)');

Z = Scp.MD.getSpecificMetadata('Z');
for i=1:size(Z,1)
    XYZ = [cell2mat(Scp.MD.getSpecificMetadataByIndex('XY',i)), cell2mat(Scp.MD.getSpecificMetadataByIndex('Z',i))]*Scp.PixelSize;
    [name, ~] = Scp.MD.getImageFilename({'index'},{i});
    TimeFrame = Scp.MD.getSpecificMetadataByIndex('frame',i);
    TimeFrame = num2str(TimeFrame{1});
    fullfile(name, 'MMStack_Pos0.ome.tif');
    pause(0.01)
    stkStr = [name '; ' TimeFrame '; (' num2str(XYZ(1)) ', ' num2str(XYZ(2)) ', ' num2str(XYZ(3)) ')' ];
    fprintf( fid, '%s\n', stkStr);
end

fclose(fid);
end
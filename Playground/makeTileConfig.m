function makeTileConfig(MD)
configFileName = fullfile(MD.pth,'TileConfiguration.txt');
fid = fopen( configFileName, 'wt' );
fprintf( fid, '%s\n', '# Define the number of dimensions we are working on');
fprintf( fid, '%s\n', 'dim = 3');
fprintf( fid, '%s\n', '# Define the image coordinates (in pixels)');
setupid = 0
Channels = MD.unique('Channel');

for ChanInd=1:numel(Channels)
    Z = MD.getSpecificMetadata('Z','Channel',Channels{ChanInd});
    timestamps = MD.getSpecificMetadata('TimestampImage','Channel',Channels{ChanInd})
    
    for i=1:numel(timestamps)
        XYZ = [cell2mat(MD.getSpecificMetadata('XY','TimestampImage',timestamps{i})), cell2mat(MD.getSpecificMetadata('Z','TimestampImage',timestamps{i}))]*MD.unique('PixelSize');
        %[name, ~] = MD.getImageFilename({'index'},{i});
        TimeFrame = MD.getSpecificMetadata('frame','TimestampImage',timestamps{i});
        TimeFrame = num2str(TimeFrame{1}-1);
        %fullfile(name, 'MMStack_Pos0.ome.tif');
        
        pause(0.01)
        stkStr = [num2str(setupid) '; ' TimeFrame '; (' num2str(XYZ(1)) ', ' num2str(XYZ(2)) ', ' num2str(XYZ(3)) ')' ];
        setupid=setupid+1;
        fprintf( fid, '%s\n', stkStr);
    end
end
fclose(fid);
end
%function makeTileConfig(MD)
ImageSize = [1232 1028];

configFileName = fullfile(MD.pth,'Processing','dataset.xml');
fid = fopen( configFileName, 'wt' );
fprintf( fid, '%s\n', '<?xml version="1.0" encoding="UTF-8"?>');
fprintf( fid, '%s\n', '<SpimData version="0.2">');
fprintf( fid, '%s\n', '  <BasePath type="relative">.</BasePath>');
fprintf( fid, '%s\n', '  <SequenceDescription>');
fprintf( fid, '%s\n', '    <ImageLoader format="spimreconstruction.filelist">');
fprintf( fid, '%s\n', '      <imglib2container>ArrayImgFactory</imglib2container>');
fprintf( fid, '%s\n', '      <ZGrouped>false</ZGrouped>');
fprintf( fid, '%s\n', '      <files>');



Tiles = Scp.MD.unique('Tile');
Tiles = sort(str2double(Tiles));
Channels = MD.unique('Channel');
frames = MD.unique('frame');
for indFrame = 1:numel(frames)
    for indCh=1:numel(Channels)
        for indTile=1:numel(Tiles)
            filename = MD.getImageFilenameRelative({'frame', 'Channel', 'Tile'},{frames(indFrame),Channels(indCh),num2str(Tiles(indTile))});
            viewsetup = (indCh-1)*numel(Tiles)+indTile-1;
            fprintf( fid, '%s%d%s%d%s\n', '        <FileMapping view_setup="',viewsetup,'" timepoint="',frames(indFrame)-1,'" series="0" channel="0">');
            fprintf( fid, '%s%s%s\n', '          <file type="relative">../',filename,'</file>');
            fprintf( fid, '%s\n', '        </FileMapping>');
        end
    end
end
fprintf( fid, '%s\n', '      </files>');
fprintf( fid, '%s\n', '    </ImageLoader>');
fprintf( fid, '%s\n', '    <ViewSetups>');

angles = [];
dZratio = MD.unique('dz')./MD.unique('PixelSize');
nZs = MD.getSpecificMetadata('nFrames','frame',1,'sortby','Channel');
Positions = MD.getSpecificMetadata('Position','frame',1,'sortby','Channel');

for indCh=1:numel(Channels)
    for indTile=1:numel(Tiles)
        viewsetup = (indCh-1)*numel(Tiles)+indTile-1;
        nZ = nZs{viewsetup+1};
        Position = Positions{viewsetup+1};
        ptrn='Theta';
        wherestheta = regexp(Position,ptrn);
        angle = str2double(Position(wherestheta+length(ptrn):wherestheta+length(ptrn)+2));
        angles = [angles angle];
        fprintf( fid, '%s\n', '      <ViewSetup>');
        fprintf( fid, '%s%d%s\n', '        <id>',viewsetup,'</id>');
        fprintf( fid, '%s%d%s\n', '        <name>',viewsetup,'</name>');
        fprintf( fid, '%s%d %d %d%s\n', '        <size>',ImageSize(1),ImageSize(2) ,nZ,'</size>');
        fprintf( fid, '%s\n', '        <voxelSize>');
        fprintf( fid, '%s\n', '          <unit>pixels</unit>');
        fprintf( fid, '%s%.1f %.1f %.2f%s\n', '          <size>',1,1,dZratio,'</size>');
        fprintf( fid, '%s\n', '        </voxelSize>');
        fprintf( fid, '%s\n', '        <attributes>');
        fprintf( fid, '%s\n', '          <illumination>0</illumination>');
        fprintf( fid, '%s%d%s\n', '          <channel>',indCh,'</channel>');
        fprintf( fid, '%s%d%s\n', '          <tile>',indTile-1,'</tile>');
        fprintf( fid, '%s%.0f%s\n', '          <angle>',angle,'</angle>');
        fprintf( fid, '%s\n', '        </attributes>');
        fprintf( fid, '%s\n', '      </ViewSetup>');
        
    end
end
angles = unique(angles);

fprintf( fid, '%s\n', '      <Attributes name="illumination">');
fprintf( fid, '%s\n', '        <Illumination>');
fprintf( fid, '%s\n', '          <id>0</id>');
fprintf( fid, '%s\n', '          <name>0</name>');
fprintf( fid, '%s\n', '        </Illumination>');
fprintf( fid, '%s\n', '      </Attributes>');


fprintf( fid, '%s\n', '      <Attributes name="channel">');
for indCh=1:numel(Channels)
fprintf( fid, '%s\n', '        <Channel>');
fprintf( fid, '%s%d%s\n', '          <id>',indCh,'</id>');
fprintf( fid, '%s%d%s\n', '          <name>',indCh,'</name>');
fprintf( fid, '%s\n', '        </Channel>');
end
fprintf( fid, '%s\n', '      </Attributes>');

fprintf( fid, '%s\n', '      <Attributes name="tile">');
for indTile=1:numel(Tiles)
fprintf( fid, '%s\n', '        <Tile>');
fprintf( fid, '%s%d%s\n', '          <id>',indTile-1,'</id>');
fprintf( fid, '%s%d%s\n', '          <name>',indTile-1,'</name>');
fprintf( fid, '%s\n', '        </Tile>');
end
fprintf( fid, '%s\n', '      </Attributes>');

fprintf( fid, '%s\n', '      <Attributes name="angle">');
for i=1:numel(angles)
fprintf( fid, '%s\n', '        <Angle>');
fprintf( fid, '%s%d%s\n', '          <id>',angles(i),'</id>');
fprintf( fid, '%s%d%s\n', '          <name>',angles(i),'</name>');
fprintf( fid, '%s\n', '        </Angle>');
end
fprintf( fid, '%s\n', '      </Attributes>');
fprintf( fid, '%s\n', '    </ViewSetups>');
fprintf( fid, '%s\n', '    <Timepoints type="range">');
fprintf( fid, '%s%d%s\n', '      <first>',min(frames)-1,'</first>');
fprintf( fid, '%s%d%s\n', '      <last>',max(frames)-1,'</last>');
fprintf( fid, '%s\n', '    </Timepoints>');

fprintf( fid, '%s\n', '    <MissingViews />');
fprintf( fid, '%s\n', '  </SequenceDescription>');



fprintf( fid, '%s\n', '  <ViewRegistrations>');
for indFrame = 1:numel(frames)
    for indCh=1:numel(Channels)
        for indTile=1:numel(Tiles)
            viewsetup = (indCh-1)*numel(Tiles)+indTile-1;
            fprintf( fid, '%s%d%s%d%s\n', '    <ViewRegistration timepoint="',frames(indFrame)-1,'" setup="',viewsetup,'">');
            fprintf( fid, '%s\n', '      <ViewTransform type="affine">');
            fprintf( fid, '%s\n', '        <Name>calibration</Name>');
            fprintf( fid, '%s %.2f %s\n', '        <affine>1.0 0.0 0.0 0.0 0.0 1.0 0.0 0.0 0.0 0.0',dZratio,'0.0</affine>');
            fprintf( fid, '%s\n', '      </ViewTransform>');            
            fprintf( fid, '%s\n', '    </ViewRegistration>');
        end
    end
end
fprintf( fid, '%s\n', '  </ViewRegistrations>');
fprintf( fid, '%s\n', '  <ViewInterestPoints />');
fprintf( fid, '%s\n', '  <BoundingBoxes />');
fprintf( fid, '%s\n', '  <PointSpreadFunctions />');
fprintf( fid, '%s\n', '  <StitchingResults />');
fprintf( fid, '%s\n', '  <IntensityAdjustments />');
fprintf( fid, '%s\n', '</SpimData>');



fclose(fid);
%end
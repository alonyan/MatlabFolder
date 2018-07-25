%%
Miji
%%
MD = Metadata('E:\RazorScopeImages\Jen\CorneaHSV\HSVInj_withControl_2017Dec22\acq_2');
%%
ScFact = 4;
%DB = stkread(MD,'Channel', 'DeepBlue-405','Position','Pos0','resize',1/ScFact,'flatfieldcorrection', false);
DB = stkread(MD,'Channel','DeepBlue-405','Position','Pos0','flatfieldcorrection',false);
%Bl = stkread(MD,'Channel', 'Blue-488','Position','Pos0', 'resize',1/ScFact,'flatfieldcorrection', false);
Bl = stkread(MD,'Channel','Blue-488','Position','Pos0','flatfieldcorrection',false);
%Gr = stkread(MD,'Channel', 'Green-561','Position','Pos0', 'resize',1/ScFact,'flatfieldcorrection', false);
Gr = stkread(MD,'Channel','Green-561','Position','Pos0','flatfieldcorrection',false);

%%


%J = cat(4, uint8(round(DB*2^8)),uint8(round(Bl*2^8)));

%[Cmin, Cmax] = ColorLims(DB);
DBAdj = imadjust3D(DB(:,:,[452:end]),[.02, .005]);
BlAdj = imadjust3D(Bl(:,:,[452:end]),[.02, .0005]);
GrAdj = imadjust3D(Gr(:,:,[452:end]),[.02, .0005]);
%stkshow(cat(4,DBAdj,BlAdj));
J = cat(4, uint8(round(DBAdj*2^8)),uint8(round(BlAdj*2^8)),uint8(round(GrAdj*2^8)));

imp = MIJ.createColor('Cornea', J, false);

calibration = ij.measure.Calibration();
calibration.pixelDepth = 3.33/ScFact;
imp.setCalibration(calibration);

universe = ij3d.Image3DUniverse();
universe.show();
c = universe.addVoltex(imp);



%% Single channel
ScFact = 1;
DB = stkread(MD,'Channel', 'DeepBlue-405','Position','Pos0','resize',1/ScFact);

%% J = cat(4, uint8(round(DB*2^8)),uint8(round(Bl*2^8)));

%[Cmin, Cmax] = ColorLims(DB);
DBAdj = imadjust3D(DB, [.01, .03]);
J =  uint8(round(DBAdj*2^8));

imp = MIJ.createImage('Cornea', J, false);

calibration = ij.measure.Calibration();
calibration.pixelDepth = 5/ScFact;
imp.setCalibration(calibration);

universe = ij3d.Image3DUniverse();
universe.show();
c = universe.addVoltex(imp);


%%

MIJ.run('Volume Viewer', 'display_mode=4 scale=0.25 z-aspect=2.5 axes=0 interpolation=1 angle_x=-59 angle_z=36 angle_y=9');
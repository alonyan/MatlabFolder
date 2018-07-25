%% Model emission path
%single scanner
cd 'D:\Oleg\Students\Rotem Tzuk\optic matrix\'

f0 = 180/63; % the focal length of objective
NA=1.2;
scanAmpl = 5e-3*sqrt(2); % in mm 0.25e-3; %

f_SL1=180; % focal length of SL'
dist_obj_SL1 = 1000; 
f_SL = 100; % focal length of SL
f_Det = 400; % focal length of the detection lens

%angl1= scanAmpl/f0;
%rearApert = NA*f0;

No_of_beams = 7;
step_size = 2*scanAmpl/(No_of_beams -1);

clear A;
%A(1,:) = repmat(-rearApert:step_size:rearApert, 1, 2); % beam positions at the back of the objective lens
%A(2,:) = [angl1*ones(1, No_of_beams) -angl1*ones(1, No_of_beams)];

A(1,:) = repmat(-scanAmpl:step_size:scanAmpl, 1, 2); % sample point positions in the sample plane
A(2,:) = [NA*ones(1, No_of_beams) -NA*ones(1, No_of_beams)];

%d1=f0; % distance from the sample to objective 

dist_scanner_SL1 = f_SL1*dist_obj_SL1/(dist_obj_SL1-f_SL1); % scanner should be projected onto the rear focal plane of the objective

dist_SL_SL1 = f_SL1 + f_SL; % the distance between two scanning lenses makes  a beam expander
dist_SL_to_DL = 100;

FrSp0.type = 'free'; 
FrSp0.param = f0; 

Obj.type = 'lens';
Obj.param = f0;

FrSp1.type = 'free'; % from objective to SL1
FrSp1.param = dist_obj_SL1; 

SL1.type = 'lens';
SL1.param = f_SL1;

FrSp2.type = 'free'; %from SL1 to scanner
FrSp2.param = dist_scanner_SL1; 

FrSp3.type = 'free';  % from scanner to SL
FrSp3.param = dist_SL_SL1 - dist_scanner_SL1; 

SL.type = 'lens';
SL.param = f_SL;

FrSp4.type = 'free'; 
FrSp4.param = dist_SL_to_DL; 

DL.type = 'lens'; % detection lens
DL.param = f_Det;

FrSp5.type = 'free'; % from detection lens to detector
FrSp5.param = f_Det; 


beam = PropagateOpticalBeam(A, [FrSp0 Obj FrSp1 SL1 FrSp2 FrSp3 SL  FrSp4 DL FrSp5])

plot(beam.z, beam.x, '-o'); 
title('Emission path');
figure(gcf)
M = (dist_obj_SL1-f_SL1)/f_SL1


%% Model excitation path
% single scanner
%STED laser
beam_div = 1.57e-3; %rad half width
No_of_beams = 7;
step_size = 2*beam_div/(No_of_beams -1);
dist_focus_to_laserImage = 2e-3;


Delta_SL = -1; %  % a free parameter to play with SL lens position
rearAp = NA*f0;
dist_laser_to_SL = rearAp*f_SL/f_SL1/beam_div + Delta_SL;

FrSp3.type = 'free';  % from scanner to SL
FrSp3.param = dist_SL_SL1 - dist_scanner_SL1 - Delta_SL; 

if exist('Ex', 'var'),
    clear Ex;
end;
if exist('ExBeam', 'var'),
    clear ExBeam;
end;
if exist('ExBeam1', 'var'),
    clear ExBeam1;
end;

Ex(1, :) = zeros(1, 2*No_of_beams);
Ex(2, :) = repmat(-beam_div:step_size:beam_div, 1, 2);

%Ex(1,:) = repmat(-BeamRad:step_size:BeamRad, 1, 2); % beam positions at the back of the objective lens
%Ex(2, :) = 0;

FrSp6.type = 'free'; % from laser to SL
FrSp6.param = dist_laser_to_SL; 

angl1= scanAmpl/f0;
M = (dist_obj_SL1-f_SL1)/f_SL1;
angl2 = angl1*M;

%Ex(2,:) = [angl2*ones(1, No_of_beams) -angl2*ones(1, No_of_beams)];

ExBeam = PropagateOpticalBeam(Ex, [ FrSp6 SL FrSp3]);

clear Ex;
Ex(1,:) = ExBeam.x(end, :); % at the scanner
Ex(2, :) = [(ExBeam.ang(end, 1:No_of_beams) - angl2) (ExBeam.ang(end, 1:No_of_beams) + angl2)]; % scanner adding angles

DeltaSL1 = 0; % a free parameter to play with SL1 lens position
FrSp1.type = 'free'; % from objective to SL1
FrSp1.param = dist_obj_SL1+DeltaSL1; 

FrSp2.type = 'free'; %from SL1 to scanner
FrSp2.param = dist_scanner_SL1-DeltaSL1; 

FrSp7.type = 'free'; % from focus to some floating place
FrSp7.param = dist_focus_to_laserImage; 

ExBeam1 = PropagateOpticalBeam(Ex, [ FrSp2 SL1 FrSp1 Obj FrSp0 FrSp7]);

ExBeam.z = [ExBeam.z (ExBeam1.z+ExBeam.z(end))];
ExBeam.x = [ExBeam.x; ExBeam1.x];
ExBeam.ang = [ExBeam.ang; ExBeam1.ang];

plot(ExBeam.z, ExBeam.x , '-o');
title('Excitation path: ideal position of the scanner')
figure(gcf)

%% Model excitation path
% imperfect  scanner position
shiftFromFoc = -5;
No_of_beams = 7;
beamExpan = f_SL1/f_SL;
BeamRad =  0.7*rearApert/beamExpan;

step_size = 2*BeamRad/(No_of_beams -1);

clear Ex ExBeam ExBeam1;
Ex(1,:) = repmat(-BeamRad:step_size:BeamRad, 1, 2); % beam positions at the back of the objective lens
Ex(2, :) = 0;

M = (dist_obj_SL1-f_SL1)/f_SL1;
angl2 = angl1*M*sqrt(2);

%Ex(2,:) = [angl2*ones(1, No_of_beams) -angl2*ones(1, No_of_beams)];

FrSp4.type = 'free';  % before SL
FrSp4.param = floating_dist_from_SL;

SL.type = 'lens'; % from SL to ideally positioned scanners
SL.param = f_SL;

FrSp3.type = 'free';  % from SL to scanner
FrSp3.param = dist_SL_SL1 - dist_scanner_SL1+shiftFromFoc; % add 5mm to the distance 

ExBeam = PropagateOpticalBeam(Ex, [ FrSp4 SL FrSp3]);

clear Ex;
Ex(1,:) = ExBeam.x(end, :); % at the scanner
Ex(2, :) = [(ExBeam.ang(end, 1:No_of_beams) - angl2) (ExBeam.ang(end, 1:No_of_beams) + angl2)]; % scanner adding angles


FrSp2.type = 'free';  % from scanner to SL'
FrSp2.param = dist_scanner_SL1 - shiftFromFoc; 

SL1.type = 'lens'; % SL' lens
SL1.param = f_SL1;

FrSp1.type = 'free'; 
FrSp1.param = dist_obj_SL1; 

Obj.type = 'lens'; % Microscope Objective
Obj.param = f0;

FrSp0.type = 'free';  % Objective to focus
FrSp0.param = f0;

ExBeam1 = PropagateOpticalBeam(Ex, [ FrSp2 SL1 FrSp1 Obj FrSp0]);

ExBeam.z = [ExBeam.z (ExBeam1.z+ExBeam.z(end))];
ExBeam.x = [ExBeam.x; ExBeam1.x];
ExBeam.ang = [ExBeam.ang; ExBeam1.ang];

plot(ExBeam.z, ExBeam.x , '-o');
title('Excitation path: shifted position of the scanner')
figure(gcf)



%List = create3DPosition(XYZ)
X = [300 300 300 1200]
Y = [300 2600 1200 1200]
Z = [1200 1200 300 1200]

XYZ = [X',Y',Z']

%%
Scp.width = 2056;
Scp.height = 2564;
Scp.PixelSizeum = 3.45/14.4/0.63;

%% How many images per strip do we need?
 xDistance = max(X)-min(X);
 yDistance = max(Y)-min(Y);
 cameraXFieldOfView = Scp.PixelSizeum * Scp.width;
 cameraYFieldOfView = Scp.PixelSizeum * Scp.height;
 fieldOverlap = 0.2; %minimal overlap: fraction by which each field should overlap
 effectiveXFieldOfView = cameraXFieldOfView * (1 - fieldOverlap);%=step size X?
 effectiveYFieldOfView = cameraYFieldOfView * (1 - fieldOverlap);%=step size Y?
 nFieldsX = ceil(1+xDistance / effectiveXFieldOfView);
 nFieldsY = ceil(1+yDistance / effectiveYFieldOfView);
disp(['Images per strip:' num2str(nFieldsX*nFieldsY)]);

 Ypos = linspace(min(Y),max(Y),nFieldsY)
 Xpos = linspace(min(X),max(X),nFieldsX)

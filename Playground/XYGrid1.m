createGridPosition(Scp, XYZ)
%X = [300 300 1200]
%Y = [300 2600 1200]
%Z = [1200 1100 1120]

%XYZ = [X',Y',Z']
%% input 3 positions, top, bottom, front
X = XYZ(:,1);
Y = XYZ(:,2);


%% Calculate # of stacks, and position of the stacks in X,Y. Take overlap>20%
 xDistance = max(X)-min(X);
 yDistance = max(Y)-min(Y);
 cameraXFieldOfView = Scp.PixelSize * Scp.Width;
 cameraYFieldOfView = Scp.PixelSize * Scp.Height;
 fieldOverlap = 0.2; %minimal overlap: fraction by which each field should overlap with neighbor. #position is minimized -> Overlap is maximized
 effectiveXFieldOfView = cameraXFieldOfView * (1 - fieldOverlap);%=step size X?
 effectiveYFieldOfView = cameraYFieldOfView * (1 - fieldOverlap);%=step size Y?
 nFieldsX = ceil(1+xDistance / effectiveXFieldOfView);
 nFieldsY = ceil(1+yDistance / effectiveYFieldOfView);
disp(['Images per strip:' num2str(nFieldsX*nFieldsY)]);

 Ygrd = linspace(min(Y),max(Y),nFieldsY); %grid positions
 Xgrd = linspace(min(X),max(X),nFieldsX);
 
 Xpos = reshape(repmat(Xgrd,length(Ygrd),1),[],1); %full list of XY Positions
 Ypos = reshape(repmat(Ygrd',length(Xgrd),1),[],1);
  List = [Xpos, Ypos];
 %% Calculate plane positions sit on and make Z interpolation function
 
 if size(XYZ,2)==3
     Z = XYZ(:,3);
     dXYZ = XYZ-repmat(XYZ(3,:),3,1);
     pNorm = cross(dXYZ(1,:),dXYZ(2,:))./norm(cross(dXYZ(1,:),dXYZ(2,:)));
     zInterp = @(x,y) -((pNorm(1:2)*([x,y]-XYZ(3,1:2))')/pNorm(3))+XYZ(3,3);
     
     Zpos = zeros(size(Xpos));
     for i=1:length(Zpos)
         Zpos(i) = zInterp(Xpos(i), Ypos(i));
     end
     
     List = [Xpos, Ypos, Zpos];
 end
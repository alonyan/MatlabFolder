function beam = PropagateOpticalBeam(StartRayParam, OpticElementArray)

% OpticElementArray an array of optical elements or free space: the first
% element is the first that the rays meet etc. Each element is a structure 
% containing twofields. One field with the element description, either
% OpticElement.type = 'free'  or 'lens'
% The second element is the quantitative parameter: 
% OpticElement.param = either the length of free space or the focal
% distance of the lens

beam.z(1) = 0;
beam.x(1, :) = StartRayParam(1, :);
beam.ang(1, :) = StartRayParam(2, :);

RayParam = StartRayParam;

for i=1:length(OpticElementArray),
    switch OpticElementArray(i).type
        case 'free',
            RayMat = [1 OpticElementArray(i).param; 0 1];
            beam.z(i+1) = beam.z(i)+OpticElementArray(i).param;
        case 'lens'
            RayMat = [1 0; -1/OpticElementArray(i).param 1];
            beam.z(i+1) = beam.z(i);
        otherwise,
    end;
            
    RayParam = RayMat*RayParam;
    beam.x(i+1, :) = RayParam(1, :);
    beam.ang(i+1, :) = RayParam(2, :);
end;

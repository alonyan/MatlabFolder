function [nFrames, dZ] = spanZ(Scp,delZ, varargin)
arg.crop=true;
%crop mode/span mode
NmaxFrames = 428;
dZ = 3.5;
nFrames = ceil(delZ/dZ);
if arg.crop
    if nFrames > NmaxFrames
        nFrames = NmaxFrames;
    end
else
    dZ = delZ/NmaxFrames;
end

Scp.Exposure = 1000*dZ/Scp.ZStage.VelocityUm;
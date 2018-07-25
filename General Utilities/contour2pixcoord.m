function [X, Y, C] = contour2pixcoord(pos, varargin)
% fsf
X = [];
Y = [];
C = [];
for j=1:(size(pos, 1) - 1),
    start = pos(j, :);
    finish = pos(j+1, :);
    %Calculate tangent vector
    tangent=(finish-start)/norm(finish-start);
    if norm(tangent)>0,
        %Calculate rounded r vector
        rndX=round([start(1):tangent(1):finish(1)]);
        rndY=round([start(2):tangent(2):finish(2)]);
        rndX = rndX(:);
        rndY = rndY(:);

        %Drawing
        if isempty(rndX)
           rndX = round(start(1))*ones(size(rndY));
        end;

        if isempty(rndY)
           rndY = round(start(2))*ones(size(rndX));
        end
       X = [X; rndX];
       Y = [Y; rndY];
    end;
end;

if length(varargin) == 1,
    imsz = varargin{1};
    C = (X - 1)*imsz(1) +Y;
end;
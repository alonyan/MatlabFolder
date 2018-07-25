function [dI, dJ] = Combine2Images_v1(fixed, moving, overlapFrac,varargin)
%fixed - first image
%moving - 2nd image
% overlapFrac:[fracoverlapy, fracoverlapx]  example: [1, 0.1] for x displacement.  Sorry if these are not very
% elegant. Feel free to fix

overlap = [min(round(overlapFrac(1)*size(fixed,1)),round(overlapFrac(1)*size(moving,1))), min(round(overlapFrac(2)*size(fixed,2)),round(overlapFrac(2)*size(moving,2)))];

fixedROI = fixed((end-overlap(1)+1):end, (end-overlap(2)+1):end);

movingROI = moving(1:overlap(1), 1:overlap(2));



if sum(strcmp(varargin,'show'))
imshowpair(fixedROI, movingROI); figure(gcf);pause;
end;


[opt,met] = imregconfig('monomodal');

opt.MaximumStepLength = .5;
opt.MaximumIterations = 200;
opt.RelaxationFactor = 0.5;
opt.GradientMagnitudeTolerance = 1e-3;

if sum(strcmp(varargin,'multimodal'))
[opt,met] = imregconfig('multimodal');
end

%met = registration.metric.MattesMutualInformation;

Tform = imregtform(movingROI , fixedROI , 'translation' , opt , met);


dI  =  size(fixed,1)-size(movingROI,1)+round(Tform.T(3,2));
dJ  =  size(fixed,2)-size(movingROI,2)+round(Tform.T(3,1));


if strcmp(varargin,'show')
    if (round(Tform.T(3,1))+1<=0)&&(round(Tform.T(3,2))+1<=0)
     imshowpair(fixedROI(:, :), movingROI(-round(Tform.T(3,2)):end,-round(Tform.T(3,1)):end)); figure(gcf); pause;
    elseif round(Tform.T(3,2))+1<=0
    imshowpair(fixedROI(:, round(Tform.T(3,1))+1:end), movingROI(-round(Tform.T(3,2)):end,:)); figure(gcf); pause;
    elseif round(Tform.T(3,1))+1<=0
     imshowpair(fixedROI(round(Tform.T(3,2))+1:end, :), movingROI(:,-round(Tform.T(3,1)):end)); figure(gcf); pause;
    else
    imshowpair(fixedROI(round(Tform.T(3,2))+1:end, round(Tform.T(3,1))+1:end), movingROI); figure(gcf); pause;
    end;
end;


end
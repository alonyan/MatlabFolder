overlapFrac = [0.1,1];

overlap = round(overlapFrac*size(fixed,1));

fixedROI = fixed((end-overlap(1)+1):end, (end-overlap(2)+1):end);

movingROI = moving(1:overlap(1), 1:overlap(2));
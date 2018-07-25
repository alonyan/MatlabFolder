function slide = openslide_opens(fpath)
% safe opening of the slide: produces an error if fpath is not valid (the
% original openslide_open crashes Matlab.
if exist(fpath), 
    slide = openslide_open(fpath);
else
    error('File does not exist!')
end;
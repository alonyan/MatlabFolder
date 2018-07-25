fname = 'my_file_with_lots_of_images.tif';
info = imfinfo(fname);
num_images = numel(info);
for k = 1:num_images
    A = imread(fname, k, 'Info', info);
    % ... Do something with image A ...
end



%% Load Data
Data=struct;
fpath = '/Users/Alonyan/GoogleDrive/IFNg-PS Paper/MOLECULAR CELL SUBMISSION/Rebuttal #1/20161010 Caveolin and Interferon/02 zstack';

nameTemp1 = ['02 z stack_z'];

flist = dir(fpath);
flist = {flist.name};


ix=regexp(flist, nameTemp1);

ix=~cellfun('isempty',ix);
flistDo = flist(ix);
flistDo'
%%
for i =1:length(flistDo);
    A(:,:,i) = imread([fpath, filesep, flistDo{i}]);
end

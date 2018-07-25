%% Channel1 (Nuclear)
fpath = '/Users/Alonyan/GoogleDrive/School/Applications and conferences/MBL2017/data/M13';
pattern = '-1.tif';


i=9;


flist = getFlistbyPattern(pattern, fpath)
filepath = [fpath filesep flist{i}];
%
%filepath = '/Users/Alonyan/GoogleDrive/School/Applications and conferences/MBL2017/data/HeLa12415-1.png'

SizeEst = EstSize(filepath);
[L, voronoiCells] = SegmentCells(filepath,'EstSize',SizeEst);

%% Channel2 (actin)
pattern = '-2.tif';
flist = getFlistbyPattern(pattern, fpath)
filepath = [fpath filesep flist{i}];

L2 = SegmentCells(filepath,'voronoiCells',voronoiCells);

%% Channel3 (microtubules)
pattern = '-3.tif';
flist = getFlistbyPattern(pattern, fpath)
filepath = [fpath filesep flist{i}];

L3 = SegmentCells(filepath,'voronoiCells',voronoiCells);




%%
%% Test data
fpath = '/Users/Alonyan/GoogleDrive/School/Applications and conferences/MBL2017/data/testdata';
pattern = 'test_image_';





flist = getFlistbyPattern(pattern, fpath)
Score = [];
for i=1:numel(flist)
    close all;
    filepath = [fpath filesep flist{i}];
    %
    %filepath = '/Users/Alonyan/GoogleDrive/School/Applications and conferences/MBL2017/data/HeLa12415-1.png'
    
    SizeEst = EstSize(filepath);
    [L, voronoiCells] = SegmentCells(filepath,'EstSize',SizeEst);
    
    CC = bwconncomp(L);
    realN = str2num(flist{i}(end-7:end-5));
    foundN = CC.NumObjects;
    Score = [Score foundN/realN];
end


%% Best
for i=7
    filepath = [fpath filesep flist{i}];
    %
    %filepath = '/Users/Alonyan/GoogleDrive/School/Applications and conferences/MBL2017/data/HeLa12415-1.png'
    
    SizeEst = EstSize(filepath);
    [L, voronoiCells] = SegmentCells(filepath,'EstSize',SizeEst);
    
    CC = bwconncomp(L);
end
%% Worst
for i=2
    filepath = [fpath filesep flist{i}];
    %
    %filepath = '/Users/Alonyan/GoogleDrive/School/Applications and conferences/MBL2017/data/HeLa12415-1.png'
    
    SizeEst = EstSize(filepath);
    [L, voronoiCells] = SegmentCells(filepath,'EstSize',SizeEst);
    
    CC = bwconncomp(L);
end
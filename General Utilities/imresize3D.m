function DataRe = imresize3D(Data, scale)

size2scl = ceil(size(Data)*scale);
DataRe = permute(imresize(permute(imresize(Data,[size2scl(1), size2scl(2)]),[3 1 2]),[size2scl(3), size2scl(1)]),[2 3 1]);
end
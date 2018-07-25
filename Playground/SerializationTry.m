%%
cd E:
tic;
byteStream = getByteStreamFromArray(Stk);
toc;
savefast('byteStream.mat','byteStream');
toc;
%%
 tic;
data = load('byteStream.mat');
Stk = getArrayFromByteStream(data.byteStream);
toc
% clear data;
% options.overwrite=true;
% saveastiff(Stk,'TiffStack.tiff',options);
% clear Stk
% toc;
%%

options.overwrite=true;
saveastiff(Stk,'E:\TiffStack.tiff',options);

%%
tic
fid = fopen('E:\byteStream.txt','w');
fwrite(fid, byteStream)
fclose(fid)
toc

%%
tic
fid = fopen('E:\byteStream.txt','r');
byteStream = fread(fid,'uint8');
fclose(fid)
toc
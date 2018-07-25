%%
img = double(img);%AOY and Rob, fix saturation BS.
img(img<0)=img(img<0)+2^16;
img = mat2gray(img,[1 2^16]);

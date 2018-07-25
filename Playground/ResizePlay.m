MD = Metadata('/bigstore/GeneralStorage/Alon/Some Pics/acq_3')

tic
stk = stkread(MD,'Channel', 'DeepBlue-405','Position','Pos0','flatfieldcorrection', false,'Zindex', 1:100);
toc
%%
stktmp = stk;
%%
stk = stktmp;

tic
sizeStk = size(stk);
scale = 0.5;
stkScaled = zeros(ceil(sizeStk.*[scale scale 1]));

for indScl=1:size(stk,3)
    stkScaled(:,:,indScl) = imresize(stk(:,:,indScl),scale);
end
clear stk
stk = stkScaled;
toc

%%

stkScaledSize = ceil(sizeStk.*[scale scale 1]); %% desired output dimensions
[x,y,z]=...
   ndgrid(linspace(1,size(stk,1),stkScaledSize(1)),...
          linspace(1,size(stk,2),stkScaledSize(2)),...
          linspace(1,size(stk,3),stkScaledSize(3)));
stkOut=interp3(stk,x,y,z);
MD = Metadata('/bigstore/Images2017/Jen/CorneaCCM/WoundAgarTitr_2017Dec05_2017Dec05/acq_1')
%%
tic
Hoescht = stkread(MD,'Channel','DeepBlue', 'flatfieldcorrection', true, 'Position', 'D04','frame',1,'rescale', 0.5);
toc
ImageJ;
%%

baseDir = '/RazorScopeData/RazorScopeSets/Jen/CorneaWound/CorneaWound_HetHet_2019Feb04/acq_2/Fused/';
filesInTP = getFlistbyPattern('fused_tp_10_',baseDir);
i=1;
ij.IJ.open([baseDir,filesInTP{i}]);
%%
MIJ.selectWindow(filesInTP{i});
ij.ImageJ.rename('bla')

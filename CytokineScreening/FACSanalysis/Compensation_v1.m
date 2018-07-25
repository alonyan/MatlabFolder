%%
filepath = '/Users/Alonyan/Google Drive/InVivo14122014_pSTAT5';
flist = dir(filepath);
flist = {flist.name};
 %regexp('Comp', flist) 
 CompList = strfind(flist','Comp');
 Index = find(not(cellfun('isempty', CompList)));
     
%%
%CompNames = ['Compensations_Blank', ]
for i=1:length(Index)
[Comp{i}.data, Comp{i}.Header] = fca_readfcs_v2([filepath filesep flist{Index(i)}])
end;
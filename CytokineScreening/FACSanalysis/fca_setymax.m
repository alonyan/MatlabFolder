function fca_setymax()

mouseclick = get(gcf,'SelectionType');
%check the mouse click type: only double click can initiate 
% the Ymax settingtool  
if ~strcmp(mouseclick,'open') &  ~strcmp(mouseclick,'alt')
    return;
end
prompt = {'New max value:'};
dlg_title = ['Input for Ymax'];
num_lines= 1;
%num_lines= [1,42;1,42;1,42;];
def     = { num2str(max(get(gca,'YLim')))};
YmaxInStr = inputdlg(prompt,dlg_title,num_lines,def);

if isempty(YmaxInStr)
    return;%return if the cancel button was pressed 
else
    NewYmax = str2double(YmaxInStr);
end
set(gca,'Ylim',[0 NewYmax]);

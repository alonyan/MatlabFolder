function SaveFig(fig,pth,name)
set(fig, 'PaperPositionMode','auto','color',[1 1 1])
%fpthpos = [fpathresults filesep Wells{j} filesep];
if ~isdir(pth)
    mkdir(pth);
end
print(fig,'-dpng',[pth filesep name],'-r300');
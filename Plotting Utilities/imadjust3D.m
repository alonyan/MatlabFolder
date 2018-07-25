function DBAdj = imadjust3D(DB,varargin)
if nargin >1
    [Cmin, Cmax] = ColorLims(DB,varargin{1});
else
    [Cmin, Cmax] = ColorLims(DB);
end
C = mat2cell(DB,size(DB,1),size(DB,2),ones(size(DB,3),1));
CAdj = cellfun(@(x) imadjust(x,[Cmin, Cmax]),C,'UniformOutput', false);
DBAdj = cell2mat(CAdj);
end


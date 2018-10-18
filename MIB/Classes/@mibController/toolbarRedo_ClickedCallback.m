function toolbarRedo_ClickedCallback(obj)
% function toolbarRedo_ClickedCallback(obj)
% do one step forward in the undo history
%
% Parameters:
% 

% Copyright (C) 14.01.2017, Ilya Belevich, University of Helsinki (ilya.belevich @ helsinki.fi)
% part of Microscopy Image Browser, http:\\mib.helsinki.fi 
% This program is free software; you can redistribute it and/or
% modify it under the terms of the GNU General Public License
% as published by the Free Software Foundation; either version 2
% of the License, or (at your option) any later version.
% 
% Updates
% 

index = obj.mibModel.U.undoIndex + 1;
if index > numel(obj.mibModel.U.undoList); return; end;
obj.mibDoUndo(index);
end
function hdl = image_multiple(C, varargin);
if length(varargin) == 0,
    hdl =imagesc(C),
else
    A(:, :, 1) = C;
    map (:, 1) = varargin{1};
    for i = 2:ceil(length(varargin)/2),
        A(:, :, i) = varargin{2*i};
        map(:, i) = varargin{2*i+1};
    end;
    
    
end;
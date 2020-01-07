function d = lineIntersect(bounds1, bounds2,dim)
if nargin==2
    dim=2;
end

min1 = min(bounds1,[],dim);
max1 = max(bounds1,[],dim);
min2 = min(bounds2,[],dim);
max2 = max(bounds2,[],dim);
d = max(0, min([max1 , max2],[],dim)-max([min1 , min2],[],dim));

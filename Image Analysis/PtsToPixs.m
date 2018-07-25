function Pic1 = PtsToPixs(xcord,ycord)
%% make trajectory into picture
%figure()
AverageStep = 10;

x = round(xcord);
y = round(ycord);
minx = min(x);
miny = min(y);
x = x-minx+1;
y = y-miny+1;

Pic  =zeros(size(min(x):max(x),2),size(min(y):max(y),2));
PicInds  =zeros(size(min(x):max(x),2),size(min(y):max(y),2));

NaNInd = max(isnan(y),isnan(x));
x = x(~NaNInd);
y = y(~NaNInd);

for ii=1:length(x)
    Pic(y(ii), x(ii)) = 1;
    PicInds(y(ii), x(ii)) = ii;
end
%imagesc(imdilate(Pic,strel('disk',AverageStep/2,0))); shg
%set(gca,'ydir','normal')

padsize = 40;
Pic = padarray(Pic,[padsize padsize],0);
PicInds = padarray(PicInds,[padsize padsize],0);

Pic1 = imdilate(Pic,strel('ball',round(2*AverageStep),1,0));
end
ptSeeds = imgGRegMax.*(imgG>ThreshVal);

linkim0=uint32(reshape(find(imgGRegMax>(min(imgGRegMax(:))-1)),size(imgGRegMax)));

SE = strel('sphere',4);
linkim = imdilate(uint32(ptSeeds).*linkim0,SE);
linkim(linkim==0)=linkim0(linkim==0);
newlink = linkim(linkim);
counter=0;
while any(newlink(:)~=linkim(:)) %&& counter<4
    linkim = newlink;
    newlink = linkim(linkim);
    counter=counter+1;
end
clear newlink
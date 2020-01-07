function [annotationX1, annotationY1] = gcatogcf_v1(x,y)

scribepin = scribe.scribepin('parent',gca,'DataAxes',gca,'DataPosition',[x;y;[0,0]]');
figPixelPos = scribepin.topixels;

figPos = getpixelposition(gcf);
figPixelPos(:,2) = figPos(4) - figPixelPos([2,1],2);
figNormPos = hgconvertunits(gcf,[figPixelPos(1,1:2),diff(figPixelPos)],'pixels','norm',gcf);
annotationX1 = figNormPos([1,1])+figNormPos(3)*[1,0];
annotationY1 = figNormPos([2,2]) + figNormPos(4)*[1,0];
end

%Create A figure
figure
mainAxes = axes;
plot(mainAxes ,0:10:50,0:10:50,'r',0:5,0:0.5:2.5,'b');
hold on
plot( 0:10,0:0.25:2.5,'g');

xlabel 'This is an X Axis Label'
ylabel 'This is a Y Axis Label'
title('A Generic Title');
legend('Red Line','Blue Line');
set(gca,'Layer','Top')

%Break The Axes
h = breakxaxis([1 2]);
Ch = get(gcf,'Children');
set(Ch(3),'Xscale','log');

%Un-Break The X Axes
%unbreakxaxes(h)


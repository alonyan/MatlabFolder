function dP = DragROI

h = get(gca, 'Children');

%find which of the "Children" are ROI: they  have type 'line'
Type = get(h, 'Type');
I = find(strcmp(Type, 'line'));

%hLine = gca;
%set(h(I),'ButtonDownFcn', 'disp(''This executes'')');
%set(h(I),'Tag','DoNotIgnore');
set(h(I),'ButtonDownFcn', []);
hp = pan;
%set(hp,'ButtonDownFilter',@mycallback);
set(hp,'ButtonDownFilter',[]);
%set(h,'Enable','on');
% mouse click on the line
%

set(hp,'ActionPreCallback', @myprecallback);
set(hp,'ActionPostCallback',@mypostcallback);
set(hp,'Enable','on');




function [flag] = mycallback(obj, event_obj)
% If the tag of the object is 'DoNotIgnore', then return true.
objTag = get(obj,'Tag');
if strcmpi(objTag,'DoNotIgnore')
   flag = true;
   Xdata = get(obj, 'Xdata');
   get(obj)
   Xdata(1)
   event_obj
else
   flag = false;
end



function myprecallback(obj,evd, StartingPoint)
disp('A pan is about to occur.');
SP = get(evd.Axes, 'CurrentPoint');
StartingPoint.X  = SP(1, 1);
StartingPoint.Y = SP(1, 2);
mydata.StartingPoint = StartingPoint

mydata.Xlim = get(evd.Axes, 'Xlim');
mydata.Ylim = get(evd.Axes, 'Ylim');
set(evd.Axes, 'UserData', mydata);
 %
 function mypostcallback(obj,evd)
  % remember axes limits in case we are dragging the selection
  
 get(evd.Axes, 'CurrentPoint');
 EP = get(evd.Axes, 'CurrentPoint');
 EndingPoint.X  = EP(1, 1);
EndingPoint.Y = EP(1, 2);
mydata = get(evd.Axes, 'UserData');
dX = EndingPoint.X - mydata.StartingPoint.X;
dY = EndingPoint.Y - mydata.StartingPoint.Y;
%find closest selection
h = get(evd.Axes, 'Children');
%find which of the "Children" are ROI: they  have type 'line'
Type = get(h, 'Type');
I = find(strcmp(Type, 'line'));
X =get(h(I), 'Xdata');
Xc = mean(cell2mat(X), 2);
Y =get(h(I), 'Ydata');
Yc = mean(cell2mat(Y), 2);
[temp, j] = min((Xc  - mydata.StartingPoint.X).^2 + (Yc  - mydata.StartingPoint.Y).^2)

I_im = find(strcmp(Type, 'image'))
BW = roipoly(get(h(I_im), 'Cdata'), X{j}, Y{j});

if BW(round(mydata.StartingPoint.Y), round(mydata.StartingPoint.X)) > 0,

        % move j-th selection
        set(h(j), 'Xdata', X{j} + dX, 'Ydata', Y{j} + dY);
        set(evd.Axes, 'Xlim', mydata.Xlim, 'Ylim', mydata.Ylim);
end;
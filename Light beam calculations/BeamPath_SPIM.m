%% Calculates lightbeams from a series of optical components
% this calculates the light path from a series of optical elements.
% 
clear all;
close all;
blue = [0 0 1];
green = [0 0.5 0];
red = [1 0 0];
cyan = [0 0.75 0.75];
magenta = [0.75 0 0.75];
black = [0 0 0];
yellow = [0.75 0.75 0];
lightred = [1 0.3 0];

%type(1,:) = ['lens']; type(2,:) = ['free'];

%uncollimated out of collector lense:
%param = [1.5 2 3 4 8.2 1 2];

%collimated out of collector lense "textbook":


figure('Position',[109 392 850 306])
set(gcf,'color','w')
%subplot(2,1,1)
axes('position',[0.0500 0.5838 0.70 0.3412]);
%[space telelens1 space telelens2 space]
param = [20 25 75 50  150 50 75 25 28 3 6];

for i=1:length(param)
    Optics(i).type = char('lens'*(rem(i,2)==0)+'free'*(rem(i,2)==1));
    Optics(i).param = param(i);
end;

StartRay(1,:) = [-0.35 0 0.35];
StartRay(2,:) = [0 0 0];


beam  = PropagateOpticalBeam(StartRay, Optics);

h = plot(beam.z, beam.x, '-x'); 
color = [blue' blue' blue' red' red' red' green' green' green' ];
for j=1:length(h)
set(h(j), 'Color',(color(:,j))');
end
title('Perpendicular axis')

L = max(max(beam.x(1:end-1)))-min(min(beam.x(1:end-1)))+4;
for i=2:2:length(param)
    pos = [beam.z(i)-1 -L/2 2 L];
    rectangle('Position',pos,'Curvature',[1 1])
end
set(gca,'xtick', 0:20:max(max(beam.z)), 'ylim',[-3,3], 'xlim',[0, max(beam.z)])
 
%
axes('position',[0.80 0.5838 0.170 0.3412]);
h = plot(beam.z(end-2:end), beam.x(end-2:end,:), '-x'); 
color = [blue' blue' blue' red' red' red' green' green' green' ];
for j=1:length(h)
set(h(j), 'Color',(color(:,j))');
end
set(gca,'xtick', beam.z(end-2):1:max(max(beam.z)), 'ylim',[-0.5,0.5],'ytick', [-0.5:0.25:0.5], 'xlim',[beam.z(end-2), max(beam.z)],'TickLength', [0.03 0.1])
title('Perpendicular axis in Chamber')



%subplot(2,1,2)
axes('position',[0.0500 0.1100 0.70 0.3412])

param = [20 25 75 50 50  50 100 50 75 25 28 3 6];

for i=1:length(param)
    Optics(i).type = char('lens'*(rem(i,2)==0)+'free'*(rem(i,2)==1));
    Optics(i).param = param(i);
end;

StartRay(1,:) = [-0.35 0 0.35];
StartRay(2,:) = [0 0 0];


beam  = PropagateOpticalBeam(StartRay, Optics);

h = plot(beam.z, beam.x, '-x'); 
title('Parallel axis')

color = [red' red' red' green' green' green' ];
for j=1:length(h)
set(h(j), 'Color',(color(:,j))');
end

L = max(max(beam.x(1:end-1)))-min(min(beam.x(1:end-1)))+4;
for i=2:2:length(param)
    pos = [beam.z(i)-1 -L/2 2 L];
    rectangle('Position',pos,'Curvature',[1 1])
end
set(gca,'xtick', 0:20:max(max(beam.z)), 'ylim',[-3,3], 'xlim',[0, max(beam.z)])
 
%
axes('position',[0.80 0.1100 0.17 0.3412]);
h = plot(beam.z(end-2:end), beam.x(end-2:end,:), '-x'); 
color = [red' red' red' green' green' green' ];
for j=1:length(h)
set(h(j), 'Color',(color(:,j))');
end
set(gca,'xtick', beam.z(end-2):1:max(max(beam.z)), 'ylim',[-1,1]./2,'ytick', [-1:0.5:1]./2, 'xlim',[beam.z(end-2), max(beam.z)],'TickLength', [0.03 0.1])
title('Parallel axis in Chamber')


figure(gcf)
      set(gcf, 'PaperPositionMode','auto')
print(gcf,'-dpng','-r300',['/Users/Alonyan/Desktop/' 'SPIMBeamPath']);
%snapnow();
%delete(gcf);

%% Calculates lightbeams from a series of optical components
% this calculates the light path from a series of optical elements.
% 
clear all;
blue = [0 0 1];
green = [0 0.5 0];
red = [1 0 0];
cyan = [0 0.75 0.75];
magenta = [0.75 0 0.75];
black = [0 0 0];
yellow = [0.75 0.75 0];
lightred = [1 0.3 0];

%type(1,:) = ['lens']; type(2,:) = ['free'];

%uncollimated out of collector lense:
%param = [1.5 2 3 4 8.2 1 2];

%collimated out of collector lense "textbook":


figure('Position',[109 392 850 306])
set(gcf,'color','w')
%subplot(2,1,1)
axes('position',[0.0500 0.5838 0.70 0.3412]);
%[space telelens1 space telelens2 space]
param = [20 25 75 50  170 50 65 15 18 3 6];

for i=1:length(param)
    Optics(i).type = char('lens'*(rem(i,2)==0)+'free'*(rem(i,2)==1));
    Optics(i).param = param(i);
end;

StartRay(1,:) = [-.35 0 .35];
StartRay(2,:) = [0 0 0];


beam  = PropagateOpticalBeam(StartRay, Optics);

h = plot(beam.z, beam.x, '-x'); 
color = [blue' blue' blue' red' red' red' green' green' green' ];
for j=1:length(h)
set(h(j), 'Color',(color(:,j))');
end
title('Perpendicular axis')

L = max(max(beam.x(1:end-1)))-min(min(beam.x(1:end-1)))+4;
for i=2:2:length(param)
    pos = [beam.z(i)-1 -L/2 2 L];
    rectangle('Position',pos,'Curvature',[1 1])
end
set(gca,'xtick', 0:20:max(max(beam.z)), 'ylim',[-3,3], 'xlim',[0, max(beam.z)])
 
%
axes('position',[0.80 0.5838 0.170 0.3412]);
h = plot(beam.z(end-2:end), beam.x(end-2:end,:), '-x'); 
color = [blue' blue' blue' red' red' red' green' green' green' ];
for j=1:length(h)
set(h(j), 'Color',(color(:,j))');
end
set(gca,'xtick', beam.z(end-2):1:max(max(beam.z)), 'ylim',[-1,1]./2,'ytick', [-1:0.5:1]./2, 'xlim',[beam.z(end-2), max(beam.z)],'TickLength', [0.03 0.1])
title('Perpendicular axis')



%subplot(2,1,2)
axes('position',[0.0500 0.1100 0.70 0.3412])

param = [20 25 75 50 70  50 100 50 65 15 18 3 6];

for i=1:length(param)
    Optics(i).type = char('lens'*(rem(i,2)==0)+'free'*(rem(i,2)==1));
    Optics(i).param = param(i);
end;

StartRay(1,:) = [-.35 0 .35];
StartRay(2,:) = [0 0 0];


beam  = PropagateOpticalBeam(StartRay, Optics);

h = plot(beam.z, beam.x, '-x'); 
title('Parallel axis')

color = [red' red' red' green' green' green' ];
for j=1:length(h)
set(h(j), 'Color',(color(:,j))');
end

L = max(max(beam.x(1:end-1)))-min(min(beam.x(1:end-1)))+4;
for i=2:2:length(param)
    pos = [beam.z(i)-1 -L/2 2 L];
    rectangle('Position',pos,'Curvature',[1 1])
end
set(gca,'xtick', 0:20:max(max(beam.z)), 'ylim',[-3,3], 'xlim',[0, max(beam.z)])
 
%
axes('position',[0.80 0.1100 0.17 0.3412]);
h = plot(beam.z(end-2:end), beam.x(end-2:end,:), '-x'); 
color = [red' red' red' green' green' green' ];
for j=1:length(h)
set(h(j), 'Color',(color(:,j))');
end
set(gca,'xtick', beam.z(end-2):1:max(max(beam.z)), 'ylim',[-1,1]./2,'ytick', [-1:0.5:1]./2, 'xlim',[beam.z(end-2), max(beam.z)],'TickLength', [0.03 0.1])
title('Parallel axis in Chamber')


figure(gcf)
      set(gcf, 'PaperPositionMode','auto')
print(gcf,'-dpng','-r300',['/Users/Alonyan/Desktop/' 'SPIMBeamPathNewLens']);
%snapnow();
%delete(gcf);
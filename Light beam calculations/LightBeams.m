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
param = [2 1.5 11.5 10 5 ];

for i=1:length(param)
    Optics(i).type = char('lens'*(rem(i,2)==0)+'free'*(rem(i,2)==1));
    Optics(i).param = param(i);
end;

StartRay(1,:) = [-.1 0 .1];
StartRay(2,:) = [0 0 0];


beam  = PropagateOpticalBeam(StartRay, Optics);

figure()
h = plot(beam.z, beam.x, '-x'); 
color = [blue' blue' blue' red' red' red' green' green' green' ];
for j=1:length(h)
set(h(j), 'Color',(color(:,j))');
end

L = max(max(beam.x(1:end-1)))-min(min(beam.x(1:end-1)))+1;
for i=2:2:length(param)
    pos = [beam.z(i)-0.1 -L/2 0.2 L];
    rectangle('Position',pos,'Curvature',[1 1])
    axis equal
end
set(gca,'xtick', 1:max(max(beam.z)))
   


figure(gcf)
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
param = [2 1.5 11.5 10 5 ];

for i=1:length(param)
    Optics(i).type = char('lens'*(rem(i,2)==0)+'free'*(rem(i,2)==1));
    Optics(i).param = param(i);
end;

StartRay(1,:) = [0 0 0];
StartRay(2,:) = [-0.5 0 0.5];


beam  = PropagateOpticalBeam(StartRay, Optics);

figure()
h = plot(beam.z, beam.x, '-x'); 
color = [ red' red' red' green' green' green' blue' blue' blue'];
for j=1:length(h)
set(h(j), 'Color',(color(:,j))');
end

L = max(max(beam.x(1:end-1)))-min(min(beam.x(1:end-1)))+1;
for i=2:2:length(param)
    pos = [beam.z(i)-0.1 -L/2 0.2 L];
    rectangle('Position',pos,'Curvature',[1 1])
    axis equal
end
set(gca,'xtick', 1:max(max(beam.z)))
   


figure(gcf)

%snapnow();
%delete(gcf);
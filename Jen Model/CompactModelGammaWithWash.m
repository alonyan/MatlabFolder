function [gamma, TSPAN]=CompactModelGammaWithWash(parameters)

TSPAN1 = 0:50:18000;                %Timespan of model run   
IFNg  = parameters.IFNg;
HS = parameters.HS;
IFNgR = parameters.IFNgR;


%Function
fun = @(t,x) ModelJen3(t,x,parameters);
% Run model
%[T,X]=ode45(fun,TSPAN,[1e-8 2.8e-11 0 5.6e-13 0].*nA); %free gamma, HS, HSc, IFNgR, IFNgRc
gamma = [];
%tsevah = ['r', 'y', 'g', 'b', 'c'];


[T,X]=ode45(fun,TSPAN1,[IFNg HS 0].*parameters.nA); %free gamma, HS, HSc, IFNgR, IFNgRc

EndParam = [];
EndParam = [EndParam; 0 X(end,2:3)]./parameters.nA;

%EndParam(1) = IFNgR;
gamma = [gamma; X(:,1)'];

TSPAN2 = TSPAN1(end)+50:50:6e5;   %Timespan of model run

[T,X]=ode45(fun,TSPAN2,[EndParam.*parameters.nA]);  %free gamma, HS, HSc, IFNgR, IFNgRc

gamma = [gamma, X(:,1)'];

TSPAN = [TSPAN1 TSPAN2];
end

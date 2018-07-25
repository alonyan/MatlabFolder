%

nA = 6.23e23;             %Avogadro no.


TSPAN = [0 1000];

fun = @(t,x) Modelon(t,x);
%init = [0.000000000606036   0.163966590005116   0.193733409994884   0.002313713818117   0.000001706181883]
%[0 1.6539e-04 9.9231e-04 1.4842e-07  2.1670e-06]
init = [0 1.6539e-04 9.9231e-04 1.4842e-07  2.1670e-07]
[T,X]=ode45(fun,TSPAN,init.*nA);
%%
semilogy(T/3600,X(:,:)./nA); figure(gcf)
%legend('RNA','New Protein','Mature Protein')
%hold all;
%%
EC50 = 3e-12;
pSTAT1 = 1./(1+EC50./(X(:,1)./nA))
plot(T/3600,pSTAT1); figure(gcf)

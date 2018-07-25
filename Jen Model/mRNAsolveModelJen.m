function [mRNA] = mRNAsolveModelJen(k0,T1,pSTAT1)

mRNA = [];
%Protein = [];

%k0 = 0.1;

TSPAN = T1;


[T,X]=ode45(@(t,x) GenpSTAT1_Fit(t,x,k0,T1,pSTAT1) ,TSPAN,[1 1]);


mRNA = X(:,1)';
%Protein = X(:,2)';
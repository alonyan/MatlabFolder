%% quasi steady state approx, taking pSTAT1 at its s.s. value. For derivation see writeup.
clear all;

%Define time 
t0=0;               %Initial time, (minutes)
tstop=60*60*50;          %Finish time, 
dt=1;
t = t0:dt:tstop;


%Define constants
nA=6.23e23;             %Avogadro no.
kon=1e8;                %mol^-1*s^-1 (Association of gamma for receptor) (Adjusted for known Kd ~5pM)
koff=5e-2;              %s^-1 (Debinding from receptor) (Adjusted for known Kd)
%kphos=2.6e5;           %s^-1 (Rate of STAT1 phosphorylation) calculated by solving for kphos using steady-state equations
alpha=747;              %s (Halflife of pSTAT1 decay - my data)          
kdeg=log(2)/alpha;      %s^-1 (Rate of pSTAT1 decay to STAT1)

sigma1=1422*60;             %avg mRNA halflife (sec)

beta1=(log(2))/sigma1;     %Convert halflife into rate of exp decay
sigma2=240*60;              %avg protein halflife (sec) (my data)
beta2=(log(2))/sigma2; 

IFNgR0 = (2000*10e12)/nA;    %A  %Convert to molarity     
STAT10 = (3000*10e12)/nA;       %B
kphos=((kdeg*koff-(50e-12)*kdeg*kon))/((50e-12)*IFNgR0*kon);



%Simulation conditions
gamma=1e-8./10.^(0:5);       %molar concentrations


Lambda1 = 5*10.^(-5:0.1:-4);
Lambda2 = 5*10.^(-2:0.1:-1);

%Lambda1 = 5e-5;
%Lambda2 = 5e-2;

%k = ((decay1*decay2)./Lambda2)*800;
k = 3.1359e-06;







i = 2;   %(conditions... )
j = 2;      
n = 2;      %gamma #


c = Lambda1(i);  %transCription 
l = Lambda2(j);     %transLation



pSTAT1_ss = ((IFNgR0*STAT10*kphos*kon)/(IFNgR0*kon*kphos+kdeg*kon)).*((gamma)./(gamma+(kdeg*koff)/(IFNgR0*kon*kphos+kdeg*kon)));
pSTAT1_ss_sc=(pSTAT1_ss*nA)/10e12;

    
A = ((k*pSTAT1_ss_sc(n))/(beta1)).*(1-exp(-beta1*t))+c/beta1; %mRNA



B = ((l*k*pSTAT1_ss_sc(n))/(beta2-beta1)).*((-exp(-beta1*t))/beta1+(exp(-beta2*t))/beta2+((beta2-beta1))/(beta1*beta2))+(l*c)/(beta1*beta2); %protein


subplot(2,1,1)
plot(t/3600,A); figure(gcf);
xlabel('time (h)')
ylabel('mRNA #')
legend('Analytic','Model')
subplot(2,1,2)
semilogy(t/3600,B); figure(gcf);
xlabel('time (h)')
ylabel('protein #')
legend('Analytic','Model')



% subplot(2,1,1)
% plot(t/3600,A); figure(gcf);
% xlabel('time (h)')
% ylabel('mRNA #')
% hold on;
% subplot(2,1,2)
% plot(t/3600,B); figure(gcf);
% xlabel('time (h)')
% ylabel('protein #')
% hold on;















%% now for 5h of gamma  quasi steady state approx with signal stop at tau, taking pSTAT1 at its s.s. value. For derivation see writeup.

% Model

%Define time 
t0=0;               %Initial time, (minutes)
tstop=60*60*50;          %Finish time, 
dt=1;
t = t0:dt:tstop;

tau = 60*60*5;  %gamma stop time (5h)


%Define constants
nA=6.23e23;             %Avogadro no.
kon=1e8;                %mol^-1*s^-1 (Association of gamma for receptor) (Adjusted for known Kd ~5pM)
koff=5e-2;              %s^-1 (Debinding from receptor) (Adjusted for known Kd)
alpha=747;              %s (Halflife of pSTAT1 decay - my data)          
kdeg=log(2)/alpha;      %s^-1 (Rate of pSTAT1 decay to STAT1)
sigma1=1422*60;             %avg mRNA halflife (sec)
beta1=(log(2))/sigma1;     %Convert halflife into rate of exp decay
sigma2=240*60;              %avg protein halflife (sec) (my data)
beta2=(log(2))/sigma2; 

IFNgR0 = (2000*10e12)/nA;    %A  %Convert to molarity     
STAT10 = (3000*10e12)/nA;       %B
kphos=((kdeg*koff-(50e-12)*kdeg*kon))/((50e-12)*IFNgR0*kon);


%Simulation conditions
gamma=1e-8./10.^(0:5);       %molar concentrations


Lambda1 = 5*10.^(-5:0.1:-4);
Lambda2 = 5*10.^(-2:0.1:-1);

%k = ((decay1*decay2)./Lambda2)*800;
k = 3.1359e-06;



i = 1;   %(conditions... ) 
j = 1;      

n = 1;      %gamma #


c = Lambda1(i);  %transCription 
l = Lambda2(j);     %transLation


pSTAT1_ss = ((IFNgR0*STAT10*kphos*kon)/(IFNgR0*kon*kphos+kdeg*kon)).*((gamma)./(gamma+(kdeg*koff)/(IFNgR0*kon*kphos+kdeg*kon)));
pSTAT1_ss_sc=(pSTAT1_ss*nA)/10e12;







    
A = (((k*pSTAT1_ss_sc(n))/(beta1)).*(1-exp(-beta1*t))+c/beta1).*(heaviside(t)-heaviside(t-tau))+...
    (((k*pSTAT1_ss_sc(n))/(beta1)).*(exp(beta1*tau)-1).*exp(-beta1*t)+c/beta1).*heaviside(t-tau); %mRNA


B = (((l*k*pSTAT1_ss_sc(n))/(beta2-beta1)).*((-exp(-beta1*t))/beta1+(exp(-beta2*t))/beta2+((beta2-beta1))/(beta1*beta2))+(l*c)/(beta1*beta2)).*(heaviside(t)-heaviside(t-tau))+...
    (((l*k*pSTAT1_ss_sc(n))/(beta2-beta1)).*((exp(beta1*tau)-1)*(exp(-beta1*t))/beta1-(exp(beta2*tau)-1)*(exp(-beta2*t))/beta2)+(l*c)/(beta1*beta2)).*heaviside(t-tau); %protein


subplot(2,1,1)
plot(t/3600,A); figure(gcf);
xlabel('time (h)')
ylabel('mRNA #')
legend('Analytic','Model')
%hold on;
subplot(2,1,2)
plot(t/3600,B); figure(gcf);
xlabel('time (h)')
ylabel('protein #')
legend('Analytic','Model')
%hold on;

% subplot(2,1,1)
% plot(t/3600,A); figure(gcf);
% xlabel('time (h)')
% ylabel('mRNA #')
% hold on;
% subplot(2,1,2)
% plot(t/3600,B); figure(gcf);
% xlabel('time (h)')
% ylabel('protein #')
% hold on;
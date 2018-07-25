%% Model
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
decay1=(log(2))/sigma1;     %Convert halflife into rate of exp decay
sigma2=240*60;              %avg protein halflife (sec) (my data)
decay2=(log(2))/sigma2;     %Convert halflife into rate of exp decay

%Simulation conditions
IFNg=1e-8./10.^(0:5);       %molar concentrations

%Make matrices to save data
IFNgR=zeros(length(t),length(IFNg)); 
IFNg_IFNgR=zeros(length(t),length(IFNg)); 
STAT1=zeros(length(t),length(IFNg)); 
pSTAT1=zeros(length(t),length(IFNg));
%IFNg=zeros(length(t),length(IFNg_m));

%Init Parameters
IFNgR(1,:) = (2000*10e12)/nA;      %Convert to molarity     
STAT1(1,:) = (3000*10e12)/nA;      
kphos=((kdeg*koff-(50e-12)*kdeg*kon))/((50e-12)*IFNgR(1,1)*kon);

%Calculate pSTAT1 from IFNg receptor engagement

for j = 1:length(IFNg);
    for i = 1:length(t)-1
        %IFNg(i+1,j) = IFNg(i,j)-(kon)*(IFNgR(i,j)*IFNg(i,j)*dt);  
        IFNgR(i+1,j) = IFNgR(i,j)+((koff*IFNg_IFNgR(i,j))-(kon*IFNgR(i,j)*IFNg(j)))*dt; 
        IFNg_IFNgR(i+1,j) = IFNg_IFNgR(i,j)+((kon*IFNgR(i,j)*IFNg(j))-(koff*IFNg_IFNgR(i,j)))*dt; 
        pSTAT1(i+1,j) = pSTAT1(i,j)+((kphos*STAT1(i,j)*IFNg_IFNgR(i,j))-(pSTAT1(i,j)*kdeg))*dt;
        STAT1(i+1,j) = STAT1(i,j)-((kphos*STAT1(i,j)*IFNg_IFNgR(i,j))-(pSTAT1(i,j)*kdeg))*dt; 
    end
end

pSTAT1_sc=(pSTAT1*nA)/10e12;







Model = ([]);
Lambda1 = 5*10.^(-5:0.1:-4);
Lambda2 = 5*10.^(-2:0.1:-1);

%Lambda1 = 5e-5;
%Lambda2 = 5e-2;

%k = ((decay1*decay2)./Lambda2)*800;
k = 3.1359e-06;


for a = 1:length(Lambda1);
    for b = 1: length(Lambda2);
        
        mRNA(1) = Lambda1(a)/decay1;                %Steady state
        protein(1) = (Lambda2(b)*mRNA(1))/decay2;   %Steady state
    
        for j = 1:length(IFNg);
            for i=1:length(t)-1
                %mRNA(i+1) = Lambda1(a)*dt+k(b)*((pSTAT1_sc(length(t),j)-pSTAT1_sc(length(t),length(IFNg)))*dt)+mRNA(i)*(1-(decay1*dt));
                mRNA(i+1) = Lambda1(a)*dt+k*((pSTAT1_sc(i,j))*dt)+mRNA(i)*(1-(decay1*dt));
                protein(i+1) = (Lambda2(b)*(mRNA(i))*dt)+protein(i)*(1-(decay2*dt));
            end
            Model(a,b,j).Lambda1 = Lambda1(a);
            Model(a,b,j).Lambda2 = Lambda2(b);
            Model(a,b,j).mRNA = mRNA;
            Model(a,b,j).protein = protein;
            Model(a,b,j).t = t;
            Model(a,b,j).IFNg = IFNg(j);
        end
    end
end


%% quasi steady state approx, taking pSTAT1 at its s.s. value. For derivation see writeup.

% t0=0;               %Initial time, (minutes)
% tstop=1e6;          %Finish time, 
% dt=1;
% t = t0:dt:tstop;


sigma1=1422*60;             %avg mRNA halflife (sec)
beta1=(log(2))/sigma1;     %Convert halflife into rate of exp decay
sigma2=240*60;              %avg protein halflife (sec) (my data)
beta2=(log(2))/sigma2; 

i = 2;   %(conditions... )
j = 2;      
n = 2;      %gamma #


c = Lambda1(i);  %transCription 
l = Lambda2(j);     %transLation

IFNgR0 = (2000*10e12)/nA;    %A  %Convert to molarity     
STAT10 = (3000*10e12)/nA;       %B
gamma = IFNg;

pSTAT1_ss = ((IFNgR0*STAT10*kphos*kon)/(IFNgR0*kon*kphos+kdeg*kon)).*((gamma)./(gamma+(kdeg*koff)/(IFNgR0*kon*kphos+kdeg*kon)));
pSTAT1_ss_sc=(pSTAT1_ss*nA)/10e12;



%k = ((decay1*decay2)./Lambda2)*800;
k = 3.1359e-06;

    
A = ((k*pSTAT1_ss_sc(n))/(beta1)).*(1-exp(-beta1*t))+c/beta1; %mRNA



B = ((l*k*pSTAT1_ss_sc(n))/(beta2-beta1)).*((-exp(-beta1*t))/beta1+(exp(-beta2*t))/beta2+((beta2-beta1))/(beta1*beta2))+(l*c)/(beta1*beta2); %protein

%semilogx(IFNg, pSTAT1_sc(length(t),:)); figure(gcf)
%pause;
subplot(2,1,1)
plot(t/3600,A,Model(i,j,n).t/3600,Model(i,j,n).mRNA); figure(gcf);
xlabel('time (h)')
ylabel('mRNA #')
legend('Analytic','Model')
subplot(2,1,2)
semilogy(t/3600,B,Model(i,j,n).t/3600,Model(i,j,n).protein); figure(gcf);
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

%%
IFNgR0 = (2000*10e12)/nA;    %A  %Convert to molarity     
STAT10 = (3000*10e12)/nA;       %B
gamma = IFNg;

pSTAT1_ss = ((IFNgR0*STAT10*kphos*kon)/(IFNgR0*kon*kphos+kdeg*kon)).*((gamma)./(gamma+(kdeg*koff)/(IFNgR0*kon*kphos+kdeg*kon)))
pSTAT1_ss_sc=(pSTAT1_ss*nA)/10e12;



















%% now for 5h of gamma
% Model

clear all;
%Define time 
t0=0;               %Initial time, (minutes)
tstop=60*60*50;          %Finish time, 
dt=1;
t = t0:dt:tstop;

tau = 60*60*5;


%Define constants
nA=6.23e23;             %Avogadro no.
kon=1e8;                %mol^-1*s^-1 (Association of gamma for receptor) (Adjusted for known Kd ~5pM)
koff=5e-2;              %s^-1 (Debinding from receptor) (Adjusted for known Kd)
%kphos=2.6e5;           %s^-1 (Rate of STAT1 phosphorylation) calculated by solving for kphos using steady-state equations
alpha=747;              %s (Halflife of pSTAT1 decay - my data)          
kdeg=log(2)/alpha;      %s^-1 (Rate of pSTAT1 decay to STAT1)
sigma1=1422*60;             %avg mRNA halflife (sec)*60
decay1=(log(2))/sigma1;     %Convert halflife into rate of exp decay
sigma2=240*60;              %avg protein halflife (sec) (my data)
decay2=(log(2))/sigma2;     %Convert halflife into rate of exp decay

%Simulation conditions
IFNg=1e-8./10.^(0:5);       %molar concentrations

%Make matrices to save data
IFNgR=zeros(length(t),length(IFNg)); 
IFNg_IFNgR=zeros(length(t),length(IFNg)); 
STAT1=zeros(length(t),length(IFNg)); 
pSTAT1=zeros(length(t),length(IFNg));
%IFNg=zeros(length(t),length(IFNg_m));

%Init Parameters
IFNgR(1,:) = (2000*10e12)/nA;      %Convert to molarity     
STAT1(1,:) = (3000*10e12)/nA;      
kphos=((kdeg*koff-(50e-12)*kdeg*kon))/((50e-12)*IFNgR(1,1)*kon);

%Calculate pSTAT1 from IFNg receptor engagement

for j = 1:length(IFNg);
    for i = 1:length(t)-1
        %IFNg(i+1,j) = IFNg(i,j)-(kon)*(IFNgR(i,j)*IFNg(i,j)*dt);  
        IFNgR(i+1,j) = IFNgR(i,j)+((koff*IFNg_IFNgR(i,j))-(kon*IFNgR(i,j)*IFNg(j)))*dt; 
        IFNg_IFNgR(i+1,j) = IFNg_IFNgR(i,j)+((kon*IFNgR(i,j)*IFNg(j))-(koff*IFNg_IFNgR(i,j)))*dt; 
        pSTAT1(i+1,j) = pSTAT1(i,j)+((kphos*STAT1(i,j)*IFNg_IFNgR(i,j))-(pSTAT1(i,j)*kdeg))*dt;
        STAT1(i+1,j) = STAT1(i,j)-((kphos*STAT1(i,j)*IFNg_IFNgR(i,j))-(pSTAT1(i,j)*kdeg))*dt; 
    end
end

pSTAT1_sc=(pSTAT1*nA)/10e12;


% add JAKi at t=tau (set pSTAT1 to 0)
pSTAT1_sc = pSTAT1_sc.*repmat((t<=tau)',1, length(IFNg));




Model = ([]);
Lambda1 = 5*10.^(-5:0.1:-4);
Lambda2 = 5*10.^(-2:0.1:-1);

%Lambda1 = 5e-5;
%Lambda2 = 5e-2;

%k = ((decay1*decay2)./Lambda2)*800;
k = 3.1359e-06;

for a = 1:length(Lambda1);
    for b = 1: length(Lambda2);
        
        mRNA(1) = Lambda1(a)/decay1;                %Steady state
        protein(1) = (Lambda2(b)*mRNA(1))/decay2;   %Steady state
    
        for j = 1:length(IFNg);
            for i=1:length(t)-1
                %mRNA(i+1) = Lambda1(a)*dt+k(b)*((pSTAT1_sc(length(t),j)-pSTAT1_sc(length(t),length(IFNg)))*dt)+mRNA(i)*(1-(decay1*dt));
                mRNA(i+1) = Lambda1(a)*dt+k*((pSTAT1_sc(i,j))*dt)+mRNA(i)*(1-(decay1*dt));
                protein(i+1) = (Lambda2(b)*(mRNA(i))*dt)+protein(i)*(1-(decay2*dt));
            end
            Model(a,b,j).Lambda1 = Lambda1(a);
            Model(a,b,j).Lambda2 = Lambda2(b);
            Model(a,b,j).mRNA = mRNA;
            Model(a,b,j).protein = protein;
            Model(a,b,j).t = t;
            Model(a,b,j).IFNg = IFNg(j);
        end
    end
end



%% quasi steady state approx with signal stop at tau, taking pSTAT1 at its s.s. value. For derivation see writeup.

% t0=0;               %Initial time, (minutes)
% tstop=1e6;          %Finish time, 
% dt=1;
% t = t0:dt:tstop;

%Define time 
% t0=0;               %Initial time, (minutes)
% tstop=1e5;          %Finish time, 
% dt=1;
% t = t0:dt:tstop;
%sigma1=1422*60;             %avg mRNA halflife (sec)*60

beta1=(log(2))/sigma1;     %Convert halflife into rate of exp decay
beta2=(log(2))/sigma2; 

i = 4;   %(conditions... )
j = 4;      

n = 3;      %gamma #


c = Lambda1(i);  %transCription 
l = Lambda2(j);     %transLation

IFNgR0 = (2000*10e12)/nA;    %A  %Convert to molarity     
STAT10 = (3000*10e12)/nA;       %B
gamma = IFNg;

pSTAT1_ss = ((IFNgR0*STAT10*kphos*kon)/(IFNgR0*kon*kphos+kdeg*kon)).*((gamma)./(gamma+(kdeg*koff)/(IFNgR0*kon*kphos+kdeg*kon)));
pSTAT1_ss_sc=(pSTAT1_ss*nA)/10e12;


%alpha = beta1*beta2*800*pSTAT1_ss_sc(n);  %see writeup. This is a measured parameter, basically.

%k = ((decay1*decay2)./Lambda2)*800;
k = 3.1359e-06;



    






    
A = (((k*pSTAT1_ss_sc(n))/(beta1)).*(1-exp(-beta1*t))+c/beta1).*(heaviside(t)-heaviside(t-tau))+...
    (((k*pSTAT1_ss_sc(n))/(beta1)).*(exp(beta1*tau)-1).*exp(-beta1*t)+c/beta1).*heaviside(t-tau); %mRNA


B = (((l*k*pSTAT1_ss_sc(n))/(beta2-beta1)).*((-exp(-beta1*t))/beta1+(exp(-beta2*t))/beta2+((beta2-beta1))/(beta1*beta2))+(l*c)/(beta1*beta2)).*(heaviside(t)-heaviside(t-tau))+...
    (((l*k*pSTAT1_ss_sc(n))/(beta2-beta1)).*((exp(beta1*tau)-1)*(exp(-beta1*t))/beta1-(exp(beta2*tau)-1)*(exp(-beta2*t))/beta2)+(l*c)/(beta1*beta2)).*heaviside(t-tau); %protein

%semilogx(IFNg, pSTAT1_sc(length(t),:)); figure(gcf)
%pause;
% 
subplot(2,1,1)
plot(t/3600,A,Model(i,j,n).t/3600,Model(i,j,n).mRNA); figure(gcf);
xlabel('time (h)')
ylabel('mRNA #')
legend('Analytic','Model')
%hold on;
subplot(2,1,2)
plot(t/3600,B,Model(i,j,n).t/3600,Model(i,j,n).protein); figure(gcf);
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

%%
IFNgR0 = (2000*10e12)/nA;    %A  %Convert to molarity     
STAT10 = (3000*10e12)/nA;       %B
gamma = IFNg;

pSTAT1_ss = ((IFNgR0*STAT10*kphos*kon)/(IFNgR0*kon*kphos+kdeg*kon)).*((gamma)./(gamma+(kdeg*koff)/(IFNgR0*kon*kphos+kdeg*kon)))
pSTAT1_ss_sc=(pSTAT1_ss*nA)/10e12;
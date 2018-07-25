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
kphos=((kdeg*koff-(3.2e-12)*kdeg*kon))/((3.2e-12)*IFNgR(1,1)*kon);
IFNgR0 = (2000*10e12)/nA;    %A  %Convert to molarity     
STAT10 = (3000*10e12)/nA;       %B
gamma = [10e-9 1e-9 100e-12 10e-12 1e-12 0];;

pSTAT1_ss = ((IFNgR0*STAT10*kphos*kon)/(IFNgR0*kon*kphos+kdeg*kon)).*((gamma)./(gamma+(kdeg*koff)/(IFNgR0*kon*kphos+kdeg*kon)));
pSTAT1_ss_sc=(pSTAT1_ss*nA)/10e12;

Lambda1 = 5*10.^-5
bet = Lambda1+[beta(2:6) 0].*pSTAT1_ss_sc

loglog(gamma, bet,'-o', gamma, 0.25*gamma.^(0.25)); figure(gcf)
%loglog(gamma./(gamma+3.2e-12), bet-5e-5,'-o'); figure(gcf)
%plot(pSTAT1_ss_sc, bet-5e-5,'-o'); figure(gcf)


function y = AnalyticMHC_v2(param,t)


k = param(1);
gamma = param(2);
tau = param(3);

%Define constants
nA=6.23e23;             %Avogadro no.
kon=7.3e6;                %mol^-1*s^-1 (Association of gamma for receptor) (Adjusted for known Kd ~50pM)
koff=5e-3;              %s^-1 (Debinding from receptor) (Adjusted for known Kd)
%kphos=2.6e5;           %s^-1 (Rate of STAT1 phosphorylation) calculated by solving for kphos using steady-state equations
alpha=747;              %s (Halflife of pSTAT1 decay - my data)          
kdeg=log(2)/alpha;      %s^-1 (Rate of pSTAT1 decay to STAT1)

sigma1=22*60*60;             %avg mRNA halflife (sec)

beta1=(log(2))/sigma1;     %Convert halflife into rate of exp decay
sigma2=3*60*60;              %avg protein halflife (sec) (my data)
beta2=(log(2))/sigma2; 

IFNgR0 = (2000*10e12)/nA;    %A  %Convert to molarity     
STAT10 = (3000*10e12)/nA;       %B
kphos=((kdeg*koff-(3.2e-12)*kdeg*kon))/((3.2e-12)*IFNgR0*kon);

%Simulation conditions




%c = 5e-5; %transcription
l = 0.1; %translation

pSTAT1_ss = ((IFNgR0*STAT10*kphos*kon)/(IFNgR0*kon*kphos+kdeg*kon)).*((gamma)./(gamma+(kdeg*koff)/(IFNgR0*kon*kphos+kdeg*kon)));
pSTAT1_ss_sc=(pSTAT1_ss*nA)/10e12;



y = (((l*k*pSTAT1_ss_sc)/(beta2-beta1)).*((-exp(-beta1*t))/beta1+(exp(-beta2*t))/beta2+((beta2-beta1))/(beta1*beta2))).*(heaviside(t)-heaviside(t-tau))+...
    (((l*k*pSTAT1_ss_sc)/(beta2-beta1)).*((exp(beta1*tau)-1)*(exp(-beta1*t))/beta1-(exp(beta2*tau)-1)*(exp(-beta2*t))/beta2)).*heaviside(t-tau); %protein








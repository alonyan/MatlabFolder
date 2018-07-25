function y = AnalyticMHC(alp,t)


%gamma = 10.00000000000000e-09;
alpha = alp(1);
gamma = alp(2);

nA=6.23e23;             %Avogadro no.
kon=1e8;                %mol^-1*s^-1 (Association of gamma for receptor) (Adjusted for known Kd ~5pM)
koff=5e-2;              %s^-1 (Debinding from receptor) (Adjusted for known Kd)
%kphos=2.6e5;           %s^-1 (Rate of STAT1 phosphorylation) calculated by solving for kphos using steady-state equations
HalfLife=747;              %s (Halflife of pSTAT1 decay - my data)          
kdeg=log(2)/HalfLife;      %s^-1 (Rate of pSTAT1 decay to STAT1)

sigma1=1422*60;             %avg mRNA halflife (sec)
beta1=(log(2))/sigma1;     %Convert halflife into rate of exp decay
sigma2=240*60;              %avg protein halflife (sec) (my data)
beta2=(log(2))/sigma2; 


IFNgR0 = (2000*10e12)/nA;    %A  %Convert to molarity     
STAT10 = (3000*10e12)/nA;       %B

kphos=((kdeg*koff-(50e-12)*kdeg*kon))/((50e-12)*IFNgR0*kon);


pSTAT1_ss = ((IFNgR0*STAT10*kphos*kon)/(IFNgR0*kon*kphos+kdeg*kon)).*((gamma)./(gamma+(kdeg*koff)/(IFNgR0*kon*kphos+kdeg*kon)));
pSTAT1_ss_sc=(pSTAT1_ss*nA)/10e12;


%alpha = beta1*beta2*800*pSTAT1_ss_sc;  %see writeup. This is a measured parameter, basically.


y = alpha*(1/(beta1*(beta1-beta2)).*(exp(-beta1*t))-1/(beta2*(beta1-beta2)).*(exp(-beta2*t))+1/(beta1*beta2)).*pSTAT1_ss_sc; %protein
%% Data to be fit (from B16 stimulation done 11.18.13)

MHC = [134689.858877585,134689.858877585,134689.858877585,134689.858877585,134689.858877585,134689.858877585;208204.791598293,175057.433541188,145520.183787332,131736.133902199,123859.533967837,118608.467344929;440236.297998031,321759.107318674,177354.775188710,119264.850672793,101214.309156547,90712.1759107319;810108.303249098,563964.555300296,234788.316376764,106793.567443387,89071.2175910732,90712.1759107319;1173088.28355760,718542.829012143,288611.749261569,119593.042336725,88743.0259271415,78240.8926813259;1773350.83688874,1165539.87528717,366721.365277322,143551.033803741,106137.184115523,93009.5175582540;1812405.64489662,1613521.49655399,421201.181489990,139284.542172629,93665.9008861175,88743.0259271415;]

time = [0 5 10 12.5 15 17.5 25.5].*60.*60;

gamma = [10e-9 1e-9 100e-12 10e-12 1e-12 0];

%%
range = 1:6;

for i = 1:5;

    dMHC = (MHC(:,i)-MHC(:,6))';

    fixed = [false true];

    initparam = [1, gamma(i)];

    [param r err] = mod_lsqcurvefit(fixed, time(range), dMHC(range), @AnalyticMHC, initparam);
end

%% My fitting function

% function y = AnalyticMHC(alp,t)
% 
% 
% 
% alpha = alp(1);
% gamma = alp(2);
% 
% nA=6.23e23;             %Avogadro no.
% kon=1e8;                %mol^-1*s^-1 (Association of gamma for receptor) (Adjusted for known Kd ~5pM)
% koff=5e-2;              %s^-1 (Debinding from receptor) (Adjusted for known Kd)
% HalfLife=747;              %s (Halflife of pSTAT1 decay - my data)          
% kdeg=log(2)/HalfLife;      %s^-1 (Rate of pSTAT1 decay to STAT1)
% 
% sigma1=1422*60;             %avg mRNA halflife (sec)
% beta1=(log(2))/sigma1;     %Convert halflife into rate of exp decay
% sigma2=240*60;              %avg protein halflife (sec) (my data)
% beta2=(log(2))/sigma2; 
% 
% 
% IFNgR0 = (2000*10e12)/nA;    %A  %Convert to molarity     
% STAT10 = (3000*10e12)/nA;       %B
% 
% kphos=((kdeg*koff-(50e-12)*kdeg*kon))/((50e-12)*IFNgR0*kon);
% 
% 
% pSTAT1_ss = ((IFNgR0*STAT10*kphos*kon)/(IFNgR0*kon*kphos+kdeg*kon)).*((gamma)./(gamma+(kdeg*koff)/(IFNgR0*kon*kphos+kdeg*kon)));
% pSTAT1_ss_sc=(pSTAT1_ss*nA)/10e12;
% 
% 
% %alpha = beta1*beta2*800*pSTAT1_ss_sc;  %see writeup. This is a measured parameter, basically.
% 
% 
% y = alpha*(1/(beta1*(beta1-beta2)).*(exp(-beta1*t))-1/(beta2*(beta1-beta2)).*(exp(-beta2*t))+1/(beta1*beta2)).*pSTAT1_ss_sc; %protein
function y = AnalyticMHC_v5(param,t,varargin)
% varargin are options pairs like 
% ('GamaStop',Time in h) 
%  AnalyticMHC(param,t,'GammaStop', 5)
%  ('SplitTime', Time in h)
%  AnalyticMHC(param,t,'SplitTime', 18)

tau = 0;
tdiv = 0;

k = param(1);
gamma = param(2);                   %Fixed parameter...
sigma1=param(3)*60*60;              %mRNA halflife (sec)



    j1=find(strcmp(varargin, 'GammaStop'));
    if length(j1)>1,
        error('Too many GammaStop inputs!')
    elseif length(j1)==1,
        tau = 60*60*varargin{j1+1};
    end;
    
        j1=find(strcmp(varargin, 'SplitTime'));
    if length(j1)>1,
        error('Too many SplitTime inputs!')
    elseif length(j1)==1,
        tdiv = 60*60*varargin{j1+1};
    end;




%Define constants
nA=6.23e23;             %Avogadro no.

kon=7.3e6;              %mol^-1*s^-1 (Association of gamma for receptor) 
koff=5e-3;              %s^-1 (Debinding from receptor) 

k0=1.9266e-07;
c = 5e-5; %transcription
l = 0.1021; %translation

IFNgR0 = (2000*10e12)/nA;    %A  %Convert to molarity     
STAT10 = (10000*10e12)/nA;       %B

alpha = 747;              %s (Halflife of pSTAT1 decay - my data)          
pStat1EC50 = 3.2e-12;
kdeg=log(2)/alpha;      %s^-1 (Rate of pSTAT1 decay to STAT1)
kphos=((kdeg*koff-(pStat1EC50)*kdeg*kon))/((pStat1EC50)*IFNgR0*kon);



beta1=(log(2))./sigma1;     %Convert halflife into rate of exp decay
sigma2=3*60*60;            %protein halflife (sec) (my data)
beta2=repmat((log(2))/sigma2,1,length(beta1)); 





pSTAT1_ss = ((IFNgR0*STAT10*kphos*kon)/(IFNgR0*kon*kphos+kdeg*kon)).*((gamma)./(gamma+(kdeg*koff)/(IFNgR0*kon*kphos+kdeg*kon)));
pSTAT1_ss_sc=(pSTAT1_ss*nA)/10e12;


    if tdiv  %if a division time is supplied
        if tau %if a cytokine stop time is supplied
        gen = (floor(t./tdiv));
        A00 = ((k*pSTAT1_ss_sc)./(beta1)).*(exp(beta1*tau)-1);
        B00 = -(l*k*pSTAT1_ss_sc./(beta2*(beta2-beta1))).*(exp(beta2*tau)-1);
        An0 = A00*(1./(2.^(gen))); %An(0)
        Bn0 = B00*(1./(2.^(gen))); %Bn(0)        
            %A = (((k*pSTAT1_ss_sc(n))/(beta1)).*(1-exp(-beta1*t))+c/beta1).*(heaviside(t)-heaviside(t-tau))+...
            %(An0.*exp(-beta1*t)+c/beta1).*heaviside(t-tau); %mRNA
        y = (((l*k*pSTAT1_ss_sc)/(beta2-beta1)).*((-exp(-beta1*t))/beta1+(exp(-beta2*t))/beta2+((beta2-beta1))/(beta1*beta2))).*(heaviside(t)-heaviside(t-tau))+...
            ((l*An0./(beta2-beta1)).*exp(-beta1*t)+Bn0.*exp(-beta2*t)).*heaviside(t-tau); %protein
        else %if a cytokine stop time is not supplied
        gen = (floor(t./tdiv));
        A00 = -(k*pSTAT1_ss_sc)./(beta1);
        B00 = l*k*pSTAT1_ss_sc./(beta2*(beta2-beta1));
        for i =1:length(gen)
            expsum1(i) = 0;
            expsum2(i) = 0;
            for m = 0:gen(i)-1;
                expsum1(i) = expsum1(i) + exp(-beta1*m*tdiv)./2^m;
                expsum2(i) = expsum2(i) + exp(-beta2*m*tdiv)./2^m;
            end
        end
        An0 = A00*(1./(2.^(gen))+(1/2)*exp(beta1*(gen)*tdiv).*expsum1); %An(0)
        Bn0 = B00*(1./(2.^(gen))+(1/2)*exp(beta2*(gen)*tdiv).*expsum2); %Bn(0)   
        %A = An0.*exp(-beta1*t)-A00+c/beta1; %mRNA
        %A = ((k*pSTAT1_ss_sc(n))./(beta1)).*(1-exp(-beta1*t))+c/beta1; %mRNA
        %B = l*An0./(beta2-beta1)+k*l*pSTAT1_ss_sc(n)./(beta1*beta2)+Bn0.*exp(-beta2*t)+(l*c)/(beta1*beta2);
        y = l*(An0.*exp(-beta1*t))./(beta2-beta1)+k*l*pSTAT1_ss_sc./(beta1*beta2)+Bn0.*exp(-beta2*t);
        end
    else %if a division time is not supplied
        if tau %if a cytokine stop time is supplied
            y = (((l*k*pSTAT1_ss_sc)/(beta2-beta1)).*((-exp(-beta1*t))/beta1+(exp(-beta2*t))/beta2+((beta2-beta1))/(beta1*beta2))).*(heaviside(t)-heaviside(t-tau))+...
            (((l*k*pSTAT1_ss_sc)/(beta2-beta1)).*((exp(beta1*tau)-1)*(exp(-beta1*t))/beta1-(exp(beta2*tau)-1)*(exp(-beta2*t))/beta2)).*heaviside(t-tau)+(k*l*c)./(k0*beta1*beta2); %protein
        else %if a cytokine stop time is not supplied
            y = (((l*k*pSTAT1_ss_sc)/(beta2-beta1)).*((-exp(-beta1*t))/beta1+(exp(-beta2*t))/beta2+((beta2-beta1))/(beta1*beta2)))+(k*l*c)./(k0*beta1*beta2);
        end;
    end;
        
        
    end







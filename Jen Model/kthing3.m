konNG=2*10^(10) ;%M^{-1}s^{-1}
koffNG = 5000 ;%s^{-1}

konG = 2*10^(10); %M^{-1}s^{-1}
koffG = 100 ;%s^{-1} , 

konP = 60000 ;%s^{-1}
koffP = 100 ;%s^{-1} 

P = 10.^(-12:0.1:-6);
Kd = koffG./konNG;

Occupancy = (P.*konG.*(koffNG*koffP+P.*konNG*(koffP+konP)).^2)./(koffG*((koffP)^2)*(koffNG+P.*konNG).^2+P.*konG.*(koffNG*koffP+P*konNG*(koffP+konP)).^2)

semilogx(P,Occupancy, P,1./(1+Kd./P)); figure(gcf)
xlabel('pSTAT1','Fontsize', 16)
ylabel('Promoter Occupancy','Fontsize', 16)
legend('With Cooperativity','Without Cooperativity', 'Fontsize', 16,'Location', 'NW')
%%
%hold all


konP = 0%60000 ;%s^{-1}
koffP = 100 ;%s^{-1} 

P = 10.^(-12:0.1:-6);
Kd = 5*10^(-9);

Occupancy = (P.*konG.*(koffNG*koffP+P.*konNG*(koffP+konP)).^2)./(koffG*((koffP)^2)*(koffNG+P.*konNG).^2+P.*konG.*(koffNG*koffP+P*konNG*(koffP+konP)).^2)

semilogx(P,Occupancy); figure(gcf)
xlabel('pSTAT1','Fontsize', 16)
ylabel('Promoter Occupancy','Fontsize', 16)
legend('With Cooperativity','Without Cooperativity', 'Fontsize', 16,'Location', 'NW')
%http://www.ebi.ac.uk/biomodels-main/static-pages.do?page=ModelMonth%2F2014-10
%%
tstop = 5;
tim = 0:0.1:100;
k0 = 10000;
tau0 = 7;
k = k0*(1-exp(-tim./tau0)).*(logical((tim>=0).*(tim<=tstop)))+k0*(1-exp(-tstop./tau0)).*exp(-(tim-tstop)./tau0).*logical(tim>tstop);
plot(tim,k); figure(gcf)




%%
koffH = 1.5*10^-5;
konH = 4*10^5;

koffR = 5*10^-3;
konR = 7.3*10^6;

kcyc = log(2)./(20*60*60);

H0 = 1*10^4;
R0 = 3*10^3;

H = 0:round(H0/10):H0;
R = 0:round(R0/10):R0;
G = 0:round((H0+R0)/10):H0+R0;

[H,R,G] = meshgrid(H,R,G);

dH = koffH*H0-(konH.*G+koffH).*H;
dR = koffR*R0-(konR.*G+koffR).*R;
dG = dH+dR-kcyc.*G;




%% simple cooperative/competitive binding
close all;
%no change
kdp = 10;
kdm = 10;

c = 10.^[-2:0.1:6];

Oc = 1./(1+kdp./c+kdp*kdm./c.^2);

semilogx(c,Oc);
hold all

% competitive
kdp = 1000;
kdm = 10;

c = 10.^[-2:0.1:6];

Oc = 1./(1+kdp./c+kdp*kdm./c.^2);

semilogx(c,Oc);


% cooperative
kdp = .01;
kdm = 10;

c = 10.^[-2:0.1:6];

Oc = 1./(1+kdp./c+kdp*kdm./c.^2);

semilogx(c,Oc);

figure(gcf)

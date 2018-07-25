%%
close all
figure('Position',[100, 100 800 400],'color','w')
R = [];
t = [];
P = [];

kc = 1;
kl = 3;
betaR = 0.5;
betaP = 1;
betaLight = 10;

tDoxOff = 20;
tDoxRecovery = 20;
tLightOn = 3;
tLightRecovery = 10;

R0 = kc/betaR;
P0 = R0*kl/betaP;
dt = 0.01;
t1 = 0:dt:1;
t = t1;
R = repmat(R0,1,length(t));
P = repmat(P0,1,length(t));
Pred = P;

%Dox OFF
tf = t(end);
t1 = 0:dt:tDoxOff;
t = t1+tf+dt;
R = [R R0*exp(-betaR.*(t-tf))];
P = [P (kl*R0/(betaP-betaR)).*(exp(-betaR.*(t-tf))-(betaR/betaP).*exp(-betaP.*(t-tf)))];
Pred = P;

%Dox back ON
tf = t(end);
tff = tf;
t1 = 0:dt:tDoxRecovery;
t = t1+tf+dt;
Re = R(end);
Pe = P(end);
R = [R R0*(1-exp(-betaR.*(t-tf)))+R(end)];
P = [P (kl*R0.*((exp(-betaR.*(t-tf))-exp(-betaP.*(t-tf)))./(betaR-betaP)+(1/betaP).*(1-exp(-betaP.*(t-tf)))))+P(end)];
Pred = P;

% Light ON
tf = t(end);
t1 = 0:dt:tLightOn;
t = t1+tf+dt;
R = [R R0*(1-exp(-betaR.*(t-tff)))+Re];
P = [P P(end).*exp(-betaLight*(t-tf))];
Pred = [Pred (kl*R0.*((exp(-betaR.*(t-tff))-exp(-betaP.*(t-tff)))./(betaR-betaP)+(1/betaP).*(1-exp(-betaP.*(t-tff)))))+Pe];

%Light OFF
tf = t(end);
t1 = 0:dt:tLightRecovery;
t = t1+tf+dt;
R = [R R0*(1-exp(-betaR.*(t-tff)))+Re];
%P = [P P0.*(1-exp(-betaP*(t-tf)))+P(end)];%%
P = [P kl*R0*(exp(-betaR*(t-tff))./(betaR-betaP)+1/betaP)+(P(end)-kl*R0*(1/betaP+exp(-betaR*(tf-tff))/(betaR-betaP)))*exp(-betaP*(t-tf))+Pe];
Pred = [Pred (kl*R0.*((exp(-betaR.*(t-tff))-exp(-betaP.*(t-tff)))./(betaR-betaP)+(1/betaP).*(1-exp(-betaP.*(t-tff)))))+Pe];
 
t = 0:dt:t(end);
subplot(2,1,1)
h = plot(t,P,'g',t,Pred,'--r',t,P./Pred,'k');shg
set(h,'linewidth',1.5)
set(gca,'ylim',[0,1.2*max(Pred)])

xlabel('time')
ylabel('Protein')

subplot(2,1,2)
h = plot(t,R,'b');shg
set(h,'linewidth',1.5)
set(gca,'ylim',[0,1.2*max(R)])

xlabel('time')
ylabel('mRNA')
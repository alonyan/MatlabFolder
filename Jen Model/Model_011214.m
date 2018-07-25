
%%
tstop = 5;
tim = 0:0.1:100;
k0 = 20;
tau0 = 7;
tau1 = 12;
k1 = 0.1*k0;
k = k0*(1-exp(-tim./tau0)).*(logical((tim>=0).*(tim<=tstop)))+(k0*(1-exp(-tstop./tau0)).*exp(-(tim-tstop)./tau1)+k1.*(1-exp(-(tim-tstop)./tau1))).*logical(tim>tstop);
plot(tim,k); figure(gcf)


%% translational dynamics


tstop = 5;
k0 = 20;
tau0 = 10;
tau1 = 1;
k1 = 0.1*k0;


transcripti = @(tim) transcription(tim , tstop, tau0,tau1, k0,k1)
translati = @(tim) translation2(tim , tstop, tau0, k0)

TSPAN = [0 100];
tim = 0:0.1:100;
fun = @(t,x) GenTrans(t,x,tim, transcripti, translati)

[T,X]=ode45(fun,TSPAN,[1 1])

plot(T,X,'--'); figure(gcf)
legend('RNA','Protein')
hold all;

plot(tim,transcripti(tim))

%%

figure();
tstop = 5;%gamma stop
k0 = 20;%trans up
tau0 = 10;%timescale up
tau1 = 5;
k1 = 0*k0;


transcripti = @(tim) transcription(tim , tstop, tau0,tau1, k0,k1)
translati = @(tim) translation(tim , tstop, tau0, k0)

TSPAN = [0 160];
tim = 0:0.1:160;
fun = @(t,x) GenTrans_v2(t,x,tim, transcripti, translati)

[T,X]=ode45(fun,TSPAN,[1 0 0])

plot(T,X); figure(gcf)
legend('RNA','New Protein','Mature Protein')
hold all;



%%

%tim = 0:0.1:100;



%transcripti = @(tim) transcription(tim , tstop, tau0,tau1, k0,k1)
%translati = @(tim) translation(tim , tstop, tau0, k0)

TSPAN = [0 50];
tim = 0:0.1:10;
fun = @(t,x) pSTAT1Feedback(t,x)

[T,X]=ode45(fun,TSPAN,[0 10 0 0 10 0])

plot(T,X(:,1), T,X(:,2)+X(:,3)+X(:,4), T,X(:,5)+X(:,3), T,X(:,6)+X(:,4)); figure(gcf)
legend('pSTAT1','STAT1','\gamma','\alpha');%,'S*\gamma','S*\alpha'
hold off;


%%
figure()

%tim = 0:0.1:100;



%transcripti = @(tim) transcription(tim , tstop, tau0,tau1, k0,k1)
%translati = @(tim) translation(tim , tstop, tau0, k0)

TSPAN = [0 1000];
tim = 0:0.1:10;
fun = @(t,x) pSTAT1Feedback_v2(t,x)

[T,X]=ode45(fun,TSPAN,[1 0 1 0 0 10 0 0])

plot(T,X(:,[5 6 7])); figure(gcf)
%legend('pSTAT1','STAT1','\gamma','\alpha');%,'S*\gamma','S*\alpha'
hold off;


%%
figure()

%tim = 0:0.1:100;



%transcripti = @(tim) transcription(tim , tstop, tau0,tau1, k0,k1)
%translati = @(tim) translation(tim , tstop, tau0, k0)
nA=6.23e23;             %Avogadro no.


TSPAN = [0 1];
fun = @(t,x) pSTAT1HS_v1(t,x)

[T,X]=ode45(fun,TSPAN,[0 (2000*10e12)/nA 0 (100000*10e12)/nA (3000*10e12)/nA 0 0])

plot(T,X(:,[5 7])); figure(gcf)
%legend('pSTAT1','STAT1','\gamma','\alpha');%,'S*\gamma','S*\alpha'
hold off;
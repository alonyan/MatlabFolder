function dx=GenpSTAT1(t,x,tim,pSTAT1)
decay1 = sqrt(2)/(24*60*60);
decay2 = sqrt(2)/(4*60*60);
tau = 12*60*60;

pS1 = interp1(tim,pSTAT1,t);
translat = 0.2;
k = interp1(tim,3*(1-exp(-tim./tau)),t);
%k=0.1;

dx(1) = k*pS1-decay1.*x(1);

dx(2)= translat.*x(1)-decay2.*x(2);


dx = dx';





function dx=GenpSTAT1_Fit(t,x,k,tim,pSTAT1)
decay1 = 1/(25*60*60);
decay2 = 1/(4*60*60);

pS1 = interp1(tim,pSTAT1,t);
translat = 0.1021;
%k = 0.1;

dx(1) = k*pS1-decay1.*x(1);

dx(2)= translat.*x(1)-decay2.*x(2);


dx = dx';





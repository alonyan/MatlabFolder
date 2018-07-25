function dx=pSTAT1Feedback(t,x)
kcat1 = 1;
kcat2 = 1;
gammad = 1/10;
kon1 = 0.5;
kon2 = 0.5;
beta1 = 1/100;
lambda = 0.01; 
beta2 = 1/100;


%,tim,transcription,translation
%transcript = interp1(tim,transcription(tim),t);
%translat = interp1(tim,translation(tim),t);

dx(1)= kcat1*x(3)+kcat2*x(4)-gammad*x(1)   ;      %pSTAT1
    
dx(2)= -kon1*x(2)*x(5)-kon2*x(2)*x(6) + gammad*x(1)  ;       %STAT1

dx(3)= kon1*x(2)*x(5)-kcat1*x(3)     ;    %S*\gamma

dx(4)= kon2*x(2)*x(6)-kcat2*x(4)     ;    %S*\alpha

dx(5)= -beta1*x(5)-kon1*x(2)*x(5)      ;   %\gamma

dx(6)= lambda*x(1)-kon2*x(6)*x(2)-beta2*x(6)    ;     %\alpha


dx = dx';





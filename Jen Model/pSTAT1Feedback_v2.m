function dx=pSTAT1Feedback_v2(t,x)

% koff1=5*10^(-2);
% kon1=1*10^8;
% koff2=5*10^(-2);
% kon2=1*10^8;
% kphos1= 2.6*10^5;
% kphos2=2.6*10^5;
% kdeg=log(2)./747;
% lambda=0;
% beta1=log(2)./747;
% beta2=log(2)./747;

koff1=0.1;
kon1=0.05;
koff2=0.1;
kon2=0.05;
kphos1= 0.2;
kphos2=0.2;
kdeg=0.3;
lambda=0.5;
beta1=2;
beta2=0.3;

%,tim,transcription,translation
%transcript = interp1(tim,transcription(tim),t);
%translat = interp1(tim,translation(tim),t);

dx(1)=  koff1*x(2)-kon1*x(1)*x(8);	%gamma Receptor 
    
dx(2)=  -(koff1*x(2)-kon1*x(1)*x(8));	%gamma Receptor complex

dx(3)=  koff2*x(4)-kon2*x(3)*x(7);	%alpha receptor

dx(4)=  -(koff2*x(4)-kon2*x(3)*x(7));	%alpha receptor complex

dx(5)=	kphos1*x(6)*x(2)+kphos2*x(6)*x(4)-kdeg*x(5);   %pSTAT5

dx(6)=	-(kphos1*x(6)*x(2)+kphos2*x(6)*x(4)-kdeg*x(5));	%stat5


dx(7)=	lambda*x(5)-kon2*x(3)*x(7)-beta1*x(7);	%alpha

dx(8)=	-kon1*x(1)*x(8)-beta2*x(8);	%gamma


dx = dx';





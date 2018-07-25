function dx=pSTAT1HS_v1(t,x)


kon=1e8;                %mol^-1*s^-1 (Association of gamma for receptor) (Adjusted for known Kd 1.5*10^-10pM)
koff=1.5e-2;              %s^-1 (Debinding from receptor) (Adjusted for known Kd)

kb=1e9;
kd=500e-3;
kphos=2.6e5;
HalfLife=747;              %s (Halflife of pSTAT1 decay - my data)          
kdeg=log(2)/HalfLife; 
kend = 0;
beta=0;

dx(1)=  koff*x(2)-kon*x(1)*x(7)+kend*x(2);	%gamma Receptor 
    
dx(2)=  -dx(1);	%gamma Receptor complex

dx(3)=  kd*x(4)-kb*x(3)*x(7);	%HS

dx(4)=  -dx(3);	%HS complex

dx(5)=	kphos*x(6)*x(2)-kdeg*x(5);   %pSTAT1

dx(6)=	-dx(5);	%stat1


dx(7)=	dx(1)-kend*x(2)+dx(3)-beta*x(7);	%gamma


dx = dx';





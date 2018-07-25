function y=Discrete2CosInLogCoordinates(beta, t)

a1 = beta(1);
T1 = beta(2);
a2 = beta(3);
T2 = beta(4);
%background =beta(3);

t=[t(:); 2*t(length(t))-t(length(t)-1)];
f=a1*T1/(2*pi)*sin(2*pi*t/T1) + a2*T2/(2*pi)*sin(2*pi*t/T2);
y=diff(f)./diff(t);%+background;

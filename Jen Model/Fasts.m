function dx=Fasts(t, x)
decay1 = 1;
alpha1 = 1;

dx(1) = -decay1.*x(1);

dx(2)= alpha1.*x(1)-decay1.*x(2);

dx(3)= alpha1.*x(2)-decay1.*x(3);

dx(4)= alpha1.*x(3)-decay1.*x(4);

dx(5)= alpha1.*x(4)-decay1.*x(5);


dx = dx'





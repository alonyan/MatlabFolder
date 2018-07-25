syms s L_p r s_Sqr

%s_Sqr = [0:0.01:1];

f=exp(-(3*r*^2)/(4*s*L_p)-s^2/2*s_Sqr);

F = int(f, s, 2*L_p, inf)
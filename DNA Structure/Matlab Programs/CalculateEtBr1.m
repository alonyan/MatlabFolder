%% Calculate EtBr to DNA ratios
n = 2.5;
K=1.5e5; %M^(-1) data from Mesquito paper

r = 0.2; % desirable ratio of bound dye to bp

H = (1-(n-1)*r).^(n-1)./(K*(1-n*r).^n)  %in M
c1 = r*H   % concentration of dilution solution

%% Preparation of bulk dye-DNA mixture
Cbp = 957e-6; % stock concentration of bp
Ct = 1000e-6; % stock concentration of EtBr
V = 13; % desirable final volume in uL
buffer_frac = 0.1;


Vbp = ((1-buffer_frac)*Ct - c1)/(Ct + Cbp*r)*V , % DNA stock volume; 0.9 stems from adding 10X buffer to a final mixture
Vt = (1-buffer_frac)*V - Vbp  , % EtBr stock volume

Cnew = Cbp*Vbp/V % final concentratio of base pairs

%% Preparation of bulk dye-DNA mixture
% assume both DNA and dye are alredy in the buffer
Cbp = 3.2e-3/650*0.9 % stock concentration of bp
Ct = 30e-6; % stock concentration of EtBr
V = 12; % desirable final volume in uL
%buffer_frac = 0.1;
buffer_frac = 0;

Vbp = ((1-buffer_frac)*Ct - c1)/(Ct + Cbp*r)*V , % DNA stock volume; 0.9 stems from adding 10X buffer to a final mixture
Vt = (1-buffer_frac)*V - Vbp  , % EtBr stock volume

Cnew = Cbp*Vbp/V % final concentratio of base pairs

%% if the sample bp volume is given
%%Preparation of bulk dye-DNA mixture
% assume both DNA and dye are alredy in the buffer
Cbp = 201e-3/650 % stock concentration of bp
Ct = 0.336e-3; % stock concentration of EtBr
Vbp = 5; % DNA sample volume in uL
%buffer_frac = 0.1;
buffer_frac = 0;

V = Vbp / (((1-buffer_frac)*Ct - c1)/(Ct + Cbp*r)) , % DNA stock volume; 0.9 stems from adding 10X buffer to a final mixture
Vt = (1-buffer_frac)*V - Vbp  , % EtBr stock volume
C_EtBr = Ct*Vt/V
Cnew = Cbp*Vbp/V % final concentratio of base pairs

%% if the sample bp volume and EtBr volume is given (both in the correct buffer): find EtBr
% concentration
%%Preparation of bulk dye-DNA mixture
% assume both DNA and dye are alredy in the buffer
n = 2.5;
K=1.5e5; %M^(-1) data from Mesquito paper
r = 0.2; % desirable ratio of bound dye to bp
H = (1-(n-1)*r).^(n-1)./(K*(1-n*r).^n)  %in M

Cbp = [3.3 3.7 2.7 3.4 4.1] *1e-3/650% stock concentration of bp
Vbp = 5; % DNA sample volume in uL
Vt = 1; %volume of dye in a buffer
%buffer_frac = 0.1;
V = Vt+Vbp
Cnew = Cbp*Vbp/V 
C_EtBr_after = (H+Cnew)*r
Ct = C_EtBr_after*V/Vt
%% Calculate r for different EtBr and Cbp concentrations
n = 2.5;
K=1.5e5;
Ct =10e-6;
Cbp = 7e-6;
 syms r
  f= r* (1-(n-1)*r).^(n-1)./(K*(1-n*r).^n) - Ct+r*Cbp;
  froots= solve(f);
  froots = eval(froots);
  r = froots(find(froots < 0.4 & froots > 0));
 r
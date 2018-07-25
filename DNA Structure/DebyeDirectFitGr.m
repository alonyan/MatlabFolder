function G = DebyeDirectFitGr(beta, R,  param)

wXY = param.wXY;
wSq = param.wSq;
NpointsZ = param.NpointsZ; 
NpointsR = param.NpointsR;

A = beta(1);
Rg = beta(2);

max_qr =  20*24/(4*Rg^2+ 3*wXY^2);
max_qz =  20*24/(4*Rg^2+ 3*wXY^2*wSq);

%NpointsZ = 400; 
%NpointsR = 200;

%z=(0:(NpointsZ-1))/NpointsZ*Zm;
%dz = Zm/NpointsZ;
%qz = 2*pi*(0:(NpointsZ-1))/(2*NpointsZ-1)/dz;

qz = (0:(NpointsZ-1))/(NpointsZ-1)*max_qz;
Rm = max([pi*NpointsR/max_qr max(R)]);

load '/Users/Alonyan/Documents/MATLAB/Matlab Programs/Processing Files/c.mat'; %for Hankel Transform
ord = 0;
c = c(ord+1,1:NpointsR+1);    %Bessel function zeros;

V = c(NpointsR+1)/(2*pi*Rm);    % Maximum frequency
r = c(1:NpointsR)'*Rm/c(NpointsR+1);   % Radius vector
v = c(1:NpointsR)'/(2*pi*Rm);   % Frequency vector

[Jn,Jm] = meshgrid(c(1:NpointsR),c(1:NpointsR));
C = (2/c(NpointsR+1))*besselj(ord,Jn.*Jm/c(NpointsR+1))./(abs(besselj(ord+1,Jn)).*abs(besselj(ord+1,Jm)));
% C is the transformation matrix

m1 = (abs(besselj(ord+1,c(1:NpointsR)))/Rm)';   %% m1 prepares input vector for transformation
m2 = m1*Rm/V;                            %% m2 prepares output vector for display
clear Jn
clear Jm
%end preparations for Hankel transform

 [QR, QZ] =meshgrid(2*pi*v, qz);
 QRgsq = (QR.^2 + QZ.^2)*Rg^2;
 Iq_2 = exp(- wXY^2*(QR.^2 + wSq*QZ.^2)/4);
 
Sq = 2*( exp(-QRgsq) - 1 + QRgsq )./QRgsq.^2;
%Sq = exp(- Rg^2*(QR.^2 + QZ.^2)/3); % Gaussian for checks
Fq = Sq.*Iq_2;

Fq = sum(Fq);

G = C*(Fq'./m2).*m1;
G = G./G(1);
G = A*interp1(r, G, R, 'linear', 'extrap');




 
 
 
 

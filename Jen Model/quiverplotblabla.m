%%
[X,Y,Z] = meshgrid(0:0.1:1,0:0.1:1,0:0.1:1);



koff=0.02;
kon=0.05;

kphos= 0.2;
kdeg=0.3;
lambda=0.6;
beta=0.1;

A=1;
B=1;


U = koff.*(A-X)-kon.*X.*Z;
V = kphos.*(B-Y).*(A-X)-kdeg.*Y;
W = lambda.*Y-kon.*X.*Z-beta.*Z;


quiver(X,Y,Z,U,V,W,'LineWidth',1);
figure(gcf)


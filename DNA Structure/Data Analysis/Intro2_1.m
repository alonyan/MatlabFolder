%Dynamic Models in Biology, Stephen Ellner and John Guckenheimer
%Secoond example m file for the Matlab Introductory materials

%Load data from file
X=load('ChlorellaGrowth.txt');

%Define vectors by slicing data
Light=X(:,1); rmax=X(:,2); 

Light_1=log(Light);
rmax_1=log(rmax);

%Repeat computations from Intro1
C=polyfit(Light,rmax,1)
D=polyfit(Light,rmax,2)
xvals=15:115;
yhat=polyval(C,xvals);
ygat=polyval(D,xvals);

C_1=polyfit(Light_1,rmax_1,1)
D_1=polyfit(Light_1,rmax_1,2)
xvals_1=2:5;
yhat_1=polyval(C_1,xvals_1);
ygat_1=polyval(D_1,xvals_1);
subplot(2,1,1)
plot(Light,rmax,'+',xvals,yhat, xvals,ygat);
axis([15 105 1 4])
subplot(2,1,2)
plot(Light_1,rmax_1,'+',xvals_1,yhat_1,xvals_1,ygat_1);

%Annotate plot with labels, title and text
xlabel('Log Light intensity (uE/m2/s)','Fontsize',14); 
ylabel('Log Maximum growth rate (1/d)','Fontsize',14);
title('Data from Fussmann et al. (2000)','FontSize',14);
text(30,3.5,'y= 1.581+ 0.0136*x','Fontsize',14);



%% Inputs
RotCalib1 = struct;
RotCalib1.x = [678 652 612 581 546 516 485 451 414 385 360];
RotCalib1.z = [1299 1309 1318 1327 1334 1341 1348 1356 1359 1361 1369];
RotCalib1.theta = pi*[0:1.5:15]/180;


%% Global fitting of axis parameters
Tinp = RotCalib1.theta;
funx = @(beta,Tinp) beta(1)+beta(3)*cos(beta(4)+Tinp);
funz = @(beta,Tinp) beta(2)+beta(3)*sin(beta(4)+Tinp);

funCell = {funx, funz};
outCell = {RotCalib1.x, RotCalib1.z};
inCell = {Tinp, Tinp};
beta0 = [600,100 100, 0.5];

beta = nlinmultifit(inCell,outCell,funCell,beta0)
%% Inputs
RotCalib2 = struct;
RotCalib2.x = [941 918 889 858 826 795 767 734 703 671 643];
RotCalib2.z = [1159 1167 1184 1200 1215 1230 1242 1255 1267 1275 1285];
RotCalib2.theta = pi*[0:1.5:15]/180;


%% Global fitting of axis parameters
Tinp = RotCalib2.theta;
funx = @(beta,Tinp) beta(1)+beta(3)*cos(beta(4)+Tinp);
funz = @(beta,Tinp) beta(2)+beta(3)*sin(beta(4)+Tinp);

funCell = {funx, funz};
outCell = {RotCalib2.x, RotCalib2.z};
inCell = {Tinp, Tinp};
beta0 = [600,100 100, 0.5];

beta = nlinmultifit(inCell,outCell,funCell,beta0)


%% Inputs
RotCalib3 = struct;
RotCalib3.x = [813 783 749 710 679 642 591 546 500];
RotCalib3.z = [747 757 783 809 823 856 875 898 909];
RotCalib3.theta = [2 4.5 7.5 10.5 12.5 15.5 16.5 19.5 22.5];


%% Global fitting of axis parameters
Tinp = RotCalib3.theta;
funx = @(beta,Tinp) beta(1)+beta(3)*cos(beta(4)+Tinp);
funz = @(beta,Tinp) beta(2)+beta(3)*sin(beta(4)+Tinp);

funCell = {funx, funz};
outCell = {RotCalib3.x, RotCalib3.z};
inCell = {Tinp, Tinp};
beta0 = [600,100 100, 0.5];

beta = nlinmultifit(inCell,outCell,funCell,beta0)
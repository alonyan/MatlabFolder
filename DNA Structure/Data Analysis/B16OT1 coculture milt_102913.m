%B16 OT1 coculture + Miltenyi 102913
%All B16 pulsed with 100nM Ova before coculture with 10e5 OT1 T cells per
%well.
%A = 10e5 B16 per well
%B = 10e4 B16 per well
%C = 10e3 B16 per well

%%

MHC_A=[141 496 1061 1244 1262
       149 557 1116 1061 1528]; MHCma=mean(MHC_A); MHCsa=std(MHC_A);
MHC_B=[120 440 699 1192 1161
       156 396 869 270  1185]; MHCmb=mean(MHC_B); MHCsb=std(MHC_B);
MHC_C=[151 186 402 288 225
       174 214 288 759 790]; MHCmc=mean(MHC_C); MHCsc=std(MHC_C);

MHC_AU=[95.2 79.1 93.1 71.6 127
        97.2 79.1 103  77.7 137]; MHCmau=mean(MHC_AU); MHCsau=std(MHC_AU);
MHC_BU=[132 85.4 73.4 64.2 97.5
        137 83.8 83   66.8 127]; MHCmbu=mean(MHC_BU); MHCsbu=std(MHC_BU);
MHC_CU=[250 107 173 77.6 91.6
        310 126 104 94   68.6]; MHCmcu=mean(MHC_CU); MHCscu=std(MHC_CU);

time=[5.5 17.5 24 48 72];

figure()
hold on
errorbar(time, MHCma, MHCsa, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
errorbar(time, MHCmb, MHCsb, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
errorbar(time, MHCmc, MHCsc, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 10)
errorbar(time, MHCmau, MHCsau, '--ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
errorbar(time, MHCmbu, MHCsbu, '--ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
errorbar(time, MHCmcu, MHCscu, '--ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 10)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 20, 'yscale', 'log', 'xgrid', 'on', 'ygrid', 'on')
xlabel('Time, (hours)')
ylabel('log H-2K^b')
legend('10e5 B16+100nM Ova', '10e4 B16', '10e3 B16', '10e5 B16 Unpulsed', '10e4 B16', '10e3 B16')
title('MHC Expression for different number of B16')
box on

%%
CD25_A=[88.5 96.7 97.6 99.1 99.3
        93   98.6 96.9 98.3 97.1]; CD25ma=mean(CD25_A); CD25sa=std(CD25_A);
CD25_B=[42.9 60.7 86.2 75.5 50
        47.5 60.9 63.3 68.8 45.3]; CD25mb=mean(CD25_B); CD25sb=std(CD25_B);
CD25_C=[7.7  7.73 15.5 5.22 5.7
        6.87 7.73 9.36 3.49 4.22]; CD25mc=mean(CD25_C); CD25sc=std(CD25_C);

CD25_AU=[2.07 2.47 2.9  12.2 21.5
         1.89 1.37 2.65 13.7 9.28]; CD25mau=mean(CD25_AU); CD25sau=std(CD25_AU);
CD25_BU=[1.49 1.62 1.38 7.18 30.7
         1.75 0.78 1.81 4    18.8]; CD25mbu=mean(CD25_BU); CD25sbu=std(CD25_BU);
CD25_CU=[1.77 0.799 0.952 6.91 9.7
         1.83 0.693 0.51  5.53 5.37]; CD25mcu=mean(CD25_CU); CD25scu=std(CD25_CU);

time=[5.5 17.5 24 48 72];

figure()
hold on
errorbar(time, CD25ma, CD25sa, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
errorbar(time, CD25mb, CD25sb, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
errorbar(time, CD25mc, CD25sc, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 10)
errorbar(time, CD25mau, CD25sau, '--ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
errorbar(time, CD25mbu, CD25sbu, '--ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
errorbar(time, CD25mcu, CD25scu, '--ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 10)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 20, 'xgrid', 'on', 'ygrid', 'on')
xlabel('Time, (hours)')
ylabel('%CD25+')
title('% CD25+ for different number of B16')
box on


%%
G_A=[1.65 10.5 46.5 55.4 14.6
     2.3  12.2 53.8 29.9 11.7]; Gma=mean(G_A); Gsa=std(G_A);
G_B=[1.55 7.19 21.7 0.0763 0.03
     1.84 5.62 11.8 0.11   0.0418]; Gmb=mean(G_B); Gsb=std(G_B);
G_C=[1.08 2.02  2.28 1.39 0
     0.62 0.494 1.17 1.2  0.781]; Gmc=mean(G_C); Gsc=std(G_C);

G_AU=[1.49 0     1.2   3.45 4.41
      1.35 1.44  0.543 5    3.23]; Gmau=mean(G_AU); Gsau=std(G_AU);
G_BU=[1.84 0 3.61 9.3  4.88
      2.44 0 2.83 5.56 4.76]; Gmbu=mean(G_BU); Gsbu=std(G_BU);
G_CU=[3.3  0    0 14.3 15.4
      2.22 2.78 0 6.52 0]; Gmcu=mean(G_CU); Gscu=std(G_CU);

time=[5.5 17.5 24 48 72];

figure()
hold on
errorbar(time, Gma, Gsa, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
errorbar(time, Gmb, Gsb, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
errorbar(time, Gmc, Gsc, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 10)
errorbar(time, Gmau, Gsau, '--ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
errorbar(time, Gmbu, Gsbu, '--ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
errorbar(time, Gmcu, Gscu, '--ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 10)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 20, 'xgrid', 'on', 'ygrid', 'on', 'ylim', [0 70])
xlabel('Time, (hours)')
ylabel('%IFN-\gamma+')
title('%Producing IFN-\gamma of activated')
box on

%%
Gn_A=[499 515  10189 9263 4418
      450 1926 10807 3123 2357]; Gnma=mean(Gn_A); Gnsa=std(Gn_A); Producers_A=trapz(Gnma);
  
Gn_B=[159 382 3442 30  21 
      174 693 1522 104 23]; Gnmb=mean(Gn_B); Gnsb=std(Gn_B); Producers_B=trapz(Gnmb);
  
Gn_C=[21 8 54 2 0
      12 7 17 3 3]; Gnmc=mean(Gn_C); Gnsc=std(Gn_C); Producers_C=trapz(Gnmc);

Gn_AU=[6 0 2 1 3
       8 2 1 2 1]; Gnmau=mean(Gn_AU); Gnsau=std(Gn_AU); Producers_AU=trapz(Gnmau);
Gn_BU=[4 0 3 4 4
       9 0 3 2 1]; Gnmbu=mean(Gn_BU); Gnsbu=std(Gn_BU); Producers_BU=trapz(Gnsbu);
Gn_CU=[11 0 0 4 2
       10 2 0 3 0]; Gnmcu=mean(Gn_CU); Gnscu=std(Gn_CU); Producers_CU=trapz(Gnscu);

   
Producers=[Producers_A, Producers_B, Producers_C];
Producers_Unp=[Producers_AU, Producers_BU, Producers_CU];

time=[5.5 17.5 24 48 72];
B16=[10e5 10e4 10e3];

figure()
hold on
errorbar(time, Gnma, Gnsa, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
errorbar(time, Gnmb, Gnsb, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
errorbar(time, Gnmc, Gnsc, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 10)
errorbar(time, Gnmau, Gnsau, '--ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
errorbar(time, Gnmbu, Gnsbu, '--ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
errorbar(time, Gnmcu, Gnscu, '--ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 10)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 20, 'xgrid', 'on', 'ygrid', 'on', 'yscale', 'log', 'ylim', [1 10e4])
xlabel('Time, (hours)')
ylabel('No. IFN-\gamma+')
title('Absolute no. producing IFN-\gamma')
box on

figure()
hold on
plot(B16, Producers, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'k', 'markersize', 10)
plot(B16, Producers_Unp, '--ko', 'markeredgecolor', 'k', 'markerfacecolor', 'k', 'markersize', 10)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 20, 'xgrid', 'on', 'ygrid', 'on', 'yscale', 'log', 'xscale', 'log')
xlabel('log B16 cells')
ylabel('\int IFN-\gamma producers')
legend('100nM Ova', 'Unpulsed')
title('\int IFN-\gamma producers over time')
box on

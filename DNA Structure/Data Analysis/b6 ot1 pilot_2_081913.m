%B6 OT-1 IFN-g pilot stain/facs #2.  

%percent CD69+ varying only number of T cells and antigen quantity (no addition of exog. IFN-gamma)  

N1P1=[57.2 62 54.8 36.5 36.5]; 
N1P2=[46.3 57.4 52.4 33.5 31.5];
N1P3=[45.5 52.1 52.6 29.9 30.7]; 

N2P1=[26.1 23.7 15.7 11.5 18.4]; 
N2P2=[23 23.3 18.6 10.5 19.2]; 
N2P3=[26.8 21.7 18.6 11.2 28.8]; 

N3P1=[18.8 15.2 10.2 7.9 11.8]; 
N3P2=[17.5 13.5 12.3 7.69 10.9]; 
N3P3=[19.3 14 13.7 9.76 11.7]; 

t=[9 17 25 32.5 41];

figure()
subplot(2,3,1)
hold on
plot(t, N1P1, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
plot(t, N2P1, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
plot(t, N3P1, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 10)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 20, 'ygrid', 'on', 'xgrid', 'on')
xlabel('Time, (hours)')
ylabel('%CD69+')
legend('10e5 OT-1', '10e4 OT-1', '10e3 OT-1')
title('100nM OVA')
box on
subplot(2,3,2)
hold on
plot(t, N1P2, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
plot(t, N2P2, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
plot(t, N3P2, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 10)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 20, 'ylim', [0 70], 'ygrid', 'on', 'xgrid', 'on')
xlabel('Time, (hours)')
ylabel('%CD69+')
title('10nM OVA')
box on
subplot(2,3,3)
hold on
plot(t, N1P3, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
plot(t, N2P3, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
plot(t, N3P3, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 10)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 20, 'ylim', [0 70], 'xgrid', 'on', 'ygrid', 'on')
xlabel('Time, (hours)')
ylabel('%CD69+')
title('1nM OVA')
box on
subplot(2,3,4)
hold on
plot(t, N1P1, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
plot(t, N1P2, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
plot(t, N1P3, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 10)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 20, 'ygrid', 'on', 'xgrid', 'on', 'ylim', [0 70])
xlabel('Time, (hours)')
ylabel('%CD69+')
legend('100nM OVA', '10nM OVA', '1nM OVA')
title('10e5 OT-1')
box on
subplot(2,3,5)
hold on
plot(t, N2P1, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
plot(t, N2P2, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
plot(t, N2P3, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 10)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 20, 'ygrid', 'on', 'xgrid', 'on', 'ylim', [0 70])
xlabel('Time, (hours)')
ylabel('%CD69+')
title('10e4 OT-1')
box on
subplot(2,3,6)
hold on
plot(t, N3P1, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
plot(t, N3P2, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
plot(t, N3P3, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 10)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 20, 'ygrid', 'on', 'xgrid', 'on', 'ylim', [0 70])
xlabel('Time, (hours)')
ylabel('%CD69+')
title('10e3 OT-1')
box on

%%
% Added exogenous IFN-gamma at T0.  H-2Kb MFI
%plot CD69+ of CD8+ for +/- addition of exogenous IFN-gamma.
P1_gamma1=[48.2 53.2 53.1 35.1 47.3];
P2_gamma1=[47.3 51.9 54.5 28.8 33];
P3_gamma1=[51.1 60.9 58.1 37 41.9];

P1_gamma2=[46.4 55 58.6 27.9 41.6];
P2_gamma2=[47.4 54.2 58.6 26.5 34.6];
P3_gamma2=[53.1 59.9 61.1 40.8 42.9];

%plot gamma 1 (10nM)
figure()
subplot(2,3,1)
hold on
plot(t, P1_gamma1, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
plot(t, N1P1, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
set(gca, 'Fontsize', 20, 'xgrid', 'on', 'ygrid', 'on', 'ylim', [20 70])
set(gcf, 'color', 'w')
ylabel('%CD69+')
xlabel('Time, (hours)')
box on
title('100nM OVA - 10nM gamma')
legend('+IFN-g', 'Endog')
subplot(2,3,2)
hold on
plot(t, P2_gamma1, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
plot(t, N1P2, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
set(gca, 'Fontsize', 20, 'xgrid', 'on', 'ygrid', 'on', 'ylim', [20 70])
set(gcf, 'color', 'w')
ylabel('%CD69+')
xlabel('Time, (hours)')
box on
title('10nM OVA - 10nM gamma')
subplot(2,3,3)
hold on
plot(t, P3_gamma1, '-ko','markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
plot(t, N1P3, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
set(gca, 'Fontsize', 20, 'xgrid', 'on', 'ygrid', 'on', 'ylim', [20 70])
set(gcf, 'color', 'w')
ylabel('%CD69+')
xlabel('Time, (hours)')
box on
title('1nM OVA - 10nM gamma')
%plot gamma 2 (1nM)
subplot(2,3,4)
hold on
plot(t, P1_gamma2, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
plot(t, N1P1, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
set(gca, 'Fontsize', 20, 'ylim', [20 70], 'xgrid', 'on', 'ygrid', 'on')
set(gcf, 'color', 'w')
ylabel('%CD69+')
xlabel('Time, (hours)')
box on
title('100nM OVA - 1nM gamma')
legend('+IFN-g', 'Endog')
subplot(2,3,5)
hold on
plot(t, P2_gamma2, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
plot(t, N1P2, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
set(gca, 'Fontsize', 20, 'ylim', [20 70], 'xgrid', 'on', 'ygrid', 'on')
set(gcf, 'color', 'w')
ylabel('%CD69+')
xlabel('Time, (hours)')
box on
title('10nM OVA - 1nM gamma')
subplot(2,3,6)
hold on
plot(t, P3_gamma2, '-ko','markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
plot(t, N1P3, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
set(gca, 'Fontsize', 20, 'ylim', [20 70], 'xgrid', 'on', 'ygrid', 'on')
set(gcf, 'color', 'w')
ylabel('%CD69+')
xlabel('Time, (hours)')
box on
title('1nM OVA - 1nM gamma')

%%

%pSTAT5 GMFI for CD69+ CD8 T cells and H-2Kb+ cells (APCs) 

N1P1=[169 72.3
192	82.4
248	69.5
269	55.6
279	73.8]; 

N1P2=[150 58.4
184	73.9
234	63.3
263	53.1
258	69.4];

N1P3=[152 61.5
167	68.5
237	68.1
260	53
255	66.2]; 

N2P1=[132 68.5
146	71.2
207	74.4
209	49.5
235	69.6];

N2P2=[124 68
137	69.8
183	71.2
182	50.7
249	72]; 

N2P3=[124 65.4
134	64
153	66.9
182	48.9
253	73.4]; 

N3P1=[107 54
110	52.2
137	56.1
146	46
153	65.2]; 

N3P2=[105 53.4
104	53.4
132	58.5
164	44.4
117	44.9]; 

N3P3=[96.4 53.4
122	52.8
123	50.8
132	46
132	47.6]; 

t=[9 17 25 32.5 41];

figure()
subplot(2,3,1)
hold on
plot(t, N1P1, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
plot(t, N2P1, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
plot(t, N3P1, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 10)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 20, 'ygrid', 'on', 'xgrid', 'on')
xlabel('Time, (hours)')
ylabel('pSTAT5 GMFI')
legend('10e5 OT-1', '10e5 OT-1', '10e4 OT-1', '10e4 OT-1', '10e3 OT-1', '10e3 OT-1')
title('100nM OVA')
box on
subplot(2,3,2)
hold on
plot(t, N1P2, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
plot(t, N2P2, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
plot(t, N3P2, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 10)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 20, 'ygrid', 'on', 'xgrid', 'on')
xlabel('Time, (hours)')
ylabel('pSTAT5 GMFI')
title('10nM OVA')
box on
subplot(2,3,3)
hold on
plot(t, N1P3, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
plot(t, N2P3, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
plot(t, N3P3, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 10)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 20, 'xgrid', 'on', 'ygrid', 'on')
xlabel('Time, (hours)')
ylabel('pSTAT5 GMFI')
title('1nM OVA')
box on
subplot(2,3,4)
hold on
plot(t, N1P1, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
plot(t, N1P2, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
plot(t, N1P3, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 10)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 20, 'ygrid', 'on', 'xgrid', 'on')
xlabel('Time, (hours)')
ylabel('pSTAT5 GMFI')
legend('100nM OVA','100nM OVA', '10nM OVA','10nM OVA', '1nM OVA', '1nM OVA')
title('10e5 OT-1')
box on
subplot(2,3,5)
hold on
plot(t, N2P1, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
plot(t, N2P2, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
plot(t, N2P3, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 10)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 20, 'ygrid', 'on', 'xgrid', 'on')
xlabel('Time, (hours)')
ylabel('pSTAT5 GMFI')
title('10e4 OT-1')
box on
subplot(2,3,6)
hold on
plot(t, N3P1, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
plot(t, N3P2, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
plot(t, N3P3, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 10)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 20, 'ygrid', 'on', 'xgrid', 'on', 'ylim', [0 300])
xlabel('Time, (hours)')
ylabel('pSTAT5 GMFI')
title('10e3 OT-1')
box on

%%
% Added exogenous IFN-gamma at T0.  H-2Kb MFI
%plot pSTAT5 GMFI of CD8+ or APCs for +/- addition of exogenous IFN-gamma.
P1_gamma1=[128 56.5
189	70.9
224	64.5
221	53.9
280	67.7];

P2_gamma1=[135 58.3
162	73.7
230	68.9
231	52.2
268	63.8];

P3_gamma1=[149 63
189	74.7
231	68.9
245	55.9
255	66.5];

P1_gamma2=[118 55.1
178	71.1
229	64.9
223	53.8
262	72.5];

P2_gamma2=[130 58.3
157	73.3
231	68.3
228	52.1
277	66.4];

P3_gamma2=[155	66.7
190	74.7
245	76.2
242	56.5
258	68.1];

%plot gamma 1 (10nM)
figure()
subplot(2,3,1)
hold on
plot(t, P1_gamma1, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
plot(t, N1P1, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
set(gca, 'Fontsize', 20, 'xgrid', 'on', 'ygrid', 'on')
set(gcf, 'color', 'w')
ylabel('pSTAT5 GMFI')
xlabel('Time, (hours)')
box on
title('100nM OVA - 10nM gamma')
legend('+IFN-g','+IFN-g', 'Endog', 'Endog')
subplot(2,3,2)
hold on
plot(t, P2_gamma1, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
plot(t, N1P2, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
set(gca, 'Fontsize', 20, 'xgrid', 'on', 'ygrid', 'on')
set(gcf, 'color', 'w')
ylabel('pSTAT5 GMFI')
xlabel('Time, (hours)')
box on
title('10nM OVA - 10nM gamma')
subplot(2,3,3)
hold on
plot(t, P3_gamma1, '-ko','markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
plot(t, N1P3, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
set(gca, 'Fontsize', 20, 'xgrid', 'on', 'ygrid', 'on')
set(gcf, 'color', 'w')
ylabel('pSTAT5 GMFI')
xlabel('Time, (hours)')
box on
title('1nM OVA - 10nM gamma')
%plot gamma 2 (1nM)
subplot(2,3,4)
hold on
plot(t, P1_gamma2, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
plot(t, N1P1, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
set(gca, 'Fontsize', 20, 'xgrid', 'on', 'ygrid', 'on')
set(gcf, 'color', 'w')
ylabel('pSTAT5 GMFI')
xlabel('Time, (hours)')
box on
title('100nM OVA - 1nM gamma')
subplot(2,3,5)
hold on
plot(t, P2_gamma2, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
plot(t, N1P2, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
set(gca, 'Fontsize', 20, 'xgrid', 'on', 'ygrid', 'on')
set(gcf, 'color', 'w')
ylabel('pSTAT5 GMFI')
xlabel('Time, (hours)')
box on
title('10nM OVA - 1nM gamma')
subplot(2,3,6)
hold on
plot(t, P3_gamma2, '-ko','markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
plot(t, N1P3, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
set(gca, 'Fontsize', 20, 'xgrid', 'on', 'ygrid', 'on')
set(gcf, 'color', 'w')
ylabel('pSTAT5 GMFI')
xlabel('Time, (hours)')
box on
title('1nM OVA - 1nM gamma')




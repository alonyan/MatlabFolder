%Rework of 10232011 (rotation)

%24 hrs
%pSTAT5 response to IL2
%A=1ug
%B=10ug
%C=100ug

A=[369
260
182
58.7
52.1
23.1
57.3
104];

B=[333
403
234
87.6
54.3
37.6
35
78.1];

C=[668
555
268
83.8
64.6
87.9
65.7
77.3];

IL2=[10000 1000 100 10 1 0.1 0.01 0];

A1=[197
148
144
124
127
127
121
115];

B1=[664
227
127
91.5
87.5
95.2
119
130];

C1=[298
197
121
76.7
50.3
68.4
66.4
51.1];

figure()
subplot(2,1,1)
hold on
plot(IL2, A, '-ro', 'linewidth', 2)
plot(IL2, B, '-bo' ,'linewidth', 2)
plot(IL2, C, '-yo', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'xscale', 'log')
ylabel('GMFI pSTAT5')
xlabel('[IL2],(pM)')
title('pSTAT5 responses to IL2 at 24 hrs')
legend('1ug K5', '10ug K5', '100ug K5')
box on
subplot(2,1,2)
hold on
plot(IL2, A1, '-ro', 'linewidth', 2)
plot(IL2, B1, '-bo' ,'linewidth', 2)
plot(IL2, C1, '-yo', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'xscale', 'log')
ylabel('GMFI pSTAT5')
xlabel('[IL2],(pM)')
title('pSTAT5 responses to IL2 at 48 hrs')
legend('1ug K5', '10ug K5', '100ug K5')
box on

%%


%Treg analysis from rotation expt. 11/14/2011

%100ug K5
A=[425
371
392
336
257
200
187];
A=A-min(A)


B=[376
380
357
327
173
109
93.1];
B=B-min(B)

C=[485
429
452
364
244
198
190];
C=C-min(C)

IL2=[10000 1000 100 10 1 0.1 0];

figure()
hold on
plot(IL2, A, '-ro', 'linewidth', 2)
plot(IL2, B, '-bo', 'linewidth', 2)
plot(IL2, C, '-yo', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'xscale', 'log', 'Fontsize', 16, 'Fontweight', 'bold')
ylabel('GMFI pSTAT5 endog. Tregs')
xlabel('[IL2], (pM)')
title('pSTAT5 response to IL2 for 100ug K5')
legend('12 hrs', '24 hrs', '36 hrs')
box on
%%

%10ug K5

A=[434
366
338
325
224
251
293];
A=A-min(A)

B=[344
314
297
287
150
119
107];
B=B-min(B)


C=[466
432
465
406
310
208
280];
C=C-min(C)

IL2=[10000 1000 100 10 1 0.1 0];

figure()
hold on
plot(IL2, A, '-ro', 'linewidth', 2)
plot(IL2, B, '-bo', 'linewidth', 2)
plot(IL2, C, '-yo', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'xscale', 'log', 'Fontsize', 16, 'Fontweight', 'bold')
ylabel('GMFI pSTAT5 endog. Tregs')
xlabel('[IL2], (pM)')
title('pSTAT5 response to IL2 for 10ug K5')
legend('12 hrs', '24 hrs', '36 hrs')
box on

%%

%1ug K5

A=[445
406
318
291
202
237
191];
A=A-min(A)

B=[461
308
325
352
191
110
135];
B=B-min(B)


C=[483
445
502
436
351
275
317];
C=C-min(C)


IL2=[10000 1000 100 10 1 0.1 0];

figure()
hold on
plot(IL2, A, '-ro', 'linewidth', 2)
plot(IL2, B, '-bo', 'linewidth', 2)
plot(IL2, C, '-yo', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'xscale', 'log', 'Fontsize', 16, 'Fontweight', 'bold')
ylabel('GMFI pSTAT5 endog. Tregs')
xlabel('[IL2], (pM)')
title('pSTAT5 response to IL2 for 1ug K5')
legend('12 hrs', '24 hrs', '36 hrs')
box on

%%

%Teff analysis from 11.14.2011

%Percent CD25hi at different timepoints
%A=1ug
%B=10ug
%C=100ug

A=[53.5
62.6
55.6];

B=[90.8
81.9
61.1];

C=[95.9
96
72.6];

Time=[12 24 36];

figure()
hold on
plot(Time, A, '-ro', 'linewidth', 2)
plot(Time, B, '-bo', 'linewidth', 2)
plot(Time, C, '-yo', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold')
xlabel('Time, (hours)')
ylabel('Percent CD25+ of Adoptively Transferred')
title('Percent CD25+ of AdTr over time')
legend('1ug K5', '10ug K5', '100ug K5')
box on

%%
%1ug K5 A=12, B=24, C=36

A=[200
181
115
62.8
58
71.2
79];
A=A-min(A)

B=[777
477
293
167
106
91.7
119];
B=B-min(B)

C=[581
385
262
177
178
168
256];
C=C-min(C)

IL2=[10000 1000 100 10 1 0.1 0];

figure()
hold on
plot(IL2, A, '-ro', 'linewidth', 2)
plot(IL2, B, '-bo', 'linewidth', 2)
plot(IL2, C, '-yo', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'xscale', 'log', 'Fontsize', 16, 'Fontweight', 'bold')
ylabel('GMFI pSTAT5 Teffs')
xlabel('[IL2], (pM)')
title('pSTAT5 response to IL2 for 1ug K5')
legend('12 hrs', '24 hrs', '36 hrs')
box on

%%

%10ug K5
A=[173
152
206
112
52.3
95
92.7]; 
A=A-min(A)

B=[1016
1072
633
317
158
146
160];
B=B-min(B)

C=[869
685
428
275
254
188
252];
C=C-min(C)

IL2=[10000 1000 100 10 1 0.1 0];

figure()
hold on
plot(IL2, A, '-ro', 'linewidth', 2)
plot(IL2, B, '-bo', 'linewidth', 2)
plot(IL2, C, '-yo', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'xscale', 'log', 'Fontsize', 16, 'Fontweight', 'bold')
ylabel('GMFI pSTAT5 Teffs')
xlabel('[IL2], (pM)')
title('pSTAT5 response to IL2 for 10ug K5')
legend('12 hrs', '24 hrs', '36 hrs')
box on


%%

%100ug K5
A=[212
165
214
128
112
98.9
79.6];
A=A-min(A)

B=[818
801
787
466
228
189
197];
B=B-min(B)

C=[1296
887
553
276
203
214
228];
C=C-min(C)

IL2=[10000 1000 100 10 1 0.1 0];

figure()
hold on
plot(IL2, A, '-ro', 'linewidth', 2)
plot(IL2, B, '-bo', 'linewidth', 2)
plot(IL2, C, '-yo', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'xscale', 'log', 'Fontsize', 16, 'Fontweight', 'bold')
ylabel('GMFI pSTAT5 Teffs')
xlabel('[IL2], (pM)')
title('pSTAT5 response to IL2 for 100ug K5')
legend('12 hrs', '24 hrs', '36 hrs')
box on

%%

%12 hours
%A=1ug
%B=10ug
%C=100ug

A=[200
181
115
62.8
58
71.2
79];
A=A-min(A);

AmpA=max(A)-min(A)

B=[173
152
206
112
52.3
95
92.7]; 
B=B-min(B);

AmpB=max(B)-min(B)

C=[212
165
214
128
112
98.9
79.6];
C=C-min(C);

AmpC=max(C)-min(C)

IL2=[10000 1000 100 10 1 0.1 0];

Peptide=[1 10 100];

figure()
hold on
plot(IL2, A, '-ro', 'linewidth', 2)
plot(IL2, B, '-bo', 'linewidth', 2)
plot(IL2, C, '-yo', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'xscale', 'log', 'Fontsize', 16, 'Fontweight', 'bold')
ylabel('GMFI pSTAT5 Teffs')
xlabel('[IL2], (pM)')
title('pSTAT5 response to IL2 at 12 hours')
legend('1ug K5', '10ug K5', '100ug K5')
box on


%%

%24 hours

A=[461
308
325
352
191
110
135];
A=A-min(A);
AmpA=max(A)-min(A)

B=[1016
1072
633
317
158
146
160];
B=B-min(B);
AmpB=max(B)-min(B)

C=[818
801
787
466
228
189
197];
C=C-min(C);
AmpC=max(C)-min(C)

IL2=[10000 1000 100 10 1 0.1 0];

figure()
hold on
plot(IL2, A, '-ro', 'linewidth', 2)
plot(IL2, B, '-bo', 'linewidth', 2)
plot(IL2, C, '-yo', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'xscale', 'log', 'Fontsize', 16, 'Fontweight', 'bold')
ylabel('GMFI pSTAT5 Teffs')
xlabel('[IL2], (pM)')
title('pSTAT5 response to IL2 at 24 hours')
legend('1ug K5', '10ug K5', '100ug K5')
box on

%%
%36 hours

A=[581
385
262
177
178
168
256];
A=A-min(A);
AmpA=max(A)-min(A)

B=[869
685
428
275
254
188
252];
B=B-min(B);
AmpB=max(B)-min(B)

C=[1296
887
553
276
203
214
228];
C=C-min(C);
AmpC=max(C)-min(C)

IL2=[10000 1000 100 10 1 0.1 0];

figure()
hold on
plot(IL2, A, '-ro', 'linewidth', 2)
plot(IL2, B, '-bo', 'linewidth', 2)
plot(IL2, C, '-yo', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'xscale', 'log', 'Fontsize', 16, 'Fontweight', 'bold')
ylabel('GMFI pSTAT5 Teffs')
xlabel('[IL2], (pM)')
title('pSTAT5 response to IL2 at 36 hours')
legend('1ug K5', '10ug K5', '100ug K5')
box on

%%

%pSTAT5 response of Teffs over time

Oneug=[222
308
206];

Tenug=[79.7
227
219];

Hundredug=[141
325
271];

Time=[12 24 36];

figure()
hold on
plot(Time, Oneug, '-ro', 'linewidth', 2)
plot(Time, Tenug, '-bo', 'linewidth', 2)
plot(Time, Hundredug, '-yo', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold')
ylabel('pSTAT5 GeoMFI')
xlabel('Time, (hours)')
title('Instantaneous pSTAT5 of AdTr cells over time')
legend('1ug K5', '10ug K5', '100ug K5')
box on

%%

%Teff amplitude of pSTAT5 response to IL2 

Oneug=[142 351 413];

Tenug=[153.7000 926 681];

Hundredug=[134.4000 629 1093];

Time=[12 24 36];

figure()
hold on
plot(Time, Oneug, '-ro', 'linewidth', 2)
plot(Time, Tenug, '-bo', 'linewidth', 2)
plot(Time, Hundredug, '-yo', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold')
ylabel('Amplitude pSTAT5 response to IL2')
xlabel('Time, (hours)')
title('Amplitude pSTAT5 response to IL2 over time')
legend('1ug K5', '10ug K5', '100ug K5')
box on

%%

%IL2 estimation for 10ug 24 hours from Teff fit

T=929;
B=11.69;
E=77.54;

x=224;

IL2=(x-B)./(T-x).*E

%%

%IL2 estimation for 100ug 24 hours from Teff fit

T=643.3;
B=7.670;
E=11.9;

x=325;

IL2=(x-B)./(T-x).*E

%%

%IL2 estimation for 10ug 36 hours from Teff fit

T=792.2;
B=15.63;
E=448.5;

x=219;

IL2=(x-B)./(T-x).*E





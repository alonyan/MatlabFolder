%24 hours rework of 11142011

%24 hours
%A=1ug
%B=10ug
%C=100ug

ApSTAT5=[1242
662
723
341
189
123
116];
A=ApSTAT5-min(ApSTAT5)


BpSTAT5=[1206
1229
1001
432
114
75.5
117];
B=BpSTAT5-min(BpSTAT5)
B1=94.5-min(BpSTAT5)

CpSTAT5=[1051
1229
1167
725
197
120
167];
C=CpSTAT5-min(CpSTAT5)
C1=84.8-min(CpSTAT5)

IL2=[10000 1000 100 10 1 0.1 0];

figure()
hold on
plot(IL2, ApSTAT5, '-ro', 'linewidth', 2)
plot([0.1, max(IL2)], [220 220], '--ro', 'linewidth', 2)
plot(IL2, BpSTAT5, '-bo', 'linewidth', 2)
plot([0.1, max(IL2)], [94.5 94.5], '--bo', 'linewidth', 2)
plot(IL2, CpSTAT5, '-yo', 'linewidth', 2)
plot([0.1, max(IL2)], [84.8 84.8], '--yo', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'xscale', 'log')
xlabel('[IL2], (pM)')
ylabel('GMFI pSTAT5')
legend('1ug K5', '1ug Snapshot', '10ug K5', '10ug Snapshot', '100ug K5', '100ug Snapshot')
box on
title('pSTAT5 response to IL2 at 24 hours')

%%

%36 hours
%A=1ug
%B=10ug
%C=100ug

ApSTAT5=[909
698
417
424
151
92.2
143];

BpSTAT5=[1757
1507
1468
536
191
141
149];

CpSTAT5=[2094
1612
1180
570
208
169
179];

IL2=[10000 1000 100 10 1 0.1 0];

figure()
hold on
plot(IL2, ApSTAT5, '-ro', 'linewidth', 2)
plot([0.1, max(IL2)], [322 322], '--ro', 'linewidth', 2)
plot(IL2, BpSTAT5, '-bo', 'linewidth', 2)
plot([0.1, max(IL2)], [125 125], '--bo', 'linewidth', 2)
plot(IL2, CpSTAT5, '-yo', 'linewidth', 2)
plot([0.1, max(IL2)], [205 205], '--yo', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'xscale', 'log')
xlabel('[IL2], (pM)')
ylabel('GMFI pSTAT5')
legend('1ug K5', '1ug Snapshot', '10ug K5', '10ug Snapshot', '100ug K5', '100ug Snapshot')
box on
title('pSTAT5 response to IL2 at 36 hours')

%%

%Treg analysis

%12 hours
%A=1ug
%B=10ug
%C=100ug

ApSTAT5=[305
272
235
217
105
111
62.3];
A=ApSTAT5-min(ApSTAT5)
A1=205-min(ApSTAT5)

BpSTAT5=[264
259
252
237
102
103
118];
B=BpSTAT5-min(BpSTAT5)
B1=126-min(BpSTAT5)

CpSTAT5=[437
324
402
299
185
113
106];
C=CpSTAT5-min(CpSTAT5)
C1=170-min(CpSTAT5)

IL2=[10000 1000 100 10 1 0.1 0];

figure()
hold on
plot(IL2, ApSTAT5, '-ro', 'linewidth', 2)
plot([0.1, max(IL2)], [205 205], '--ro', 'linewidth', 2)
plot(IL2, BpSTAT5, '-bo', 'linewidth', 2)
plot([0.1, max(IL2)], [126 126], '--bo', 'linewidth', 2)
plot(IL2, CpSTAT5, '-yo', 'linewidth', 2)
plot([0.1, max(IL2)], [170 170], '--yo', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'xscale', 'log')
xlabel('[IL2], (pM)')
ylabel('GMFI pSTAT5')
legend('1ug K5', '1ug Snapshot', '10ug K5', '10ug Snapshot', '100ug K5', '100ug Snapshot')
box on
title('pSTAT5 response to IL2 at 12 hours Tregs')

%%
%Treg analysis

%24 hours
%A=1ug
%B=10ug
%C=100ug

ApSTAT5=[480
322
316
328
128
53.7
75.9];
A=ApSTAT5-min(ApSTAT5)
A1=200-min(ApSTAT5)

BpSTAT5=[341
311
282
263
95.1
54.8
52.1];
B=BpSTAT5-min(BpSTAT5)
B1=145-min(BpSTAT5)

CpSTAT5=[420
435
403
368
160
79.4
67.4];
C=CpSTAT5-min(CpSTAT5)
C1=142-min(CpSTAT5)

IL2=[10000 1000 100 10 1 0.1 0];

figure()
hold on
plot(IL2, ApSTAT5, '-ro', 'linewidth', 2)
plot([0.1, max(IL2)], [200 200], '--ro', 'linewidth', 2)
plot(IL2, BpSTAT5, '-bo', 'linewidth', 2)
plot([0.1, max(IL2)], [145 145], '--bo', 'linewidth', 2)
plot(IL2, CpSTAT5, '-yo', 'linewidth', 2)
plot([0.1, max(IL2)], [142 142], '--yo', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'xscale', 'log')
xlabel('[IL2], (pM)')
ylabel('GMFI pSTAT5')
legend('1ug K5', '1ug Snapshot', '10ug K5', '10ug Snapshot', '100ug K5', '100ug Snapshot')
box on
title('pSTAT5 response to IL2 at 24 hours Tregs')

%%

%Treg analysis

%36 hours
%A=1ug
%B=10ug
%C=100ug

ApSTAT5=[352
404
339
314
133
92.1
177];
A=ApSTAT5-min(ApSTAT5)
A1=123-min(ApSTAT5)

BpSTAT5=[436
367
389
302
123
75.7
95.2];
B=BpSTAT5-min(BpSTAT5)
B1=132-min(BpSTAT5)

CpSTAT5=[469
374
378
296
140
85.1
90.4];
C=CpSTAT5-min(CpSTAT5)
C1=140-min(CpSTAT5)

IL2=[10000 1000 100 10 1 0.1 0];

figure()
hold on
plot(IL2, ApSTAT5, '-ro', 'linewidth', 2)
plot([0.1, max(IL2)], [123 123], '--ro', 'linewidth', 2)
plot(IL2, BpSTAT5, '-bo', 'linewidth', 2)
plot([0.1, max(IL2)], [132 132], '--bo', 'linewidth', 2)
plot(IL2, CpSTAT5, '-yo', 'linewidth', 2)
plot([0.1, max(IL2)], [140 140], '--yo', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'xscale', 'log')
xlabel('[IL2], (pM)')
ylabel('GMFI pSTAT5')
legend('1ug K5', '1ug Snapshot', '10ug K5', '10ug Snapshot', '100ug K5', '100ug Snapshot')
box on
title('pSTAT5 response to IL2 at 36 hours Tregs')

%%

%12 1 ug
T=248.2;
B=0;
EC50=8.61;

IL212_1=(142.7-B)./(T-142.7).*EC50

T1=324.6;
B1=0;
EC501=2.794;

IL224_1=(146.3-B1)./(T1-146.3).*EC501

T2=274.9;
B2=0;
EC502=3.588;

IL236_1=(30.9-B2)./(T2-30.9).*EC502

IL2_1=[IL212_1, IL224_1, IL236_1];
%%
%12 10 ug
T=156.3;
B=0;
EC50=6.149;

IL212_10=(24-B)./(T-24).*EC50

T1=262;
B1=0;
EC501=3.499;

IL224_10=(92.9-B1)./(T1-92.9).*EC501

T2=325.9;
B2=0;
EC502=4.859;

IL236_10=(56.3-B2)./(T2-56.3).*EC502

IL2_10=[IL212_10, IL224_10, IL236_10];
%%
%12 100 ug
T=286.4;
B=0;
EC50=3.582;

IL212_100=(64-B)./(T-64).*EC50

T1=354.4;
B1=0;
EC501=2.4;

IL224_100=(74.6-B1)./(T1-74.6).*EC501

T2=339.1;
B2=0;
EC502=6.573;

IL236_100=(54.9-B2)./(T2-54.9).*EC502

IL2_100=[IL212_100, IL224_100, IL236_100];
%%

peptide=[1 10 100];
time=[12 24 36];

figure()
hold on
plot(time, IL2_1, '-ro', 'linewidth', 2)
plot(time, IL2_10, '-bo', 'linewidth', 2)
plot(time, IL2_100, '-yo', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold')
ylabel('[IL2], (pM)')
xlabel('Time, hrs')
title('IL2 backcalculated from pSTAT5 in the spleen')
legend('1ug K5', '10ug K5', '100ug K5')
box on






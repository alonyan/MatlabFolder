absorbance=[0.979	0.086	0.731	0.082	0.083	0.097	0.084	0.084	0.627	0.09	0.491	0.09
1.504	0.087	0.999	0.096	0.086	0.09	0.086	0.09	1.289	0.088	0.522	0.096
0.929	0.086	0.28	0.087	0.085	0.093	0.085	0.091	1.291	0.093	0.217	0.125
0.366	0.095	0.126	0.093	0.09	0.098	0.084	0.105	0.613	0.094	0.134	0.116
0.164	0.114	0.094	0.126	0.085	0.102	0.111	0.171	0.28	0.18	0.097	0.104];

T=4.154;
B=0.09828;
E=3.652e-10;

IL2=(absorbance-B)./(T-absorbance).*E;


i_WT_Reg=IL2(:,1:2);
i_WT=IL2(:,3:4);
i_KO_Reg=IL2(:,5:6);
i_KO=IL2(:,7:8);
i_Co_Reg=IL2(:,9:10);
i_Co=IL2(:,11:12);

Time=[24 36 48 57 73];

figure()
subplot(2,1,1)
hold on
plot(Time, i_WT_Reg(:,1), '-o', 'linewidth', 2)
plot(Time, i_WT(:,1), '--o', 'linewidth', 2)
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'yscale', 'log')
set(gcf, 'color', 'w')
xlabel('Time, (hrs)')
ylabel('[IL2], (M)')
box on
title('IL2 accumulation for 5c.c7 cells +/- Tregs')
subplot(2,1,2)
hold on
plot(Time, i_Co_Reg(:,1), '-o', 'linewidth', 2)
plot(Time, i_Co(:,1), '--o', 'linewidth', 2)
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'yscale', 'log')
set(gcf, 'color', 'w')
xlabel('Time, (hrs)')
ylabel('[IL2], (M)')
box on
title('IL2 accumulation for 5c.c7/Tac110 Co-culture +/- Tregs')


%%

%Processing for WT without Tregs hi and lo peptide

%Normalizing cell counts for 60,000 events (lowest number you collected for WT & to account for the fact that I did not keep a uniform collection)
data_norm_NoReg=[4731
5778
6777
10658
23105
5453
6056
7423
6116
5036
];

data_norm_NoReg=(data_norm_NoReg*6e4)./10e4;

data_norm_NoReg=reshape(data_norm_NoReg, 5,2);

hi_noReg=data_norm_NoReg(:,1);
lo_noReg=data_norm_NoReg(:,2);

Time=[24 36 48 57 73];

figure()
hold on
plot(Time, hi_noReg, '-o', 'linewidth', 2)
plot(Time, lo_noReg, '--o', 'linewidth', 2)
set(gca, 'Fontsize', 16, 'Fontweight', 'bold')
set(gcf, 'color', 'w')
xlabel('Time, (hrs)')
ylabel('WT CD4 T cells per 60,000 events')
box on
legend('7.5uM K5', '190pM K5')
title('WT proliferation -Tregs')

WT_hi_NoReg=hi_noReg;
WT_lo_NoReg=lo_noReg;

%%

%Processing for WT with Tregs hi and lo peptide

%Normalizing cell counts for 60,000 events
data_norm_Reg=[3551
3609
4182
3870
6295
10052
11613
7629
6431
5798];

data_norm_Reg=reshape(data_norm_Reg, 5,2);

i_hi=data_norm_Reg(:,1);
i_lo=data_norm_Reg(:,2);

i_lo=(i_lo*6e4)./16e4;

figure()
hold on
plot(Time, i_hi, '-o', 'linewidth', 2)
plot(Time, i_lo, '--o', 'linewidth', 2)
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'ylim', [2000 14000])
set(gcf, 'color', 'w')
xlabel('Time, (hrs)')
ylabel('WT CD4 T cells per 60,000 events')
box on
legend('7.5uM K5', '190pM K5')
title('WT proliferation +Tregs')

WT_hi_Reg=i_hi;
WT_lo_Reg=i_lo;

%%
%Compiled WT figure
figure()
hold on
plot(Time, hi_noReg, '-bo', 'linewidth', 2)
plot(Time, i_hi, '-ro', 'linewidth', 2)
plot(Time, lo_noReg, '--bo', 'linewidth', 2)
plot(Time, i_lo, '--ro', 'linewidth', 2)
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'ylim', [2000 14000])
set(gcf, 'color', 'w')
xlabel('Time, (hrs)')
ylabel('WT CD4 T cells per 60,000 events')
box on
title('WT proliferation +/-Tregs')

%%
%Processing for KO - Tregs 
%Normalizing all to 60,000 collected events (like WT situation) - so that I
%can compare between groups
data_norm_NoReg=[8138
6718
8206
7104
10188
9837
9927
8923
6624
7450];

data_norm_NoReg=reshape(data_norm_NoReg, 5,2);

i_lo_NoReg=data_norm_NoReg(:,2);
i_lo_NoReg=(i_lo_NoReg*6e4)./30e4;

parse_hi_1=[8138 6718 8206 7104];
parse_hi_1=(parse_hi_1*6e4)./30e4;
parse_hi_2=[10188];
parse_hi_2=(parse_hi_2*6e4)./277346;


data_norm_NoReg_2=[1.6276e3 1.3436e3 1.6412e3 1.4208e3 2.204e3 1.9674e3 1.9854e3 1.7846e3 1.3248e3 1.4900e3];

data_norm_NoReg_2=reshape(data_norm_NoReg_2, 5,2);

KO_hi_NoReg=data_norm_NoReg_2(:,1);
KO_lo_NoReg=data_norm_NoReg_2(:,2);

figure()
hold on
plot(Time, KO_hi_NoReg, '-o', 'linewidth', 2)
plot(Time, KO_lo_NoReg, '--o', 'linewidth', 2)
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'ylim', [1000 14000])
set(gcf, 'color', 'w')
xlabel('Time, (hrs)')
ylabel('IL2 KO CD4 T cells per 60,000 events')
box on
title('IL2 KO proliferation -Tregs')


%%
%Processing for KO + Tregs 
%Normalizing all to 60,000 collected events (like WT situation) - so that I
%can compare between groups

data_norm_Reg=[9163
7394
8669
7370
9965
10188
9266
8478
5930
7705
];

data_norm_Reg=reshape(data_norm_Reg, 5,2);

i_lo_Reg=data_norm_Reg(:,2);

parse_hi_1=[9163 7394 8669];
parse_hi_2=[7370 9965];
parse_hi_1=(parse_hi_1*6e4)./40e4;
parse_hi_2=(parse_hi_2*6e4)./30e4;

hi_Reg=[1.3744e3 1.1091e3 1.3003e3 1474 1993];

i_lo_Reg=(i_lo_Reg*6e4)./30e4;

figure()
hold on
plot(Time, hi_Reg, '-o', 'linewidth', 2)
plot(Time, i_lo_Reg, '--o', 'linewidth', 2)
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'ylim', [1000 14000])
set(gcf, 'color', 'w')
xlabel('Time, (hrs)')
ylabel('IL2 KO CD4 T cells per 60,000 events')
box on
title('IL2 KO proliferation +Tregs')

KO_hi_Reg=hi_Reg;
KO_lo_Reg=i_lo_Reg;

%%

%Compiled KO figure

figure()
hold on
plot(Time, KO_hi_NoReg, '-bo', 'linewidth', 2)
plot(Time, hi_Reg, '-ro', 'linewidth', 2)
plot(Time, KO_lo_NoReg, '--bo', 'linewidth', 2)
plot(Time, i_lo_Reg, '--ro', 'linewidth', 2)
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'ylim', [1000 14000])
set(gcf, 'color', 'w')
xlabel('Time, (hrs)')
ylabel('IL2 KO CD4 T cells per 60,000 events')
box on
title('IL2 KO proliferation +/-Tregs')


%%

%comparing WT and KO cells on the same axes

figure()
subplot(2,1,1)
hold on
plot(Time, WT_hi_NoReg, '-bo', 'linewidth', 2)
plot(Time, KO_hi_NoReg, '-ro', 'linewidth', 2)
plot(Time, WT_hi_Reg, '--bo', 'linewidth', 2)
plot(Time, KO_hi_Reg, '--ro', 'linewidth', 2)
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'ylim', [1000 14000])
set(gcf, 'color', 'w')
xlabel('Time, (hrs)')
ylabel('CD4 T cells per 60,000 events')
box on
title('IL2 WT and KO proliferation +/-Tregs for high [antigen]')
subplot(2,1,2)
hold on
plot(Time, WT_lo_NoReg, '-bo', 'linewidth', 2)
plot(Time, KO_lo_NoReg, '-ro', 'linewidth', 2)
plot(Time, WT_lo_Reg, '--bo', 'linewidth', 2)
plot(Time, KO_lo_Reg, '--ro', 'linewidth', 2)
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'ylim', [1000 14000])
set(gcf, 'color', 'w')
xlabel('Time, (hrs)')
ylabel('CD4 T cells per 60,000 events')
box on
title('IL2 WT and KO proliferation +/-Tregs for low [antigen]')

%%
%Processing for Co-cultured cells

(2145*6e4)/109371
(3086*6e4)/180572

Co_NoReg=[2145	1760
5318	5219
3953	6360
5076	11426
9145	22365
5505	5419
8330	7224
6344	5529
6033	5248
3633	3086];

Co_NoReg=(Co_NoReg*6e4)./30e4;

Co_NoReg= [1.1767e3    0.3520e3
    1.0636e3    1.0438e3
    0.7906e3    1.2720e3
    1.0152e3    2.2852e3
    1.8290e3    4.4730e3
    1.1010e3    1.0838e3
    1.6660e3    1.4448e3
    1.2688e3    1.1058e3
    1.2066e3    1.0496e3
    0.7266e3    1.0254e3];

Co_NoReg=reshape(Co_NoReg, 5,4)

i_NoReg_hi_KO=Co_NoReg(:,1);
i_NoReg_hi_WT=Co_NoReg(:,3);
i_NoReg_lo_KO=Co_NoReg(:,2);
i_NoReg_lo_WT=Co_NoReg(:,4);

(4583*6e4)/176080
(4226*6e4)/187276

Co_Reg=[4583	3804
5178	4672
3767	5865
3903	7513
5997	13273
5148	5376
7402	6654
5654	4957
5193	4433
4404	4226];

Co_Reg=(Co_Reg*6e4)./30e4;

Co_Reg=[1.5617e3    0.7608e3
    1.0356e3    0.9344e3
    0.7534e3   1.1730e3
    0.7806e3    1.5026e3
    1.1994e3    2.6546e3
    1.0296e3    1.0752e3
    1.4804e3    1.3308e3
    1.1308e3    0.9914e3
    1.0386e3    0.8866e3
    0.8808e3    1.3539e3];

Co_Reg=reshape(Co_Reg, 5,4)

i_Reg_hi_KO=Co_Reg(:,1);
i_Reg_hi_WT=Co_Reg(:,3);
i_Reg_lo_KO=Co_Reg(:,2);
i_Reg_lo_WT=Co_Reg(:,4);

figure()
subplot(2,1,1)
hold on
plot(Time, i_NoReg_hi_KO, '-ro', 'linewidth', 2)
plot(Time, i_NoReg_hi_WT, '-bo', 'linewidth', 2)
plot(Time, i_NoReg_lo_KO, '--ro', 'linewidth', 2)
plot(Time, i_NoReg_lo_WT, '--bo', 'linewidth', 2)
set(gca, 'Fontsize', 16, 'Fontweight', 'bold')
set(gcf, 'color', 'w')
xlabel('Time, (hrs)')
ylabel('CD4 T cells per 60,000 events')
box on
title('IL2 WT and KO proliferation during Co-culture -Tregs')
subplot(2,1,2)
hold on
plot(Time, i_Reg_hi_KO, '-ro', 'linewidth', 2)
plot(Time, i_Reg_hi_WT, '-bo', 'linewidth', 2)
plot(Time, i_Reg_lo_KO, '--ro', 'linewidth', 2)
plot(Time, i_Reg_lo_WT, '--bo', 'linewidth', 2)
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'ylim', [0 4500])
set(gcf, 'color', 'w')
xlabel('Time, (hrs)')
ylabel('CD4 T cells per 60,000 events')
box on
title('IL2 WT and KO proliferation during Co-culture +Tregs')


%%
%CD25 population for WT cells

CD25hi=[26.3
38.5
56.7
71
59.6
0.954
1.8
1.37
1.26
3.16
43.2
49.5
54.4
68.1
86.6
1.81
2.43
2.19
2.69
3.62
];

CD25hi=reshape(CD25hi, 5,4)

hi_NoReg=CD25hi(:,1);
lo_NoReg=CD25hi(:,2);
hi_Reg=CD25hi(:,3);
lo_Reg=CD25hi(:,4);

figure()
hold on
plot(Time, hi_NoReg, '-bo', 'linewidth', 2)
plot(Time, lo_NoReg, '--bo', 'linewidth', 2)
plot(Time, hi_Reg, '-ro', 'linewidth', 2)
plot(Time, lo_Reg, '--ro', 'linewidth', 2)
set(gca, 'Fontsize', 16, 'Fontweight', 'bold')
set(gcf, 'color', 'w')
xlabel('Time, (hrs)')
ylabel('%CD25+')
box on
title('%CD25+ for WT cells')

%%
%Cd25 population for KO Cells

CD25hi=[24.2
26.8
41.3
46.4
66
0.274
0.685
0.448
0.604
1.15
19.7
21.3
35.2
49.2
65.9
0.265
0.831
0.436
0.691
1.28];

CD25hi=reshape(CD25hi, 5,4)

hi_NoReg=CD25hi(:,1);
lo_NoReg=CD25hi(:,2);
hi_Reg=CD25hi(:,3);
lo_Reg=CD25hi(:,4);

figure()
hold on
plot(Time, hi_NoReg, '-bo', 'linewidth', 2)
plot(Time, lo_NoReg, '--bo', 'linewidth', 2)
plot(Time, hi_Reg, '-ro', 'linewidth', 2)
plot(Time, lo_Reg, '--ro', 'linewidth', 2)
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'ylim', [0 90])
set(gcf, 'color', 'w')
xlabel('Time, (hrs)')
ylabel('%CD25+')
box on
title('%CD25+ for KO cells')


%%

%Cd25 population for Co-cultured cells

CD25hi_KO=[27.4
19
21.4
47.3
66.9
0.182
0.54
0.725
0.895
0.936
24.2
17.9
16.9
26.5
44.8
0.291
0.824
0.424
0.963
1.88];

CD25hi_KO=reshape(CD25hi_KO, 5,4);

hi_NoReg_KO=CD25hi_KO(:,1);
lo_NoReg_KO=CD25hi_KO(:,2);
hi_Reg_KO=CD25hi_KO(:,3);
lo_Reg_KO=CD25hi_KO(:,4);


CD25hi_WT=[36
44.4
65.9
82.9
87.7
0.388
0.664
1.16
1.49
1.75
29.8
45.7
74.4
81.2
89.8
0.335
1.4
1.01
1.26
6.6];

CD25hi_WT=reshape(CD25hi_WT, 5,4);

hi_NoReg_WT=CD25hi_WT(:,1);
lo_NoReg_WT=CD25hi_WT(:,2);
hi_Reg_WT=CD25hi_WT(:,3);
lo_Reg_WT=CD25hi_WT(:,4);

figure()
subplot(2,2,1)
hold on
plot(Time, hi_NoReg_KO, '-ro', 'linewidth', 2)
plot(Time, hi_NoReg_WT, '-bo', 'linewidth', 2)
set(gca, 'Fontsize', 16, 'Fontweight', 'bold')
set(gcf, 'color', 'w')
xlabel('Time, (hrs)')
ylabel('%CD25+')
box on
legend('KO', 'WT')
title('%CD25+ for WT and KO Co-cultured cells -Tregs, high [Ag]')
subplot(2,2,2)
hold on
plot(Time, hi_Reg_KO, '-ro', 'linewidth', 2)
plot(Time, hi_Reg_WT, '-bo', 'linewidth', 2)
set(gca, 'Fontsize', 16, 'Fontweight', 'bold')
set(gcf, 'color', 'w')
xlabel('Time, (hrs)')
ylabel('%CD25+')
box on
title('%CD25+ for WT and KO Co-cultured cells +Tregs, high [Ag]')
subplot(2,2,3)
hold on
plot(Time, lo_NoReg_KO, '-ro', 'linewidth', 2)
plot(Time, lo_NoReg_WT, '-bo', 'linewidth', 2)
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'ylim', [0 7])
set(gcf, 'color', 'w')
xlabel('Time, (hrs)')
ylabel('%CD25+')
box on
title('%CD25+ for WT and KO Co-cultured cells -Tregs, low [Ag]')
subplot(2,2,4)
hold on
plot(Time, lo_Reg_KO, '-ro', 'linewidth', 2)
plot(Time, lo_Reg_WT, '-bo', 'linewidth', 2)
set(gca, 'Fontsize', 16, 'Fontweight', 'bold')
set(gcf, 'color', 'w')
xlabel('Time, (hrs)')
ylabel('%CD25+')
box on
title('%CD25+ for WT and KO Co-cultured cells +Tregs, low [Ag]')


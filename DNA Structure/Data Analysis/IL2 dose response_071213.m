%Data I've re-worked from my rotation - experiment is from 11.30.11

%IL2 dose responses - gated on CD25+ of adoptively transferred then GeoMFI
%of pSTAT5

pSTAT5_1=[304
288
267
180
155
192
165
1037
735
486
285
188
182
232
657
515
266
217
178
195
207];

pSTAT5_10=[261
258
272
194
180
208
190
1148
1214
790
345
218
194
209
970
807
492
285
219
168
184];

pSTAT5_100=[288
240
289
225
206
197
187
959
993
1005
586
318
244
260
1250
976
591
262
192
182
186];

IL2=[10e-9 1e-9 100e-12 10e-12 1e-12 100e-15 0];

%Plotting the pSTAT5 response to IL2 for different peptide and timepoints

figure()
subplot(1,3,1)
hold on
plot(IL2, pSTAT5_1(1:7), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 15)
plot(IL2, pSTAT5_1(8:14), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 15)
plot(IL2, pSTAT5_1(15:21), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 15)
set(gca, 'xscale', 'log', 'Fontsize', 20, 'Fontweight', 'bold', 'ylim', [0 1400], 'ygrid', 'on', 'xgrid', 'on')
set(gcf, 'color', 'w')
xlabel('log [IL2], (M)')
ylabel('GeoMFI of PSTAT5')
title('pSTAT5 response for 1ug K5')
legend('12 hours', '24 hours', '36 hours')
box on
subplot(1,3,2)
hold on
plot(IL2, pSTAT5_10(1:7), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 15)
plot(IL2, pSTAT5_10(8:14), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 15)
plot(IL2, pSTAT5_10(15:21), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 15)
set(gca, 'xscale', 'log', 'Fontsize', 20, 'Fontweight', 'bold', 'ygrid', 'on', 'xgrid', 'on')
set(gcf, 'color', 'w')
xlabel('log [IL2], (M)')
ylabel('GeoMFI of PSTAT5')
title('pSTAT5 response for 10ug K5')
box on
subplot(1,3,3)
hold on
plot(IL2, pSTAT5_100(1:7), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 15)
plot(IL2, pSTAT5_100(8:14), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 15)
plot(IL2, pSTAT5_100(15:21), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 15)
set(gca, 'xscale', 'log', 'Fontsize', 20, 'Fontweight', 'bold', 'ygrid', 'on', 'xgrid', 'on')
set(gcf, 'color', 'w')
xlabel('log [IL2], (M)')
ylabel('GeoMFI of PSTAT5')
title('pSTAT5 response for 100ug K5')
box on
%%
%Calculating the amplitudes of response for all pSTAT5 dose responses

a_1_12=pSTAT5_1(1,:)-pSTAT5_1(7,:);
a_1_24=pSTAT5_1(8,:)-pSTAT5_1(14,:);
a_1_36=pSTAT5_1(15,:)-pSTAT5_1(21,:);

a_10_12=pSTAT5_10(1,:)-pSTAT5_10(7,:);
a_10_24=pSTAT5_10(8,:)-pSTAT5_10(14,:);
a_10_36=pSTAT5_10(15,:)-pSTAT5_10(21,:);

a_100_12=pSTAT5_100(1,:)-pSTAT5_100(7,:);
a_100_24=pSTAT5_100(8,:)-pSTAT5_100(14,:);
a_100_36=pSTAT5_100(15,:)-pSTAT5_100(21,:);

P1_amp=[a_1_12; a_1_24; a_1_36];
P2_amp=[a_10_12; a_10_24; a_10_36];
P3_amp=[a_100_12; a_100_24; a_100_36];

P1_reg=[153.4 429.9 274.9];
P2_reg=[144.5 280.7 337];
P3_reg=[303.3 369.1 376.1];

figure()
subplot(1,3,1)
hold on
plot(CD25MFI(1,:), a_1_12, 'o', 'markersize', 10, 'markeredgecolor', 'k', 'markerfacecolor', 'r')
plot(CD25MFI(2,:), a_10_12, 'o', 'markersize', 10, 'markeredgecolor', 'k', 'markerfacecolor', 'b')
plot(CD25MFI(3,:), a_100_12, 'o', 'markersize', 10, 'markeredgecolor', 'k', 'markerfacecolor', 'y')
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'xscale', 'log', 'ylim', [0 1100], 'xlim', [10e1 10e3])
xlabel('CD25 GMFI')
ylabel('pSTAT5 amplitude')
title('12 HPI')
legend('1ug K5', '10ug K5', '100ug K5')
box on
subplot(1,3,2)
hold on
plot(CD25MFI(4,:), a_1_24, 'o', 'markersize', 10, 'markeredgecolor', 'k', 'markerfacecolor', 'r')
plot(CD25MFI(5,:), a_10_24, 'o', 'markersize', 10, 'markeredgecolor', 'k', 'markerfacecolor', 'b')
plot(CD25MFI(6,:), a_100_24, 'o', 'markersize', 10, 'markeredgecolor', 'k', 'markerfacecolor', 'y')
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'xscale', 'log', 'ylim', [0 1100], 'xlim', [10e1 10e3])
xlabel('CD25 GMFI')
ylabel('pSTAT5 amplitude')
title('24 HPI')
box on
subplot(1,3,3)
hold on
plot(CD25MFI(7,:), a_1_36, 'o', 'markersize', 10, 'markeredgecolor', 'k', 'markerfacecolor', 'r')
plot(CD25MFI(8,:), a_10_36, 'o', 'markersize', 10, 'markeredgecolor', 'k', 'markerfacecolor', 'b')
plot(CD25MFI(9,:), a_100_36, 'o', 'markersize', 10, 'markeredgecolor', 'k', 'markerfacecolor', 'y')
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'xscale', 'log', 'ylim', [0 1100], 'xlim', [10e1 10e3])
xlabel('CD25 GMFI')
ylabel('pSTAT5 amplitude')
title('36 HPI')
box on

figure()
subplot(1,3,1)
plot(CD25MFI(1:3), P1_amp, 'o', 'markersize', 10, 'markeredgecolor', 'k', 'markerfacecolor', 'r')
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'xscale', 'log', 'ylim', [0 1100], 'xlim', [10e1 10e3])
xlabel('CD25 GMFI')
ylabel('pSTAT5 amplitude')
title('1ug K5')
box on
subplot(1,3,2)
plot(CD25MFI(4:6), P2_amp, 'o', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'xscale', 'log', 'ylim', [0 1100], 'xlim', [10e1 10e3])
xlabel('CD25 GMFI')
ylabel('pSTAT5 amplitude')
box on
title('10ug K5')
subplot(1,3,3)
plot(CD25MFI(7:9), P3_amp, 'o', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 10)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'xscale', 'log', 'ylim', [0 1100], 'xlim', [10e1 10e3])
xlabel('CD25 GMFI')
ylabel('pSTAT5 amplitude')
box on
title('100ug K5')

sum_1=sum(P1_amp);
sum_10=sum(P2_amp);
sum_100=sum(P3_amp);

summed=[sum_1; sum_10; sum_100];

peptide=[1 10 100];
time=[12 24 36];


%%

%Correlating amplitude of pSTAT5 and EC50 of pSTAT5 with Receptor abundance

CD25GeoMFI=[146 152 106 499 321 133 945 1000 170];
CD25GeoMFI=reshape(CD25GeoMFI, 3,3);
figure()
subplot(1,2,2)
hold on
plot(CD25GeoMFI(:,1), [a_1_12, a_1_24, a_1_36], '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 15)
plot(CD25GeoMFI(:,2), [a_10_12, a_10_24, a_10_36], '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 15)
plot(CD25GeoMFI(:,3), [a_100_12, a_100_24, a_100_36], '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 15)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 20, 'Fontweight', 'bold', 'xscale', 'log', 'yscale', 'log', 'ygrid', 'on', 'xgrid', 'on')
xlabel('log IL2R\alpha GeoMFI')
ylabel('log pSTAT5 amplitude')
box on
title('IL2R\alpha abundance does not correlate with pSTAT5 amplitude')
subplot(1,2,1)
hold on
plot(CD25GeoMFI(:,1), P1, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 15)
plot(CD25GeoMFI(:,2), P2, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 15)
plot(CD25GeoMFI(:,3), P3, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 15)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 20, 'Fontweight', 'bold', 'xscale', 'log', 'yscale', 'log', 'ygrid', 'on', 'xgrid', 'on')
xlabel('log IL2R\alpha GeoMFI')
ylabel('log EC50 of response, (pM of IL2)')
legend('1ug K5', '10ug K5', '100ug K5')
box on
title('IL2R\alpha abundance correlates with high sensitivity to IL2')
%%

%plotting the snapshot pSTAT5 values

Snapshot=[276
265
186
132
187
207
166
201
181];

Snapshot_norm=Snapshot./min(Snapshot);

Treg_snapshot=[163
236
119
104
164
155
181
165
125];

time=[12 24 36];

figure()
subplot(1,2,1)
hold on
plot(time, Snapshot(1:3), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 13)
plot(time, Snapshot(4:6), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 13)
plot(time, Snapshot(7:9), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 13)
set(gca, 'Fontsize', 16, 'Fontweight', 'bold')
set(gcf, 'color', 'w')
xlabel('Time post-immunization, (hours)')
ylabel('GeoMFI of PSTAT5')
title('Instantaneous pSTAT5 for activated effectors')
legend('1ug K5', '10ug K5', '100ug K5')
box on
subplot(1,2,2)
hold on
plot(time, Treg_snapshot(1:3), '--ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 13)
plot(time, Treg_snapshot(4:6), '--ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 13)
plot(time, Treg_snapshot(7:9), '--ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 13)
set(gca, 'Fontsize', 16, 'Fontweight', 'bold')
set(gcf, 'color', 'w')
xlabel('Time post-immunization, (hours)')
ylabel('GeoMFI of PSTAT5')
title('Instantaneous pSTAT5 for Tregs')
legend('1ug K5', '10ug K5', '100ug K5')
box on

%%
peptide=[1 10 100];
peptide=log10(peptide);
Snapshot_norm=reshape(Snapshot_norm, 3,3);
fit1=polyfit(peptide, Snapshot_norm(1,:), 1);
xvals=0:2
yhat1=polyval(fit1,xvals);
fit2=polyfit(peptide, Snapshot_norm(2,:), 1);
yhat2=polyval(fit2,xvals);
fit3=polyfit(peptide, Snapshot_norm(3,:), 1);
yhat3=polyval(fit3,xvals);


figure()
subplot(1,2,1)
hold on
plot(peptide, Snapshot_norm(1,:),'o', xvals, yhat1, 'r-', 'linewidth', 1.5, 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 15)
plot(peptide, Snapshot_norm(2,:),'o', xvals, yhat2, 'b-', 'linewidth', 1.5, 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 15)
plot(peptide, Snapshot_norm(3,:),'o', xvals, yhat3, 'y-', 'linewidth', 1.5, 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 15)
set(gca, 'Fontsize', 20, 'Fontweight', 'bold', 'xlim', [0 2], 'xtick', [0 0.5 1 1.5 2], 'ylim', [1 2.2], 'ygrid', 'on', 'xgrid', 'on')
set(gcf, 'color', 'w')
xlabel('log10[Peptide dose], (ug K5)')
ylabel('Normalized PSTAT5')
title('Instantaneous pSTAT5 for activated effectors')
legend('12 HPI', 'fit', '24 HPI', 'fit', '36 HPI', 'fit')
box on
subplot(1,2,2)
plot(time, [-0.416 -0.242 -0.018], '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'g', 'markersize', 15)
set(gca, 'Fontsize', 20, 'Fontweight', 'bold', 'ygrid', 'on', 'xgrid', 'on', 'ytick', [-0.4 -0.3 -0.2 -0.1 0])
set(gcf, 'color', 'w')
xlabel('Time post-immunization, (hours)')
ylabel('Slope')
title('Change in relationship between [peptide] and pSTAT5 amplitude over time')
box on
%%
Div=[0 5.64 8.41 2.17 1.47 75.6 0.406 2.27 83.1];

Div=reshape(Div, 3,3);

figure()
hold on
plot([a_1_12, a_1_24, a_1_36], Div(:,1), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 13)
plot([a_10_12, a_10_24, a_10_36], Div(:,2), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 13)
plot([a_100_12, a_100_24, a_100_36], Div(:,3), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 13)
set(gca, 'Fontsize', 16, 'Fontweight', 'bold')
set(gcf, 'color', 'w')
ylabel('% of Cells undergone max divisions')
xlabel('Amplitude of pSTAT5 response')
legend('12 HPI', '24 HPI', '36 HPI')
box on
%%

dose=[10000 1000 100 10 1 0.1 0];
response1=[304 288 267 180 155 192 165];

%deal with 0 dosage by using it to normalise the results.
normalized=0;
if (sum(dose(:)==0)>0)
    %compute mean control response
    controlResponse=mean(response1(dose==0));
    %remove controls from dose/response curve
    response1=response1(dose~=0)/controlResponse;
    dose=dose(dose~=0);
    normalized=1;
end

%hill equation sigmoid
sigmoid=@(beta,x)beta(1)+(beta(2)-beta(1))./(1+(x/beta(3)).^beta(4));

%calculate some rough guesses for initial parameters
minResponse=min(response1);
maxResponse=max(response1);
midResponse=mean([minResponse maxResponse]);
minDose=min(dose);
maxDose=max(dose);

%fit the curve and compute the values
[coeffs,r,J]=nlinfit(dose,response1,sigmoid,[minResponse maxResponse midResponse 1]);

ec50=coeffs(3);
hillCoeff=coeffs(4);

%plot the fitted sigmoid
xpoints=logspace(log10(minDose),log10(maxDose),1000);
semilogx(xpoints,sigmoid(coeffs,xpoints),'Color',[0 0 0],'LineWidth',2)
set(gcf, 'color', 'w')
hold on

%notate the EC50
text(ec50,mean([coeffs(1) coeffs(2)]),[' \leftarrow ' sprintf('EC_{50}=%0.2g',ec50)],'FontSize',16);

%plot mean response for each dose with standard error
doses=unique(dose);
meanResponse=zeros(1,length(doses));
stdErrResponse=zeros(1,length(doses));
for i=1:length(doses)
    responses=response1(dose==doses(i));
    meanResponse(i)=mean(responses);
    stdErrResponse(i)=std(responses)/sqrt(length(responses));
    %stdErrResponse(i)=std(responses);
end

errorbar(doses,meanResponse,stdErrResponse,'o','Color',[0.5 0.5 0.5],'LineWidth',2,'MarkerSize',12)


%label axes
xlabel('Dose','FontSize',16);
if normalized
    ylabel('Normalized Response','FontSize',16);
else
    ylabel('Response','FontSize',16);
end
set(gca,'FontSize',16);

hold off;

%%

%percent CD25+ at different timepoints

CD25=[26.4
31.3
20.6
78.3
59.7
28
94.7
91.7
32.5];

CD25MFI=[538
636
508
686
811
749
1047
1175
640];

figure()
subplot(2,1,1)
hold on
plot(time, CD25(1:3), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 15)
plot(time, CD25(4:6), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 15)
plot(time, CD25(7:9), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 15)
set(gca, 'Fontsize', 20, 'Fontweight', 'bold', 'ygrid', 'on', 'xgrid', 'on')
set(gcf, 'color', 'w')
xlabel('Time post-immunization, (hours)')
ylabel('%IL2R\alpha+')
title('Percent of Ag-specific cells IL2R  \alpha+')
legend('1ug K5', '10ug K5', '100ug K5')
box on
subplot(2,1,2)
hold on
plot(time, CD25MFI(1:3), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 15)
plot(time, CD25MFI(4:6), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 15)
plot(time, CD25MFI(7:9), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 15)
set(gca, 'Fontsize', 20, 'Fontweight', 'bold', 'yscale', 'log', 'ygrid', 'on', 'xgrid', 'on')
set(gcf, 'color', 'w')
xlabel('Time post-immunization, (hours)')
ylabel('log IL2R\alpha GeoMFI')
title('IL2R\alpha MFI among activated cells')
box on

%%

%Plotting GMFI of pSTAT5 for CD25 high medium and low 100ug K5

CD25hi=[564
503
596
387
320
295
349
1170
1721
1573
1066
345
271
369
2151
1751
1604
854
393
265
271];

CD25hi_100=CD25hi

CD25med=[280
237
311
224
209
198
185
1070
1157
1263
661
304
223
235
1710
1442
1009
471
242
230
230];
CD25lo=[257
207
233
202
187
183
174
701
542
410
283
296
296
227
1104
845
445
203
172
174
176];


figure()
subplot(1,3,1)
hold on
plot(IL2, CD25hi(1:7), '-ro', 'linewidth', 2, 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 13)
plot(IL2, CD25hi(8:14), '-bo', 'linewidth', 2, 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 13)
plot(IL2, CD25hi(15:21), '-yo', 'linewidth', 2, 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 13)
set(gca, 'xscale', 'log', 'Fontsize', 16, 'Fontweight', 'bold', 'ylim', [0 2200])
set(gcf, 'color', 'w')
xlabel('log [IL2], (M)')
ylabel('GeoMFI of PSTAT5')
title('pSTAT5 response for CD25hi - 100ug')
legend('12 hours', '24 hours', '36 hours')
box on
subplot(1,3,2)
hold on
plot(IL2, CD25med(1:7), '-ro', 'linewidth', 2, 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 13)
plot(IL2, CD25med(8:14), '-bo', 'linewidth', 2, 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 13)
plot(IL2, CD25med(15:21), '-yo', 'linewidth', 2, 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 13)
set(gca, 'xscale', 'log', 'Fontsize', 16, 'Fontweight', 'bold', 'ylim', [0 2200])
set(gcf, 'color', 'w')
xlabel('log [IL2], (M)')
ylabel('GeoMFI of PSTAT5')
title('pSTAT5 response for CD25med - 100ug')
box on
subplot(1,3,3)
hold on
plot(IL2, CD25lo(1:7), '-ro', 'linewidth', 2, 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 13)
plot(IL2, CD25lo(8:14), '-bo', 'linewidth', 2, 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 13)
plot(IL2, CD25lo(15:21), '-yo', 'linewidth', 2, 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 13)
set(gca, 'xscale', 'log', 'Fontsize', 16, 'Fontweight', 'bold', 'ylim', [0 2200])
set(gcf, 'color', 'w')
xlabel('log [IL2], (M)')
ylabel('GeoMFI of PSTAT5')
title('pSTAT5 response for CD25lo - 100ug')
box on

%%

%Plotting GMFI of pSTAT5 for CD25 high medium and low 10ug K5

CD25hi=[1221
1382
902
289
605
966
1551
1424
1497
1368
743
224
220
266
2076
1869
1610
1074
340
217
220];

CD25hi_10=CD25hi

CD25med=[285
256
246
211
191
189
205
1284
1321
1034
392
231
178
208
1578
1380
1201
372
275
198
262];
CD25lo=[195
225
241
175
116
177
162
958
1071
539
240
204
206
190
786
603
319
213
206
171
190];


figure()
subplot(1,3,1)
hold on
plot(IL2, CD25hi(1:7), '-ro', 'linewidth', 2, 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 13)
plot(IL2, CD25hi(8:14), '-bo', 'linewidth', 2, 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 13)
plot(IL2, CD25hi(15:21), '-yo', 'linewidth', 2, 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 13)
set(gca, 'xscale', 'log', 'Fontsize', 16, 'Fontweight', 'bold', 'ylim', [0 2200])
set(gcf, 'color', 'w')
xlabel('log [IL2], (M)')
ylabel('GeoMFI of PSTAT5')
title('pSTAT5 response for CD25hi - 10ug')
legend('12 hours', '24 hours', '36 hours')
box on
subplot(1,3,2)
hold on
plot(IL2, CD25med(1:7), '-ro', 'linewidth', 2, 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 13)
plot(IL2, CD25med(8:14), '-bo', 'linewidth', 2, 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 13)
plot(IL2, CD25med(15:21), '-yo', 'linewidth', 2, 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 13)
set(gca, 'xscale', 'log', 'Fontsize', 16, 'Fontweight', 'bold', 'ylim', [0 2200])
set(gcf, 'color', 'w')
xlabel('log [IL2], (M)')
ylabel('GeoMFI of PSTAT5')
title('pSTAT5 response for CD25med - 10ug')
box on
subplot(1,3,3)
hold on
plot(IL2, CD25lo(1:7), '-ro', 'linewidth', 2, 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 13)
plot(IL2, CD25lo(8:14), '-bo', 'linewidth', 2, 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 13)
plot(IL2, CD25lo(15:21), '-yo', 'linewidth', 2, 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 13)
set(gca, 'xscale', 'log', 'Fontsize', 16, 'Fontweight', 'bold', 'ylim', [0 2200])
set(gcf, 'color', 'w')
xlabel('log [IL2], (M)')
ylabel('GeoMFI of PSTAT5')
title('pSTAT5 response for CD25lo - 10ug')
box on

%%
%Plotting GMFI of pSTAT5 for CD25 high medium and low 1ug K5

CD25hi=[799
551
535
530
237
359
110
1531
682
929
826
275
256
333
1019
1072
520
784
364
206
163];

CD25hi_1=CD25hi

CD25med=[415
463
423
262
159
258
227
1357
936
848
416
241
232
257
963
873
527
372
228
248
249];
CD25lo=[289
263
242
166
149
184
158
935
698
391
237
168
165
219
606
464
240
186
167
187
196];


figure()
subplot(1,3,1)
hold on
plot(IL2, CD25hi(1:7), '-ro', 'linewidth', 2, 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 13)
plot(IL2, CD25hi(8:14), '-bo', 'linewidth', 2, 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 13)
plot(IL2, CD25hi(15:21), '-yo', 'linewidth', 2, 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 13)
set(gca, 'xscale', 'log', 'Fontsize', 16, 'Fontweight', 'bold', 'ylim', [0 2200])
set(gcf, 'color', 'w')
xlabel('log [IL2], (M)')
ylabel('GeoMFI of PSTAT5')
title('pSTAT5 response for CD25hi - 1ug')
legend('12 hours', '24 hours', '36 hours')
box on
subplot(1,3,2)
hold on
plot(IL2, CD25med(1:7), '-ro', 'linewidth', 2, 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 13)
plot(IL2, CD25med(8:14), '-bo', 'linewidth', 2, 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 13)
plot(IL2, CD25med(15:21), '-yo', 'linewidth', 2, 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 13)
set(gca, 'xscale', 'log', 'Fontsize', 16, 'Fontweight', 'bold', 'ylim', [0 2200])
set(gcf, 'color', 'w')
xlabel('log [IL2], (M)')
ylabel('GeoMFI of PSTAT5')
title('pSTAT5 response for CD25med - 1ug')
box on
subplot(1,3,3)
hold on
plot(IL2, CD25lo(1:7), '-ro', 'linewidth', 2, 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 13)
plot(IL2, CD25lo(8:14), '-bo', 'linewidth', 2, 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 13)
plot(IL2, CD25lo(15:21), '-yo', 'linewidth', 2, 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 13)
set(gca, 'xscale', 'log', 'Fontsize', 16, 'Fontweight', 'bold', 'ylim', [0 2200])
set(gcf, 'color', 'w')
xlabel('log [IL2], (M)')
ylabel('GeoMFI of PSTAT5')
title('pSTAT5 response for CD25lo - 1ug')
box on

%%

%Plotting the pSTAT5 responsiveness among cells with equivalent CD25 levels
%but different time and different peptide

figure()
subplot(1,3,1)
hold on
plot(IL2, CD25hi_100(1:7),'-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 13)
plot(IL2, CD25hi_10(1:7), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 13)
plot(IL2, CD25hi_1(1:7), '-ko',  'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 13)
set(gca, 'xscale', 'log', 'Fontsize', 16, 'Fontweight', 'bold', 'ylim', [0 2200])
set(gcf, 'color', 'w')
xlabel('log [IL2], (M)')
ylabel('GeoMFI of PSTAT5 for CD25high')
title('pSTAT5 response for CD25high at 12 hpi')
legend('100ug', '10ug', '1ug')
box on
subplot(1,3,2)
hold on
plot(IL2, CD25hi_100(8:14),'-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 13)
plot(IL2, CD25hi_10(8:14), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 13)
plot(IL2, CD25hi_1(8:14), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 13)
set(gca, 'xscale', 'log', 'Fontsize', 16, 'Fontweight', 'bold', 'ylim', [0 2200])
set(gcf, 'color', 'w')
xlabel('log [IL2], (M)')
ylabel('GeoMFI of PSTAT5 for CD25high')
title('pSTAT5 response for CD25high at 24 hpi')
box on
subplot(1,3,3)
hold on
plot(IL2, CD25hi_100(15:21),'-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 13)
plot(IL2, CD25hi_10(15:21), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 13)
plot(IL2, CD25hi_1(15:21), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 13)
set(gca, 'xscale', 'log', 'Fontsize', 16, 'Fontweight', 'bold', 'ylim', [0 2200])
set(gcf, 'color', 'w')
xlabel('log [IL2], (M)')
ylabel('GeoMFI of PSTAT5 for CD25high')
title('pSTAT5 response for CD25high at 36 hpi')
box on

%%
%Plotting the amplitudes of pSTAT5 response for CD25 high cells

T1_100A=max(CD25hi_100(1:7))-min(CD25hi_100(1:7)); %12 HPI
T2_100A=max(CD25hi_100(8:14))-min(CD25hi_100(8:14)); %24 HPI
T3_100A=max(CD25hi_100(15:21))-min(CD25hi_100(15:21)); %36 HPI

T1_10A=max(CD25hi_10(1:7))-min(CD25hi_10(1:7)); %12 HPI
T2_10A=max(CD25hi_10(8:14))-min(CD25hi_10(8:14)); %24 HPI
T3_10A=max(CD25hi_10(15:21))-min(CD25hi_10(15:21)); %36 HPI

T1_1A=max(CD25hi_1(1:7))-min(CD25hi_1(1:7)); %12 HPI
T2_1A=max(CD25hi_1(8:14))-min(CD25hi_1(8:14)); %24 HPI
T3_1A=max(CD25hi_1(15:21))-min(CD25hi_1(15:21)); %36 HPI

T1=[T1_1A, T1_10A, T1_100A];
T2=[T2_1A, T2_10A, T2_100A];
T3=[T3_1A, T3_10A, T3_100A];

All=[T1_1A T2_1A T3_1A T1_10A T2_100A T3_10A T1_100A T2_100A T3_100A];
All=reshape(All, 9,1);

figure()
hold on
plot(peptide, T1, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 13)
plot(peptide, T2, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 13)
plot(peptide, T3, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 13)
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'xscale', 'log')
set(gcf, 'color', 'w')
xlabel('[Peptide], (ug K5)')
ylabel('Amplitude of pSTAT5 for equivalent CD25')
legend('12 hpi', '24 hpi', '36 hpi')
box on

%%

%Plotting TCR (Vb3) fluoresence intensity of adoptively transferred cells
%as a proxy for TCR signaling

TCR=[2511
4572
3382
3890
6570
4012
5885
11160
4798];

time=[12 24 36];

figure()
hold on
plot(time, TCR(1:3), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 13)
plot(time, TCR(4:6), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 13)
plot(time, TCR(7:9), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 13)
set(gca, 'Fontsize', 16, 'Fontweight', 'bold')
set(gcf, 'color', 'w')
xlabel('Time post-immunization, (hours)')
ylabel('GeoMFI Vb3')
title('TCR MFI over time for different [Peptide]')
legend('1ug K5', '10ug K5', '100ug K5')
box on

TCR=reshape(TCR, 3,3);

%Plotting TCR fluorescence versus pSTAT5 amplitude
T1=[139 71 101];
T2=[805 939 699];
T3=[450 786 1064];

fit1=polyfit(TCR(1,:), T1, 1)
xvals1=2000:6000
yhat1=polyval(fit1,xvals1);
fit2=polyfit(TCR(2,:), T2, 1)
xvals2=4000:12000
yhat2=polyval(fit2,xvals2);
fit3=polyfit(TCR(3,:), T3, 1)
xvals3=3000:5500
yhat3=polyval(fit3,xvals3);
figure()
hold on
plot(TCR(1,:), T1, 'o', xvals1, yhat1, 'k-', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 12)
plot(TCR(2,:), T2, 'o', xvals2, yhat2, 'k-', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 12)
plot(TCR(3,:), T3, 'o', xvals3, yhat3, 'k-', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 12)
set(gca, 'Fontsize', 16, 'Fontweight', 'bold')
set(gcf, 'color', 'w')
xlabel('TCR GMFI')
ylabel('pSTAT5 amplitude for CD25hi')
legend('12 hpi', 'fit', '24 hpi', 'fit', '36 hpi', 'fit')
box on

%TCR=reshape(TCR, 9,1);

%trying a linear regression of these data
Fit=polyfit(TCR, Snapshot, 1)
min(TCR)
max(TCR)
xvals=2400:11200;
%make xvals a vector of integers from 2400 to 11200
yhat=polyval(Fit, xvals);

figure()
plot(TCR, Snapshot, 'o', xvals, yhat)
set(gca, 'Fontsize', 16, 'Fontweight', 'bold')
set(gcf, 'color', 'w')
xlabel('TCR GMFI')
ylabel('pSTAT5 Snapshot')



%%
%Calculating IL2 from dose response curves and snapshot data

%1ug - 12 HPI
T=301.7;
B=167.8;
E=48.94;
SS=276;
IL2=(SS-B)./(T-SS).*E
%1ug - 24 HPI
T=1013;
B=224.2;
E=48.94;
SS=265;
IL2=(SS-B)./(T-SS).*E
%1ug - 36 HPI
T=683.2;
B=195.7;
E=540.3;
SS=186;
IL2=(SS-B)./(T-SS).*E

%10ug - 12 HPI
T=267;
B=189.4;
E=27.46;
SS=132;
IL2=(SS-B)./(T-SS).*E
%10ug - 24 HPI
T=1208;
B=202.9;
E=65.75;
SS=187;
IL2=(SS-B)./(T-SS).*E
%10ug - 36 HPI
T=954.2;
B=201.7;
E=167.6;
SS=207;
IL2=(SS-B)./(T-SS).*E

%100ug - 12 HPI
T=273.2;
B=193;
E=9.875;
SS=166;
IL2=(SS-B)./(T-SS).*E
%100ug - 24 HPI
T=1007;
B=247.9;
E=10.82;
SS=201;
IL2=(SS-B)./(T-SS).*E
%100ug - 36 HPI
T=1215;
B=194.1;
E=184.9;
SS=181;
IL2=(SS-B)./(T-SS).*E

%%
%Treg GMFI of CD25

Treg=[1001
1063
921
1160
1323
1179
1447
1609
1158];

figure()
hold on
plot(time, Treg(1:3), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 15)
plot(time, Treg(4:6), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 15)
plot(time, Treg(7:9), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 15)
set(gca, 'Fontsize', 20, 'Fontweight', 'bold', 'ygrid', 'on', 'xgrid', 'on')
set(gcf, 'color', 'w')
xlabel('Time post-immunization, (hours)')
ylabel('IL2R\alpha GeoMFI')
title('IL2R\alpha levels among Tregs')
legend('1ug K5', '10ug K5', '100ug K5')
box on

%%

%EC50 of response, P1=1ug P2=10ug P3=100ug, in order from 12-->24-->36
%hours

P1=[48.94 321.7 540.3];
P2=[27.46 65.75 167.6];
P3=[9.875 10.82 184.9];

figure()
hold on
plot(time, P1, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
plot(time, P2, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
plot(time, P3, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 10)
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'yscale', 'log')
set(gcf, 'color', 'w')
xlabel('Time post-immunization, (hours)')
ylabel('EC50 of pSTAT5 response, (pM of IL2)')
title('EC50 of pSTAT5 reseponse to IL2')
legend('1ug K5', '10ug K5', '100ug K5')
box on

%%

%Amplitude versus the EC50

figure()
hold on
plot(P1_amp, P1,'-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 13)
plot(P2_amp, P2,'-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 13)
plot(P3_amp, P3,'-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 13)
set(gca, 'Fontsize', 20, 'Fontweight', 'bold', 'yscale', 'log', 'xscale', 'log', 'ygrid', 'on', 'xgrid', 'on')
set(gcf, 'color', 'w')
xlabel('Amplitude of pSTAT5 response')
ylabel('EC50 of pSTAT5 response, (pM of IL2)')
title('Amplitude versus EC50')
legend('1ug K5', '10ug K5', '100ug K5')
box on

%%

%Parsing what cells are sensing cytokine by peak of division - snapshot

CFSE=[142 166	NaN 144	102	78.1 138 85.8 56.9 131 NaN 157 119 127 243 174	97.1 78.9 163 179 228 183 256 500 131 116 111];

CFSE=reshape(CFSE,3,9)

peak=[1 2 3];

figure()
subplot(1,3,1)
plot(peak, CFSE (1:3,1:3), '-o', 'linewidth', 2, 'markeredgecolor', 'k', 'markersize', 10)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'ylim', [0 500])
xlabel('CFSE Dilution')
ylabel('pSTAT5 GMFI')
legend('12 HPI', '24 HPI', '36 HPI')
title('1ug K5')
box on
subplot(1,3,2)
plot(peak, CFSE (1:3,4:6), '-o', 'linewidth', 2, 'markeredgecolor', 'k', 'markersize', 10)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'ylim', [0 500])
xlabel('CFSE Dilution')
ylabel('pSTAT5 GMFI')
title('10ug K5')
box on
subplot(1,3,3)
plot(peak, CFSE(1:3,7:9), '-o', 'linewidth', 2, 'markeredgecolor', 'k', 'markersize', 10)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'ylim', [0 500])
xlabel('CFSE Dilution')
ylabel('pSTAT5 GMFI')
box on
title('100ug K5')

%%

%IL2 dose responses by based on division

%100ug K5

P3T1=[278
230
248
217
196
191
182];

figure()
subplot(1,3,1)
plot(IL2, P3T1, '-o', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'xscale', 'log', 'ylim', [0 1100])
xlabel('log [IL2], (M)')
ylabel('pSTAT5 GMFI')
legend('Peak 1')
title('12 hours')


P3T2=[925 596
883	545
1013 350
535	485
306	268
256	215
254	220];

subplot(1,3,2)
plot(IL2, P3T2, '-o', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'xscale', 'log', 'ylim', [0 1100])
xlabel('log [IL2], (M)')
ylabel('pSTAT5 GMFI')
legend('Peak 1', 'Peak 2')
title('24 hours')

P3T3=[951
603
349
172
146
145
155];

subplot(1,3,3)
plot(IL2, P3T3, '-o', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'xscale', 'log', 'ylim', [0 1100])
xlabel('log [IL2], (M)')
ylabel('pSTAT5 GMFI')
legend('Peak 3')
title('36 hours')

%%

%IL2 dose responses by based on division

%10ug K5

P2T1=[214
203
230
180
141
139
160];

figure()
subplot(1,3,1)
plot(IL2, P2T1, '-o', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'xscale', 'log', 'ylim', [0 1200])
xlabel('log [IL2], (M)')
ylabel('pSTAT5 GMFI')
legend('Peak 1')
title('12 hours')


P2T2=[1049	990
972	1142
605	690
328	241
226	162
187	172
223	152];

subplot(1,3,2)
plot(IL2, P2T2, '-o', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'xscale', 'log', 'ylim', [0 1200])
xlabel('log [IL2], (M)')
ylabel('pSTAT5 GMFI')
legend('Peak 1', 'Peak 2')
title('24 hours')

P2T3=[561	555
483	478
290	241
190	174
170	161
150	127
164	147];

subplot(1,3,3)
plot(IL2, P2T3, '-o', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'xscale', 'log', 'ylim', [0 1200])
xlabel('log [IL2], (M)')
ylabel('pSTAT5 GMFI')
legend('Peak 2', 'Peak 3')
title('36 hours')

%%

%IL2 dose responses by based on division

%1ug K5

P1T1=[223
195
164
136
119
148
128];

figure()
subplot(1,3,1)
plot(IL2, P1T1, '-o', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'xscale', 'log', 'ylim', [0 1200])
xlabel('log [IL2], (M)')
ylabel('pSTAT5 GMFI')
legend('Peak 1')
title('12 hours')


P1T2=[678	647
440	457
277	307
192	172
161	161
154	150
184	174];

subplot(1,3,2)
plot(IL2, P1T2, '-o', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'xscale', 'log', 'ylim', [0 1200])
xlabel('log [IL2], (M)')
ylabel('pSTAT5 GMFI')
legend('Peak 1', 'Peak 2')
title('24 hours')

P1T3=[418	510	438
305	349	268
183	164	181
157	134	113
146	128	166
145	136	136
178	178	194];

subplot(1,3,3)
plot(IL2, P1T3, '-o', 'linewidth', 2)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'xscale', 'log', 'ylim', [0 1200])
xlabel('log [IL2], (M)')
ylabel('pSTAT5 GMFI')
legend('Peak 1', 'Peak 2', 'Peak 3')
title('36 hours')

%%

%percent occupancy

Occup=[97.2	1.59	0
63.3	28.8	5.64
41.4	48.1	8.41
93.5	0	2.17
53.1	43.6	1.47
0.579	18.5	75.6
97.2	1.42	0.406
76.5	20.5	2.27
0.574	11.4	83.1];

peak=[1 2 3];

figure()
subplot(1,3,1)
hold on
plot(peak, Occup(1,:), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 15)
plot(peak, Occup(4,:), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 15)
plot(peak, Occup(7,:), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 15)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'xtick', [1 2 3], 'ylim', [0 100])
xlabel('CFSE dilution')
ylabel('% Occupancy')
legend('1ug', '10ug', '100ug')
title('12 hours post-immunization')
box on
subplot(1,3,2)
hold on
plot(peak, Occup(2,:), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 15)
plot(peak, Occup(5,:), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 15)
plot(peak, Occup(8,:), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 15)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'xtick', [1 2 3], 'ylim', [0 100])
xlabel('CFSE dilution')
ylabel('% Occupancy')
title('24 hours post-immunization')
box on
subplot(1,3,3)
hold on
plot(peak, Occup(3,:), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 15)
plot(peak, Occup(6,:), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 15)
plot(peak, Occup(9,:), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 15)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold', 'xtick', [1 2 3], 'ylim', [0 100])
xlabel('CFSE dilution')
ylabel('% Occupancy')
title('36 hours post-immunization')
box on
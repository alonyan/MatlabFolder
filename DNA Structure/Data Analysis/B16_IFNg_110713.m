%B16-IFN-gamma incubation 11/7/13
%culture B16s with titration of gamma over 25 hours
%Groups 1/2 = Just B16s + gamma titration + DMSO vehicle at T1
%Group 3 = Jak inhibitor at T1 (p6 - 10uM)
%Group 4 = anti-IFN-g from T0

%Plot MHC upregulation
G12_1=[321 875 2745 8251 10439
       323 929 2640 5468 10180]; G12_1s=std(G12_1); G12_1m=mean(G12_1);

G12_2=[325 782 2070 6043 9064
       305 752 2005 5157 7720]; G12_2s=std(G12_2); G12_2m=mean(G12_2);

G12_3=[300 415 562 1135 1787
       279 394 543 1091 1807];  G12_3s=std(G12_3); G12_3m=mean(G12_3);

G12_4=[286 232 184 218 267
       255 215 171 146 257]; G12_4s=std(G12_4); G12_4m=mean(G12_4);

G12_5=[274 206 154 152 197
       261 192 142 111 184]; G12_5s=std(G12_5); G12_5m=mean(G12_5);

G12_6=[294 210 153 146 169
       273 194 132 123 172]; G12_6s=std(G12_6); G12_6m=mean(G12_6);

time=[4 10 14 20 25];
gamma=[10e-9 1e-9 100e-12 10e-12 1e-12 0];

figure()
subplot(1,3,1)
hold on
errorbar(time, G12_1m, G12_1s, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
errorbar(time, G12_2m, G12_2s, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', [1 0.5 0], 'markersize', 10)
errorbar(time, G12_3m, G12_3s, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 10)
errorbar(time, G12_4m, G12_4s, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'g', 'markersize', 10)
errorbar(time, G12_5m, G12_5s, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
errorbar(time, G12_6m, G12_6s, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'k', 'markersize', 10)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 20, 'yscale', 'log', 'xgrid', 'on', 'ygrid', 'on', 'ylim', [10 10e3])
xlabel('Time, (hours)')
ylabel('log H-2K^b')
title('MHC Expression over time for different IFN-\gamma+DMSO vehicle')
legend('10nM', '1nM', '100pM', '10pM', '1pM', '0')
box on

G3_1=[312 540 650 809 522];
G3_2=[294 487 414 489 697];
G3_3=[270 273 204 173 233];
G3_4=[269 161 104 77.8 113];
G3_5=[263 148 93 70.7 73.4];
G3_6=[268 153 101 53.6 91.3];

subplot(1,3,2)
hold on
plot(time, G3_1, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
plot(time, G3_2, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', [1 0.5 0], 'markersize', 10)
plot(time, G3_3, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 10)
plot(time, G3_4, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'g', 'markersize', 10)
plot(time, G3_5, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
plot(time, G3_6, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'k', 'markersize', 10)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 20, 'yscale', 'log', 'xgrid', 'on', 'ygrid', 'on', 'ylim', [10 10e3])
xlabel('Time, (hours)')
ylabel('log H-2K^b')
title('MHC Expression over time for different IFN-\gamma + p6 Jaki')
box on

G4_1=[269 184 144 92.7 63.3];
G4_2=[274 173 116 70.1 50.8];
G4_3=[264 170 120 60.4 44.9];
G4_4=[266 170 115 64.7 45.3];
G4_5=[268 163 111 57.3 43.2];
G4_6=[270 173 119 61.5 53.2];

subplot(1,3,3)
hold on
plot(time, G4_1, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
plot(time, G4_2, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', [1 0.5 0], 'markersize', 10)
plot(time, G4_3, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 10)
plot(time, G4_4, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'g', 'markersize', 10)
plot(time, G4_5, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
plot(time, G4_6, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'k', 'markersize', 10)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 20, 'yscale', 'log', 'xgrid', 'on', 'ygrid', 'on', 'ylim', [10 10e3])
xlabel('Time, (hours)')
ylabel('log H-2K^b')
title('MHC Expression over time for different IFN-\gamma + \alpha-IFN-\gamma')
box on


%%
%Plot IFN-gamma Ra's
G12_1=[1713 1734 1627 1709 1653
       1687 1715 1680 1681 1786]; G12_1s=std(G12_1); G12_1m=mean(G12_1);

G12_2=[1676 1697 1641 1778 1715
       1653 1671 1727 1730 1670]; G12_2s=std(G12_2); G12_2m=mean(G12_2);

G12_3=[1675 1628 1588 1692 1656
       1613 1647 1679 1732 1781];  G12_3s=std(G12_3); G12_3m=mean(G12_3);

G12_4=[1647 1631 1562 1594 1630
       1677 1599 1597 1476 1640]; G12_4s=std(G12_4); G12_4m=mean(G12_4);

G12_5=[1719 1663 1608 1567 1574
       1676 1651 1571 1446 1603]; G12_5s=std(G12_5); G12_5m=mean(G12_5);

G12_6=[1696 1703 1523 1611 1582
       1711 1637 1528 1488 1535]; G12_6s=std(G12_6); G12_6m=mean(G12_6);

time=[4 10 14 20 25];
gamma=[10e-9 1e-9 100e-12 10e-12 1e-12 0];

figure()
subplot(1,3,1)
hold on
errorbar(time, G12_1m, G12_1s, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
errorbar(time, G12_2m, G12_2s, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', [1 0.5 0], 'markersize', 10)
errorbar(time, G12_3m, G12_3s, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 10)
errorbar(time, G12_4m, G12_4s, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'g', 'markersize', 10)
errorbar(time, G12_5m, G12_5s, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
errorbar(time, G12_6m, G12_6s, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'k', 'markersize', 10)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 20, 'yscale', 'log', 'xgrid', 'on', 'ygrid', 'on', 'ylim', [10e2 10e3])
xlabel('Time, (hours)')
ylabel('log IFN-\gammaR\alpha')
title('IFN-\gammaR\alpha over time for different IFN-\gamma+DMSO vehicle')
legend('10nM', '1nM', '100pM', '10pM', '1pM', '0')
box on

G3_1=[1743 1736 1662 1814 1294];
G3_2=[1659 1602 1438 1633 1641];
G3_3=[1640 1591 1494 1551 1535];
G3_4=[1658 1516 1404 1425 1550];
G3_5=[1684 1500 1359 1419 1364];
G3_6=[1736 1588 1487 1310 1416];

subplot(1,3,2)
hold on
plot(time, G3_1, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
plot(time, G3_2, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', [1 0.5 0], 'markersize', 10)
plot(time, G3_3, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 10)
plot(time, G3_4, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'g', 'markersize', 10)
plot(time, G3_5, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
plot(time, G3_6, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'k', 'markersize', 10)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 20, 'yscale', 'log', 'xgrid', 'on', 'ygrid', 'on', 'ylim', [10e2 10e3])
xlabel('Time, (hours)')
ylabel('log IFN-\gammaR\alpha')
title('IFN-\gammaR\alpha for different IFN-\gamma + p6 Jaki')
box on

G4_1=[1556 1482 1568 1565 1619];
G4_2=[1499 1515 1590 1548 1438];
G4_3=[1502 1498 1567 1498 1399];
G4_4=[1494 1496 1526 1593 1313];
G4_5=[1524 1551 1555 1516 1381];
G4_6=[1538 1615 1584 1559 1514];

subplot(1,3,3)
hold on
plot(time, G4_1, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
plot(time, G4_2, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', [1 0.5 0], 'markersize', 10)
plot(time, G4_3, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 10)
plot(time, G4_4, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'g', 'markersize', 10)
plot(time, G4_5, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
plot(time, G4_6, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'k', 'markersize', 10)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 20, 'yscale', 'log', 'xgrid', 'on', 'ygrid', 'on', 'ylim', [10e2 10e3])
xlabel('Time, (hours)')
ylabel('log IFN-\gammaR\alpha')
title('IFN-\gammaR\alpha over time for different IFN-\gamma + \alpha-IFN-\gamma')
box on



%%
%Plot IFN-gamma Rb's
G12_1=[67.1 102 155 166 96
       70.4 104 111 235 238]; G12_1s=std(G12_1); G12_1m=mean(G12_1);

G12_2=[166 230 292 334 279
       161 187 289 343 307]; G12_2s=std(G12_2); G12_2m=mean(G12_2);

G12_3=[259 363 384 379 331
       229 349 466 454 447];  G12_3s=std(G12_3); G12_3m=mean(G12_3);

G12_4=[273 366 402 357 427
       288 356 448 380 325]; G12_4s=std(G12_4); G12_4m=mean(G12_4);

G12_5=[299 417 526 346 367
       266 399 418 420 327]; G12_5s=std(G12_5); G12_5m=mean(G12_5);

G12_6=[286 485 414 438 400
       307 410 406 372 352];  G12_6s=std(G12_6); G12_6m=mean(G12_6);

time=[4 10 14 20 25];
gamma=[10e-9 1e-9 100e-12 10e-12 1e-12 0];

figure()
subplot(1,3,1)
hold on
errorbar(time, G12_1m, G12_1s, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
errorbar(time, G12_2m, G12_2s, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', [1 0.5 0], 'markersize', 10)
errorbar(time, G12_3m, G12_3s, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 10)
errorbar(time, G12_4m, G12_4s, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'g', 'markersize', 10)
errorbar(time, G12_5m, G12_5s, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
errorbar(time, G12_6m, G12_6s, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'k', 'markersize', 10)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 20, 'yscale', 'log', 'xgrid', 'on', 'ygrid', 'on', 'ylim', [10 1000])
xlabel('Time, (hours)')
ylabel('log IFN-\gammaR\beta')
title('IFN-\gammaR\beta over time for different IFN-\gamma+DMSO vehicle')
legend('10nM', '1nM', '100pM', '10pM', '1pM', '0')
box on

G3_1=[134 135 183 257 206];
G3_2=[163 234 235 300 351];
G3_3=[262 296 302 348 327];
G3_4=[270 302 319 335 479];
G3_5=[278 320 314 307 348];
G3_6=[292 344 397 312 310];

subplot(1,3,2)
hold on
plot(time, G3_1, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
plot(time, G3_2, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', [1 0.5 0], 'markersize', 10)
plot(time, G3_3, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 10)
plot(time, G3_4, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'g', 'markersize', 10)
plot(time, G3_5, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
plot(time, G3_6, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'k', 'markersize', 10)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 20, 'yscale', 'log', 'xgrid', 'on', 'ygrid', 'on', 'ylim', [10 1000])
xlabel('Time, (hours)')
ylabel('log IFN-\gammaR\beta')
title('IFN-\gammaR\beta for different IFN-\gamma + p6 Jaki')
box on

G4_1=[268 342 499 454 524];
G4_2=[262 400 558 548 483];
G4_3=[248 408 532 531 461];
G4_4=[255 419 539 614 464];
G4_5=[273 437 568 513 498];
G4_6=[260 484 607 563 622];

subplot(1,3,3)
hold on
plot(time, G4_1, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
plot(time, G4_2, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', [1 0.5 0], 'markersize', 10)
plot(time, G4_3, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 10)
plot(time, G4_4, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'g', 'markersize', 10)
plot(time, G4_5, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
plot(time, G4_6, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'k', 'markersize', 10)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 20, 'yscale', 'log', 'xgrid', 'on', 'ygrid', 'on', 'ylim', [10 1000])
xlabel('Time, (hours)')
ylabel('log IFN-\gammaR\beta')
title('IFN-\gammaR\beta over time for different IFN-\gamma + \alpha-IFN-\gamma')
box on
%%
%Plot pSTAT1 over time for different conditions

G12_1=[360 390 714 552 535
       429 311 295 436 459]; G12_1s=std(G12_1); G12_1m=mean(G12_1);
G12_2=[409 545 559 379 378
       427 285 239 379 361]; G12_2s=std(G12_2); G12_2m=mean(G12_2);
G12_3=[248 318 278 284 258
       251 217 242 269 265]; G12_3s=std(G12_3); G12_3m=mean(G12_3);
G12_4=[205 243 220 256 228
       209 240 210 285 244]; G12_4s=std(G12_4); G12_4m=mean(G12_4);
G12_5=[213 224 223 226 205
       207 209 199 249 222]; G12_5s=std(G12_5); G12_5m=mean(G12_5);
G12_6=[206 251 227 200 232
       200 226 203 258 235];  G12_6s=std(G12_6); G12_6m=mean(G12_6);
   
figure()
subplot(1,3,1)
hold on
errorbar(time, G12_1m, G12_1s, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
errorbar(time, G12_2m, G12_2s, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', [1 0.5 0], 'markersize', 10)
errorbar(time, G12_3m, G12_3s, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 10)
errorbar(time, G12_4m, G12_4s, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'g', 'markersize', 10)
errorbar(time, G12_5m, G12_5s, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
errorbar(time, G12_6m, G12_6s, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'k', 'markersize', 10)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 20, 'yscale', 'log', 'xgrid', 'on', 'ygrid', 'on', 'ylim', [100 1000])
xlabel('Time, (hours)')
ylabel('log pSTAT1')
title('pSTAT1 over time for different IFN-\gamma+DMSO vehicle')
legend('10nM', '1nM', '100pM', '10pM', '1pM', '0')
box on

G3_1=[416 311 295 331 349];
Int_G3_1=[trapz(time(1:2), G3_1(1:2)), trapz(time(1:3), G3_1(1:3)), trapz(time(1:4), G3_1(1:4)), trapz(time(1:5), G3_1(1:5))];
G3_2=[377 285 239 293 263];
Int_G3_2=[trapz(time(1:2), G3_2(1:2)), trapz(time(1:3), G3_2(1:3)), trapz(time(1:4), G3_2(1:4)), trapz(time(1:5), G3_2(1:5))];
G3_3=[250 217 242 251 206];
Int_G3_3[trapz(time(1:2), G3_3(1:2)), trapz(time(1:3), G3_3(1:3)), trapz(time(1:4), G3_3(1:4)), trapz(time(1:5), G3_3(1:5))];
G3_4=[211 240 210 227 206];
Int_G3_4[trapz(time(1:2), G3_4(1:2)), trapz(time(1:3), G3_4(1:3)), trapz(time(1:4), G3_4(1:4)), trapz(time(1:5), G3_4(1:5))];
G3_5=[195 209 199 234 226];
Int_G3_5[trapz(time(1:2), G3_5(1:2)), trapz(time(1:3), G3_5(1:3)), trapz(time(1:4), G3_5(1:4)), trapz(time(1:5), G3_5(1:5))];
G3_6=[206 226 203 300 262];
Int_G3_6[trapz(time(1:2), G3_6(1:2)), trapz(time(1:3), G3_6(1:3)), trapz(time(1:4), G3_6(1:4)), trapz(time(1:5), G3_6(1:5))];


subplot(1,3,2)
hold on
plot(time, G3_1, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
plot(time, G3_2, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', [1 0.5 0], 'markersize', 10)
plot(time, G3_3, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 10)
plot(time, G3_4, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'g', 'markersize', 10)
plot(time, G3_5, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
plot(time, G3_6, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'k', 'markersize', 10)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 20, 'yscale', 'log', 'xgrid', 'on', 'ygrid', 'on', 'ylim', [100 1000])
xlabel('Time, (hours)')
ylabel('log pSTAT1')
title('pSTAT1 for different IFN-\gamma + p6 Jaki')
box on

G3_1=[312 540 650 809 522];
G3_2=[294 487 414 489 697];
G3_3=[270 273 204 173 233];
G3_4=[269 161 104 77.8 113];
G3_5=[263 148 93 70.7 73.4];
G3_6=[268 153 101 53.6 91.3];


G4_1=[270 244 280 330 342];
Int_G4_1=[trapz(time(1:2), G4_1(1:2)), trapz(time(1:3), G4_1(1:3)), trapz(time(1:4), G4_1(1:4)), trapz(time(1:5), G4_1(1:5))];
G4_2=[227 266 249 262 300];
Int_G4_2=[trapz(time(1:2), G4_2(1:2)), trapz(time(1:3), G4_2(1:3)), trapz(time(1:4), G4_2(1:4)), trapz(time(1:5), G4_2(1:5))];
G4_3=[226 243 236 259 283];
Int_G4_3=[trapz(time(1:2), G4_3(1:2)), trapz(time(1:3), G4_3(1:3)), trapz(time(1:4), G4_3(1:4)), trapz(time(1:5), G4_3(1:5))];
G4_4=[201 217 252 258 260];
Int_G4_4=[trapz(time(1:2), G4_4(1:2)), trapz(time(1:3), G4_4(1:3)), trapz(time(1:4), G4_4(1:4)), trapz(time(1:5), G4_4(1:5))];
G4_5=[201 233 254 235 266];
Int_G4_5[trapz(time(1:2), G4_5(1:2)), trapz(time(1:3), G4_5(1:3)), trapz(time(1:4), G4_5(1:4)), trapz(time(1:5), G4_5(1:5))];
G4_6=[209 237 256 255 294];
Int_G4_6[trapz(time(1:2), G4_6(1:2)), trapz(time(1:3), G4_6(1:3)), trapz(time(1:4), G4_6(1:4)), trapz(time(1:5), G4_6(1:5))];

subplot(1,3,3)
hold on
plot(time, G4_1, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
plot(time, G4_2, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', [1 0.5 0], 'markersize', 10)
plot(time, G4_3, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 10)
plot(time, G4_4, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'g', 'markersize', 10)
plot(time, G4_5, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
plot(time, G4_6, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'k', 'markersize', 10)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 20, 'yscale', 'log', 'xgrid', 'on', 'ygrid', 'on', 'ylim', [100 1000])
xlabel('Time, (hours)')
ylabel('log pSTAT1')
title('pSTAT1 over time for different IFN-\gamma + \alpha-IFN-\gamma')
box on


G4_1=[269 184 144 92.7 63.3];
G4_2=[274 173 116 70.1 50.8];
G4_3=[264 170 120 60.4 44.9];
G4_4=[266 170 115 64.7 45.3];
G4_5=[268 163 111 57.3 43.2];
G4_6=[270 173 119 61.5 53.2];


%%

%pSTAT1 staining & subtracting out the Jaki background

G12_1=[360 390 714 552 535
       429 311 295 436 459]; G12_1s=std(G12_1); G12_1m=mean(G12_1); %G12_1m=G12_1m-G3_1; 

Int_G12_1=[trapz(time(1:2), G12_1m(1:2)), trapz(time(1:3), G12_1m(1:3)), trapz(time(1:4), G12_1m(1:4)), trapz(time(1:5), G12_1m(1:5))];

G12_2=[409 545 559 379 378
       427 285 239 379 361]; G12_2s=std(G12_2); G12_2m=mean(G12_2); %G12_2m=G12_2m-G3_2; 

Int_G12_2=[trapz(time(1:2), G12_2m(1:2)), trapz(time(1:3), G12_2m(1:3)), trapz(time(1:4), G12_2m(1:4)), trapz(time(1:5), G12_2m(1:5))];   
   
G12_3=[248 318 278 284 258
       251 217 242 269 265];  G12_3s=std(G12_3); G12_3m=mean(G12_3); %G12_3m=G12_3m-G3_3; 

Int_G12_3=[trapz(time(1:2), G12_3m(1:2)), trapz(time(1:3), G12_3m(1:3)), trapz(time(1:4), G12_3m(1:4)), trapz(time(1:5), G12_3m(1:5))];

G12_4=[205 243 220 256 228
       209 240 210 285 244]; G12_4s=std(G12_4); G12_4m=mean(G12_4); %G12_4m=G12_4m-G3_4; 

Int_G12_4=[trapz(time(1:2), G12_4m(1:2)), trapz(time(1:3), G12_4m(1:3)), trapz(time(1:4), G12_4m(1:4)), trapz(time(1:5), G12_4m(1:5))];   
   
G12_5=[213 224 223 226 205
       207 209 199 249 222]; G12_5s=std(G12_5); G12_5m=mean(G12_5); %G12_5m=G12_5m-G3_5; 

Int_G12_5=[trapz(time(1:2), G12_5m(1:2)), trapz(time(1:3), G12_5m(1:3)), trapz(time(1:4), G12_5m(1:4)), trapz(time(1:5), G12_5m(1:5))];

G12_6=[206 251 227 200 232
       200 226 203 258 235];  G12_6s=std(G12_6); G12_6m=mean(G12_6); %G12_6m=G12_6m-G3_6; 

Int_G12_6=[trapz(time(1:2), G12_6m(1:2)), trapz(time(1:3), G12_6m(1:3)), trapz(time(1:4), G12_6m(1:4)), trapz(time(1:5), G12_6m(1:5))];


time=[4 10 14 20 25];
gamma=[10e-9 1e-9 100e-12 10e-12 1e-12 0];


figure()
hold on
plot(Int_G12_1, G12_1(2:5), 'o', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
plot(Int_G12_2, G12_2(2:5), 'o', 'markeredgecolor', 'k', 'markerfacecolor', [1 0.5 0], 'markersize', 10)
plot(Int_G12_3, G12_3(2:5), 'o', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 10)
plot(Int_G12_4, G12_4(2:5), 'o', 'markeredgecolor', 'k', 'markerfacecolor', 'g', 'markersize', 10)
plot(Int_G12_5, G12_5(2:5), 'o', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
plot(Int_G12_6, G12_6(2:5), 'o', 'markeredgecolor', 'k', 'markerfacecolor', 'k', 'markersize', 10)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 20, 'yscale', 'log', 'xscale', 'log', 'xgrid', 'on', 'ygrid', 'on', 'xlim', [1000 10000], 'ylim', [100 20000])
ylabel('log H-2K^b at each t')
xlabel('log \int pSTAT1 at each t')
title('\int pSTAT1 versus MHC for IFN-\gamma+DMSO vehicle')
legend('10nM', '1nM', '100pM', '10pM', '1pM', '0')
box on

%plot pSTAT1 over time with background subtracted
figure()
hold on
plot(time, G12_1m, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
plot(time, G12_2m, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', [1 0.5 0], 'markersize', 10)
plot(time, G12_3m, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 10)
plot(time, G12_4m, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'g', 'markersize', 10)
plot(time, G12_5m, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
plot(time, G12_6m, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 20, 'yscale', 'log', 'xgrid', 'on', 'ygrid', 'on')
xlabel('Time, (hours)')
ylabel('log pSTAT1')
title('pSTAT1 over time for different IFN-\gamma + DMSO vehicle')
box on
%%
%MHC versus pSTAT1 integral
G12_1=[321 875 2745 8251 10439
       323 929 2640 5468 10180]; G12_1s=std(G12_1); G12_1m=mean(G12_1);

G12_2=[325 782 2070 6043 9064
       305 752 2005 5157 7720]; G12_2s=std(G12_2); G12_2m=mean(G12_2);

G12_3=[300 415 562 1135 1787
       279 394 543 1091 1807];  G12_3s=std(G12_3); G12_3m=mean(G12_3);

G12_4=[286 232 184 218 267
       255 215 171 146 257]; G12_4s=std(G12_4); G12_4m=mean(G12_4);

G12_5=[274 206 154 152 197
       261 192 142 111 184]; G12_5s=std(G12_5); G12_5m=mean(G12_5);

G12_6=[294 210 153 146 169
       273 194 132 123 172]; G12_6s=std(G12_6); G12_6m=mean(G12_6);
   
   


figure()
hold on
plot(Int_G12_1, G12_1m(2:5), 'o', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
plot(Int_G12_2, G12_2m(2:5), 'o', 'markeredgecolor', 'k', 'markerfacecolor', [1 0.5 0], 'markersize', 10)
plot(Int_G12_3, G12_3m(2:5), 'o', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 10)
plot(Int_G12_4, G12_4m(2:5), 'o', 'markeredgecolor', 'k', 'markerfacecolor', 'g', 'markersize', 10)
plot(Int_G12_5, G12_5m(2:5), 'o', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
plot(Int_G12_6, G12_6m(2:5), 'o', 'markeredgecolor', 'k', 'markerfacecolor', 'k', 'markersize', 10)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 20, 'yscale', 'log', 'xscale', 'log', 'xgrid', 'on', 'ygrid', 'on')
ylabel('log H-2K^b at each t')
xlabel('log \int pSTAT1 at each t')
title('\int pSTAT1 versus MHC for IFN-\gamma+DMSO vehicle')
legend('10nM', '1nM', '100pM', '10pM', '1pM', '0')
box on

%%

G3_1=[416 311 295 331 349];
Int_G3_1=[trapz(time(1:2), G3_1(1:2)), trapz(time(1:3), G3_1(1:3)), trapz(time(1:4), G3_1(1:4)), trapz(time(1:5), G3_1(1:5))];

G3_2=[377 285 239 293 263];
Int_G3_2=[trapz(time(1:2), G3_2(1:2)), trapz(time(1:3), G3_2(1:3)), trapz(time(1:4), G3_2(1:4)), trapz(time(1:5), G3_2(1:5))];

G3_3=[250 217 242 251 206];
Int_G3_3[trapz(time(1:2), G3_3(1:2)), trapz(time(1:3), G3_3(1:3)), trapz(time(1:4), G3_3(1:4)), trapz(time(1:5), G3_3(1:5))];

G3_4=[211 240 210 227 206];
Int_G3_4[trapz(time(1:2), G3_4(1:2)), trapz(time(1:3), G3_4(1:3)), trapz(time(1:4), G3_4(1:4)), trapz(time(1:5), G3_4(1:5))];

G3_5=[195 209 199 234 226];
Int_G3_5[trapz(time(1:2), G3_5(1:2)), trapz(time(1:3), G3_5(1:3)), trapz(time(1:4), G3_5(1:4)), trapz(time(1:5), G3_5(1:5))];

G3_6=[206 226 203 300 262];
Int_G3_6[trapz(time(1:2), G3_6(1:2)), trapz(time(1:3), G3_6(1:3)), trapz(time(1:4), G3_6(1:4)), trapz(time(1:5), G3_6(1:5))];


G3_1_m=[312 540 650 809 522];
G3_2_m=[294 487 414 489 697];
G3_3_m=[270 273 204 173 233];
G3_4_m=[269 161 104 77.8 113];
G3_5_m=[263 148 93 70.7 73.4];
G3_6_m=[268 153 101 53.6 91.3];

figure()
hold on
plot(Int_G3_1, G3_1_m(2:5), 'o', 'markeredgecolor', 'y', 'markerfacecolor', 'r', 'markersize', 10)
plot(Int_G3_2, G3_2_m(2:5), 'o', 'markeredgecolor', 'y', 'markerfacecolor', [1 0.5 0], 'markersize', 10)
plot(Int_G3_3, G3_3_m(2:5), 'o', 'markeredgecolor', 'y', 'markerfacecolor', 'y', 'markersize', 10)
plot(Int_G3_4, G3_4_m(2:5), 'o', 'markeredgecolor', 'y', 'markerfacecolor', 'g', 'markersize', 10)
plot(Int_G3_5, G3_5_m(2:5), 'o', 'markeredgecolor', 'y', 'markerfacecolor', 'b', 'markersize', 10)
plot(Int_G3_6, G3_6_m(2:5), 'o', 'markeredgecolor', 'y', 'markerfacecolor', 'k', 'markersize', 10)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 20, 'yscale', 'log', 'xscale', 'log', 'xgrid', 'on', 'ygrid', 'on')
ylabel('log H-2K^b at each t')
xlabel('log \int pSTAT1 at each t')
title('\int pSTAT1 versus MHC for IFN-\gamma+DMSO vehicle')
legend('10nM', '1nM', '100pM', '10pM', '1pM', '0')
box on
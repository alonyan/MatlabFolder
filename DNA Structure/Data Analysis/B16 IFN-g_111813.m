%% B16 IFN-g stimulation 11.17.13

%Group 1: Vehicle (DMSO) added at T0
%Group 2: Vehicle added at 5hr post culture
%Group 3: Jaki (azd1480 - 10uM) added at T0
%Group 4: Jaki added at 5hr post culture

%% MHC up-regulation for different groups

time=[0 5 10 12.5 15 17.5 25.5];

gamma=[10e-9 1e-9 100e-12 10e-12 1e-12 0];

MHC_g1=[510  510  510  510  510  510
        734  633  543  501  477  461
        1441 1080 640  463  408  376
        2568 1818 815  425  371  376
        3674 2289 979  464  370  338
        5503 3651 1217 537  423  383
        5622 5016 1383 524  385  370]; %Group 1
    
MHC_g1_amp=MHC_g1(7,:)-min(MHC_g1(7,:));

figure()
plot(gamma, MHC_g1_amp, '-ko', 'markerfacecolor', 'r', 'markeredgecolor', 'k', 'markersize', 10)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 25, 'yscale', 'log', 'xscale' ,'log')
xlabel('gamma, [M]')
ylabel('Amplitude of MHC Response')

%Convert the fluorescence for APC into actual # of MHC molecules using the
%linear regression fitted to the APC calibration beads 
y_g1=MHC_g1;    
x_g1=(y_g1-99.6)/.003047;
MHC_g1_mol=x_g1;

Isotype_g1=[288 288 288 288 288 288   
         455 401 446 453 423 412
         392 401 459 417 451 454
         258 330 378 418 429 346 
         182 258 386 422 364 406
         167 316 402 558 574 501
         85  159 339 326 325 358]; %Isotype for Group 1
     
MHC_g3=[510 510 510 510 510 510
        387 341 419 421 420 420
        375 369 346 359 323 348
        358 353 335 323 312 276
        348 358 318 313 300 279
        358 354 348 306 305 310
        354 349 315 299 283 284]; %Group 3

y_g3=MHC_g3;    
x_g3=(y_g3-99.6)/.003047;
MHC_g3_mol=x_g3;
    
Isotype_g3=[288 288 288 288 288 288
            433 433 406 406 395 406
            444 453 439 473 442 421
            379 439 419 389 406 418
            437 421 411 428 432 439
            445 398 535 473 436 496
            437 451 481 415 433 456]; %Isotype for Group 3 
        
MHC_g2=[510  510  510  510 510 510
        611  573  515  452 466 451
        1174 1023 654  441 369 375
        2775 1814 760  407 362 357
        3829 2742 906  429 365 341
        5617 3749 1083 477 407 375
        6846 4821 1363 479 397 367]; %Group 2

y_g2=MHC_g2;    
x_g2=(y_g2-99.6)/.003047;
MHC_g2_mol=x_g2;
    
Isotype_g2=[288 288 288 288 288 288
            462 383 421 406 409 415
            376 413 465 457 414 415
            313 344 355 356 437 382
            214 551 415 400 423 483
            180 268 420 435 495 414
            147 216 296 360 348 413]; %Isotype for Group 2 
        
MHC_g4=[510  510  510 510 510 510
        586  544  491 430 441 446
        997  819  539 376 350 335
        1435 1054 605 360 321 296
        1405 1092 560 345 296 262
        1796 1213 580 310 272 253
        1245 1059 510 274 244 217]; %Group 4
    
y_g4=MHC_g4;    
x_g4=(y_g4-99.6)/.003047;
MHC_g4_mol=x_g4;
    
Isotype_g4=[288 288 288 288 288 288
            427 373 381 393 446 471
            407 451 483 455 435 456
            367 350 430 431 374 395
            365 364 372 359 446 417
            429 461 492 475 474 524
            390 466 442 453 446 412]; %Isotype for Group 4 
    

%Plot the MHC upregulation for group 3 and it's control (group 1) (Jaki or DMSO added @ T0)
figure() 
subplot(2,2,1)
hold on
plot(time, MHC_g1(:,1), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
plot(time, MHC_g1(:,2), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', [1 0.5 0], 'markersize', 10)
plot(time, MHC_g1(:,3), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 10)
plot(time, MHC_g1(:,4), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'g', 'markersize', 10)
plot(time, MHC_g1(:,5), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
plot(time, MHC_g1(:,6), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'k', 'markersize', 10)
%plot(time, Isotype_g1, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'w', 'markersize', 10)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 25, 'yscale', 'log', 'xgrid', 'on', 'ygrid', 'on', 'ylim', [1e2 1e4])
xlabel('Time, (hours)')
ylabel('log H-2K^b')
legend('10nM IFN-\gamma', '1nM', '100pM', '10pM', '1pM', '0', 'Isotype')
box on
title('MHC exp for DMSO vehicle @ T0')

MHC_g1_backg=MHC_g1-Isotype_g1;

subplot(2,2,2)
hold on
plot(time, MHC_g1_backg(:,1), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
plot(time, MHC_g1_backg(:,2), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', [1 0.5 0], 'markersize', 10)
plot(time, MHC_g1_backg(:,3), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 10)
plot(time, MHC_g1_backg(:,4), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'g', 'markersize', 10)
plot(time, MHC_g1_backg(:,5), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
plot(time, MHC_g1_backg(:,6), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'k', 'markersize', 10)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 25, 'yscale', 'log', 'xgrid', 'on', 'ygrid', 'on', 'ylim', [1e2 1e4])
xlabel('Time, (hours)')
ylabel('log H-2K^b')
box on
title('MHC exp for DMSO vehicle @ T0, Isotype subtr')
subplot(2,2,3)
hold on
plot(time, MHC_g3(:,1), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
plot(time, MHC_g3(:,2), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', [1 0.5 0], 'markersize', 10)
plot(time, MHC_g3(:,3), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 10)
plot(time, MHC_g3(:,4), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'g', 'markersize', 10)
plot(time, MHC_g3(:,5), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
plot(time, MHC_g3(:,6), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'k', 'markersize', 10)
%plot(time, Isotype_g3, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'w', 'markersize', 10)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 25, 'yscale', 'log', 'xgrid', 'on', 'ygrid', 'on', 'ylim', [1e2 1e4])
xlabel('Time, (hours)')
ylabel('log H-2K^b')
box on
title('MHC exp for 10uM Jaki (AZD1480) @ T0')

MHC_g3_backg=MHC_g3-Isotype_g3;

subplot(2,2,4)
hold on
plot(time, MHC_g3_backg(:,1), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
plot(time, MHC_g3_backg(:,2), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', [1 0.5 0], 'markersize', 10)
plot(time, MHC_g3_backg(:,3), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 10)
plot(time, MHC_g3_backg(:,4), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'g', 'markersize', 10)
plot(time, MHC_g3_backg(:,5), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
plot(time, MHC_g3_backg(:,6), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'k', 'markersize', 10)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 25, 'yscale', 'log', 'xgrid', 'on', 'ygrid', 'on', 'ylim', [1e2 1e4])
xlabel('Time, (hours)')
ylabel('log H-2K^b')
box on
title('MHC exp for 10uM Jaki (AZD1480) @ T0, Isotype subtr')

%Plot the MHC upregulation for group 4 and it's control (group 2) (Jaki or DMSO added 5 hours post culture)
figure()
subplot(2,2,1)
hold on
plot(time, MHC_g2(:,1), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
plot(time, MHC_g2(:,2), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', [1 0.5 0], 'markersize', 10)
plot(time, MHC_g2(:,3), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 10)
plot(time, MHC_g2(:,4), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'g', 'markersize', 10)
plot(time, MHC_g2(:,5), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
plot(time, MHC_g2(:,6), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'k', 'markersize', 10)
%plot(time, Isotype_g2, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'w', 'markersize', 10)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 25, 'yscale', 'log', 'xgrid', 'on', 'ygrid', 'on', 'ylim', [1e2 1e4])
xlabel('Time, (hours)')
ylabel('log H-2K^b')
legend('10nM IFN-\gamma', '1nM', '100pM', '10pM', '1pM', '0', 'Isotype')
box on
title('MHC exp for DMSO vehicle 5hr post-culture')

MHC_g2_backg=MHC_g2-Isotype_g2;

subplot(2,2,2)
hold on
plot(time, MHC_g2_backg(:,1), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
plot(time, MHC_g2_backg(:,2), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', [1 0.5 0], 'markersize', 10)
plot(time, MHC_g2_backg(:,3), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 10)
plot(time, MHC_g2_backg(:,4), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'g', 'markersize', 10)
plot(time, MHC_g2_backg(:,5), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
plot(time, MHC_g2_backg(:,6), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'k', 'markersize', 10)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 25, 'yscale', 'log', 'xgrid', 'on', 'ygrid', 'on', 'ylim', [1e2 1e4])
xlabel('Time, (hours)')
ylabel('log H-2K^b')
box on
title('MHC exp for DMSO vehicle 5hr post-culture, Isotype subtr')
subplot(2,2,3)
hold on
plot(time, MHC_g4(:,1), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
plot(time, MHC_g4(:,2), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', [1 0.5 0], 'markersize', 10)
plot(time, MHC_g4(:,3), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 10)
plot(time, MHC_g4(:,4), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'g', 'markersize', 10)
plot(time, MHC_g4(:,5), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
plot(time, MHC_g4(:,6), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'k', 'markersize', 10)
%plot(time, Isotype_g4, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'w', 'markersize', 10)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 25, 'yscale', 'log', 'xgrid', 'on', 'ygrid', 'on', 'ylim', [1e2 1e4])
xlabel('Time, (hours)')
ylabel('log H-2K^b')
box on
title('MHC exp for 10uM Jaki (AZD1480) 5hr post-culture')

MHC_g4_backg=MHC_g4-Isotype_g4;

subplot(2,2,4)
hold on
plot(time, MHC_g4_backg(:,1), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
plot(time, MHC_g4_backg(:,2), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', [1 0.5 0], 'markersize', 10)
plot(time, MHC_g4_backg(:,3), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 10)
plot(time, MHC_g4_backg(:,4), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'g', 'markersize', 10)
plot(time, MHC_g4_backg(:,5), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
plot(time, MHC_g4_backg(:,6), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'k', 'markersize', 10)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 25, 'yscale', 'log', 'xgrid', 'on', 'ygrid', 'on', 'ylim', [1e2 1e4])
xlabel('Time, (hours)')
ylabel('log H-2K^b')
box on
title('MHC exp for 10uM Jaki (AZD1480) 5hr post-culture, Isotype subtr')

tsehvah=['r', 'm', 'y', 'g', 'b', 'k'];

figure()
subplot(1,3,1)
hold on
for i=[1 2 3 4 5 6]
    plot(time, MHC_g1_mol(:,i), '-ko', 'markerfacecolor', tsehvah(:,i), 'markersize', 8)
end
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 25, 'yscale' ,'log', 'xgrid', 'on', 'ygrid', 'on', 'ylim', [3e4 1e7])
xlabel('Time, (hours)')
ylabel('#H-2K^b molecules')
box on
title('DMSO vehicle @ T0')
% subplot(2,2,2)
% hold on
% for i=[1 2 3 4 5 6]
%     plot(time, MHC_g2_mol(:,i), '-ko', 'markerfacecolor', tsehvah(:,i), 'markersize', 8)
% end
% set(gcf, 'color', 'w')
% set(gca, 'Fontsize', 25, 'yscale' ,'log', 'xgrid', 'on', 'ygrid', 'on')
% xlabel('Time, (hours)')
% ylabel('log #H-2K^b molecules')
% box on
% title('# of class I for DMSO vehicle 5hr post-culture')
subplot(1,3,2)
hold on
for i=[1 2 3 4 5 6]
    plot(time, MHC_g3_mol(:,i), '-ko', 'markerfacecolor', tsehvah(:,i), 'markersize', 8)
end
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 25, 'yscale' ,'log', 'xgrid', 'on', 'ygrid', 'on', 'ylim', [3e4 1e7])
xlabel('Time, (hours)')
ylabel('#H-2K^b molecules')
box on
legend('10nM IFN-\gamma', '1nM', '100pM', '10pM', '1pM', '0')
title('10uM Jaki(azd1480) @ T0')
subplot(1,3,3)
hold on
for i=[1 2 3 4 5 6]
    plot(time, MHC_g4_mol(:,i), '-ko', 'markerfacecolor', tsehvah(:,i), 'markersize', 8)
end
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 25, 'yscale' ,'log', 'xgrid', 'on', 'ygrid', 'on', 'ylim', [3e4 1e7])
xlabel('Time, (hours)')
ylabel('#H-2K^b molecules')
box on
title('10uM Jaki(azd1480) 5hr post-culture')
    
%% 
%Find the fold upregulation of MHC for each group by subtracting the
%isotype and then dividing by T0

MHC_g1=MHC_g1./222;
MHC_g2=MHC_g2./222;
MHC_g3=MHC_g3./222;
MHC_g4=MHC_g4./222;

figure()
subplot(2,2,1)
hold on
plot(time, MHC_g1(:,1), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
plot(time, MHC_g1(:,2), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', [1 0.5 0], 'markersize', 10)
plot(time, MHC_g1(:,3), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 10)
plot(time, MHC_g1(:,4), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'g', 'markersize', 10)
plot(time, MHC_g1(:,5), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
plot(time, MHC_g1(:,6), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'k', 'markersize', 10)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 25,'xgrid', 'on', 'ygrid', 'on', 'ylim', [-5 35])
legend('10nM IFN-\gamma', '1nM', '100pM', '10pM', '1pM', '0')
xlabel('Time, (hours)')
ylabel('fold H-2K^b up-regulation')
box on
title('Fold up-regulation of MHC for DMSO @ T0')
subplot(2,2,2)
hold on
plot(time, MHC_g3(:,1), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
plot(time, MHC_g3(:,2), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', [1 0.5 0], 'markersize', 10)
plot(time, MHC_g3(:,3), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 10)
plot(time, MHC_g3(:,4), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'g', 'markersize', 10)
plot(time, MHC_g3(:,5), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
plot(time, MHC_g3(:,6), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'k', 'markersize', 10)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 25,'xgrid', 'on', 'ygrid', 'on', 'ylim', [-5 10])
xlabel('Time, (hours)')
ylabel('fold H-2K^b up-regulation')
box on
title('Fold up-regulation of MHC for 10uM Jaki (azd1480) @ T0')
subplot(2,2,3)
hold on
plot(time, MHC_g2(:,1), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
plot(time, MHC_g2(:,2), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', [1 0.5 0], 'markersize', 10)
plot(time, MHC_g2(:,3), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 10)
plot(time, MHC_g2(:,4), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'g', 'markersize', 10)
plot(time, MHC_g2(:,5), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
plot(time, MHC_g2(:,6), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'k', 'markersize', 10)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 25,'xgrid', 'on', 'ygrid', 'on', 'ylim', [-5 35])
xlabel('Time, (hours)')
ylabel('fold H-2K^b up-regulation')
box on
title('Fold up-regulation of MHC for DMSO 5hr post-culture')
subplot(2,2,4)
hold on
plot(time, MHC_g4(:,1), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
plot(time, MHC_g4(:,2), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', [1 0.5 0], 'markersize', 10)
plot(time, MHC_g4(:,3), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 10)
plot(time, MHC_g4(:,4), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'g', 'markersize', 10)
plot(time, MHC_g4(:,5), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
plot(time, MHC_g4(:,6), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'k', 'markersize', 10)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 25,'xgrid', 'on', 'ygrid', 'on', 'ylim', [-5 10])
xlabel('Time, (hours)')
ylabel('fold H-2K^b up-regulation')
box on
title('Fold up-regulation of MHC for 10uM Jaki (azd1480) 5hr post-culture')
%% Expression of IFN-gR alpha and beta for different groups

alpha_g1=[1269 1269 1269 1269 1269 1269
          1492 1388 1481 1508 1478 1482
          1410 1419 1489 1384 1483 1499
          1309 1375 1343 1398 1443 1281
          1186 1321 1450 1436 1288 1357
          1298 1447 1389 1562 1563 1337
          1192 1415 1419 1361 1650 1353]; %Group 1 - alpha chain expression

%Convert the fluorescence for FITC into actual # of alpha chain molecules using the
%linear regression fitted to the FITC calibration beads 
y_g1_a=alpha_g1;    
x_g1_a=(y_g1_a-738.8)/.08539;
alpha_g1_mol=x_g1_a;
      
beta_g1=[299 299 299 299 299 299
         251 280 420 461 433 410
         199 334 447 427 458 457
         156 325 400 433 418 346
         175 298 387 419 359 417
         286 466 451 582 595 474
         181 329 337 280 243 336]; %Group 1 - beta chain expression
     
%Convert the fluorescence for Pe into actual # of beta chain molecules using the
%linear regression fitted to the Pe calibration beads 
y_g1_b=beta_g1;    
x_g1_b=(y_g1_b-139.8)/.06696;
beta_g1_mol=x_g1_b;
     
alpha_g3=[1269 1269 1269 1269 1269 1269
          1560 1401 1452 1439 1418 1477
          1548 1493 1511 1540 1420 1415
          1342 1435 1369 1329 1372 1331
          1374 1339 1338 1369 1397 1374
          1413 1321 1527 1404 1351 1418
          1449 1522 1594 1468 1518 1584]; %group 3

y_g3_a=alpha_g3;    
x_g3_a=(y_g3_a-738.8)/.08539;
alpha_g3_mol=x_g3_a;
      
beta_g3=[299 299 299 299 299 299
         204 334 392 409 394 410
         239 412 421 473 420 439
         203 440 451 414 426 394
         264 401 418 430 446 466
         288 384 564 482 445 521
         271 406 441 377 410 434]; %Group 3
     
y_g3_b=beta_g3;    
x_g3_b=(y_g3_b-139.8)/.06696;
beta_g3_mol=x_g3_b;
     
alpha_g2=[1269 1269 1269 1269 1269 1269
          1490 1331 1463 1421 1445 1474
          1388 1462 1578 1534 1394 1403
          1405 1431 1313 1272 1422 1346
          1218 1568 1412 1353 1376 1456
          1297 1399 1392 1380 1448 1326
          1365 1483 1459 1532 1467 1445]; %group 2

y_g2_a=alpha_g2;    
x_g2_a=(y_g2_a-738.8)/.08539;
alpha_g2_mol=x_g2_a;
      
beta_g2=[299 299 299 299 299 299
         233 259 395 403 415 433
         190 329 455 470 405 431
         226 332 391 366 464 401
         220 702 431 403 430 485
         297 423 433 432 500 396
         344 412 290 308 309 384];  %group 2
     
y_g2_b=beta_g2;    
x_g2_b=(y_g2_b-139.8)/.06696;
beta_g2_mol=x_g2_b;

alpha_g4=[1269 1269 1269 1269 1269 1269
          1495 1366 1458 1456 1514 1580
          1531 1556 1623 1540 1439 1486
          1450 1358 1526 1522 1330 1394
          1384 1381 1400 1346 1463 1353
          1346 1376 1343 1326 1340 1411
          1343 1461 1456 1431 1474 1391];  %group 4

y_g4_a=alpha_g4;    
x_g4_a=(y_g4_a-738.8)/.08539;
alpha_g4_mol=x_g4_a;
      
beta_g4=[299 299 299 299 299 299
         198 249 349 393 474 506
         211 369 461 444 439 469 
         224 330 432 434 389 389
         239 369 362 365 463 437
         560 572 580 545 541 581
         374 474 445 450 449 397];  %group 4

y_g4_b=beta_g4;    
x_g4_b=(y_g4_b-139.8)/.06696;
beta_g4_mol=x_g4_b;
     
%Plot IFN-gammaR alpha and beta expression for groups 1 and 3
figure() 
subplot(2,2,1)
hold on
plot(time, alpha_g1(:,1), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
plot(time, alpha_g1(:,2), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', [1 0.5 0], 'markersize', 10)
plot(time, alpha_g1(:,3), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 10)
plot(time, alpha_g1(:,4), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'g', 'markersize', 10)
plot(time, alpha_g1(:,5), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
plot(time, alpha_g1(:,6), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'k', 'markersize', 10)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 25, 'yscale', 'log', 'xgrid', 'on', 'ygrid', 'on', 'ylim', [1e3 1e4])
xlabel('Time, (hours)')
ylabel('log IFN-\gammaR\alpha')
legend('10nM IFN-\gamma', '1nM', '100pM', '10pM', '1pM', '0')
box on
title('\gammaR\alpha exp. for DMSO vehicle @ T0')
subplot(2,2,2)
hold on
plot(time, beta_g1(:,1), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
plot(time, beta_g1(:,2), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', [1 0.5 0], 'markersize', 10)
plot(time, beta_g1(:,3), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 10)
plot(time, beta_g1(:,4), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'g', 'markersize', 10)
plot(time, beta_g1(:,5), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
plot(time, beta_g1(:,6), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'k', 'markersize', 10)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 25, 'yscale', 'log', 'xgrid', 'on', 'ygrid', 'on', 'ylim', [1e2 1e3])
xlabel('Time, (hours)')
ylabel('log IFN-\gammaR\beta')
box on
title('\gammaR\beta exp. for DMSO vehicle @ T0')
subplot(2,2,3)
hold on
plot(time, alpha_g3(:,1), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
plot(time, alpha_g3(:,2), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', [1 0.5 0], 'markersize', 10)
plot(time, alpha_g3(:,3), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 10)
plot(time, alpha_g3(:,4), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'g', 'markersize', 10)
plot(time, alpha_g3(:,5), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
plot(time, alpha_g3(:,6), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'k', 'markersize', 10)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 25, 'yscale', 'log', 'xgrid', 'on', 'ygrid', 'on', 'ylim', [1e3 1e4])
xlabel('Time, (hours)')
ylabel('log IFN-\gammaR\alpha')
box on
title('\gammaR\alpha exp. for 10uM Jaki (AZD1480) @ T0')
subplot(2,2,4)
hold on
plot(time, beta_g3(:,1), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
plot(time, beta_g3(:,2), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', [1 0.5 0], 'markersize', 10)
plot(time, beta_g3(:,3), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 10)
plot(time, beta_g3(:,4), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'g', 'markersize', 10)
plot(time, beta_g3(:,5), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
plot(time, beta_g3(:,6), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'k', 'markersize', 10)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 25, 'yscale', 'log', 'xgrid', 'on', 'ygrid', 'on', 'ylim', [1e2 1e3])
xlabel('Time, (hours)')
ylabel('log IFN-\gammaR\beta')
box on
title('\gammaR\beta exp. for 10uM Jaki (AZD1480) @ T0')

%Plot IFN-gammaR alpha and beta expression for groups 2 and 4
figure() 
subplot(2,2,1)
hold on
plot(time, alpha_g2(:,1), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
plot(time, alpha_g2(:,2), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', [1 0.5 0], 'markersize', 10)
plot(time, alpha_g2(:,3), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 10)
plot(time, alpha_g2(:,4), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'g', 'markersize', 10)
plot(time, alpha_g2(:,5), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
plot(time, alpha_g2(:,6), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'k', 'markersize', 10)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 25, 'yscale', 'log', 'xgrid', 'on', 'ygrid', 'on', 'ylim', [1e3 1e4])
xlabel('Time, (hours)')
ylabel('log IFN-\gammaR\alpha')
box on
title('\gammaR\alpha exp. for DMSO vehicle 5hr post-culture')
subplot(2,2,2)
hold on
plot(time, beta_g2(:,1), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
plot(time, beta_g2(:,2), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', [1 0.5 0], 'markersize', 10)
plot(time, beta_g2(:,3), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 10)
plot(time, beta_g2(:,4), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'g', 'markersize', 10)
plot(time, beta_g2(:,5), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
plot(time, beta_g2(:,6), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'k', 'markersize', 10)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 25, 'yscale', 'log', 'xgrid', 'on', 'ygrid', 'on', 'ylim', [1e2 1e3])
xlabel('Time, (hours)')
ylabel('log IFN-\gammaR\beta')
box on
title('\gammaR\beta exp. for DMSO vehicle 5hr post-culture')
subplot(2,2,3)
hold on
plot(time, alpha_g4(:,1), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
plot(time, alpha_g4(:,2), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', [1 0.5 0], 'markersize', 10)
plot(time, alpha_g4(:,3), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 10)
plot(time, alpha_g4(:,4), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'g', 'markersize', 10)
plot(time, alpha_g4(:,5), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
plot(time, alpha_g4(:,6), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'k', 'markersize', 10)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 25, 'yscale', 'log', 'xgrid', 'on', 'ygrid', 'on', 'ylim', [1e3 1e4])
xlabel('Time, (hours)')
ylabel('log IFN-\gammaR\alpha')
box on
title('\gammaR\alpha exp. for 10uM Jaki (AZD1480) 5hr post-culture')
subplot(2,2,4)
hold on
plot(time, beta_g4(:,1), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
plot(time, beta_g4(:,2), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', [1 0.5 0], 'markersize', 10)
plot(time, beta_g4(:,3), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 10)
plot(time, beta_g4(:,4), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'g', 'markersize', 10)
plot(time, beta_g4(:,5), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
plot(time, beta_g4(:,6), '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'k', 'markersize', 10)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 25, 'yscale', 'log', 'xgrid', 'on', 'ygrid', 'on', 'ylim', [1e2 1e3])
xlabel('Time, (hours)')
ylabel('log IFN-\gammaR\beta')
box on
title('\gammaR\beta exp. for 10uM Jaki (AZD1480) 5hr post-culture')

figure()
subplot(2,2,1)
hold on
for i=[1 2 3 4 5 6]
    plot(time, alpha_g1_mol(:,i), '-ko', 'markerfacecolor', tsehvah(:,i), 'markersize', 8)
    plot(time, beta_g1_mol(:,i), '--kd', 'markerfacecolor', tsehvah(:,i), 'markersize', 8)
end
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 25, 'yscale' ,'log', 'xgrid', 'on', 'ygrid', 'on', 'ylim', [1e2 1e5])
xlabel('Time, (hours)')
ylabel('log # molecules')
box on
title('# of \alpha and \beta R chains for DMSO vehicle @ T0')
subplot(2,2,2)
hold on
for i=[1 2 3 4 5 6]
    plot(time, alpha_g2_mol(:,i), '-ko', 'markerfacecolor', tsehvah(:,i), 'markersize', 8)
    plot(time, beta_g2_mol(:,i), '--kd', 'markerfacecolor', tsehvah(:,i), 'markersize', 8)
end
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 25, 'yscale' ,'log', 'xgrid', 'on', 'ygrid', 'on', 'ylim', [1e2 1e5])
xlabel('Time, (hours)')
ylabel('log # molecules')
box on
title('# of \alpha and \beta R chains for DMSO vehicle 5hr post-culture')
subplot(2,2,3)
hold on
for i=[1 2 3 4 5 6]
    plot(time, alpha_g3_mol(:,i), '-ko', 'markerfacecolor', tsehvah(:,i), 'markersize', 8)
    plot(time, beta_g3_mol(:,i), '--kd', 'markerfacecolor', tsehvah(:,i), 'markersize', 8)
end
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 25, 'yscale' ,'log', 'xgrid', 'on', 'ygrid', 'on', 'ylim', [1e2 1e5])
xlabel('Time, (hours)')
ylabel('log # molecules')
box on
title('# of \alpha and \beta R chains for 10uM Jaki(azd1480) @ T0')
subplot(2,2,4)
hold on
for i=[1 2 3 4 5 6]
    plot(time, alpha_g4_mol(:,i), '-ko', 'markerfacecolor', tsehvah(:,i), 'markersize', 8)
    plot(time, beta_g4_mol(:,i), '--kd', 'markerfacecolor', tsehvah(:,i), 'markersize', 8)
end
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 25, 'yscale' ,'log', 'xgrid', 'on', 'ygrid', 'on', 'ylim', [1e2 1e5])
xlabel('Time, (hours)')
ylabel('log # molecules')
box on
title('# of \alpha and \beta R chains for 10uM Jaki(azd1480) 5hr post-culture')

%%

%Plot the hill slope over time

time=[5 10 12.5 15 17.5 25.5];

G1_hill=[0.5811	0.7839	0.8681	0.7666	0.9663	1.522];
G2_hill=[0.8536	0.8556	0.8691	1.069	1.075	1.088];
G4_hill=[0.7759	0.7945	0.7333	0.8965	0.7864	1.077];

figure()
hold on
plot(time, G1_hill, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 10)
plot(time, G2_hill, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 10)
plot(time, G4_hill, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 10)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 25, 'xgrid', 'on', 'ygrid', 'on', 'ylim', [0.5 2])
xlabel('Time, (hours)')
ylabel('Hill Coefficient for different \gamma over time')
legend('DMSO @T0', 'DMSO 5hr post-culture', 'Jaki 5 hr post-culture')
box on


%%

%pSTAT1 staining 
  %t  1  2  3   4  5    6
time=[5 10 12.5 15 17.5 25.5];
       %g  %1  %2  %3  %4  %5  %6
pSTAT1_g1=[586 428 290 299 305 322
           621 443 371 307 330 338
           498 399 395 354 346 351
           771 478 389 400 388 441
           830 542 417 350 412 378
          1062 585 394 354 357 362]; %Group 1
      

      %I am a motherfucking genius and it took me all day to figure this
      %shit out
Int_g1=zeros(5,6); %Make a matrix of appropriate size to hold your data
for t=[2 3 4 5 6] %time from 1:2 or 3 or 4, etc...
    Int_g1(t-1,:)=[trapz(time(1:t), pSTAT1_g1(1:t,:))]; %Do this integration and put it into your pre-defined matrix
end
    
%Convert the fluorescence for PE into actual # of pSTAT1 molecules using the
%linear regression fitted to the Pe calibration beads UNCOMPENSATED (b/c you didn't compensate this data b/c it was so simple.  Cells stained only with dapi and anti-pSTAT1 Pe) 
y_g1_p=pSTAT1_g1;    
x_g1_p=(y_g1_p-204)/.06676;
pSTAT1_g1_mol=x_g1_p;
         
pSTAT1_g2=[476 411 343 282 285 334
           650 455 349 344 344 361
           635 421 389 404 394 408
           644 538 436 399 411 474
           923 581 415 384 391 392
           945 624 459 395 494 404];%Group 2
       
Int_g2=zeros(5,6);
for t=[2 3 4 5 6]
    Int_g2(t-1,:)=[trapz(time(1:t), pSTAT1_g2(1:t,:))];
end
       
y_g2_p=pSTAT1_g2;    
x_g2_p=(y_g2_p-204)/.06676;
pSTAT1_g2_mol=x_g2_p;

pSTAT1_g3=[273 289 294 287 295 305
           324 340 387 331 354 355
           365 350 349 328 318 325
           371 363 362 356 358 370
           459 370 362 361 370 388
           388 389 412 392 496 436]; %Group 3
       
Int_g3=zeros(5,6);
for t=[2 3 4 5 6]
    Int_g3(t-1,:)=[trapz(time(1:t), pSTAT1_g3(1:t,:))];
end

y_g3_p=pSTAT1_g3;    
x_g3_p=(y_g3_p-204)/.06676;
pSTAT1_g3_mol=x_g3_p;
       
pSTAT1_g4=[477 382 320 310 314 301
           328 341 356 345 328 361
           355 353 308 317 317 345
           376 362 347 353 352 368
           450 454 394 365 441 394
           438 500 469 444 470 450]; %Group 4
       
Int_g4=zeros(5,6);
for t=[2 3 4 5 6]
    Int_g4(t-1,:)=[trapz(time(1:t), pSTAT1_g4(1:t,:))];
end

y_g4_p=pSTAT1_g4;    
x_g4_p=(y_g4_p-204)/.06676;
pSTAT1_g4_mol=x_g4_p;
           
tsehvah=['r', 'm', 'y', 'g', 'b', 'k'];

figure()
subplot(2,2,1)
hold on
for i=[1 2 3 4 5 6]
plot(time, pSTAT1_g1(:,i), '-ko', 'markerfacecolor', tsehvah(:,i), 'markersize', 8)
end
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 25, 'xgrid', 'on', 'ygrid', 'on', 'yscale', 'log', 'ylim', [1e2 1100])
xlabel('Time, (hours)')
ylabel('log GMFI pSTAT1')
legend('10nM IFN-\gamma', '1nM', '100pM', '10pM', '1pM', '0')
title('pSTAT1 for DMSO @ T0')
box on
subplot(2,2,2)
hold on
for i=[1 2 3 4 5 6]
    plot(time, pSTAT1_g2(:,i), '-ko', 'markerfacecolor', tsehvah(:,i), 'markersize', 8)
end
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 25, 'xgrid', 'on', 'ygrid', 'on', 'yscale', 'log', 'ylim', [1e2 1100])
xlabel('Time, (hours)')
ylabel('log GMFI pSTAT1')
title('pSTAT1 for DMSO 5 hr post-culture')
box on
subplot(2,2,3)
hold on
for i=[1 2 3 4 5 6]
    plot(time, pSTAT1_g3(:,i), '-ko', 'markerfacecolor', tsehvah(:,i), 'markersize', 8)
end
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 25, 'xgrid', 'on', 'ygrid', 'on', 'yscale', 'log', 'ylim', [1e2 1100])
xlabel('Time, (hours)')
ylabel('log GMFI pSTAT1')
title('pSTAT1 for 10uM Jaki(azd1480) @ T0')
box on
subplot(2,2,4)
hold on
for i=[1 2 3 4 5 6]
    plot(time, pSTAT1_g4(:,i), '-ko', 'markerfacecolor', tsehvah(:,i), 'markersize', 8)
end
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 25, 'xgrid', 'on', 'ygrid', 'on', 'yscale', 'log', 'ylim', [1e2 1100])
xlabel('Time, (hours)')
ylabel('log GMFI pSTAT1')
title('pSTAT1 for 10uM Jaki(azd1480) 5 hr post-culture')
box on

%Plot actual # of molecules
figure()
subplot(2,2,1)
hold on
for i=[1 2 3 4 5 6]
plot(time, pSTAT1_g1_mol(:,i), '-ko', 'markerfacecolor', tsehvah(:,i), 'markersize', 8)
end
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 25, 'xgrid', 'on', 'ygrid', 'on', 'yscale', 'log', 'ylim', [1e3 1e5])
xlabel('Time, (hours)')
ylabel('log # pSTAT1 molecules')
title('pSTAT1 for DMSO @ T0')
box on
subplot(2,2,2)
hold on
for i=[1 2 3 4 5 6]
    plot(time, pSTAT1_g2_mol(:,i), '-ko', 'markerfacecolor', tsehvah(:,i), 'markersize', 8)
end
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 25, 'xgrid', 'on', 'ygrid', 'on', 'yscale', 'log', 'ylim', [1e3 1e5])
xlabel('Time, (hours)')
ylabel('log # pSTAT1 molecules')
title('pSTAT1 for DMSO 5 hr post-culture')
box on
subplot(2,2,3)
hold on
for i=[1 2 3 4 5 6]
    plot(time, pSTAT1_g3_mol(:,i), '-ko', 'markerfacecolor', tsehvah(:,i), 'markersize', 8)
end
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 25, 'xgrid', 'on', 'ygrid', 'on', 'yscale', 'log', 'ylim', [1e3 1e5])
xlabel('Time, (hours)')
ylabel('log # pSTAT1 molecules')
title('pSTAT1 for 10uM Jaki(azd1480) @ T0')
box on
subplot(2,2,4)
hold on
for i=[1 2 3 4 5 6]
    plot(time, pSTAT1_g4_mol(:,i), '-ko', 'markerfacecolor', tsehvah(:,i), 'markersize', 8)
end
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 25, 'xgrid', 'on', 'ygrid', 'on', 'yscale', 'log', 'ylim', [1e3 1e5])
xlabel('Time, (hours)')
ylabel('log # pSTAT1 molecules')
title('pSTAT1 for 10uM Jaki(azd1480) 5 hr post-culture')
box on

%%
%plot the pSTAT1 over time when Jaki background is subtracted out


%Plot MHC versus the integral of pSTAT1 over time
figure()
subplot(2,2,1)
    plot(Int_g1, MHC_g1(2:6,:),  '-o', 'markersize', 8)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 25, 'xgrid', 'on', 'ygrid', 'on', 'yscale', 'log', 'xscale', 'log')
ylabel('log H-2K^b')
xlabel('log \int pSTAT1 at each t')
legend('10nM IFN-\gamma', '1nM', '100pM', '10pM', '1pM', '0')
box on
title('DMSO @ T0')
subplot(2,2,2)
    plot(Int_g2, MHC_g2(2:6,:),  '-o', 'markersize', 8)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 25, 'xgrid', 'on', 'ygrid', 'on', 'yscale', 'log', 'xscale', 'log')
ylabel('log H-2K^b')
xlabel('log \int pSTAT1 at each t')
box on
title('DMSO 5hr post-culture')
subplot(2,2,3)
    plot(Int_g3, MHC_g3(2:6,:),  '-o', 'markersize', 8)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 25, 'xgrid', 'on', 'ygrid', 'on', 'yscale', 'log', 'xscale', 'log', 'xlim', [1e3 1e5], 'ylim', [1e2 1e4])
ylabel('log H-2K^b')
xlabel('log \int pSTAT1 at each t')
box on
title('10uM Jaki(azd1480) @ T0')
subplot(2,2,4)
    plot(Int_g4, MHC_g4(2:6,:),  '-o', 'markersize', 8)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 25, 'xgrid', 'on', 'ygrid', 'on', 'yscale', 'log', 'xscale', 'log', 'xlim', [1e3 1e5])
ylabel('log H-2K^b')
xlabel('log \int pSTAT1 at each t')
box on
title('10uM Jaki(azd1480) 5hr post-culture')

figure()
hold on
plot(Int_g1, MHC_g1(2:6,:),  'o', 'markeredgecolor', 'k', 'markerfacecolor', 'k', 'markersize', 8)
plot(Int_g2, MHC_g2(2:6,:),  'o', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 8)
plot(Int_g3, MHC_g3(2:6,:),  'o', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 8)
plot(Int_g4, MHC_g4(2:6,:),  'o', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 8)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 25, 'xgrid', 'on', 'ygrid', 'on', 'yscale', 'log', 'xscale', 'log', 'xlim', [1e3 3e4])
ylabel('log H-2K^b')
xlabel('log \int pSTAT1 at each t')
box on
title('Overlaid')


%Subtract out the Jaki background
Int_g1_backg=Int_g1-Int_g3;
Int_g2_backg=Int_g2-Int_g3;
Int_g4_backg=Int_g4-Int_g3;


figure()
subplot(2,2,1)
plot(Int_g1_backg, MHC_g1(2:6,:), 'o', 'markeredgecolor', 'k', 'markerfacecolor', 'm', 'markersize', 8)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 25, 'xgrid', 'on', 'ygrid', 'on', 'yscale', 'log', 'xscale', 'log')
ylabel('log H-2K^b')
xlabel('log \int pSTAT1 at each t')
box on
title('DMSO @ T0, background subtr')
subplot(2,2,2)
    plot(Int_g2_backg, MHC_g2(2:6,:), 'o', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 8)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 25, 'xgrid', 'on', 'ygrid', 'on', 'yscale', 'log', 'xscale', 'log')
ylabel('log H-2K^b')
xlabel('log \int pSTAT1 at each t')
box on
title('DMSO 5hr post-culture, background subtr')
subplot(2,2,3)
    plot(Int_g4_backg, MHC_g4(2:6,:), 'o', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 8)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 25, 'xgrid', 'on', 'ygrid', 'on', 'yscale', 'log', 'xscale', 'log')
ylabel('log H-2K^b')
xlabel('log \int pSTAT1 at each t')
box on
title('10uM Jaki(azd1480) 5hr post-culture, background subtr')
subplot(2,2,4)
hold on
plot(Int_g1_backg, MHC_g1(2:6,:), 'o', 'markeredgecolor', 'k', 'markerfacecolor', 'm', 'markersize', 8)
plot(Int_g2_backg, MHC_g2(2:6,:), 'o', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 8)
plot(Int_g4_backg, MHC_g4(2:6,:), 'o', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 8)
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 25, 'xgrid', 'on', 'ygrid', 'on', 'yscale', 'log', 'xscale', 'log')
ylabel('log H-2K^b')
xlabel('log \int pSTAT1 at each t')
box on
title('Overlaid')

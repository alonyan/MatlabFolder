%%Egg White/Siinfekl pulsing experiment 9.19.13

%%
%Siinfekl and IFN-g titration at T0

gamma1_mhc=[571 656	5566 10296
            543	754 5453 9483]; e1_mhc=std(gamma1_mhc); m1_mhc=mean(gamma1_mhc); 
gamma2_mhc=[528 670 4531 7401
            502 699 4106 7111]; e2_mhc=std(gamma2_mhc); m2_mhc=mean(gamma2_mhc); 
gamma3_mhc=[503 505 1708 2265
            460 485 1582 2367]; e3_mhc=std(gamma3_mhc); m3_mhc=mean(gamma3_mhc); 
gamma4_mhc=[460 357 389 517
            427 340 451 424]; e4_mhc=std(gamma4_mhc); m4_mhc=mean(gamma4_mhc); 
gamma5_mhc=[437 302 274 282
            432 293 305 237]; e5_mhc=std(gamma5_mhc); m5_mhc=mean(gamma5_mhc); 
gamma6_mhc=[443 316 264 211
            434 311 284 231]; e6_mhc=std(gamma6_mhc); m6_mhc=mean(gamma6_mhc); 
        
gamma1_ova=[6881 3459 1213 2253
            6365 4035 1333 2022]; e1_ova=std(gamma1_ova); m1_ova=mean(gamma1_ova); 
gamma2_ova=[6259 3686 1206 1572
            5966 4024 1037 1372]; e2_ova=std(gamma2_ova); m2_ova=mean(gamma2_ova);  
gamma3_ova=[6020 3328 637 408
            5451 3096 496 332]; e3_ova=std(gamma3_ova); m3_ova=mean(gamma3_ova);
gamma4_ova=[5564 3056 413 246
            4979 2784 367 275]; e4_ova=std(gamma4_ova); m4_ova=mean(gamma4_ova);
gamma5_ova=[5299 2848 399 270
            5136 2750 433 312]; e5_ova=std(gamma5_ova); m5_ova=mean(gamma5_ova);
gamma6_ova=[5482 3109 445 295
            5184 3014 430 259]; e6_ova=std(gamma6_ova); m6_ova=mean(gamma6_ova);
        
time=[4 8.5 20.5 32.5];
        
figure()
subplot(2,1,1)
hold on
errorbar(time, m1_mhc, e1_mhc, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 8)
errorbar(time, m2_mhc, e2_mhc, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 8)
errorbar(time, m3_mhc, e3_mhc, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', [1 0.5 0], 'markersize', 8)
errorbar(time, m4_mhc, e4_mhc, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 8)
errorbar(time, m5_mhc, e5_mhc, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'g', 'markersize', 8)
errorbar(time, m6_mhc, e6_mhc, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'c', 'markersize', 8)
set(gca, 'Fontsize', 20, 'yscale', 'log', 'xgrid', 'on', 'ygrid', 'on')
set(gcf, 'color', 'w')
xlabel('Time, (hours)')
ylabel('log H-2K^b GMFI')
title('MHC expression for Siinfekl + gamma at T0')
legend('10nM IFN-\gamma', '1nM', '100pM', '10pM', '1pM', '0')
box on
subplot(2,1,2)
hold on
errorbar(time, m1_ova, e1_ova, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 8)
errorbar(time, m2_ova, e2_ova, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 8)
errorbar(time, m3_ova, e3_ova, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', [1 0.5 0], 'markersize', 8)
errorbar(time, m4_ova, e4_ova, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 8)
errorbar(time, m5_ova, e5_ova, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'g', 'markersize', 8)
errorbar(time, m6_ova, e6_ova, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'c', 'markersize', 8)
set(gca, 'Fontsize', 20, 'yscale', 'log', 'xgrid', 'on', 'ygrid', 'on')
set(gcf, 'color', 'w')
xlabel('Time, (hours)')
ylabel('log K^b-Ova GMFI')
title('Ova presentation for Siinfekl + gamma at T0')
box on
 
%%
%Siinfekl + wash then IFN-g titration at T1

gamma1_mhc=[480 351 4219 6902
            466 322 4017 7916]; e1_mhc=std(gamma1_mhc); m1_mhc=mean(gamma1_mhc); 
gamma2_mhc=[459 328 3930 7607
            453 304 4161 7763]; e2_mhc=std(gamma2_mhc); m2_mhc=mean(gamma2_mhc); 
gamma3_mhc=[443 303 1588 3775
            466 308 1755 3962]; e3_mhc=std(gamma3_mhc); m3_mhc=mean(gamma3_mhc); 
gamma4_mhc=[452 268 338 562
            455 265 348 559]; e4_mhc=std(gamma4_mhc); m4_mhc=mean(gamma4_mhc); 
gamma5_mhc=[443 262 201 227
            455 265 348 559]; e5_mhc=std(gamma5_mhc); m5_mhc=mean(gamma5_mhc); 
gamma6_mhc=[445 229 182 191
            400 251 3961 196]; e6_mhc=std(gamma6_mhc); m6_mhc=mean(gamma6_mhc); 
        
gamma1_ova=[6011 1022 597 1436
            5665 727  593 1599]; e1_ova=std(gamma1_ova); m1_ova=mean(gamma1_ova); 
gamma2_ova=[5660 836 692 1443
            5521 732 708 1693]; e2_ova=std(gamma2_ova); m2_ova=mean(gamma2_ova);  
gamma3_ova=[5499 919 385 550 
            5699 844 418 617]; e3_ova=std(gamma3_ova); m3_ova=mean(gamma3_ova);
gamma4_ova=[5700 827 380 241
            5582 736 320 288]; e4_ova=std(gamma4_ova); m4_ova=mean(gamma4_ova);
gamma5_ova=[5579 943 408 238
            5674 813 355 227]; e5_ova=std(gamma5_ova); m5_ova=mean(gamma5_ova);
gamma6_ova=[5605 870 369 280
            4840 639 540 268]; e6_ova=std(gamma6_ova); m6_ova=mean(gamma6_ova);
        
time=[4 8.5 20.5 32.5];
        
figure()
subplot(2,1,1)
hold on
errorbar(time, m1_mhc, e1_mhc, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 8)
errorbar(time, m2_mhc, e2_mhc, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 8)
errorbar(time, m3_mhc, e3_mhc, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', [1 0.5 0], 'markersize', 8)
errorbar(time, m4_mhc, e4_mhc, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 8)
errorbar(time, m5_mhc, e5_mhc, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'g', 'markersize', 8)
errorbar(time, m6_mhc, e6_mhc, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'c', 'markersize', 8)
set(gca, 'Fontsize', 20, 'yscale', 'log', 'xgrid', 'on', 'ygrid', 'on')
set(gcf, 'color', 'w')
xlabel('Time, (hours)')
ylabel('log H-2K^b GMFI')
title('MHC expression for Siinfekl + wash and gamma at T1')
legend('10nM IFN-\gamma', '1nM', '100pM', '10pM', '1pM', '0')
box on
subplot(2,1,2)
hold on
errorbar(time, m1_ova, e1_ova, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 8)
errorbar(time, m2_ova, e2_ova, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 8)
errorbar(time, m3_ova, e3_ova, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', [1 0.5 0], 'markersize', 8)
errorbar(time, m4_ova, e4_ova, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 8)
errorbar(time, m5_ova, e5_ova, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'g', 'markersize', 8)
errorbar(time, m6_ova, e6_ova, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'c', 'markersize', 8)
set(gca, 'Fontsize', 20, 'yscale', 'log', 'xgrid', 'on', 'ygrid', 'on')
set(gcf, 'color', 'w')
xlabel('Time, (hours)')
ylabel('log K^b-Ova GMFI')
title('Ova Presentation for Siinfekl + wash and gamma at T1')
box on

figure()
hold on
plot(m1_mhc, m1_ova, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 8)
plot(m2_mhc, m2_ova, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 8)
plot(m3_mhc, m3_ova, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', [1 0.5 0], 'markersize', 8)
plot(m4_mhc, m4_ova, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 8)
plot(m5_mhc, m5_ova, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'g', 'markersize', 8)
plot(m6_mhc, m6_ova, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'c', 'markersize', 8)
set(gca, 'Fontsize', 20, 'yscale', 'log', 'xscale', 'log', 'xgrid', 'on', 'ygrid', 'on')
set(gcf, 'color', 'w')
ylabel('log K^b-Ova GMFI')
xlabel('log H-2K^b GMFI')
title('MHC v. Ova for Siinfekl + wash and gamma at T1')
legend('10nM IFN-\gamma', '1nM', '100pM', '10pM', '1pM', '0')
box on
%%
%Egg white + IFN-g titration at T0

gamma1_mhc=[395 590 3987 8029
            378 624 4208 6919]; e1_mhc=std(gamma1_mhc); m1_mhc=mean(gamma1_mhc); 
gamma2_mhc=[389 531 2630 6211
            367 577 2724 6235]; e2_mhc=std(gamma2_mhc); m2_mhc=mean(gamma2_mhc); 
gamma3_mhc=[359 435 732 4353
            350 443 661 3502]; e3_mhc=std(gamma3_mhc); m3_mhc=mean(gamma3_mhc); 
gamma4_mhc=[351 307 402 914
            330 300 350 909]; e4_mhc=std(gamma4_mhc); m4_mhc=mean(gamma4_mhc); 
gamma5_mhc=[340 255 356 395
            321 270 325 390]; e5_mhc=std(gamma5_mhc); m5_mhc=mean(gamma5_mhc); 
gamma6_mhc=[340 252 3473 337
            330 247 4936 299]; e6_mhc=std(gamma6_mhc); m6_mhc=mean(gamma6_mhc); 
        
gamma1_ova=[163 202 598 1261
            165 306 587 992]; e1_ova=std(gamma1_ova); m1_ova=mean(gamma1_ova); 
gamma2_ova=[165 230 284 1082
            152 310 487 1045]; e2_ova=std(gamma2_ova); m2_ova=mean(gamma2_ova);  
gamma3_ova=[145 261 301 557
            188 262 285 422]; e3_ova=std(gamma3_ova); m3_ova=mean(gamma3_ova);
gamma4_ova=[174 281 238 204
            177 242 208 194]; e4_ova=std(gamma4_ova); m4_ova=mean(gamma4_ova);
gamma5_ova=[146 240 259 223
            147 307 306 217]; e5_ova=std(gamma5_ova); m5_ova=mean(gamma5_ova);
gamma6_ova=[167 253 453 254
            153 230 563 266]; e6_ova=std(gamma6_ova); m6_ova=mean(gamma6_ova);
        
time=[4 8.5 20.5 32.5];
        
figure()
subplot(2,1,1)
hold on
errorbar(time, m1_mhc, e1_mhc, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 8)
errorbar(time, m2_mhc, e2_mhc, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 8)
errorbar(time, m3_mhc, e3_mhc, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', [1 0.5 0], 'markersize', 8)
errorbar(time, m4_mhc, e4_mhc, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 8)
errorbar(time, m5_mhc, e5_mhc, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'g', 'markersize', 8)
errorbar(time, m6_mhc, e6_mhc, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'c', 'markersize', 8)
set(gca, 'Fontsize', 20, 'yscale', 'log', 'xgrid', 'on', 'ygrid', 'on')
set(gcf, 'color', 'w')
xlabel('Time, (hours)')
ylabel('log H-2K^b GMFI')
title('MHC expression for Egg White + gamma at T0')
legend('10nM IFN-\gamma', '1nM', '100pM', '10pM', '1pM', '0')
box on
subplot(2,1,2)
hold on
errorbar(time, m1_ova, e1_ova, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 8)
errorbar(time, m2_ova, e2_ova, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 8)
errorbar(time, m3_ova, e3_ova, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', [1 0.5 0], 'markersize', 8)
errorbar(time, m4_ova, e4_ova, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 8)
errorbar(time, m5_ova, e5_ova, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'g', 'markersize', 8)
errorbar(time, m6_ova, e6_ova, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'c', 'markersize', 8)
set(gca, 'Fontsize', 20, 'yscale', 'log', 'xgrid', 'on', 'ygrid', 'on')
set(gcf, 'color', 'w')
xlabel('Time, (hours)')
ylabel('log K^b-Ova GMFI')
title('Ova Presentation for Egg White + gamma at T0')
box on

%%
%Egg white + wash & IFN-g titration at T1

gamma1_mhc=[334 349 5022 9082
            333 345 5297 9577]; e1_mhc=std(gamma1_mhc); m1_mhc=mean(gamma1_mhc); 
gamma2_mhc=[333 358 2910 9563
            328 351 2928 9029]; e2_mhc=std(gamma2_mhc); m2_mhc=mean(gamma2_mhc); 
gamma3_mhc=[332 324 577 5872
            328 327 671 4799]; e3_mhc=std(gamma3_mhc); m3_mhc=mean(gamma3_mhc); 
gamma4_mhc=[325 293 225 950 
            312 306 225 892]; e4_mhc=std(gamma4_mhc); m4_mhc=mean(gamma4_mhc); 
gamma5_mhc=[334 274 187 193
            329 271 213 241]; e5_mhc=std(gamma5_mhc); m5_mhc=mean(gamma5_mhc); 
gamma6_mhc=[331 259 5116 172 
            327 284 176  186]; e6_mhc=std(gamma6_mhc); m6_mhc=mean(gamma6_mhc); 
        
gamma1_ova=[198 291 597 1505
            200 332 735 1581]; e1_ova=std(gamma1_ova); m1_ova=mean(gamma1_ova); 
gamma2_ova=[206 282 538 1748
            170 260 532 1532]; e2_ova=std(gamma2_ova); m2_ova=mean(gamma2_ova);  
gamma3_ova=[176 229 266 917
            189 253 339 729]; e3_ova=std(gamma3_ova); m3_ova=mean(gamma3_ova);
gamma4_ova=[197 215 277 261
            187 293 282 227]; e4_ova=std(gamma4_ova); m4_ova=mean(gamma4_ova);
gamma5_ova=[209 268 344 244
            208 277 437 248]; e5_ova=std(gamma5_ova); m5_ova=mean(gamma5_ova);
gamma6_ova=[212 228 696 235
            225 386 305 229]; e6_ova=std(gamma6_ova); m6_ova=mean(gamma6_ova);
        
time=[4 8.5 20.5 32.5];
        
figure()
subplot(2,1,1)
hold on
errorbar(time, m1_mhc, e1_mhc, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 8)
errorbar(time, m2_mhc, e2_mhc, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 8)
errorbar(time, m3_mhc, e3_mhc, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', [1 0.5 0], 'markersize', 8)
errorbar(time, m4_mhc, e4_mhc, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 8)
errorbar(time, m5_mhc, e5_mhc, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'g', 'markersize', 8)
errorbar(time, m6_mhc, e6_mhc, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'c', 'markersize', 8)
set(gca, 'Fontsize', 20, 'yscale', 'log', 'xgrid', 'on', 'ygrid', 'on')
set(gcf, 'color', 'w')
xlabel('Time, (hours)')
ylabel('log H-2K^b GMFI')
title('MHC expression for Egg White + wash & gamma at T1')
legend('10nM IFN-\gamma', '1nM', '100pM', '10pM', '1pM', '0')
box on
subplot(2,1,2)
hold on
errorbar(time, m1_ova, e1_ova, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 8)
errorbar(time, m2_ova, e2_ova, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 8)
errorbar(time, m3_ova, e3_ova, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', [1 0.5 0], 'markersize', 8)
errorbar(time, m4_ova, e4_ova, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 8)
errorbar(time, m5_ova, e5_ova, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'g', 'markersize', 8)
errorbar(time, m6_ova, e6_ova, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'c', 'markersize', 8)
set(gca, 'Fontsize', 20, 'yscale', 'log', 'xgrid', 'on', 'ygrid', 'on')
set(gcf, 'color', 'w')
xlabel('Time, (hours)')
ylabel('log K^b-Ova GMFI')
title('Ova Presentation for Egg White + wash & gamma at T1')
box on

figure()
hold on
plot(m1_mhc, m1_ova, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'r', 'markersize', 8)
plot(m2_mhc, m2_ova, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'y', 'markersize', 8)
plot(m3_mhc, m3_ova, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', [1 0.5 0], 'markersize', 8)
plot(m4_mhc, m4_ova, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'b', 'markersize', 8)
plot(m5_mhc, m5_ova, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'g', 'markersize', 8)
plot(m6_mhc, m6_ova, '-ko', 'markeredgecolor', 'k', 'markerfacecolor', 'c', 'markersize', 8)
set(gca, 'Fontsize', 20, 'yscale', 'log', 'xscale', 'log', 'xgrid', 'on', 'ygrid', 'on')
set(gcf, 'color', 'w')
ylabel('log K^b-Ova GMFI')
xlabel('log H-2K^b GMFI')
title('MHC v. Ova for Egg White + wash and gamma at T1')
legend('10nM IFN-\gamma', '1nM', '100pM', '10pM', '1pM', '0')
box on

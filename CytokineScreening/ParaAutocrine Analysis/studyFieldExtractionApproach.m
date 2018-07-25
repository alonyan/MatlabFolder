%%  Start fitting with ScreenedFieldToDistributionFIDA
options.tol_exp_FIDA = 1e-3;
options.rhomaxfactor = 12;
options.Nrhopt = 200;
options.range_q = 3;
options.Nqpt = 20;

options.r0_in_cell_dia = 5;
options.secretion.do = false;
options.secretion.sig = 0.92; %  std in lognormal coordinates of secretion rate distribution 

options.capture.do = false;
options.capture.sig = 0.1766; %  std in lognormal coordinates of capture antibody distribution 

options.BG.do = false;
options.BG.sig = 0.2014;  %  std of the normal distribution of background rescaled with Linear Range
options.BG.mean = 0.1484; % a

%%
X = -1:(9/300):8;

%% Play a bit with parameters beta0 - [Qtag rho0] to get in the range
beta0 = [20  5];
P = ScreenedFieldToDistributionFIDA(beta0, X, options);
%%
plot( X, P); figure(gcf);
kd = beta0(2)/options.r0_in_cell_dia
maxX = asinh(beta0(1)/kd*exp(-kd));
P(X > maxX) = 0;
P = P/sum(P);
%%
Xtrue = sinh(X);
cdfvect1 = 1- cumsum(P);
semilogy(cdfvect1.^(1/3), Xtrue);
figure(gcf);
%%
r = ( 1- log(1 - cdfvect1)*options.r0_in_cell_dia.^3 ).^(1/3);
semilogy(r, Xtrue.*r, [1 5], beta0(1)*exp(-kd*[1 5]));
figure(gcf);

%% New set
options.secretion.do = false;
beta0 = [4.25  2.5];
P1 = ScreenedFieldToDistributionFIDA(beta0, X, options);
%%
plot( X, P1); figure(gcf);
kd = beta0(2)/options.r0_in_cell_dia
maxX = asinh(beta0(1)/kd*exp(-kd));
P1(X > maxX) = 0;
P1 = P1/sum(P1);
%%
Xtrue = sinh(X);
cdfvect1 = 1- cumsum(P1);
semilogy(cdfvect1.^(1/3), Xtrue);
figure(gcf);
%%
r = ( 1- log(1 - cdfvect1)*options.r0_in_cell_dia.^3 ).^(1/3);
semilogy(r, Xtrue.*r, [1 5], 2*beta0(1)*exp(-kd*[1 5]));
figure(gcf);

%%
semilogy(r, Xtrue.*r -  beta0(1)*exp(-kd*r));
figure(gcf);

%% Check the effect of spread in secretion
options.secretion.do = true;
beta0 = [4.25  2.5];
P2 = ScreenedFieldToDistributionFIDA(beta0, X, options);

plot( X, P2); figure(gcf);
kd = beta0(2)/options.r0_in_cell_dia
maxX = asinh(beta0(1)/kd*exp(-kd));
%P2(X > maxX) = 0;
%P2 = P2/sum(P2);
%%
Xtrue = sinh(X);
cdfvect1 = 1- cumsum(P2);
semilogy(cdfvect1.^(1/3), Xtrue);
figure(gcf);
%%
r = ( 1- log(1 - cdfvect1)*options.r0_in_cell_dia.^3 ).^(1/3);
semilogy(r, Xtrue.*r, [1 5], 2*beta0(1)*exp(-kd*[1 5]));
figure(gcf);
%%  Try pair contributions
options.secretion.do = false;
options.tol_exp_FIDA = 1e-3;
options.rhomaxfactor = 12;
options.Nrhopt = 400;
options.r0_in_cell_dia = 3;
beta0 = [100  3];
[P, Plin, B, I] = ScreenedFieldToDistributionFIDA(beta0, X, options);

plot( X, P); figure(gcf);
kd = beta0(2)/options.r0_in_cell_dia
maxX = asinh(beta0(1)/kd*exp(-kd));
%P(X > maxX) = 0;
%P = P/sum(P);
%%
Xtrue = sinh(X);
cdfvect1 = 1- cumsum(P);
semilogy(cdfvect1.^(1/3), Xtrue);
figure(gcf);
%%
r = ( 1- log(1 - cdfvect1)*options.r0_in_cell_dia.^3 ).^(1/3);
r1 = ( 1 + cdfvect1*(options.r0_in_cell_dia.^3 -1) ).^(1/3);
semilogy(r, Xtrue.*r, r, beta0(1)*exp(-kd*r)/kd, r1, Xtrue.*r1);
figure(gcf);

%% 
I2 = sqrt(I);
plot(1:length(I2), [real(I2(:)) imag(I2(:))]);
figure(gcf);
%%

plot(1:length(I2), angle(I2(:)));
figure(gcf);
%% Correct discontinuities of sqrt
jc = find(abs(diff(angle(I2))) > pi/2);
jc = [jc length(I2)];
for i=1:2:(length(jc)-1),
    I2((jc(i)+1):(jc(i+1))) =  - I2((jc(i)+1):(jc(i+1)));
end;
plot(1:length(I2), [real(I2(:)) imag(I2(:))], 'o');
figure(gcf);

%%
N = length(I2)-1;
Plin = fft([I2 conj(I2(N:-1:2))]);
Plin = circshift(Plin, [0 N-1]);
X2 = asinh(B/beta0(1));
P2 = interp1(B, real(Plin), sinh(X)).*sqrt(1 + sinh(X).^2);
P2(P2 <0) = 0;
P2 = P2/sum(P2);
plot( X, P2, X, P); 
figure(gcf);

%%
%P2(X > maxX) = 0;
%P2 = P2/sum(P2);
cdfvect2 = 1- cumsum(P2);
r2 = ( 1- log(1 - cdfvect2)*2*options.r0_in_cell_dia.^3 ).^(1/3);
semilogy(r, Xtrue.*r, r, beta0(1)*exp(-kd*r)/kd, r2, Xtrue.*r2);
figure(gcf);

%%
r3_1 = r;
r3_2 = r2;

semilogy(r3_1, Xtrue.*r3_1, r3_2, Xtrue.*r3_2, r4_2, Xtrue.*r4_2, r, beta0(1)*exp(-kd*r)/kd, r5_2, Xtrue.*r5_2);
figure(gcf)

%%
semilogy(r3_2, Xtrue.*r3_2, r, beta0(1)*exp(-kd*r)/kd, r5_1, Xtrue.*r5_1);
figure(gcf)

%% Try to deal with n cell- interactions
n = 5;
In = I.^(1/n);
plot(1:length(In), [real(In(:)) imag(In(:))]);
figure(gcf);
%%

plot(1:length(In), angle(In(:)));
figure(gcf);
%% Correct discontinuities of sqrt
diffangle = diff(angle(In));
jc = find(abs(diffangle) > pi/n);
jc = [jc length(In)];
for i=1:(length(jc)-1),
    In((jc(i)+1):length(In)) =  In((jc(i)+1):length(In))*exp(-sqrt(-1)*diffangle(jc(i)));
end;
plot(1:length(In), [real(In(:)) imag(In(:))], 'o');
figure(gcf);

%%
N = length(In)-1;
Plin = fft([In conj(In(N:-1:2))]);
Plin = circshift(Plin, [0 N-1]);
Xn = asinh(B/beta0(1));
Pn = interp1(B, real(Plin), sinh(X)).*sqrt(1 + sinh(X).^2);
%P2(P2 <0) = 0;
Pn = Pn/sum(Pn);
plot( X, P2, X, P, X, Pn); 
figure(gcf);

%%
%P2(X > maxX) = 0;
%P2 = P2/sum(P2);
cdfvectn = 1- cumsum(Pn);
rn = ( 1- log(1 - cdfvectn)*n*options.r0_in_cell_dia.^3 ).^(1/3);
semilogy(r, Xtrue.*r, r, beta0(1)*exp(-kd*r)/kd, r2, Xtrue.*r2, rn, Xtrue.*rn);
figure(gcf);

%%
r3_5 = rn;

semilogy(r3_1, Xtrue.*r3_1, r3_2, Xtrue.*r3_2, r4_2, Xtrue.*r4_2, r, beta0(1)*exp(-kd*r)/kd, r5_2, Xtrue.*r5_2,  r3_5, Xtrue.*r3_5);
figure(gcf)

%%  Try several approximations

options.secretion.do = false;
options.tol_exp_FIDA = 1e-6;
options.rhomaxfactor = 12;
options.Nrhopt = 400;
options.r0_in_cell_dia = 4;
beta0 = [100  4];
[P, Plin, B, I] = ScreenedFieldToDistributionFIDA(beta0, X, options);

plot( X, P); figure(gcf);
kd = beta0(2)/options.r0_in_cell_dia
maxX = asinh(beta0(1)/kd*exp(-kd));

%%
clear rn
for n = 1:10,
    In = I.^(1/n);
    diffangle = diff(angle(In));
    jc = find(abs(diffangle) > pi/n);
    jc = [jc length(In)];
    for i=1:(length(jc)-1),
        In((jc(i)+1):length(In)) =  In((jc(i)+1):length(In))*exp(-sqrt(-1)*diffangle(jc(i)));
    end;
    N = length(In)-1;
    Plin = fft([In conj(In(N:-1:2))]);
    Plin = circshift(Plin, [0 N-1]);
    Plin = Plin/sum(Plin);
    cdfvectn = 1- cumsum(Plin);
    rn(:, n) = ( 1- log(1 - cdfvectn)*n*options.r0_in_cell_dia.^3 ).^(1/3);
end;
%%
semilogy(rn, repmat(B(:), 1, n) .*rn, r, beta0(1)*exp(-kd*r)/kd);
figure(gcf);
%%
rn4 = rn;
B4 = B;
%%
semilogy(rn4(:, 1), B4'.*rn4(:, 1), rn4(:, 10), B4'.*rn4(:, 10), rn3(:, 1), B3'.*rn3(:, 1), rn3(:, 10), B3'.*rn3(:, 10))
figure(gcf)

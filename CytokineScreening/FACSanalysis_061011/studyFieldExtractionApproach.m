%%  Start fitting with ScreenedFieldToDistributionFIDA
options.tol_exp_FIDA = 1e-3;
options.rhomaxfactor = 12;
options.Nrhopt = 200;
options.range_q = 3;
options.Nqpt = 20;

options.r0_in_cell_dia = 4.73;
options.secretion.do = true;
options.secretion.sig = 0.92; %  std in lognormal coordinates of secretion rate distribution 

options.capture.do = true;
options.capture.sig = 0.1766; %  std in lognormal coordinates of capture antibody distribution 

options.BG.do = true;
options.BG.sig = 0.2014;  %  std of the normal distribution of background rescaled with Linear Range
options.BG.mean = 0.1484; % a

fpath = 'D:\Oleg\Experiments\MSKCC\20110713_AutoParaCrine\'
%%
X = -1:(9/300):8;

%% Play a bit with parameters beta0 - [Qtag rho0] to get in the range
beta0 = [4.25  2.46];
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

%%
Plin = circshift(Plin, [1 N-1]);
Xn = asinh(B/beta0(1));
Pn = interp1(B, real(Plin), sinh(X)).*sqrt(1 + sinh(X).^2);
%P2(P2 <0) = 0;
%%
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


%% Try to extract field from Grand canonical approach:
X = -1:(9/300):8;
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
%%
lnG = log(I);
% remove discontinuities
diffangle = diff(imag(lnG));
jc = find(abs(diffangle) > pi);
jc = [jc length(lnG)];
for i=1:(length(jc)-1),
    lnG((jc(i)+1):length(lnG)) =  lnG((jc(i)+1):length(lnG)) - sqrt(-1)*pi*round(diffangle(jc(i))/pi);
end;
N = length(lnG)-1;
%%
lnG = [lnG(1:N) conj(lnG((N+1):-1:2))];
size(lnG)
hannwindow = circshift(hann(2*N), N);
size(hannwindow)
P1 = fft(lnG.*hannwindow');
plot(real(P1));
figure(gcf)

%%
P1 = circshift(P1, [0 N-1]);
plot(real(P1)); figure(gcf);
%%
I = cumsum(real(P1((2*N):-1:N)));
dB = median(diff(B));
r = (I*(N-1)/(N^2*2) + options.r0_in_cell_dia.^(-3)).^(1/3);
plot(real(r));
figure(gcf);


semilogy(real(r), real(r.*B((2*N):-1:N)), real(r), beta0(1)/beta0(2)*exp(-beta0(2)*real(r))); figure(gcf);

%% Calculate without using I: directly from P
N = length(Plin)/2;
Plin = circshift(Plin, [1 -(N-1)]);
I1 = ifft(real(Plin));

lnG = log(I1);
% remove discontinuities
diffangle = diff(imag(lnG));
jc = find(abs(diffangle) > pi);
jc = [jc length(lnG)];
for i=1:(length(jc)-1),
    lnG((jc(i)+1):length(lnG)) =  lnG((jc(i)+1):length(lnG)) - sqrt(-1)*pi*round(diffangle(jc(i))/pi);
end;

%%
lnG = [lnG(1:N) conj(lnG((N+1):-1:2))];
%size(lnG)
hannwindow = circshift(hann(2*N), round(N));
size(hannwindow)
P2 = fft(lnG.*hannwindow');
plot(real(P2));
figure(gcf)

%%
P2 = circshift(P2, [0 N-1]);
plot(1:(2*N), real(P2), 1:(2*N), real(P1)); figure(gcf);
%%
IdB = cumsum(real(P2((2*N):-1:N)));
%dB = median(diff(B));
r = (IdB*(N-1)/(N^2*2) + options.r0_in_cell_dia.^(-3)).^(1/3);
plot(real(r));
figure(gcf);


semilogy(real(r), real(r.*B((2*N):-1:N)), real(r), beta0(1)/beta0(2)*exp(-beta0(2)*real(r))); figure(gcf);

%% Check how badly the distribution of secretion rates affect the data
X = -1:(9/300):8;
options.secretion.sig = 0.1; %0.92
options.secretion.do = true;
options.tol_exp_FIDA = 1e-3;
options.rhomaxfactor = 12;
options.Nrhopt = 400;
options.r0_in_cell_dia = 3;
beta0 = [100  3];
[P, Plin, B, I] = ScreenedFieldToDistributionFIDA(beta0, X, options);

plot( X, P); figure(gcf);
kd = beta0(2)/options.r0_in_cell_dia
maxX = asinh(beta0(1)/kd*exp(-kd));

%%
N = length(Plin)/2;
Plin = circshift(Plin, [1 -(N-1)]);
I1 = ifft(real(Plin));

lnG = log(I1);
% remove discontinuities
diffangle = diff(imag(lnG));
jc = find(abs(diffangle) > pi);
jc = [jc length(lnG)];
for i=1:(length(jc)-1),
    lnG((jc(i)+1):length(lnG)) =  lnG((jc(i)+1):length(lnG)) - sqrt(-1)*pi*round(diffangle(jc(i))/pi);
end;

%%
lnG = [lnG(1:N) conj(lnG((N+1):-1:2))];
%size(lnG)
hannwindow = circshift(hann(2*N), round(N));
size(hannwindow)
P2 = fft(lnG.*hannwindow');
plot(real(P2));
figure(gcf)

%%
P2 = circshift(P2, [0 N-1]);
plot(1:(2*N), real(P2), 1:(2*N), real(P1)); figure(gcf);
%%
IdB = cumsum(real(P2((2*N):-1:N)));
%dB = median(diff(B));
r = (IdB*(N-1)/(N^2*2) + options.r0_in_cell_dia.^(-3)).^(1/3);
plot(real(r));
figure(gcf);


semilogy(real(r), real(r.*B((2*N):-1:N)), real(r), beta0(1)*exp(options.secretion.sig^2/2)/beta0(2)*exp(-beta0(2)*real(r))); figure(gcf);

%% see if we can get the actual  distribution by convolving different of secretion rates
%r = real(r(1:(length(r) - 2 )));
% interpolate B at logarithmically distributed points:
Np = 200;
dB = median(diff(B));
dlogBe = log(max(B)/dB)/Np;
Be = exp(log(dB):dlogBe:log(max(B))); 

Rmin = 0.1/options.r0_in_cell_dia;
Rmax = 2*log(beta0(1)*options.r0_in_cell_dia/(beta0(2)*dB))/beta0(2);
R = Rmin+(0:2000)/2000*(Rmax - Rmin);
R3e = interp1(  beta0(1)/beta0(2)*exp(-beta0(2)*R)./R, R.^3, Be );

R3e(Be > (beta0(1)/kd*exp(-kd))) = 0;
semilogx( beta0(1)/beta0(2)*exp(-beta0(2)*R)./R, R.^3, Be, R3e); figure(gcf)

%%
 [X,Y] = meshgrid(log(Be));
 sig = options.secretion.sig;
 T = dlogBe/sqrt(2*pi*sig^2)*exp(- (X - Y).^2/(2*sig^2));
 
 r3calc = T*R3e(:) + options.r0_in_cell_dia.^(-3);
 r3 = (IdB*(N-1)/(N^2*2) + options.r0_in_cell_dia.^(-3));
 semilogx(real(B((2*N):-1:N)), real(r3),  Be, r3calc);
 figure(gcf)

%%
pot = beta0(1)/beta0(2)*exp(-beta0(2)*R)./R;
pot(pot > (beta0(1)/kd*exp(-kd))) = NaN;
 semilogx(real(B((2*N):-1:N)), real(r3) - options.r0_in_cell_dia.^(-3),  Be, r3calc, Be, R3e, pot, R.^3);
 figure(gcf)


%%
rcalc = r3calc.^(1/3);
r = real(r3.^(1/3));
semilogy(real(r), real(r.*B((2*N):-1:N)),  rcalc, rcalc.*Be(:));
figure(gcf)


%% ONCE MORE
% Check how badly the distribution of secretion rates affect the data
X = -1:(9/300):8;
options.secretion.sig = 0.92;
options.secretion.do = true;
options.tol_exp_FIDA = 1e-3;
options.rhomaxfactor = 12;
options.Nrhopt = 400;
options.r0_in_cell_dia = 3;
beta0 = [100  3];
[P, Plin, B, I] = ScreenedFieldToDistributionFIDA(beta0, X, options);

plot( X, P); figure(gcf);
kd = beta0(2)/options.r0_in_cell_dia
maxX = asinh(beta0(1)/kd*exp(-kd));

%
N = length(Plin)/2;
Plin = circshift(Plin, [1 -(N-1)]);
I1 = ifft(real(Plin));

lnG = log(I1);
% remove discontinuities
diffangle = diff(imag(lnG));
jc = find(abs(diffangle) > pi);
jc = [jc length(lnG)];
for i=1:(length(jc)-1),
    lnG((jc(i)+1):length(lnG)) =  lnG((jc(i)+1):length(lnG)) - sqrt(-1)*pi*round(diffangle(jc(i))/pi);
end;

%
lnG = [lnG(1:N) conj(lnG((N+1):-1:2))];
%size(lnG)
hannwindow = circshift(hann(2*N), round(N));
size(hannwindow)
P2 = fft(lnG.*hannwindow');
plot(real(P2));
figure(gcf)

%
P2 = circshift(P2, [0 N-1]);
plot(1:(2*N), real(P2), 1:(2*N), real(P1)); figure(gcf);
%
IdB = cumsum(real(P2((2*N):-1:N)))*(N-1)/(N^2*2);
%dB = median(diff(B));
r = (IdB + options.r0_in_cell_dia.^(-3)).^(1/3);
plot(real(r));
figure(gcf);

semilogy(real(r), real(r.*B((2*N):-1:N)), real(r), beta0(1)*exp(options.secretion.sig^2/2)/beta0(2)*exp(-beta0(2)*real(r))); figure(gcf);

%% ONCE MORE
%  see if we can get the actual  distribution by convolving different of
%  secretion rates
% interpolate B at logarithmically distributed points:

Np = 300;
dB = median(diff(B));
dlogBe = log(max(B)/dB)/Np;
Be = exp(log(dB):dlogBe:log(max(B))); 

Rmin = 0.1/options.r0_in_cell_dia;
Rmax = 2*log(beta0(1)*options.r0_in_cell_dia/(beta0(2)*dB))/beta0(2);
R = Rmin+(0:2000)/2000*(Rmax - Rmin);
pot = beta0(1)/beta0(2)*exp(-beta0(2)*R)./R;
R3e = interp1( pot, R.^3, Be );
R3e_d = R3e - options.r0_in_cell_dia.^(-3);
R3e_d((R3e_d < 0) | isnan(R3e_d)) = 0;

semilogx(pot, R.^3, Be, R3e_d); figure(gcf)

[X,Y] = meshgrid(log(Be));
 sig = options.secretion.sig;
 T = dlogBe/sqrt(2*pi*sig^2)*exp(- (X - Y).^2/(2*sig^2));
 T = T./repmat(sum(T, 2), 1, Np+1);
 r3_dcalc = T*R3e_d(:);
 %r3 = (IdB*(N-1)/(N^2*2) + options.r0_in_cell_dia.^(-3));
 semilogx(real(B((2*N):-1:N)), IdB,  Be, r3_dcalc, Be, R3e_d);
 figure(gcf)
%%
Re = (R3e_d + options.r0_in_cell_dia.^(-3)).^(1/3);
rcalc = (r3_dcalc + options.r0_in_cell_dia.^(-3)).^(1/3);
semilogy(real(r), real(r.*B((2*N):-1:N)), real(r), beta0(1)*exp(options.secretion.sig^2/2)/beta0(2)*exp(-beta0(2)*real(r)), rcalc, Be(:).*rcalc); figure(gcf);

%% Try to get the real distribution from the "measured" by iterative
% procedure:
% 1) get R3e_d from r3_dcalc:
Niter = 1000;
gamma = 0.01;
F = gamma*r3_dcalc;

for i=1:Niter,
    F = F+ gamma*(r3_dcalc - T*F);
    semilogx(Be, r3_dcalc, Be, R3e_d, Be, F);
figure(gcf)
end;

semilogx(Be, r3_dcalc, Be, R3e_d, Be, F);
figure(gcf)

% perfect

%% 2) get real distribution from IdB
Niter = 150;
gamma = 0.01;

Bee = exp(log(dB/100):dlogBe:log(max(B))); 
IdBe = interp1( real(B((2*N):-1:(N+2))), ((IdB(1:(N-1)))).^(1/3), Bee, 'linear', 'extrap' ).^3;


j = ~isnan(IdBe);
IdBe = IdBe(j);
Bee = Bee(j);

[X,Y] = meshgrid(log(Bee));
T1 = dlogBe/sqrt(2*pi*sig^2)*exp(- (X - Y).^2/(2*sig^2));
%T1 = T1./repmat(sum(T1, 2), 1,length(IdBe));
F = gamma*IdBe(:);

for i=1:Niter,
    F = F+ gamma*T1'*(IdBe(:) - T1*F);
    semilogx(real(B((2*N):-1:N)), real(IdB), Bee, IdBe, Be, R3e_d, Bee, F);
figure(gcf)
end;

semilogx(real(B((2*N):-1:N)), real(IdB), Bee, IdBe, Be, R3e_d, Bee, F);
figure(gcf)

%% Try extraction from real data:

load 'D:\Oleg\Experiments\MSKCC\20110713_AutoParaCrine\process20110713_AutoParaCrine.mat' TACclusters_TAC proc_TACclusters_TAC
%%
TACclusters_TAC_PE = GetFACSdataFromMatLabStructByTag( TACclusters_TAC, 'PE');
%% work first with 0 AB on 5CC7 cells
Nhist = 512;
data = TACclusters_TAC_PE(1).PE; 
Xmax = 2*max(data);
dX = 2*Xmax/Nhist;
X = (-Xmax):dX:Xmax;
[Plin X] = hist(data, X);
Plin = Plin/sum(Plin);
plot(X, Plin);
figure(gcf)

 N = round(length(Plin)/2);
Plin = circshift(Plin, [1 -(N-1)]);
I1 = ifft(Plin);

lnG = log(I1);
plot(X, real(lnG), X, imag(lnG));
figure(gcf)

%%
% remove discontinuities
diffangle = diff(imag(lnG));
jc = find(abs(diffangle) > pi);
jc = [jc length(lnG)];
for i=1:(length(jc)-1),
    lnG((jc(i)+1):length(lnG)) =  lnG((jc(i)+1):length(lnG)) - sqrt(-1)*pi*round(diffangle(jc(i))/pi);
end;

%lnG = lnG - sqrt(-1)*mean(imag(lnG));
plot(X, real(lnG), X, imag(lnG));
figure(gcf)
%%
lnG = [lnG(1:N) conj(lnG((N+1):-1:2))] ;
%size(lnG)

%lnG = lnG  - 2*pi*sqrt(-1);
plot(X, real(lnG), X, imag(lnG));
figure(gcf)
%%
hannwindow = circshift(hann(2*N-1), round(N));
size(hannwindow)
P2 = circshift(fft(lnG.*hannwindow'), [2 N-1]);
plot(X, real(P2));
figure(gcf)

%%
%P2 = circshift(P2, [0 N-1]);
plot(1:(2*N), real(P2)); figure(gcf);
%%
IdB = cumsum(real(P2((N):-1:1)))*(N-1)/(N^2*2);
%dB = median(diff(B));
r = (IdB + 4.7330.^(-3)).^(1/3);
plot(real(r));
figure(gcf);

%%
semilogy(real(r), real(r).*X((2*N-1):-1:N), r, 400*exp(- r/0.4));
figure(gcf)

%%  Take into account secretion distribution

Np = Nhist;
dB = median(diff(X));
dlogBe = log(max(X)/dB)/Np;
Be = exp((log(dB)):dlogBe:log(max(X)));
logBe = log(Be);

IdBe = interp1( log(real(X((2*N -1):-1:(N+1)))), (IdB(1:(N-1))).^(1/3), logBe, 'linear', 'extrap' ).^3;
plot(real(X((2*N -1):-1:N)), IdB, Be, IdBe ); figure(gcf)

%%
Niter = 52;
gamma = 0.01;


[X1,Y1] = meshgrid(logBe);
T1 = dlogBe/sqrt(2*pi*sig^2)*exp(- (X1 - Y1).^2/(2*sig^2));
%T1 = T1./repmat(sum(T1, 2), 1,length(IdBe));
F = gamma*IdBe(:);

for i=1:Niter,
    F = F+ gamma*(IdBe(:) - T1*F);
    F(F>1) = 1;
    F(F<0) = 0;
    J = find(diff(F) > 0),
   while length(J)>0,
    F(J+1) =F(J);
    J = find(diff(F) > 0);
   end;
    
  
    subplot(1, 2, 1); semilogx(real(X((2*N-1):-1:N)), real(IdB), Be, IdBe,  Be, F, Be, T1*F);
    subplot(1, 2, 2); semilogy((IdB + 4.7330.^(-3)).^(1/3), real(X((2*N-1):-1:N)), (IdBe + 4.7330.^(-3)).^(1/3), Be, (F + 4.7330.^(-3)).^(1/3),  Be, (T1*F + 4.7330.^(-3)).^(1/3),  Be);
figure(gcf)
end;

%%
r1= (F + 4.7330.^(-3)).^(1/3);
semilogy(real(r), real(r).*X((2*N-1):-1:N), r, 400*exp(- r/0.4), r1, r1.*Be(:));
figure(gcf)


%% Re-analyze the data based on the simplest canonical approach: from cdf

proc_TACclusters_TAC = HistAsinh3(TACclusters_TAC, 'Tag', 'PE', 'Nbins', 21);
plot(proc_TACclusters_TAC.PE.cdfvect, proc_TACclusters_TAC.PE.cdfval ); figure(gcf)
%%
proc_TACclusters_TAC.PE.r = ( 1- 4.73^3*log(1 - proc_TACclusters_TAC.PE.cdfvect) ).^(1/3);
r = proc_TACclusters_TAC.PE.r;
semilogy(proc_TACclusters_TAC.PE.r,proc_TACclusters_TAC.PE.cdfval,  '-', r, 1000*exp(- r/1.9));
figure(gcf)

%%  Take into account secretion distribution
% work with the first set: 0 capture AB on 5CC7
I = 1;

maxlogBe = 2*log(max(proc_TACclusters_TAC.PE.cdfval(:, I)));
Np = 400;
dlogBe = maxlogBe/Np;
logBe = dlogBe:dlogBe:maxlogBe;

J = (proc_TACclusters_TAC.PE.cdfval(:, I) > 0);
cdfSec = interp1( log(proc_TACclusters_TAC.PE.cdfval(J, I)), proc_TACclusters_TAC.PE.cdfvect(J), logBe, 'linear', 'extrap' );
cdfSec(cdfSec >1) =1;
cdfSec(cdfSec <0) =0;
plot(log(proc_TACclusters_TAC.PE.cdfval(:, I)), proc_TACclusters_TAC.PE.cdfvect, logBe, cdfSec ); figure(gcf)

re = ( 1- 4.73^3*log(1 - exp(logBe)) ).^(1/3);
%%
Niter = 1000;
gamma = 0.01;
sig = options.secretion.sig;

[X1,Y1] = meshgrid(logBe);
T1 = dlogBe/sqrt(2*pi*sig^2)*exp(- (X1 - Y1).^2/(2*sig^2));
T1 = T1./repmat(sum(T1, 2), 1,length(cdfSec));
%F = gamma*cdfSec(:);
F = 0.9*cdfSec(:);

for i=1:Niter,
    F = F+ gamma*(cdfSec(:) - T1*F);
    F(F>1) = 1;
    F(F<0) = 0;
    J = find(diff(F) > 0),
   while length(J)>0,
    F(J+1) =F(J);
    J = find(diff(F) > 0);
   end;
    
    subplot(1, 2, 1); plot(logBe, cdfSec, logBe, F, logBe, T1*F);
   re = ( 1- 4.73^3*log(1 - F) ).^(1/3);
    subplot(1, 2, 2); semilogy(proc_TACclusters_TAC.PE.r ,proc_TACclusters_TAC.PE.cdfval(:, I), re, exp(logBe),  ( 1- 4.73^3*log(1 - T1*F) ).^(1/3),  exp(logBe),  r, 1000*exp(- r/1.9));
    figure(gcf);
   %pause(0.1);
end;

%% First deconvolve spatial interactions
I = 1;
n=2;
 %% work first with 0 AB on 5CC7 cells
Nhist = 1024;
data = TACclusters_TAC_PE(I).PE;
Xmax = 4*max(data);
dX = 2*Xmax/Nhist;
X = (-Xmax):dX:Xmax;
[Plin X] = hist(data, X);
plot(X, Plin);
figure(gcf)

 N = round(length(Plin)/2);
Plin = circshift(Plin, [1 -(N-1)]);
I1 = ifft(Plin);


lnG = log(I1);
Gn =I1.^(1/n);
%plot(X, real(lnG), X, imag(lnG), X, real(Gn), X, imag(Gn));
plot( X, abs(Gn), X, angle(Gn));
figure(gcf)

%%
% remove discontinuities
%diffangle = diff(imag(Gn));

diffangle = diff(angle(Gn));
jc = find(abs(diffangle) > pi/n);
jc = [jc length(Gn)];
for i=1:(length(jc)-1),
   % lnG((jc(i)+1):length(lnG)) =  lnG((jc(i)+1):length(lnG)) - sqrt(-1)*pi*round(diffangle(jc(i))/pi);
   Gn((jc(i)+1):length(Gn)) =  Gn((jc(i)+1):length(Gn)) * exp(-sqrt(-1)*pi/n*round(diffangle(jc(i))/pi*n));
%    plot(angle(Gn));
%    figure(gcf);
%    pause;
end;
%Gn((N+1):(2*N-1)) = conj(Gn((N-1):-1:1));
%Gn = Gn*exp(-sqrt(-1)*pi/n*round(angle(Gn(N))/pi*n))
%lnG = lnG - sqrt(-1)*mean(imag(lnG));
plot(X, real(Gn), X, imag(Gn));
figure(gcf)
%%
%Gn = [Gn(1:N) conj(Gn((N+1):-1:2))];

%size(lnG)
%hannwindow = circshift(hann(2*N), round(N));
hannwindow = circshift(hann(2*N-1), N);
size(hannwindow)
Pn = circshift(fft(Gn.*hannwindow'), [2 N-1]);
plot(X, real(Pn));
Pn = real(Pn)/real(sum(Pn));
figure(gcf)

%%
cdfvectn = 1- cumsum(Pn);
rn = ( 1- n*4.73^3*log(1 - cdfvectn) ).^(1/3);
semilogy(proc_TACclusters_TAC.PE.r,proc_TACclusters_TAC.PE.cdfval(:, I), rn, X);
figure(gcf)

%% deconvolve
maxlogBe = 2*log(max(proc_TACclusters_TAC.PE.cdfval(:, I)));
Np = 400;
dlogBe = maxlogBe/Np;
logBe = dlogBe:dlogBe:maxlogBe;

J = (X > 0);
cdfSec = interp1( log(X(J)), cdfvectn(J), logBe, 'linear', 'extrap' );
cdfSec(cdfSec >1) =1;
cdfSec(cdfSec <0) =0;
plot(log(X(J)), cdfvectn(J), logBe, cdfSec ); figure(gcf)

re = ( 1- 4.73^3*log(1 - exp(logBe)) ).^(1/3);
%%
Niter = 200;
gamma = 0.01;
sig = options.secretion.sig;

[X1,Y1] = meshgrid(logBe);
T1 = dlogBe/sqrt(2*pi*sig^2)*exp(- (X1 - Y1).^2/(2*sig^2));
T1 = T1./repmat(sum(T1, 2), 1,length(cdfSec));
%F = gamma*cdfSec(:);
F = 0.9*cdfSec(:);

for i=1:Niter,
    F = F+ gamma*(cdfSec(:) - T1*F);
    F(F>1) = 1;
    F(F<0) = 0;
    J = find(diff(F) > 0);
   while length(J)>0,
    F(J+1) =F(J);
    J = find(diff(F) > 0);
   end;
    
    subplot(1, 2, 1); plot(logBe, cdfSec, logBe, F, logBe, T1*F);
   re = ( 1- 4.73^3*log(1 - F) ).^(1/3);
    subplot(1, 2, 2); semilogy(proc_TACclusters_TAC.PE.r ,proc_TACclusters_TAC.PE.cdfval(:, I), re, exp(logBe),  ( 1- 4.73^3*log(1 - T1*F) ).^(1/3),  exp(logBe),  r, 1000*exp(- r/1.9));
     title(i)
    figure(gcf);
   
   %pause(0.1);
end;

%%  Practice in subtracting background
options.BG.sig = 150*0.2014;  %  std of the normal distribution of background rescaled with Linear Range
options.BG.mean = 150*0.1484; % a
[Plin X] = hist(data, X);
BG = exp(-(X - options.BG.mean ).^2/(2*options.BG.sig^2 ))/sqrt(2*pi)/options.BG.sig*median(diff(X));
plot(X, Plin/sum(Plin), X, BG); figure(gcf)

 N = round(length(Plin)/2);
Plin = circshift(Plin, [1 -(N-1)]);
I1 = circshift(ifft(Plin),  [1 (N-1)]);
q = 2*pi*((- (N-1)):(N -1))/(max(X) - min(X));
IBG = exp(-sqrt(-1)*options.BG.mean*q-options.BG.sig^2*q.^2/2);
plot(q, imag(I1), q, imag(I1./IBG)); figure(gcf);
pause;
hannwindow = circshift(hann(2*N-1), N);
Gb = circshift(I1./IBG,  [1 -(N-1)]);

Pb = circshift(fft(Gb.*hannwindow'), [2 N-1]);
plot(X, Pb, X, circshift(Plin, [1 N-1])); figure(gcf)
%%
x = -100:100;
Bg.sig = 20;  %  std of the normal distribution of background rescaled with Linear Range
Bg.mean = 5; % a
BG = exp(-(x - Bg.mean ).^2/(2*Bg.sig^2 ))/sqrt(2*pi)/Bg.sig*median(diff(x));
plot(x, BG); figure(gcf)

 N = round(length(BG)/2);
PBG = circshift(BG, [1 -(N-1)]);
plot(x, PBG); figure(gcf)

IBG = ifft(PBG);
IBG = circshift(IBG, [1 (N-1)]);
q = 2*pi*((- (N-1)):(N -1))/(max(x) - min(x));
plot(q, imag(IBG), q, imag(exp(sqrt(-1)*Bg.mean*q-Bg.sig^2*q.^2/2)*median(diff(x))/(2*N+1))); figure(gcf)

%% now on data: remove background
Nhist = 2048;
data = TACclusters_TAC_PE(1).PE; 
Xmax = 2*max(data);
dX = 2*Xmax/Nhist;
X = (-Xmax):dX:Xmax;
BG.sig = 150*0.2014;  %  std of the normal distribution of background rescaled with Linear Range
BG.mean = 150*0.1484; % a
[Pexp X] = hist(data, X);
Pexp = Pexp/sum(Pexp);
%BG = exp(-(X - BG.mean ).^2/(2*BG.sig^2 ))/sqrt(2*pi)/BG.sig*median(diff(X));
%plot(X, Pexp/sum(Pexp), X, BG); figure(gcf)

 N = round(length(Pexp)/2);
Pexp1 = circshift(Pexp, [1 -(N-1)]);
I1 = circshift(ifft(Pexp1),  [1 (N-1)]);
q = 2*pi*((- (N-1)):(N -1))/(max(X) - min(X));
IBG = exp(sqrt(-1)*BG.mean*q- BG.sig^2*q.^2/2);
plot(q, imag(I1), q, imag(I1./IBG)); figure(gcf);
pause;
%% zero - pad data above/below q = +/- 0.08
I1BG = I1./IBG;
I1BG((q > 0.08) | (q < -0.08)) = 0;
plot(q, imag(I1BG), q, real(I1BG)); figure(gcf);

%%
hannwindow = circshift(hann(2*N-1), N);
Gb = circshift(I1BG,  [1 -(N-1)]);

Pb = circshift(fft(Gb.*hannwindow'), [2 N-1]);
Pb = real(Pb)/sum(real(Pb));
plot(X, Pb, X, Pexp); figure(gcf)



%% Now do simultaneously background subtraction and  deconvolving spatial interactions
I = 1;
n=2;
options.BG.sig = 150*0.2014;  %  std of the normal distribution of background rescaled with Linear Range
options.BG.mean = 150*0.1484; % a
 %% work first with 0 AB on 5CC7 cells
Nhist = 1024;
data = TACclusters_TAC_PE(I).PE;
Xmax = 4*max(data);
dX = 2*Xmax/Nhist;
X = (-Xmax):dX:Xmax;
[Plin X] = hist(data, X);
plot(X, Plin);
figure(gcf)

%%
 N = round(length(Plin)/2);
Plin = circshift(Plin, [1 -(N-1)]);
I1 = ifft(Plin);


q = 2*pi*((- (N-1)):(N -1))/(max(X) - min(X));
IBG = exp(sqrt(-1)*options.BG.mean*q-options.BG.sig^2*q.^2/2);
IBG = circshift(IBG,  [1 -(N-1)]);
plot(q, imag(I1), q, imag(I1./IBG)); figure(gcf);
pause;
hannwindow = circshift(hann(2*N-1), N);
%Gb = circshift(I1./IBG,  [1 -(N-1)]);

lnG = log(I1./IBG);
Gn =(I1./IBG).^(1/n);
%plot(X, real(lnG), X, imag(lnG), X, real(Gn), X, imag(Gn));
plot( X, abs(Gn), X, angle(Gn));
figure(gcf)

%%
% remove discontinuities
%diffangle = diff(imag(Gn));

diffangle = diff(angle(Gn));
jc = find(abs(diffangle) > pi/n);
jc = [jc length(Gn)];
jc(jc==N)=[];
for i=1:(length(jc)-1),
   % lnG((jc(i)+1):length(lnG)) =  lnG((jc(i)+1):length(lnG)) - sqrt(-1)*pi*round(diffangle(jc(i))/pi);
   Gn((jc(i)+1):length(Gn)) =  Gn((jc(i)+1):length(Gn)) * exp(-sqrt(-1)*pi/n*round(diffangle(jc(i))/pi*n));
%    plot(angle(Gn));
%    figure(gcf);
%    pause;
end;
%Gn((N+1):(2*N-1)) = conj(Gn((N-1):-1:1));
%Gn = Gn*exp(-sqrt(-1)*pi/n*round(angle(Gn(N))/pi*n))
%lnG = lnG - sqrt(-1)*mean(imag(lnG));
plot(X, real(Gn), X, imag(Gn));
figure(gcf)
%%
%Gn = [Gn(1:N) conj(Gn((N+1):-1:2))];

%size(lnG)
%hannwindow = circshift(hann(2*N), round(N));
hannwindow = circshift(hann(2*N-1), N);
size(hannwindow)
Pn = circshift(fft(Gn.*hannwindow'), [2 N-1]);
plot(X, real(Pn));
Pn = real(Pn)/real(sum(Pn));
figure(gcf)


%%
cdfvectn = 1- cumsum(Pn);
rn = ( 1- n*4.73^3*log(1 - cdfvectn) ).^(1/3);
rn = ( 1+ n*4.73^3*cdfvectn).^(1/3);
semilogy(proc_TACclusters_TAC.PE.r,proc_TACclusters_TAC.PE.cdfval(:, I), rn, X);
figure(gcf)

%% deconvolve
maxlogBe = 2*log(max(proc_TACclusters_TAC.PE.cdfval(:, I)));
Np = 400;
dlogBe = maxlogBe/Np;
logBe = dlogBe:dlogBe:maxlogBe;

J = (X > 0);
cdfSec = interp1( log(X(J)), cdfvectn(J), logBe, 'linear', 'extrap' );
cdfSec(cdfSec >1) =1;
cdfSec(cdfSec <0) =0;
plot(log(X(J)), cdfvectn(J), 'o', logBe, cdfSec ); figure(gcf)

re = ( 1- 4.73^3*log(1 - exp(logBe)) ).^(1/3);
re = ( 1+ n*4.73^3*exp(logBe)).^(1/3);
%%
Niter = 400;
gamma = 0.01;
sig = options.secretion.sig;

[X1,Y1] = meshgrid(logBe);
T1 = dlogBe/sqrt(2*pi*sig^2)*exp(- (X1 - Y1).^2/(2*sig^2));
T1 = T1./repmat(sum(T1, 2), 1,length(cdfSec));
%F = gamma*cdfSec(:);
F = 0.9*cdfSec(:);

for i=1:Niter,
    F = F+ gamma*(cdfSec(:) - T1*F);
    F(F>1) = 1;
    F(F<0) = 0;
    J = find(diff(F) > 0);
   while length(J)>0,
    F(J+1) =F(J);
    J = find(diff(F) > 0);
   end;
    
    subplot(1, 2, 1); plot(logBe, cdfSec, logBe, F, logBe, T1*F);
   re = ( 1- 4.73^3*log(1 - F) ).^(1/3);
   re = ( 1+ 4.73^3*F).^(1/3);
    subplot(1, 2, 2); semilogy(  rn, X, re, exp(logBe),  ( 1+ 4.73^3*T1*F ).^(1/3),  exp(logBe),  r, 1000*exp(- r/1.9));
     title(i)
    figure(gcf);
   
   %pause(0.1);
end;

%% Start with simulated data
options.BG.sig = 0.2014;  %  std of the normal distribution of background rescaled with Linear Range
options.BG.mean = 0.1484;
options.BG.do = true;
X = -3:(9/300):8;
beta0 = [4.25  2.46];
options.BG.do = true;
[P, Plin, B, I] = ScreenedFieldToDistributionFIDA(beta0, X, options);
%options.BG.do = false;
%[P, PlinNoBG, BnoBG, InoBG] = ScreenedFieldToDistributionFIDA(beta0, X, options);

plot(B, Plin);
figure(gcf)

%%
Plin1 = Plin(1:(length(Plin) -1));
B1 = B(1:(length(B)-1));
N = round(length(Plin1)/2);
Plin1 = circshift(Plin1, [1 -(N-1)]);
I1 = circshift(ifft(Plin1),  [1 (N-1)]);
q = 2*pi*((- (N-1)):(N -1))/(max(B) - min(B));
IBG = exp(sqrt(-1)*options.BG.mean*q-options.BG.sig^2*q.^2/2);
plot(q, real(I1), q, imag(I1), q, real(IBG), q, imag(IBG));
figure(gcf)
%%

plot(q, imag(I1), q, imag(I1./IBG)); figure(gcf);

%% cut edges (2/3 of the range): huge noise there:
N1 = round(N/3);
I1BG = I1./IBG;
I1BG = I1BG((N-N1+1):(N +N1-1));
q1 = q((N-N1+1):(N +N1-1));
plot(q1, real(I1BG), q1, imag(I1BG)); figure(gcf);

%%


hannwindow = circshift(hann(2*N1-1), N1);
Gb = circshift(I1BG,  [1 -(N1-1)]);

Pb = circshift(fft(Gb.*hannwindow'), [2 N1-1]);
Bb = 2*pi*((- (N1-1)):(N1 -1))/(max(q1) - min(q1));
plot(Bb, Pb, B, Plin, BnoBG, PlinNoBG); figure(gcf)

%%
% X = 150*B;
% [Pexp X] = hist(data, X);
% plot(X, Plin/sum(Plin), X, Pexp/sum(Pexp));
% figure(gcf)

%% Try to develop a new procedure for FFT
plot(B, Plin); figure(gcf)
Ncdf = 1000;

i1 = (real(Plin) >1e4*eps);
Btemp = B(i1);
Ptemp = Plin(i1);
cdfvect = (1:Ncdf)/(Ncdf+1);
cdftemp = real(cumsum(Ptemp)/sum(Ptemp));
cdfval = interp1(cdftemp, Btemp, cdfvect);

plot(Btemp, cdftemp, cdfval, cdfvect);
figure(gcf)

%%
Gmy = sum(exp(sqrt(-1)*q1(:)*cdfval), 2)/Ncdf;
%%
plot(q1, real(Gmy)*0.235, q1, imag(Gmy)*0.235, q, real(I1), q, imag(I1)); figure(gcf)

%%
IBG = exp(sqrt(-1)*options.BG.mean*q-options.BG.sig^2*q.^2/2);
I1BG = Gmy'./IBG((N-N1+1):(N +N1-1));
plot(q1, real(I1BG), q1, imag(I1BG)); figure(gcf);

I1BG((q1 > 11) | (q1 < -11)) = 0;
plot(q1, imag(I1BG), q1, real(I1BG)); figure(gcf);

%%
hannwindow = circshift(hann(2*N1-1), N1);
Gb = circshift(I1BG,  [1 -(N1-1)]);

Pb = circshift(fft(Gb.*hannwindow'), [1 N1-1]);
Pb = real(Pb)/sum(real(Pb));
%%
plot(-Bb, Pb*length(Bb)/length(B), B, Plin/sum(Plin), BnoBG, PlinNoBG/sum(PlinNoBG)); figure(gcf)

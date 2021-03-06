function [P, Plin, B, I] = ScreenedFieldToDistributionFIDAfast(beta, X, varargin)

%lam = 10;

if length(varargin) >0,
    options = varargin{1};
else
%    options.minrho = 0.01;
    options.Np = 1001;
    options.r0_in_cell_dia = 3;
    
    %FIDA options
    options.tol_exp_FIDA = 1e-3;
    options.rhomaxfactor = 12;
    options.Nrhopt = 200;
    options.range_q = 3;
    options.Nqpt = 20;
 
    options.secretion.do = false;
    options.secretion.sig = 0.92; %  std in lognormal coordinates of secretion rate distribution 
    
    options.capture.do = false;
    options.capture.sig = 0.1766; %  std in lognormal coordinates of capture antibody distribution 
    
    options.BG.do = false;
    options.BG.sig = 0.2014;  %  std of the normal distribution of background rescaled with Linear Range
    options.BG.mean = 0.1484; % average value of background rescaled with Linear Range
    
    options.data.mean = 1; % average value of the data rescaled with LinearRange
    
    
end;

%Qtag = beta(1); % mean
rho0 = beta(1);
A = 1; % beta(3);

e = exp(1);
kd = rho0/options.r0_in_cell_dia;

Qtag =  (options.data.mean - options.BG.mean)*rho0^3*exp(kd)/(3*(1+kd));
if options.secretion.do,
    Qtag = Qtag*exp(-options.secretion.sig.^2/2 );
end;
Qtag

tol_exp_FIDA = options.tol_exp_FIDA;
rhomaxfactor =  options.rhomaxfactor;
Nrhopt = options.Nrhopt;
range_q = options.range_q;
Nqpt = options.Nqpt ;

Btag_max = sinh(max(X))/Qtag;

% Non-zero values of FIDA function for Fourier transforming are in the
% range of 

x_max = pi*exp((-3.5*rho0.^3.*log(tol_exp_FIDA)/3).^(1/3)); %use an estimate for homogeneous sources in the meantime

N = 2^ceil(log2(x_max*Btag_max/pi+1))
x = (0:N)/N*x_max;

if options.secretion.do,
    sig_q = options.secretion.sig;
    if options.capture.do,
        sig_q = sqrt(sig_q^2 + options.capture.sig^2);
    end;
    % try different q step before and after maximum
    % up to a lognormal maximum cdf is 
    cdf = 1/2*(1+ erf(-sig_q/2^(1/2)));
    % use this as a fraction of Nqpt
    Nqpt1 = round(cdf*Nqpt);
    Nqpt2 = Nqpt - Nqpt1;
    q1 = (0:Nqpt1)/Nqpt1*exp(-sig_q^2);
    q2 = exp(-sig_q^2) + (1:Nqpt2)*(exp(sig_q*range_q) - exp(-sig_q^2))/Nqpt2;
    q = [q1 q2];
    dq = diff(q);
    q = (q(1:Nqpt) + q(2:(Nqpt+1)))/2;
    Plogn = dq.*exp( - log(q).^2/(2*sig_q^2))./(q*sig_q*sqrt(2*pi));
    
else % assume single secretion rate
    Nqpt = 1;
    q= 1;
    Plogn = 1;
end;

  % matrix of q-values:
qmat = repmat(q, Nrhopt-1, 1);
I = zeros(size(x));
for i=1:length(x),

    rho_max = rhomaxfactor*log(abs(x(i)*q)/pi./log(abs(x(i)*q)/pi));
    %rho_max(rho_max<rhomaxfactor) = rhomaxfactor;
    rho_max((x(i)*q<pi*e) & (x(i)*q > - pi*e )) = rhomaxfactor;



%    rho = kd+(rho_max - kd)/log(Nrhopt(i))*log(Nrhopt(i)./(1:Nrhopt(i)));          good
% first calculate the set of rho for some intermediate value of q:
    rho_norm = e+(rho_max(round(Nqpt/2)) - e)/log(Nrhopt)*log(Nrhopt./(1:Nrhopt)); 
%    rho = e+(rho_max(i) - e)/log(Nrhopt)*log(Nrhopt./(1:Nrhopt));
    rho_norm = rho_norm./log(rho_norm);
% rescale now to the range from 0 to 1:
    rho_norm = (rho_norm - e)/(rho_norm(1) - e);
    rho_norm = rho_norm(:);
 % now calculate the set of rho for each q by adjusting the range to [kd, rho_max]
    rho = kd +rho_norm*(rho_max - kd);
    drho_norm = diff(rho_norm);
    rho = ( rho(1:(Nrhopt-1), :) + rho(2:Nrhopt, :) )/2;
  %  I(i) = Plogn * ( (rho.^2.*(exp(sqrt(-1)*qmat*x(i)./rho.*exp(-rho)) -1)).'*drho_norm).*(rho_max - kd)' )/Qtag; % transposition as ()' also conjugates, use .'
    I(i) = Plogn * ( ( ( rho.^2.*(exp(sqrt(-1)*qmat*x(i)./rho.*exp(-rho)) -1) ).'*drho_norm).*(rho_max - kd)' );
%    pause;
end;

%  plot(x, real(I), x, imag(I))
% figure(gcf);
% pause;

I = exp(-3/rho0^3*I)/Qtag;
% plot(x, real(I), x, imag(I))
% figure(gcf);
% pause;

%I = ones(size(x)) ; % check for delta function behavior

if options.BG.do
    I = I.*exp(sqrt(-1)*options.BG.mean*x/Qtag - 1/2*(options.BG.sig*x/Qtag).^2);
end;

% Fourier transform the exponent of that integral
Plin = fft([I conj(I(N:-1:2))]);
Btag = pi*( (-N+1):N)*(N -1)/N/x_max;
B = Btag*Qtag;
Plin = circshift(Plin, [0  N-1]);

P = interp1(B, real(Plin), sinh(X)).*sqrt(1 + sinh(X).^2);
P(P <0) = 0;
%sum(Plin)/(2*N)
% check that transformation to X does not change the normalization
%( Plin(1:(2*N-1)) +Plin(2:(2*N)) )*diff(B)'
%( P(1:(length(P)-1)) +P(2:length(P)) )'*diff(X)
P = P/sum(P);






function [P1, P, kern] = ScreenedFieldToDistributionWithSpreadQ_v1(beta, X, varargin)

lam = 10;

if length(varargin) >0,
    options = varargin{1};
else
    options.minrho = 0.01;
    options.Np = 1001;
 
    options.secretion.do = false;
    options.secretion.sig = 0.92; %  std in lognormal coordinates of secretion rate distribution 
    
    opttions.capture.do = false;
    options.capture.sig = 0.1766; %  std in lognormal coordinates of capture antibody distribution 
    
    options.BG.do = false;
    options.BG.sig = 0.2014;  %  std of the normal distribution of background rescaled with Linear Range
    options.BG.mean = 0.1484; % average value of background rescaled with Linear Range
end;


% minrho = 0.01;
% Qspread = 0.92; %  lognormal distribution of secretion rate
% 
% BGspread = 0.2014; % normal distribution of background relative to Linear Range
% BGmean = 0.1484; % average value of background    

%Np = 1001;
 range = 30;

Qtag = beta(1); % mean
rho0 = beta(2);
A = beta(3);

Qmax = X(length(X))/(2*exp(-rho0)/(1+rho0));
%stdQ = Qtag*sqrt(exp(options.secretion.sig^2) - 1);
mu = log(Qtag) - options.secretion.sig^2/2;
Np = options.Np;
%Qvec = Qtag + (( (- (Np -1)/2):((Np-1)/2) )/Np*2*range*stdQ);

%tol = options.tol;
%Qvec = exp(mu - sqrt(2)*options.secretion.sig*erfcinv(2*(tol:tol:(1-tol))));
%cumProb = tol*exp(1:(tol*log(1/tol)):log(1/tol-1));

%cumProb =  (tol:tol:1).^4 *(1- tol);

%cumProb = [tol:(tol):0.5 (0.5 + tol):tol:(1 - tol)];
%size(cumProb)
%diffCumProb = diff(cumProb);
%cumProb = [tol:(tol):(1 - tol)];

%Qvec = exp(mu - sqrt(2)*options.secretion.sig*erfcinv(2*cumProb));
Qvec = (1:Np)/Np*Qmax;
rho_vec = 2*rho0./(1+sqrt(Qtag./Qvec));

P = zeros(size(X));

% J = 1:Np;
% J = J(Qvec >0);
for i = 1:length(Qvec), % take into account the distribution of secetion 
%    if Qvec(i) > 0,
%        P = P + ScreenedFieldToDistribution([Qvec(i) rho_vec(i) A], X);
         P = P + ScreenedFieldToDistribution([Qvec(i) rho_vec(i) A],  X)*lognpdf(Qvec(i),mu, options.secretion.sig);

        
%         if any(isnan(P)),
%             [i Qvec(i) rho_vec(i)],
%         end;
 %   end;
end;

% background

[X1, X2] = meshgrid(X);
kern = exp(- (sinh(X1) - sinh(X2) + sinh(options.BG.mean)).^2/(2*options.BG.sig^2));
kern = kern./repmat(sum(kern, 2), 1, length(X));
P1 = kern*P;






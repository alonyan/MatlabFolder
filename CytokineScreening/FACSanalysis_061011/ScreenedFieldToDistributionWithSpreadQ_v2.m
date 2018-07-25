function P = ScreenedFieldToDistributionWithSpreadQ_v2(beta, X, varargin)

%lam = 10;

if length(varargin) >0,
    options = varargin{1};
else
%    options.minrho = 0.01;
    options.Np = 1001;
    options.r0_in_cell_dia = 3;
 
    options.secretion.do = false;
    options.secretion.sig = 0.92; %  std in lognormal coordinates of secretion rate distribution 
    
    options.capture.do = false;
    options.capture.sig = 0.1766; %  std in lognormal coordinates of capture antibody distribution 
    
    options.BG.do = false;
    options.BG.sig = 0.2014;  %  std of the normal distribution of background rescaled with Linear Range
    options.BG.mean = 0.1484; % average value of background rescaled with Linear Range
end;

Qtag = beta(1); % mean
rho0 = beta(2);
A = 1; % beta(3);

if options.secretion.do,
    Qmax = X(length(X))/(2*exp(-rho0)/(1+rho0));
    sig = options.secretion.sig;
    if options.capture.do,
        sig = sqrt(sig^2 + options.capture.sig^2);
    end;
    mu = log(Qtag) - sig^2/2;
    Np = options.Np;

    Qvec = (1:Np)/Np*Qmax;
    rho_vec = 2*rho0./(1+sqrt(Qtag./Qvec));
    
    minrho = 0.5*rho0/ options.r0_in_cell_dia; % one cell radius is the minimal distance (not diameter )
    P = zeros(size(X));


    for i = 1:length(Qvec), % take into account the distribution of secretion 
             P = P + ScreenedFieldToDistribution([Qvec(i) rho_vec(i) A],  X, minrho)*lognpdf(Qvec(i),mu, sig);
    end;
else
    P = ScreenedFieldToDistribution([Qtag rho0 A],  X);
end;

% background

if options.BG.do
    [X1, X2] = meshgrid(X);
    kern = exp(- (sinh(X1) - sinh(X2) + sinh(options.BG.mean)).^2/(2*options.BG.sig^2));
    kern = kern./repmat(sum(kern, 2), 1, length(X));
    P = kern*P;
end;

P = P/sum(P);






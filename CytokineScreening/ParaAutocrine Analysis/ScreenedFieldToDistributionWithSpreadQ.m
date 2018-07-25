function [P1, P, kern] = ScreenedFieldToDistributionWithSpreadQ(beta, X)
minrho = 0.01;
Qspread = 0.92; %  lognormal distribution of secretion rate

BGspread = 0.2014; % normal distribution of background relative to Linear Range
BGmean = 0.1484; % average value of background    

Np = 1001;
range = 30;

Qtag = beta(1); % mean
rho0 = beta(2);
A = beta(3);

stdQ = Qtag*sqrt(exp(Qspread^2) - 1);
mu = log(Qtag) - Qspread^2/2;

Qvec = Qtag + (( (- (Np -1)/2):((Np-1)/2) )/Np*2*range*stdQ);
rho_vec = 2*rho0./(1+sqrt(Qtag./Qvec));

P = zeros(size(X));

J = 1:Np;
J = J(Qvec >0);
for i = J, % take into account the distribution of secetion 
%    if Qvec(i) > 0,
        P = P + ScreenedFieldToDistribution([Qvec(i) rho_vec(i) A], X)*lognpdf(Qvec(i),mu,Qspread);
%         P = P + ScreenedFieldToDistribution([Qvec(i) rho_vec(i) A], asinh(sinh(X) - sinh(BGmean)))*lognpdf(Qvec(i),mu,Qspread);

        
        if any(isnan(P)),
            [i Qvec(i) rho_vec(i)],
        end;
 %   end;
end;

% background

[X1, X2] = meshgrid(X);
kern = exp(- (sinh(X1) - sinh(X2) + sinh(BGmean)).^2/(2*BGspread^2));
kern = kern./repmat(sum(kern, 2), 1, length(X));
P1 = kern*P;






function rhoE =rhoEfit(beta, n)
rhoE = beta(1)./n.^(3/2).*((1+beta(2)*sqrt(n)).^(1/3) - 1).^3;
function y = YukawaFit(beta, x)
logc0 = beta(1);
kappa = beta(2);

y = logc0 - log(x) -kappa.*x;
end


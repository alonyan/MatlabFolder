function Y = CCDcalibrationGlobalFit(beta, X);
a = beta(1);
b = beta(2);

Xb = X(:, 1);
pow = X(:, 2);

Y = a.^pow .* ( Xb + b/(a-1)) - b/(a-1);
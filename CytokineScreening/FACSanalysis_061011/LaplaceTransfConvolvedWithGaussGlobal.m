function y = LaplaceTransfConvolvedWithGaussGlobal(beta, x, param)
% assume beta are the coefficients in Laplace Transform
if length(param) ~= 3,
    errordlg('param should be a cell array containing pos and sig of the background and an  array with exponents')
end;
if size(param{3}, 1) ~= (length(beta) - 1),
    errordlg('the length of beta should be larger  than the number of raws in param{3} by 1')
end;

beta = beta(:);
x = x(:);
pos = param{1}; % center of the Gaussian
sig = param{2}; % width of the Gaussian (std)

s = param{3}; % an array of Laplace transform exponents


for i = 1:size(s, 2), 
    x1 = x - pos(i);
    [S, X] = meshgrid(s(:, i),x1);
    A = (erfc( - (X - S*sig(i)^2)/sig(i)/sqrt(2) ).*exp( - S.*X + S.^2*sig(i)^2/2).*S/2);
    y(:, i) = beta(1)/sig(i)/sqrt(2*pi)*exp(- x1.^2/sig(i)^2/2) + A*beta(2:(end)); % add background to the set of exponents
end;

y(isnan(y)) = 0;
%y = y./repmat(sum(y, 1), size(y, 1), 1);
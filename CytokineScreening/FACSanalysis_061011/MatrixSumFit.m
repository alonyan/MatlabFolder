function y = MatrixSumFit(beta, x, Mx)
y = zeros(size(Mx(:, :, 1)));
for i=1:length(beta),
    y = y + Mx(:, :, i)*beta(i);
end;
y = y(:);
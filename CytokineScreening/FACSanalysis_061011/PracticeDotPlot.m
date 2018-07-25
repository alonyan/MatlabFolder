clear;
sig
A(:, 1) = [normrnd(3, sig, 100000, 1); normrnd(0, sig, 100000, 1)];
A(:, 2) = [normrnd(-1, sig, 100000, 1); normrnd(3, sig, 100000, 1)];

%scatter(A(:, 1), A(:, 2), 1);
%figure(gcf)
colormap('jet');

Nbins =30;
[N, X] = hist3(A, [Nbins Nbins]);
C = interp2(X{1}, X{2}, N, A(:, 1), A(:, 2), '*linear');
scatter(A(:, 1), A(:, 2), 1, C);
figure(gcf)

%%
A = normrnd(0, 1, 100000, 2);
%scatter(A(:, 1), A(:, 2), 1);
%figure(gcf)
%%
colormap('jet');

Nbins =30;
[N, X1] = hist3(A, [Nbins Nbins]);
C = interp2(X1{1}, X1{2}, N, A(:, 1), A(:, 2));
scatter(A(:, 1), A(:, 2), 1, C);
figure(gcf)

%%
TempData = LoadFACSfromFlowJoWorkspace_v4(fpath, 'GroupInd', 8, 'GateInd', -1  , 'NameFilter', 'Cluster with 5CC7\[KO\]IL2_N1');
%%
ScatterPlotFACS_v1(TempData(1).data(:, [4 6]))

%%
%%
ScatterPlotFACS_v1(TempData(1).data(:, [1 2]), [], 'LogXscale', 0, 'LogYscale', 0); 
figure(gcf)
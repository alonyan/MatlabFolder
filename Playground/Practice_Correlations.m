%% Weird single-square maps

 %% Start here, Make some grid and some velocity field (nXn)
 nox = 20;
noy = 20;

[A.X1, A.X2] = meshgrid(linspace(0,30,nox));
[A.Y1, A.Y2] = meshgrid(linspace(0,60,noy));


A.U = exp(-0.001*(A.X1-5).^2).*exp(-0.005*(A.X1-20).^2);
A.V = exp(-0.001*(A.Y1-5).^2).*exp(-0.005*(A.Y2-20).^2);

%% Make a map of distances bw each element and each other elemnt (nnxnn).


    bx1 = reshape(A.X1,[],1);
    by1 = reshape(A.Y1,[],1);
    bx2 = reshape(A.X2,[],1);
    by2 = reshape(A.Y2,[],1);
    [bx1 bx2] = meshgrid(bx2,bx1);
    [by1 by2] = meshgrid(by2,by1);
    DistMap = sqrt((bx2-bx1).^2+((by2-by1)').^2);%blocks of distance from point... each noxXnoy block is the distance from the relevant i,j point
    DistMap = cell2mat(reshape(mat2cell(DistMap,nox*ones(1,noy),noy*ones(nox,1)),nox,noy).');%reshape Distmap in a more convenient form

% make map of dot products bw local velocities ("scores")    
    bu = reshape(A.U,[],1);
    bv = reshape(A.V,[],1);
    bx1 = reshape(A.X1,[],1);
    by1 = reshape(A.Y2,[],1);
    arrow3([bx1,by1],[bx1+3*bu,by1+3*bv],'|1',0.4,0.8)
    twovCorr = kron(A.V, A.V)+kron(A.U, A.U);
%% make individual maps for each square. This is mostly for presentation.

clear DistMaps
clear CorrMaps
for i=1:noy
    for j=1:nox
        CorrMaps(:,:,i,j) = twovCorr(1+(i-1)*nox:i*nox,1+(j-1)*noy:j*noy);
        DistMaps(:,:,i,j) = DistMap(1+(i-1)*nox:i*nox,1+(j-1)*noy:j*noy);
    end
end

%%
i=17;j=17;
DistMapVec = DistMaps(:,:,i,j);
DistMapVec = DistMapVec(:);
CorrVec = CorrMaps(:,:,i,j);
CorrVec = CorrVec(:);

%% Calculate correlation function
DistBinSize = 3;
len = ceil(max(DistMapVec)/DistBinSize);
DistBins = (0.5+(0:len))*DistBinSize;

BinNo = ceil(DistMapVec/DistBinSize);

Nbin = [];
Corr = [];
error_corr = [];
for i = 1:(len+1),
    %i
    J = find(BinNo == i);
    Nbin = [Nbin length(J)];
    Corr = [Corr mean(CorrVec(J))];
    error_corr = [error_corr std(CorrVec(J))/sqrt(Nbin(i))];
end

plot(DistBins, Corr,'o');
shg




%%Normal correlation functions:


 %% Start here, Make some grid and some velocity field (nXn), (these will be our inputs later)
 nox = 10;
noy = 10;

[A.X, ~] = meshgrid(linspace(0,60,nox));
[~, A.Y] = meshgrid(linspace(0,30,noy));

A.U = exp(-0.001*(A.X-5).^2).*exp(-0.001*(A.X-20).^2);
A.V = exp(-0.001*(A.X-5).^2).*exp(-0.001*(A.X-20).^2);
 
A.X = reshape(A.X,[],1);
A.Y = reshape(A.Y,[],1);
A.U = reshape(A.U,[],1);
A.V = reshape(A.V,[],1);


%% Make a map of distances bw each element and each other elemnt (nnxnn).


    [AX1 AX2] = meshgrid(A.X);
    [AY1 AY2] = meshgrid(A.Y);
    A.DistMap = sqrt((AX1-AX2).^2+((AY1-AY2)').^2);%blocks of distance from point... each noxXnoy block is the distance from the relevant i,j point
    A.CorrMap = A.U*A.U'+A.V*A.V';
%% make map of dot products bw local velocities ("scores")    


    arrow3([A.X,A.Y],[A.X+3*A.U,A.Y+3*A.V],'|1',0.4,0.8)
%% 
J = find(tril(A.DistMap)>0); %No double counting, and no self correlations
DistMapVec = A.DistMap(J);
CorrMapVec = A.CorrMap(J);

plot(DistMapVec, CorrMapVec,'o');

%% Calculate correlation function
DistBinSize = 10;
len = ceil(max(DistMapVec)/DistBinSize);
DistBins = (0.5+(0:len))*DistBinSize;

BinNo = ceil(DistMapVec/DistBinSize);

for i = 1:(len+1),
    %i
    J = find(BinNo == i);
    Nbin(i) = length(J);
    Corr(i) = mean(CorrMapVec(J));
    error_corr(i) = std(CorrMapVec(J))/sqrt(Nbin(i));
end

plot(DistBins, Corr,'o');
shg

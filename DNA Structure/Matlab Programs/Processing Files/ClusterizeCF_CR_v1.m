function [T, j, DeleteList] = ClusterizeCF_CR_v1(CF, varargin)
%use Matlab routines to cluster correlation data
%parameters
% CF - correlation structure;
%
% other come in pairs
% 'No of Clusters'      -       NoClust
% 'Normalization range'   -   range1:  like [1e-3 1e-2] - used to normalize
%                                                                               CF_CRs to unity
%'Distance range'  -  range2:                  to measure distances between
%                                                                               curves
%
%  'Linkage':                      'single' (default)
%                                               'weighted' 
%                                               'average'
%example of use:
% [T, j, DeleteList] = ClusterizeCF_CR_v1(PBR_24uM_10000, 'No of Clusters', 220, 'Normalization range', [1e-3 5e-3], 'Distance range', [1e-1 10], 'Linkage', 'single')

%loading varargin and/or defaults
CF_CR = CF.CF_CR';
t = CF.lag;
Ncorr = size(CF_CR, 1)

j1=find(strcmp(varargin, 'No of Clusters'));
if length(j1)>1,
    error('Too many No of Clusters inputs!')
elseif length(j1)==1,
    NoClust = varargin{j1+1};
else %default
    NoClust = round(Ncorr/2);
end;

j1=find(strcmp(varargin, 'Normalization range'));
if length(j1)>1,
    error('Too many Normalization range inputs!')
elseif length(j1)==1,
    range1 = varargin{j1+1};
else %default
    range1 = [1e-3 1e-2];
end;

j1=find(strcmp(varargin, 'Distance range'));
if length(j1)>1,
    error('Too many Distance range inputs!')
elseif length(j1)==1,
    range2 = varargin{j1+1};
else %default
    range2 = [1e-2 1000];
end;

j1=find(strcmp(varargin, 'Speed (um/ms)'));
if length(j1)>1,
    error('Too many Speed (um/ms) inputs!')
elseif length(j1)==1,
    vel = varargin{j1+1};
else %default
    vel = 1;
end;

j1=find(strcmp(varargin, 'Linkage'));
if length(j1)>1,
    error('Too many Linkage inputs!')
elseif length(j1)==1,
    LinkType  = varargin{j1+1};
else %default
    LinkType = 'single';
end;

%normalizing CF_CR to unity in range1
j=find( (t > range1(1) ) & (t < range1(2)) );
CF_CR = CF_CR./repmat(mean(CF_CR(:, j), 2), 1, size(CF_CR, 2));

%now start clustering
j=find( (t > range2(1) ) & (t < range2(2)) );

Z = pdist(CF_CR(:, j), 'seuclidean');
%Z = pdist(CF_CR(:, j), 'correlation');
Zl=linkage(Z, LinkType);
%Zl=linkage(Z, 'weighted');
%Zl=linkage(Z, 'average');
disp('evaluate quality of clustering cophenet')
c = cophenet(Zl,Z) 

T = cluster(Zl,'maxclust', NoClust);
[Y, J]=sort(hist(T, NoClust), 'descend'); 
Y(1:min(10, length(Y)))

j = find(T==J(1));
disp('good runs')
disp(length(j))
DeleteList = setdiff(1:Ncorr, j);

figure;
semilogx(t,  CF_CR, '-b', t,  CF_CR(find(T==J(1)), :), '-g', t,  CF_CR(find(T==J(2)), :), '-r');
axis([0.001 1000 -0.5 1.5]);
figure;
 
semilogy( t.^2,  mean(CF_CR(j, :), 1), t.^2,  median(CF_CR(j, :), 1));
axis([0 1 1e-3 1.5]);
 
% figure;
 %semilogy( t.^2,  mean(CF.CF_CR(:, j), 2), t.^2,  median(CF.CF_CR(:,j), 2));
%axis([0 1e6 1e-2 1.5]);


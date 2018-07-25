close all
NormRange = [0.5e-2 10e-2];
fig1 = figure;
fig2 = figure;

filepath = 'D:\People\Ilan\Experiments\020210\'
%% FCS file
FCSname ={ 's_224_2mkW_30m_d__corr_4' };
S = LoadMultipleCorrFunc_v2(filepath,  FCSname, 'Rejection',100, 'NormalizationRange', NormRange,  'DeleteList', [ ] );

%%  PCH file
PCHname =  's_224_2mkW_30m_d__pch_4'
fid = fopen([filepath PCHname])
fread(fid, 1, 'int16')
fread(fid, 1, 'int32')
fread(fid, 1, 'int32')
dt = fread(fid, 1, 'double')*1e-3;
LogBookSize = fread(fid, 1, 'int32')
LogBook = fscanf(fid, '%c', LogBookSize)
c = fread(fid, inf, 'uint8');
c(1:9)
c = c(9:length(c));
fclose(fid);
len = length(c);
%% which run?
Nruns=size(S.CF_CR, 2);
clear N_fcs q_fcs N_pch q_pch
for i = 1:  Nruns,
    figure(fig1);
    semilogx(S.lag, S.CF_CR(:, i)); title(['count rate per molecule = ' num2str(S.G0_good(i))]);
    axis([0.01 1000 0 2*S.G0_good(i)])
    figure(fig2)
    plot(S.trace(:, i)); title(['total count rate = ' num2str(S.CR(i))]);
    pause;
    ccut = c(round(((i-1)*len/Nruns +1):(i*len/Nruns)));
    figure(fig1); plot(ccut);
    title('Choose min/max ranges')
    n = 0:max(ccut);
    hc = hist(ccut, n);
    figure(fig2); plot(n, hc);
    title('Choose min/max ranges')
    pause;   
    
    minn = input('discard count values below level ')
    maxn = input('discard count values above level ')
    
    J = find((ccut<maxn) & (ccut > minn)); 
    ccut = ccut(J);
    n = minn:maxn;
    hc = hist(ccut, n);
    Pexp = hc/sum(hc);

    'Number of molecules'
    [ S.CR(i)/S.G0_good(i)      mean(ccut)^2/(var(ccut) - mean(ccut))] 
    
    N_fcs(i) = S.CR(i)/S.G0_good(i)
    q_fcs(i) = S.G0_good(i)*dt
    
    beta = nlinfit(n, Pexp, @FIDAsimple_fit, [N_fcs(i) q_fcs(i)]);
    
    N_pch(i)  = beta(1)
    q_pch(i) = beta(2)
    
   figure(fig1);
   semilogy(n, Pexp, 'o', n, FIDAsimple_fit(beta, n));
   pause;
end;


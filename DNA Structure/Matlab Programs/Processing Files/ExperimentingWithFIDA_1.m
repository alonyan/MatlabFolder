%% 
clear Pexp n InvBetaFIMDA1comp logG_sur
bins =50;
len = length(c1);
for i = 50:50%Nruns,
        N_fcs(i) = S.CR(i)/S.G0_good(i);
        q_fcs(i) = S.G0_good(i)*dt;
        figure(fig2);
        ccut1 = c1(round(((i-1)*len/Nruns +1):(i*len/Nruns)));
        for j = 1:length(coarsegrain),
            j
           if coarsegrain(j) == 1,
               ccut2 = ccut1;
           elseif coarsegrain(j) == 2,
               ccut2 = ccut1(1:(length(ccut1)-1)) + ccut1(2:length(ccut1)) ;
           else
               ccut2 = smooth(ccut1, coarsegrain(j))*coarsegrain(j);
           end;
           fimda(j).ccut2 = ccut2;
%             maxn = max(ccut2);
%             minn = min(ccut2);
%             step = ceil((maxn-minn)/bins)
%             n(:, j) = minn + (0:49)'*step;
%             hc = hist(ccut2, n(:, j));
%             Pexp(:, j) = hc'/sum(hc)/step;
        end;
      
%         semilogy(n, Pexp, 'o'); figure(gcf)
%         pause;
   % Fits
    
   maxn = max(fimda(length(fimda)).ccut2);
   n = 0:maxn;
   
    for j = 1:length(dt1),
        
       hc = hist(fimda(j).ccut2, n);
       Nsamples  = sum(hc);
       Pexp(:, j) = hc'/Nsamples;
       
      
% start test
   %     nJ = 0:51;
    %    Ptest = [FIDAsimple_fit([N_fcs(i) q_fcs(i)], nJ); zeros(length(n) -length(nJ), 1) ];
     %  Pexp(:, j) =Ptest;
%    end test
        J = find(Pexp(:, j) > 0);
        J = 1:max(J);
       xi1 = J/max(J)*pi;
       logG = log(polyval(Pexp(max(J):-1:1, j), xi1));
       logG =logG(:);
       
    
  %now create surrogates in order to estimate mistakes on logG:
  M = 30; % number of surrogates
  J1 = randperm(Nsamples);
  Surrogate_length = floor(Nsamples/M);

  meas = reshape(fimda(j).ccut2(J1(1:(Surrogate_length*M))), Surrogate_length, M);
  
  hc_sur = hist(meas, n);
  norm_hc = sum(hc_sur);
  Pexp_sur = hc_sur./repmat(norm_hc, (maxn+1), 1);
  meanPexp = mean(Pexp_sur, 2);
  errorPexp = std(Pexp_sur, 0, 2);
 
%  plot(n, meanPexp);
%plot(sqrt(meanPexp), errorPexp, 'o');
%figure(gcf);
% now to Fourier transform
clear logG_sur;
for jsur = 1:M,
    logG_sur(:, jsur) = log(polyval(Pexp_sur(max(J):-1:1, jsur), xi1));
end;

stdLogG = std(logG_sur, 0, 2)/sqrt(M);
  
        if j==1,
            startBeta = [N_fcs(i)/2 q_fcs(i)*0.5  N_fcs(i)/2 q_fcs(i)*2];
           %  startBeta = [N_fcs(i)/2 0.9*q_fcs(i)  N_fcs(i)/2 1.1*q_fcs(i)];
            %  startBeta =[N_fcs(i) q_fcs(i)];
        else 
            startBeta =  InvBetaFIMDA1comp(j-1, :)
            startBeta(2) = 0.9*startBeta(2)*dt1(j)/dt1(j-1);
            startBeta(4) = 1.1*startBeta(4)*dt1(j)/dt1(j-1);
        end;    
       InvBetaFIMDA1comp(j, :) = nlinfit_logG(xi1, logG,  @FIDA_Inv_Fit_N_comp_vs_Xi_v2, startBeta, 'ErrorWeights', stdLogG, 'Parameters', {2 'simple'}) 
       J = find(Pexp(:, j) > 0);
        [temp, logGfit, Pfit] = FIDA_Inv_Fit_N_comp_vs_Xi_v2(InvBetaFIMDA1comp(j, :) , xi1, {2 'simple' [] n(J)});
        [temp, logGfit0, P0] =  FIDA_Inv_Fit_N_comp_vs_Xi_v2(startBeta , xi1, {2 'simple' [] n(J)});
        subplot(1, 2, 1); plot(xi1, logG, 'o',  xi1, [logGfit logGfit0]);

        title(j)
        subplot(1, 2, 2); semilogy(n(J), Pexp(J, j), 'o', n(J), Pfit, n(J), P0); 
        title(num2str(dt1(j)))
        figure(gcf);
        pause;
    end;
    
end;%Nrun

%% Try iterations without noise: create data from single source
q_exp = 0.5;
N_exp = 10;
n=0:20;
J = 1:(max(n)+1);
xi1 = J/max(J)*pi;

 [temp, logGexp, Pexp] = FIDA_Inv_Fit_N_comp_vs_Xi_v2([N_exp, q_exp] , xi1, {1 'simple' [] n});
 subplot(1, 2, 1); plot(xi1, logGexp, '-o');
 subplot(1, 2, 2); semilogy(n, Pexp, '-o'); 
figure(gcf)

%% create the set of possible q values and H  matrix tranfering the number
% the number of each specie into logG

q = 0.1:0.1:2;
xi1 = xi1(:);
H = exp((xi1 - 1)*q) -1;
size(H)

% create initial distribution for iterations:
N = ones(size(q))';
iter= 0;
%% start iterations
beta = 0.0001;
for iter = 1:100000,
    
    N = N +beta*H'*(logGexp - H*N);
    N(N< 0)=0;
end;

subplot(1, 2, 1); plot(xi1, logGexp, '-o', xi1, H*N);
subplot(1, 2, 2); plot(q, N)
figure(gcf);

%%
beta = reshape([N'; q], 1, 2*length(q));
 [temp, logGiter, Piter] = FIDA_Inv_Fit_N_comp_vs_Xi_v2(beta , xi1, {length(q) 'simple' [] n});
subplot(1, 2, 2); semilogy(n, Pexp, '-o', n, Piter); 
figure(gcf)

%% Try now some actual results
% Prepare them first
clear Pexp n InvBetaFIMDA1comp logG_sur
bins =50;
len = length(c1);
i = 50 % run number
        N_fcs(i) = S.CR(i)/S.G0_good(i);
        q_fcs(i) = S.G0_good(i)*dt;
        figure(fig2);
        ccut1 = c1(round(((i-1)*len/Nruns +1):(i*len/Nruns)));
        for j = 1:length(coarsegrain),
            j
           if coarsegrain(j) == 1,
               ccut2 = ccut1;
           elseif coarsegrain(j) == 2,
               ccut2 = ccut1(1:(length(ccut1)-1)) + ccut1(2:length(ccut1)) ;
           else
               ccut2 = smooth(ccut1, coarsegrain(j))*coarsegrain(j);
           end;
           fimda(j).ccut2 = ccut2;
        end;
        
        maxn = max(fimda(length(fimda)).ccut2);
        n = 0:maxn;
   
        for j = 1:length(dt1),
            hc = hist(fimda(j).ccut2, n);
            Nsamples  = sum(hc);
            Pexp(:, j) = hc'/Nsamples;
        end;
%% 
j = 5;
J = find(Pexp(:, j) > 0);
J = 1:max(J);
xi1 = J/max(J);
logG = log(polyval(Pexp(max(J):-1:1, j), xi1));
logG =logG(:);
       
q = (1:320)*0.0005*dt1(j)/dt;
xi1 = xi1(:);
H = exp((xi1 - 1)*q) -1;
size(H)

% create initial distribution for iterations:
N = zeros(size(q))' + 1;
[temp, minind] = min(abs(q - q_fcs(i)*dt1(j)/dt));
N(minind) = N_fcs(i);
iter= 0;
subplot(1, 2, 1); plot(xi1, logG, '-o', xi1, H*N);
chiSq = sum((logG - H*N).^2)
title(num2str(chiSq))
subplot(1, 2, 2); plot(q, N)
figure(gcf);

%% start iterations
beta = 0.0001;
for iter = 1:100000,   
    N = N +beta*H'*(logG - H*N);
    N(N< 0)=0;
end;
subplot(1, 2, 1); plot(xi1, logG, '-o', xi1, H*N);
chiSq = sum((logG - H*N).^2)
title(num2str(chiSq))
subplot(1, 2, 2); plot(q, N)
figure(gcf);
 
%%
beta = reshape([N'; q], 1, 2*length(q));
J = find(Pexp(:, j) > 0);
 [temp, logGiter, Piter] = FIDA_Inv_Fit_N_comp_vs_Xi_v2(beta , xi1, {length(q) 'simple' [] n(J)});
subplot(1, 2, 2); semilogy(n(J), Pexp(J, j), '-o', n(J), Piter); 
chiSqP = sum((Piter -  Pexp(J, j)).^2)
title(num2str(chiSqP))
figure(gcf)

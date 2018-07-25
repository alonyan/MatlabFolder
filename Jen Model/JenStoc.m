%%
clear all
close all
t=0;
tstop = 600;
ps = 10.^(1:0.1:5.5);
sumx = zeros(length(ps),1);

for j = 1:length(ps)
    
    t=0;
x = [ps(j); 2; 0];    %pSTAT1 empty promotor complex                                 
S = [-1  -1  0;...
      0  -1  1;...
      0   1 -1]; 
  
  decay = log(2)/(12*60);
  kon = 2e-5;
  koff = 0.1;
     % figure()
while t<tstop     
    w = [decay*x(1); kon*x(1)*x(2); koff*x(3)];   %% Specify Propensity functions (need decay rate of pSTAT1 and on and off rates)
    w0 = sum(w);   % compute the sum of the prop. functions 
    dt = 1/w0*log(1/rand);
	t = t+dt;                       % update time of next reaction
    if t<=tstop
		r2w0=rand*w0;               % generate second random number and multiply by prop. sum         
		i=1;                                          % initialize reaction counter
		while sum(w(1:i))<r2w0             % increment counter until sum(w(1:i)) exceeds r2w0
			i=i+1;
		end
		x = x+S(:,i);    % update the configuration
        sumx(j) = sumx(j)+x(3)*dt;
    end
%     subplot(2,1,1)
%     plot(t,x(1),'.')
%     hold on
%     subplot(2,1,2)
%     plot(t,x(3),'d')
%     drawnow
%     hold on   
end
%hold off;
end;
sumx
semilogx(ps,sumx./(tstop*2),'-o'); figure(gcf)

EC50 = ps(find(sumx./(tstop*2)<=0.5, 1, 'last'))
%%
clear all
close all
t=0;
dt=0;
tstop = 60*60*10;
ps = 10.^(1:0.2:7);

%ps = 1000
sumx = zeros(length(ps),1);

for j = 1:length(ps)
    t=0;
    pNum = 2;
x = [ps(j); pNum; 0];    %pSTAT1 empty promotor complex                                 
S = [ -1  1;...
      -1  1;...
       1 -1]; 
  
  %decay = log(2)/(12*60);
  kon = 1e-5;
  koff = 0.1;
%       figure()
while t<tstop   
    w = [kon*x(1)*x(2); koff*x(3)];   %% Specify Propensity functions (need decay rate of pSTAT1 and on and off rates)
    w0 = sum(w);   % compute the sum of the prop. functions 
    dt = 1/w0*log(1/rand);
	t = t+dt;                       % update time of next reaction
    if t<=tstop
		r2w0=rand*w0;               % generate second random number and multiply by prop. sum         
		i=1;                                          % initialize reaction counter
		while sum(w(1:i))<r2w0             % increment counter until sum(w(1:i)) exceeds r2w0
			i=i+1;
        end

		x = x+S(:,i);    % update the configuration
        sumx(j) = sumx(j)+x(3)*dt;

    end
%     subplot(2,1,1)
%     plot(t,x(1),'.')
%     hold on
%     subplot(2,1,2)
%     plot(t,x(3),'d')
%     drawnow
%     hold on;
end
% hold off;
end;
sumx
semilogx(ps,sumx./(tstop*pNum),'-o'); figure(gcf)

%EC50 = ps(find(sumx./(tstop*pNum)<=0.5, 1, 'last'))
   


%%



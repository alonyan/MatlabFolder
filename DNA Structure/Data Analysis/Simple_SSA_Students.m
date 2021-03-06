clear all
close all
t=0;
tstop = 2;                                  %%specify initial and final times
x = [1000; 0];                                        %% Specify initial conditions
S = [-1;...
    1 ]; 
Xs = [];
ts = [];
% Specify stoichiometry
while t<tstop    
    Xs = [Xs, x(1)];
    ts = [ts, t];
    w = [1*x(1)];   %% Specify Propensity functions
    w0 = sum(w);                               % compute the sum of the prop. functions 
	t = t+1/w0*log(1/rand);                       % update time of next reaction
    if t<=tstop
		r2w0=rand*w0;               % generate second random number and multiply by prop. sum         
		i=1;                                          % initialize reaction counter
		while sum(w(1:i))<r2w0             % increment counter until sum(w(1:i)) exceeds r2w0
			i=i+1;
		end
		x = x+S(:,i);                                 % update the configuration
    end
    %subplot(3,1,1)
    plot(t,x(1),'rx')
    hold on
%     subplot(3,1,2)
%     plot(t,x(2),'x')
%     hold on
%     subplot(3,1,3)
%     plot(x(1),x(2),'x')
%     drawnow
%     hold on
end

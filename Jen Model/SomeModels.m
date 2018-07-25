k0=0;
k1=10;

beta = [0.1:0.01:1];
t0=2;

t1 = 0:0.01:t0;
[beta1 t1] = meshgrid(beta,t1);

t2 = (t0+0.1):0.1:50
[beta2 t2] = meshgrid(beta,t2);


X = k0./beta1+(k1-k0).*(1-exp(-beta1.*t1))./beta1;
%
X = [X ; k0./beta2+(k1-k0).*(1-exp(-beta2.*t0)).*exp(-beta2.*(t2-t0))./beta2];

h = plot([t1; t2],X); shg
a = makeColorMap([0 0 1],[0 1 0],length(beta));
for i=1:length(beta)
    set(h(i),'color',a(i,:))
end






%%
k0=0;
k1=10;

beta = [0.5]%:0.01:1];
t0=2;

t1 = 0:0.01:50;
[beta1 t1] = meshgrid(beta,t1);

%t2 = (t0+0.1):0.1:50
%[beta2 t2] = meshgrid(beta,t2);


X = k0./beta1+(k1-k0).*(1-exp(-beta1.*t1))./beta1;
%
%X = [X ; k0./beta2+(k1-k0).*(1-exp(-beta2.*t0)).*exp(-beta2.*(t2-t0))./beta2];

h = plot([t1],X); shg
a = makeColorMap([0 0 1],[0 1 0],length(beta));
for i=1:length(beta)
    set(h(i),'color',a(i,:))
end




%%
k0=0;
k1=10;
k2=5;

beta = [0.1:0.01:1];
t0=2;

t1 = 0:0.01:t0;
[beta1 t1] = meshgrid(beta,t1);

t2 = (t0+0.1):0.1:50
[beta2 t2] = meshgrid(beta,t2);


X = k0./beta1+(k1-k0).*(1-exp(-beta1.*t1))./beta1;
%
X = [X ; k0./beta2+(k1-k0).*(1-exp(-beta2.*t0)).*exp(-beta2.*(t2-t0))./beta2];

h = plot([t1; t2],X); shg
a = makeColorMap([0 0 1],[0 1 0],length(beta));
for i=1:length(beta)
    set(h(i),'color',a(i,:))
end


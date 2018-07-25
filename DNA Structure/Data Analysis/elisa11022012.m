%P1=1uM K5
P1=[0.62	0.594	0.591	0.656	0.591	0.649
1.144	0.456	0.636	0.861	0.745	0.721
0.454	0.22	0.238	0.326	0.261	0.381];

%P2=1nM K5
P2=[0.091	0.082	0.096	0.089	0.095	0.097
0.118	0.093	0.097	0.108	0.11	0.115
0.119	0.087	0.106	0.103	0.101	0.117];

T=[4.02];
B=[0.09230];
E=[2.631e-10];


IL2P1=(P1-B)./(T-P1).*E;
IL2P2=(P2-B)./(T-P2).*E;

T=[17 41 48];
%%

figure()
hold on
plot(T, IL2P1, '-o', 'linewidth', 2)
set(gca, 'Fontsize', 16, 'Fontweight', 'Bold', 'yscale', 'log')
set(gcf, 'color', 'w')
ylabel('[IL2], (M)')
xlabel('Time, hrs')
title('IL2 accumulation over time for 1uM K5')
legend('No Tregs', '1/1', '1/2', '1/5', '1/20', '1/100')
box on

%%

figure()
hold on
plot(T, IL2P2, '--o', 'linewidth',2)
set(gca, 'Fontsize', 16, 'Fontweight', 'Bold', 'yscale', 'log')
set(gcf, 'color', 'w')
ylabel('[IL2], (M)')
xlabel('Time, hrs')
title('IL2 accumulation over time for 1nM K5')
box on

%Cell Density pilot 3.16.14
%Key: A = Cluster diffuse; B = Cluster disturbed; C = Plate 50k; D = Plate
%5k; E = Diffuse

A = [269 357 275 243
     279 350 244 254];

B = [388 537 299 420
     388 537 299 420]; %These are NOT true replicate values!  They have been inserted for plotting ease!!!!
 
C = [249 4382 282 520
     263 3996 263 714];
 
D = [329 2077 223 436
     284 1819 225 375];
 
E = [411 6050 518 885
     411 6050 518 885]; %These are NOT true replicate values!  They have been inserted for plotting ease!!!!
 
c = [A B C D E];

for l = 1:length(c)
    m = mean(c); 
    s = std(c); 
end

m = reshape(m, 4,5)'; s = reshape(s, 4,5)';
%%
density = [1 2 3 4 5];

figure(1)
subplot(2,1,1)
hold on
errorbar(density, m(:,1), s(:,1), '-ko', 'markerfacecolor', 'b', 'markersize', 9)
errorbar(density, m(:,2), s(:,2), '-ko', 'markerfacecolor', 'r', 'markersize', 9)
errorbar(density, m(:,3), s(:,3), '-ko', 'markerfacecolor', 'y', 'markersize', 9)
errorbar(density, m(:,4), s(:,4), '-ko', 'markerfacecolor', 'k', 'markersize', 9)
set(gcf, 'color', 'w')
set(gca, 'yscale', 'log', 'ylim', [1e2 1e4], 'xlim', [0 6], 'xtick', [1 2 3 4 5], 'Fontsize', 25, 'ygrid', 'on', 'xgrid', 'on')
xlabel('"Density rep"')
ylabel('GMFI H-2K^b')
legend('Media/DMSO', '10nM IFN-\gamma/DMSO', 'IFN-\gamma/Jaki T0', 'IFN-\gamma/Jaki T5')
box on

%%

Amp = m(:,2) - m(:,1);

Ampofmemory = m(:,4) - m(:,1);

Percofmax = (Ampofmemory./Amp)*100

subplot(2,1,2)
hold on
plot(density, Amp, '-ko', 'markerfacecolor', 'b', 'markersize', 9)
plot(density, Ampofmemory, '-ko', 'markerfacecolor', 'r', 'markersize', 9)
set(gcf, 'color', 'w')
set(gca, 'xlim', [0 6], 'xtick', [1 2 3 4 5], 'Fontsize', 25, 'yscale', 'log', 'xgrid', 'on', 'ygrid', 'on')
xlabel('"Density rep"')
ylabel('Amplitude of Response')
legend('10nM IFN-\gamma - Media', 'Memory - Media')
box on

figure()
plot(density, Percofmax, '-ko', 'markerfacecolor', 'y', 'markersize', 9)
set(gcf, 'color', 'w')
set(gca, 'xtick', [1 2 3 4 5], 'Fontsize', 25)
xlabel('"Density rep"')
ylabel('Memory % of Max Response')
box on

    

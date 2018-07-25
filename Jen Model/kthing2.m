figure
h = plot(CD25inBinPerCell, ZeroConst,'-o')

%set(gca, 'Xlim', [0.4E-11 3E-11])
set(gca, 'Fontsize', 15)
xlabel('IL2R\alpha','Fontsize', 18)
ylabel('I','Fontsize', 18)
set(h, 'Linewidth', 2)
set(h, 'Markersize', 2)
set(h, 'Marker', 'o')
set(h, 'Markersize', 4)
set(h, 'Markeredgecolor', 'k')

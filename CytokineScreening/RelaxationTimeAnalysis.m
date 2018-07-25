%% %% solve time dependent equation in 3D case: check relaxation rate at different distances

L = 300; 
x = linspace(1, L, 4000); 
t = linspace(0, 300, 399); %in s
%t = [1:10 60 60*(2:5)];
%t = linspace(0, 10, 10).^2;
ksi = 7; 
J = 30;

EC50 = 10; %in pM
R = 5; % cell radius in um
secretion_rate = 120; %molecules per sec
D = 100; % diffusion coeff um^2/s



C = TimeDependent3D_Cytokine(t*D/ksi^2/R^2, x, J, 'ksi', ksi, 'Dimensionality', 2);

%%
SteadyState = SolveCytokineDistribution_3Da(J, ksi, L,'Number of points', 1000)
%%
subplot(1, 2, 1);
plotC(x, C); figure(gcf)
text(4, 90, ['L = ' num2str(L)], 'FontSize', 14)
axis tight
title('Concentrations')
%legend(num2str(t')) 
subplot(1, 2, 2);
plotColor('semilogy', x, C./(1+C)); figure(gcf)
axis tight
title('Response')
figure(gcf)
%% check convergence to Steady state
figure;
semilogy(x, C(end, :), SteadyState.r, SteadyState.C);
figure(gcf)

%% plot concentrations as ratios to the final concentration
figure;
Cf = repmat(interp1(SteadyState.r,SteadyState.C, x,'spline'), length(t), 1);
plotC(x, C./Cf); figure(gcf)
%text(4, 90, ['L = ' num2str(L)], 'FontSize', 14)
axis tight
title('Concentrations');




%% analyze points to see when C reaches 90% of the final concentration
savpath = '/Users/Alonyan/GoogleDrive/School/My Papers/Screening Paper/FiguresShort/';
close all;
fig1 = figure('Position',[360   278   510   660],'Color',[1 1 1]);


axes('Position', [0.2 .747 0.28 0.20])

h = plot(x./ksi, C([1:2:70   100 200 300 399],:),SteadyState.r./ksi, SteadyState.C,'-.r'); figure(gcf)
set(h,'Linewidth', 1.5)
cm = colormap(makeColorMap([0 0 1],[0 1 0],size(h,1)))
for i=1:length(h)-1
    set(h(i),'color',cm(i,:)');
end
%text(4, 90, ['L = ' num2str(L)], 'FontSize', 14)
set(gca,'yscale','log')
set(gca,'xlim',[0 8],'ylim',[10^-10 10^2],'xtick',[0:10])

title('Approach to steady state')
cb = colorbar('Location','WestOutside')
set(cb,'Position', [0.05    0.747    0.03    0.20],'yticklabel','')
ylabel(cb,'time')
annotation('arrow',[0.065 0.065], [0.747 0.947])
xlabel('r/\lambda - Distance from source', 'FontSize', 12)
ylabel('[Cytokine]', 'FontSize', 12)

tau = [];
Crel = C./Cf; %concentration as fraction of final
%plotC(t, Crel); figure(gcf)
for i = 1:size(Crel, 2),
    tau(i) = interp1(Crel(:, i), t, 1-exp(-1));   
end
rect1 = annotation('rectangle',[0.205 0.75 0.25 0.05]);
set(rect1,'FaceColor',[1 1 1])
hleg = legend([h(1) h(end-1) h(end)],'','Dynamic solutions','Steady State solution');
legend boxoff
set(hleg,'fontsize',10,'Position',[0.17    0.75    0.2844    0.0712])
hLine = findobj(hleg,'type','line')
set(hLine,'xdata',[0.15 0.25])
set(hLine(6),'ydata',get(hLine(4),'ydata')-0.1)
%hText = findobj(hleg,'type','text')
%set(hText(3),'Position',get(hLine(4),'ydata')+0.05)
uistack(hleg,'top')

axes('Position', [0.65 .747 0.28 0.20])

h = plot(x/ksi, tau,'k');

xlabel('r/\lambda - Distance from source', 'FontSize', 12)
ylabel('\tau_{relaxation}(s) - Relaxation time', 'FontSize', 12)
figure(gcf)
set(gca,'xlim',[0 8],'xtick',[0:8],'ylim',[0 60])
set(h,'Linewidth', 1.5)


 a = annotation('textbox',[ 0.04 0.94    0.05    0.05],'string','A', 'Fontsize',15,'LineStyle','none')
 a = annotation('textbox',[ 0.52 0.94    0.05    0.05],'string','B', 'Fontsize',15,'LineStyle','none')
 

%%
uistack(hleg,'top')

%%

savpath = '/Users/Alonyan/GoogleDrive/School/My Papers/Screening Paper/FiguresShort/';%the folder where the figure should go

set(gcf, 'PaperPositionMode','auto')
        
FigureName = 'FigureRelaxation' %name you want for the figure file

     print(gcf,'-dpdf',[savpath ,FigureName]);
     system(['pdfcrop' [' "', savpath ,FigureName,'.pdf','" '] ['"',savpath ,FigureName,'.pdf','"']]);
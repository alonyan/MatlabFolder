%Long Term Kinetics

AdTr=[0.63
0.399
1.33
1.97
0.105
0.436
1.16
2.32
0.351
0.347
1.02
3.11
0.38
0.145
1.43
1.56
0.38
0.19
1.19
1.63];

AdTr=reshape(AdTr, 4,5);

i_p1=AdTr(1,:);
i_p2=AdTr(2,:);
i_p3=AdTr(3,:);
i_p4=AdTr(4,:);

Time=[4 5 6 7 8];

figure()
hold on
plot(Time, AdTr, '-o', 'linewidth', 2)
BreakPlot(AdTr, [0:0.7, 0.75:3.2], 'Line')
set(gcf, 'color', 'w')
set(gca, 'Fontsize', 16, 'Fontweight', 'bold')
ylabel('Time post-immunization, (days)')
xlabel('Percent Ag specific of Total CD4+')
title('Kinetics of 5cc7 Expansion and Contraction')

BreakPlot(x,y,y_break_start,y_break_end,break_type) 
%%
figure
BreakPlot(rand(1,21),[1:10,40:50],10,40,'Line')
x=rand(1,21);y=[1:10,40:50];
subplot(2,1,1);plot(x(y>=40),y(y>=40),'.');
set(gca,'XTickLabel',[]);
subplot(2,1,2);plot(x(y<=20),y(y<=20),'.');%
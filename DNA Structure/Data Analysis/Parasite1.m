%set up initial parasite loads for me and for my assistant
initsize_me=400;
initsize_ass=120;

%create a matrix to store the results for each loop
popsize_me=zeros(30,1); popsize_me(1)=initsize_me;
popsize_ass=zeros(30,1); popsize_ass(1)=initsize_ass;

%calculate parasite population size for days 2-30 for both me and my
%assitant and write it to the command window
for n=2:30;
    popsize_me(n)=popsize_me(n-1)*1.1;
    popsize_ass(n)=popsize_ass(n-1)*1.2;
    x1=log(popsize_me(n));
    x2=log(popsize_ass(n));
    q1=[num2str(n), ' ', num2str(x1)];
    q2=[num2str(n), ' ', num2str(x2)];
    disp(q1)
    disp(q2)
end;



%determine how many values are in popsize me and assitant

[r1,c1]=size(popsize_me);
xvals=(1:r1)-1;
hold on
plot(xvals, popsize_me, '-ro', 'linewidth', 2)
plot(xvals, popsize_ass, '-bo', 'linewidth', 2)
set(gca, 'yscale', 'log', 'Fontsize', 16, 'Fontweight', 'bold')
set(gcf, 'color', 'w')
legend('me', 'assistant')
xlabel('Time, (days)')
ylabel('log Parasite load')
box on



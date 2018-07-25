%%
fpath = '/Users/Alonyan/Documents/School/Tirgul/Physics3A'
filename = 'Phys3A2013'
%%
Dataset = Phys3;


%% get only guys who took the test
okA = []
okB = []
okExA = []
okFinal = []
for i = 1:length(Phys3)
if Dataset(i,2)<700 
okA = [okA Phys3(i,2)]
end

if Dataset(i,3)>0 
okB = [okB Phys3(i,3)]
end

if Dataset(i,4)>0 
okExA = [okExA Phys3(i,4)]
end

if Dataset(i,4)>0 
okFinal = [okFinal Phys3(i,5)]
end
end

%% Make Histogram
Nbins = 25;
[H,X] = hist(okExA, Nbins);
[H1,X1] = hist(okFinal, Nbins);
%% Fit with Gaussians
beta = nlinfit(X,H,@GaussianFit,[50,50,25,0]);

beta1 = nlinfit(X1,H1,@GaussianFit,[50,50,25,0]);

%% Count Failed and 90+
j=0;
for i = 1:length(okFinal)
    if okFinal(i)>89
    j=j+1;
    end
end
Above90 = j
j=0;
for i = 1:length(okFinal)
    if okFinal(i)<56
    j=j+1;
    end
end
Failed = j

Mean = mean(okFinal)
stdv = std(okFinal)


%%
figure(1)
bar(X,H, 'LineWidth',0,'FaceColor',[0.85,0.85,1])
h1=gca;
h2 = axes('Position',get(h1,'Position'));
plot(X,GaussianFit(beta,X),'r','LineWidth',2)
set(h2,'YAxisLocation','right','Color','none','XAxisLocation','top')
set(h2,'XLim',get(h1,'XLim'),'Layer','top')
%%
figure(2)
bar(X1,H1, 'LineWidth',0,'FaceColor',[0.85,0.85,1])
h1=gca;
h2 = axes('Position',get(h1,'Position'));
plot(X1,GaussianFit(beta1,X1),'r','LineWidth',2)
set(h2,'YAxisLocation','right','Color','none','XAxisLocation','top')
set(h2,'XLim',get(h1,'XLim'),'Layer','top')


%%
save([fpath filesep filename])
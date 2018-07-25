%%

dose=[100 25 6.25 1.56 0.4 0.1 0.025 0.00625 0.00156 0.0004];
response1=[2.188 1.807 1.314 0.216 0.1 0.09 0.087 0.096 0.086 0.089];

%hill equation sigmoid
sigmoid=@(beta,x)beta(1)+(beta(2)-beta(1))./(1+(x/beta(3)).^beta(4));

%calculate some rough guesses for initial parameters
minResponse=min(response1);
maxResponse=max(response1);
midResponse=mean([minResponse maxResponse]);
minDose=min(dose);
maxDose=max(dose);

%fit the curve and compute the values
[coeffs,r,J]=nlinfit(dose,response1,sigmoid,[minResponse maxResponse midResponse 1]);

ec50=coeffs(3);
hillCoeff=coeffs(4);

%plot the fitted sigmoid
xpoints=logspace(log10(minDose),log10(maxDose),1000);
semilogx(xpoints,sigmoid(coeffs,xpoints),'Color',[0 0 0],'LineWidth',2)
set(gcf, 'color', 'w')
hold on

%notate the EC50
text(ec50,mean([coeffs(1) coeffs(2)]),[' \leftarrow ' sprintf('EC_{50}=%0.2g',ec50)],'FontSize',16);

%plot mean response for each dose with standard error
doses=unique(dose);
meanResponse=zeros(1,length(doses));
stdErrResponse=zeros(1,length(doses));
for i=1:length(doses)
    responses=response1(dose==doses(i));
    meanResponse(i)=mean(responses);
    stdErrResponse(i)=std(responses)/sqrt(length(responses));
    %stdErrResponse(i)=std(responses);
end

errorbar(doses,meanResponse,stdErrResponse,'o','Color',[0.5 0.5 0.5],'LineWidth',2,'MarkerSize',12)


%label axes
xlabel('Dose','FontSize',16);
if normalized
    ylabel('Normalized Response','FontSize',16);
else
    ylabel('Response','FontSize',16);
end
set(gca,'FontSize',16);

hold off;
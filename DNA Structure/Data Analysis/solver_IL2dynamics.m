%##########################################################################
% Dynamical model of inteleukin-2 production and consumption
%##########################################################################
% Author: Debashis Barik @ MSKCC
% Date: March 16, 2012
%##########################################################################

%**************************************************************************
% Time for integration
%**************************************************************************
ts = 0;             % ts=start time
tf = 200;           % tf=final time
tspan  = [ts tf];
%**************************************************************************


%**************************************************************************
ncell=25;           % Number of cells in a cluster
nrxn=11;            % Number of reactions on a cell
Ncls=40;            % Number of clusters
%**************************************************************************
numN=10;
numP=10;

av_data=zeros(2001,15,numN,numP);
maxIL2=zeros(numN,numP);
time_max=zeros(numN,numP);
Ncl1=logspace(3,5,numN)./25;
Ncl=Ncl1*ncell;
Pep=logspace(7,10,numP);

for NN=1:numN
    
    Ncls=Ncl1(NN);
    
for PP=1:numP
    cnd=[NN,PP]
%**************************************************************************
% Initial conditions
%**************************************************************************
    ix0(1)=Pep(PP);            % Initial total peptide in the medium
    ix0(2)=0;                  % Initial IL-2 population
for i=1:ncell
    indx=(i-1)*(nrxn-2);
    ix0(3+indx)=0;             % Initial population of PTCR
    ix0(4+indx)=0;             % Initial population of IL2R-a
    ix0(5+indx)=1000;          % Initial population of IL2R-b
    ix0(6+indx)=0;             % Initial population of IL-2 mRNA
    ix0(7+indx)=0;             % Initial population of cellular IL-2
    ix0(8+indx)=0;             % Initial population of RaIL2
    ix0(9+indx)=0;             % Initial population of RabIL2
    ix0(10+indx)=0;            % Initial population of pSTAT5
    ix0(11+indx)=0;            % Initial population of UFa  
end
%**************************************************************************

time=[];
xsol=[];

%**************************************************************************
% Generation of log-normal-distributed inital population of TCR on T cell
%**************************************************************************
m1=30000;
cv=0.5;
%v1=(cv*m1)^2;
v1=0;
mu1 = log((m1^2)/sqrt(v1+m1^2));
sigma1 = sqrt(log(v1/(m1^2)+1));
for i1=1:ncell
    TCR_T(i1)=lognrnd(mu1,sigma1);
end
%**************************************************************************

%**************************************************************************
% Uniformly distributed inital delay in finding T cell to peptide
%**************************************************************************
a=0;
b=30;
tim=a+(b-a)*rand(ncell,1);
%tim=zeros(ncell,1);
%**************************************************************************

%**************************************************************************
% Integration options
%**************************************************************************
options = odeset('RelTol',1e-2,'AbsTol',1e-2);
%**************************************************************************

[t,ix]=ode15s(@(t,ix)function_IL2dynamics(t,ix,tim,TCR_T,Ncls),[ts:0.1:tf],ix0,options);

%**************************************************************************
% Calculation of average population of species
%**************************************************************************
s_ptcr=0;
s_ra=0;
s_rb=0;
s_nal2=0;
s_il2c=0;
s_ral=0;
s_rabl=0;
s_ps5=0;
s_ufa=0;

for i1=1:ncell
    i2=(i1-1)*(nrxn-2);
    s_ptcr=s_ptcr+ix(:,3+i2);
    s_ra=s_ra+ix(:,4+i2);
    s_rb=s_rb+ix(:,5+i2);
    s_nal2=s_nal2+ix(:,6+i2);
    s_il2c=s_il2c+ix(:,7+i2);
    s_ral=s_ral+ix(:,8+i2);
    s_rabl=s_rabl+ix(:,9+i2);
    s_ps5=s_ps5+ix(:,10+i2);
    s_ufa=s_ufa+ix(:,11+i2);
end
IL2=ix(:,2);
PTCR=s_ptcr./ncell;
Ra=s_ra./ncell;
Rb=s_rb./ncell;
mRNA_IL2=s_nal2./ncell;
IL2c=s_il2c./ncell;
Ral=s_ral./ncell;
Rabl=s_rabl./ncell;
pSTAT5=s_ps5./ncell;
UFa=s_ufa./ncell;

Ra_T=Ra+Ral+Rabl;
Rb_T=Rb+Rabl;
c_IL2=IL2/(2E-4*6.023E23);
%**************************************************************************

IL2p=zeros(1,length(t));
for ii=1:length(ix(:,7))
    IL2p(ii)=0;
    for jj=1:ncell
    jj1=(jj-1)*(nrxn-2);
        if ix(ii,7+jj1)>=1000;
        IL2p(ii)=IL2p(ii)+1;
        end
    end
end

intIL2p=cumsum(IL2p'*Ncls*0.1);

%**************************************************************************
[maxi I]=max(c_IL2);
maxIL2(NN,PP)=maxi;
time_max(NN,PP)=t(I);
%**************************************************************************

av_data(1:length(t),:,NN,PP)=[IL2 c_IL2 IL2p' intIL2p PTCR Ra Rb mRNA_IL2 IL2c Ral Rabl pSTAT5 UFa Ra_T Rb_T];
cel_data(1:length(t),:,NN,PP)=[t ix];

end

end

figure(9)
subplot(221)
for PP=1:numP
    loglog(Ncl,maxIL2(:,PP),'-O','linewidth',1.5)
    hold on
end
xlabel('Number of T cell')
ylabel('IL2_{max} (M)')

subplot(222)
for NN=1:numN
    loglog(Pep,maxIL2(NN,:),'-O','linewidth',1.5)
    hold on
end
xlabel('Peptide')
ylabel('IL2_{max} (M)')

subplot(223)
for PP=1:numP
    semilogx(Ncl,time_max(:,PP),'-O','linewidth',1.5)
    hold on
end
xlabel('Number of T cell')
ylabel('Time (IL2_{max}) (h)')

subplot(224)
for NN=1:numN
    semilogx(Pep,time_max(NN,:),'-O','linewidth',1.5)
    hold on
end
xlabel('Peptide')
ylabel('Time (IL2_{max}) (h)')

figure(10)
for PP=1:numP
    subplot(3,numP,PP)
    for NN=1:numN
        semilogy(t,av_data(:,2,NN,PP),'linewidth',1.0)
        axis([0 200 1E-12 1E-8])
        hold on
    end

    subplot(3,numP,PP+numP)
    for NN=1:numN
        semilogy(t,av_data(:,12,NN,PP),'linewidth',1.0)
        axis([0 200 1 1E4])
        hold on
    end

    subplot(3,numP,PP+2*numP)
    for NN=1:numN
        semilogy(t,av_data(:,14,NN,PP),'linewidth',1.0)
        axis([0 200 1000 1E8])
        hold on
    end
end

figure(11)
for NN=1:numN
    subplot(3,numN,NN)
    for PP=1:numP
        semilogy(t,av_data(:,2,NN,PP),'linewidth',1.0)
        axis([0 200 1E-12 1E-8])
        hold on
    end

    subplot(3,numN,NN+numN)
    for PP=1:numP
        semilogy(t,av_data(:,12,NN,PP),'linewidth',1.0)
        axis([0 200 1 1E4])
        hold on
    end

    subplot(3,numN,NN+2*numN)
    for PP=1:numP
        semilogy(t,av_data(:,14,NN,PP),'linewidth',1.0)
        axis([0 200 1000 1E8])
        hold on
    end
end
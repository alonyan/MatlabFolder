% Preliminary thoughts on a model 11.21.13

%Question 1: How much interferon gamma is sensed at T0 by a cell

%Assumption 1: The # of IFN-gRb chains are limiting for sensing of IfN-g
%Assumption 2: The # of IFN-gRb chains stays constant (we know this isn't true and that they get down-regulatd upon sensing of IfN-g)
%Assumption 3: The kon of IFN-g for the receptor is 75pM (7.5e10-11) - this
%is from my work.  The published Kon is quoted in the schrieber annual
%reviews review to be between 1e9 and 1e10M-1.  

gamma_R=1000; %Assume that the starting number of gamma receptor chains is 1000 per cell.  # of a is triple that, but beta is limiting

kon=7.5e11; %units is M^-1 - From my work About an order of magnitude different from published value - this is moles/L

gamma=[1.2e12 1.2e11 1.2e10 1.2e9 1.2e8 0]; %Number of IFN-g molecules in each of my different gamma starting concentrations

%Compute the amount of gamma sensed by the cell at the time it goes into
%media
gamma_sensed=zeros(1,6);
for i=[1 2 3 4 5 6];
    gamma_sensed(:,i)=gamma(:,i)*kon*gamma_R;
end











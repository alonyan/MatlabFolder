function dx=Modelon(t,x)
nA = 6.23e23;             %Avogadro no.
kon = 7.3e4/nA;              %M-1*s-1 IFNg-IFNgR association
koff = 5e-5;              %s-1 IFNg-IFNgR dissociation
HSkon = 2.5e6/nA;            %M-1*s-1 IFNg-HS association
HSkoff = 1.3e-6;          %s-1 IFNg-HS debinding      
kendo = 5e-5;             %s-1 Rate of IFNgRc endocytosis


dx(2) = -HSkon*x(2)*x(1)+HSkoff*x(3); %HS

dx(3) = -dx(2); %gamma HS

dx(4) = -kon*x(4)*x(1)+koff*x(5)+kendo*x(5); %gR

dx(5) = -dx(4);%gRC

dx(1) = dx(2)+dx(4)-kendo*x(5); %free gamma


dx = dx';

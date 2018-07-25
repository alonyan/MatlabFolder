function dx=RateMatrix_WithCellProliferation_v1(t,x,parameters)

% 1: free gamma (free concentration in supernAtant)
% 2: free HS (number of molecules per cell)
% 3: gamma-HS (number of molecules per cell)
% 4: free gamma receptor (number of molecules per cell)
% 5: gamma receptor complexed with cytokine (number of molecules per cell)
% 6: number of cells
HSkon = parameters.HSkon;
HSkoff = parameters.HSkoff;
kon = parameters.kon;
koff = parameters.koff;
kend = parameters.k_endocytosis;
k_cellcycle = parameters.k_cellcycle;
cellcapacity = parameters.cellcapacity;
nA = 6*10^23;
volume = 200*10^-6;



dx(2) = -HSkon*x(2)*x(1)+HSkoff*x(3); %HS

dx(3) = -dx(2); %gamma HS

dx(4) = -kon*x(4)*x(1)+koff*x(5)+kend*x(5); %gR

dx(5) = -dx(4);%gRC  

dx(6)= k_cellcycle*log(cellcapacity/x(6))*x(6); %Number of Cells modeled with Gompertz law

dx(1) = (dx(2)+dx(4)-kend*x(5))*x(6)/nA/volume; %free gamma

dx = dx';




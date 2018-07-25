%% Define Agents
Cells = cell(100000, 4);% create cell array , 100000 cells? Start of life, Class, Cause of death, End of life
InitCells = 100; %initial number of cells
Class = 1; %% Initialize Class(first guys in are class 1
dN = 50; %% Initialize stop parameter
Ncells0 = 0; %% Initialize previous number of cells, before the exp there were 0...
for i = 1:InitCells %%Create initial conditions
    Cells{i,1} = 0;
    Cells{i,2} = Class;
end
Ncells = InitCells; 
% Generate Random rates
Maxtime = 100; %%define stop time
Maxclass = 8; %maximal detectable division class
while(dN > 0); %while there are new cells to deal with, and these cells are not going to outlive the exp
    dN = Ncells-Ncells0;
    tdeath = gamrnd(3,8,Ncells, 1); %generate two random times for death/proli
    tproli = gamrnd(3,4,Ncells, 1);
    Ncells0 = Ncells;
    for i = 1:Ncells0 %run up to the last iterations number of cells

        
        if(isempty(Cells{i,3})) %%if the cells havent died/proli yet
            if((tdeath(i)<tproli(i)) && (Cells{i,1}<Maxtime)) %cell dies if tdeath<tproli
               Cells{i,3} = 'Dead';
               Cells{i,4} = Cells{i,1}+tdeath(i);
               if(Cells{i,4}>Maxtime) %if it dies after the experiment ends, we'll see him as "alive"
                   Cells{i,3} = 'Alive';
               end;
            elseif((tdeath(i)>=tproli(i)) &&(Cells{i,1}<Maxtime)) %cell proli if tdeath>tproli
               Cells{i,3} = 'Proliferated';
               Cells{i,4} = Cells{i,1}+tproli(i);
               if(Cells{i,4}>Maxtime)%if it proli after the experiment ends, we'll see him as "alive"
                   Cells{i,3} = 'Alive';
               else
               Cells{Ncells+1,2} = min(Cells{i,2}+1, Maxclass); %update newborn cells. if their class would 
               Cells{Ncells+2,2} = min(Cells{i,2}+1, Maxclass); %not be detectable we'll put them in Maxclass
               Cells{Ncells+1,1} = Cells{i,4}; %Newborn's time of birth is mother's time of proliferation.
               Cells{Ncells+2,1} = Cells{i,4};
               Ncells = Ncells+2;
               end
            elseif(Cells{i,1}>=Maxtime) %any cell that lives longer then our 
               Cells{i,3} = 'Alive'; %experiment time would be alive when we measure 
               Cells{i,4} = Maxtime; %and would have the time Maxtime;
            end
        end
    end
end

 
%% Plot live cells/time
Maxtp = 20; %How many timepoint do we want?
Alive = zeros(Maxtp,1); %Init Alive at each timepoint
for tp = 0:(Maxtp-1);
    t = tp*(Maxtime/Maxtp);
    for i = 1:Ncells
        if((Cells{i,1}<=t)&&(Cells{i,4}>t))
            Alive(tp+1,1) = Alive(tp+1,1)+1;
        end    
    end;
end
plot((0:(Maxtp-1))*(Maxtime/Maxtp),Alive);
figure(gcf);


%% Plot CFSE data
Maxtp = 20; %How many timepoint do we want?
CellsPerClass = zeros(Maxtp,Maxclass); %Init Alive at each timepoint
for tp = 0:(Maxtp-1);
    t = tp*(Maxtime/Maxtp);
    for i = 1:Ncells
        if((Cells{i,1}<=t)&&(Cells{i,4}>t))
           CellsPerClass(tp+1, [Cells{i,2}])= CellsPerClass(tp+1, [Cells{i,2}])+1;
        end    
    end;
end
semilogy((0:(Maxtp-1))*(Maxtime/Maxtp),CellsPerClass);
%plot((0:(Maxtp-1))*(Maxtime/Maxtp),CellsPerClass);
figure(gcf);
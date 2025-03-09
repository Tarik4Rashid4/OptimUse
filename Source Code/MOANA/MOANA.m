%  ANA best result without comment

function MOANA(Lower_Bound, Upper_Bound, Dimensions, Fitness_Function, Functin_Name)

% Functin_Name = 'ZDT1';
% [Lower_Bound, Upper_Bound, Dimensions, Fitness_Function] = get_test_functions(Functin_Name);


%% MOANA Parameter Sets

Iterations=500;           %  Number of Iterations
Number_of_Ants =30;            % Population Size
Archive_size=3;            % Repository Size
Grid_Number = 7;       % Number of Grids per Dimension
Best_Ant_Selection_factor = 2;    
Polynomial_Mutation_Rate = 5; 
Delete_Factor = 2;         
Inflation_rate = 0.1;   
Decision_Variabels_Size =[1 Dimensions];   % Size of Decision Variables Matrix          

%% Initialization

Initail_Ant.Position=[];
Initail_Ant.PreviousPosition=[];
Initail_Ant.Fitness=[];
Initail_Ant.IsDominated=[];
Initail_Ant.GridIndex=[];
Initail_Ant.GridSubIndex=[];
Initail_Ant.Best.Position=[];
Initail_Ant.Best.Fitness=[];

Ants = repmat(Initail_Ant, Number_of_Ants,1);
tempAnt = repmat(Initail_Ant,1,1);

%% Distributing Artificial Worker Ant Randomly
for i=1:Number_of_Ants

    if numel(Lower_Bound) == 1
        Ants(i).Position=unifrnd(Lower_Bound,Upper_Bound,Decision_Variabels_Size);

    elseif numel(Lower_Bound) == 2
          lower =  unifrnd(Lower_Bound(1),Lower_Bound(2));
          upper = unifrnd(Upper_Bound(1),Upper_Bound(2));       
          Ants(i).Position=[lower upper];
    end
    Ants(i).PreviousPosition=Ants(i).Position;
    Ants(i).Fitness=Fitness_Function(Ants(i).Position);
    Ants(i).Best.Position = Ants(i).Position;
    Ants(i).Best.Fitness = Ants(i).Fitness;
    
end
%% Locating Non_Dominated Solutions
Ants=CheckDomination(Ants);
archive=Ants(~[Ants.IsDominated]);
Hyper_Queb_Grid = GenerateGrid(archive,Grid_Number,Inflation_rate);

for i=1:numel(archive)
    archive(i)=FindGridIndex(archive(i),Hyper_Queb_Grid);
end


%% MOANA Algorithm 

for it=1:Iterations
    for i=1:Number_of_Ants
        Best_Ant=SelectBestAnt(archive,Best_Ant_Selection_factor);

        for d=1 : Dimensions
           nx=[];
           x = Ants(i).Position(d);
           xb=Best_Ant.Position(d);
           Pre_x = Ants(i).PreviousPosition(d);
           random = Levy(1);
           distance_from_best_Ant = Best_Ant.Position(d)- x;
            if x == xb
                rateOfChange = x * random;
            elseif x == Pre_x
                rateOfChange = distance_from_best_Ant * random;
            else
                Tendency=sqrt((Ants(i).Position(d)-Best_Ant.Position(d)).^2+(sum(Fitness_Function(Ants(i).Position))-sum(Fitness_Function(Best_Ant.Position))).^2);
                preTendency=sqrt((Ants(i).PreviousPosition(d)-Best_Ant.PreviousPosition(d)).^2+(sum(Fitness_Function(Ants(i).PreviousPosition))-sum(Fitness_Function(Best_Ant.Position))).^2); 
                rateOfChange =  random*(Tendency/preTendency)*distance_from_best_Ant;
            end
            nx = x +rateOfChange;
            tempAnt.Position(d) = nx;
            tempAnt.PreviousPosition(d) = x;
        end
            
         if Fitness_Function(tempAnt.Position) < Fitness_Function( Ants(i).Position)
            Ants(i).Position = tempAnt.Position;    
            Ants(i).PreviousPosition = tempAnt.PreviousPosition;            
        else
            for k=1 : Dimensions
                x = Ants(i).Position(k);
                random = Levy(1);          
                x=x+x*random;
                tempAnt.Position(k)= x;               
            end
            
            if Fitness_Function(tempAnt.Position) < Fitness_Function( Ants(i).Position)
                Ants(i).Position = tempAnt.Position;             
            end
        end
        Ants(i).Position = max(Ants(i).Position, min(Lower_Bound));
        Ants(i).Position = min(Ants(i).Position, max(Upper_Bound));
        Ants(i).Fitness = Fitness_Function(Ants(i).Position);
       
        % Apply Polynomial Mutation
        Polynomial_Mutation=(1-(it-1)/(Iterations-1))^(Polynomial_Mutation_Rate);
             
        if rand < Polynomial_Mutation
            Mutated_Solution.Position = Mutate(Ants(i).Position,Polynomial_Mutation,Lower_Bound,Upper_Bound);
            Mutated_Solution.Fitness=Fitness_Function(Mutated_Solution.Position);
           
            if Dominates(Mutated_Solution,Ants(i))
                Ants(i).Position=Mutated_Solution.Position;
                Ants(i).Fitness=Mutated_Solution.Fitness;
                
            elseif Dominates(Ants(i),Mutated_Solution)
                % Discard Mutated Solution
            else
                if rand<0.5
                    Ants(i).Position=Mutated_Solution.Position;
                    Ants(i).Fitness=Mutated_Solution.Fitness;           
                end
            end
        end
        
        if Dominates(Ants(i),Ants(i).Best)
            Ants(i).Best.Position=Ants(i).Position;
            Ants(i).Best.Fitness=Ants(i).Fitness;
            
        elseif Dominates(Ants(i).Best,Ants(i))
            % Best ant still better than current ant
        else
            if rand < 0.5
                Ants(i).Best.Position=Ants(i).Position;
                Ants(i).Best.Fitness=Ants(i).Fitness;           
            end
        end
    end
    
   
    % Add Non-Dominated Ants to Archive
    %   archive=[archive
    %     Ant(~[Ants.IsDominated])]; %#ok
    archive=[archive
        Ants(~[Ants.IsDominated])];  
    % Determine Domination of New Archive Members
    archive=CheckDomination(archive);
  

    % Keep only Non-Dminated Memebrs in the Archive
    archive=archive(~[archive.IsDominated]);  

    % Update Grid
    Hyper_Queb_Grid = GenerateGrid(archive,Grid_Number,Inflation_rate);
      

    % Update Grid Indices
    for i=1:numel(archive)
        archive(i)=FindGridIndex(archive(i),Hyper_Queb_Grid);
       
    end
    
    % Check if Archive is Full
    if numel(archive)>Archive_size
        Extra=numel(archive)-Archive_size;
        for e=1:Extra
            archive=DeleteOneArchiveMemebr(archive,Delete_Factor);
           

        end  
    end
    
    % Draw Objectives on plot
    figure(1);
    DrawObjectives(Ants,archive, Functin_Name);
    pause(0.01);   
    
    % Show Iteration Information
    disp([' Iteration ' num2str(it) ': Number of Rep Members = ' num2str(numel(archive))]);

    Euclidean_Distance=0;
    
    for f=1:numel(archive)
        Euclidean_Distance = Euclidean_Distance + sum((Fitness_Function(Best_Ant.Position) - Fitness_Function(archive(f).Position)).^ 2); 
                 %d                                         obtained Pareto optimal and Pareto optimal solution
                 
    end

    Euclidean_Distance =  sqrt(Euclidean_Distance);
    %mean
    IGD = Euclidean_Distance/numel(archive);  
    
    disp(['IGD  =  ' num2str(IGD)]);  

   
end




end
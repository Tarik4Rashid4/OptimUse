% Cite this article
%Abdulhameed, S., Rashid, T.A. Child Drawing Development Optimization Algorithm Based on Child’s Cognitive Development. 
%Arab J Sci Eng (2021). https://doi.org/10.1007/s13369-021-05928-6
%
%
function [output] = CCD(itt, lb,ub,dim,fobj)

for n=1:itt
    
    %% Parameters of DCA 14 17 20 21
                                                          % Name of the test function that can be from F1 to F23 (Table 1,2,3 in the paper) Except 14,19,20

    nVar = dim;                                                            % Number of Unknown (Decision) Variables
    ShowIterInfo = true;                                                   % Flag for Showing Iteration Information
    VarSize = [1 nVar];                                                    % Matrix Size of Decision Variables
    VarMin = round(lb);                                                    % Lower Bound of Decision Variables
    VarMax = round( ub);                     % Upper Bound of Decision Variables
    MaxIt = 100;                             % Maximum Number of Iterations
    nPop = 50;                               % Population size
    LR=0.01 ;                                % child level rate
    SR=0.9;                                  % Child skill rate
    T=randi([VarMin VarMax],1);              % random Hand presure
    PS=10;                                   % pattern matrix size % Constriction Coefficients
    %   MaxGR = 0.2*(VarMax-VarMin);             % Max boundery for Golden ratio
    %   MinGR = -MaxGR;                          % Min boundery for Golden ratio
    CR=0.1;                                  % Creativity Rate
    k=0;                                     % index for the pattern matrix
     ncount=0;
    %% Initialization
    % The child Template
    empty_child.Drawing = [];
    empty_child.GR = [];
    empty_child.Cost = [];
    empty_child.Best.Drawing = [];
    empty_child.Best.Cost = [];
    
    empty_int.Drawing = [];
    empty_int.Cost = [];
    % Initialize Global Best
    GlobalBest.Cost = inf;
    
    % Create Population Array
    child = repmat(empty_child, nPop, 1);
    CP=repmat(empty_child,PS,1);
    
    
    % Initialize Population Members
    for i=1:nPop
        p1=randi([1 nVar]);
        p2=randi([1 nVar]);
        p3 =randi([1 nVar]);
        
        % Generate Random Solution
        child(i).Drawing = unifrnd(VarMin, VarMax, VarSize); % child get started drawing (random and movemnet)
        
        % Initialize Golden ratio
        child(i).GR=child(i).Drawing(1,p2)+child(i).Drawing(1,p3)/child(i).Drawing(1,p2);
        
        % Evaluation
        child(i).Cost = fobj(child(i).Drawing);
        
        % Update the Personal Best
        child(i).Best.Drawing = child(i).Drawing;
        child(i).Best.Cost = child(i).Cost;
        
        % Update Global Best
        if child(i).Best.Cost < GlobalBest.Cost
            GlobalBest = child(i).Best;
        end
    end
    
    % Array to Hold Best Cost Value on Each Iteration (best Solution in each it
    BestCosts = zeros(MaxIt, 1);
    [~, SortOrder]=sort([child.Cost]);
    for o=1:PS
        CP(o)=child(SortOrder(o));
    end
    k=randi([1 PS]);
    for it=1:MaxIt
      
        for i=1:nPop
            T=randi([VarMin VarMax],1);
            p1=randi([1 nVar]);
            p2=randi([1 nVar]);
            p3 =randi([1 nVar]);
            
            if (child(i).Drawing(1,p1)<=T)
                % Update the drawings
                child(i).Drawing = child(i).GR ...
                    + SR*rand(VarSize).*(child(i).Best.Drawing - child(i).Drawing) ...
                    +LR*rand(VarSize).*(GlobalBest.Drawing - child(i).Drawing);
                LR = randi([6,10])/10;
                SR = randi([6,10])/10;
                % Consider the learnt patterns (||child(i).Drawing(1,p1)>T)
            elseif ( 1.5 <child(i).GR<2  )
                child(i).Drawing= CP(k).Drawing -CR*child(i).Best.Drawing ;
                LR = randi([0,5])/10;
                SR = randi([0,5])/10;
                ncount=ncount+1;
            end
            %
            %                 CR=randi([0,10])/10;
            % Evaluation
            child(i).Cost = fobj(child(i).Drawing);
            
            % Update Personal Best
            if child(i).Cost < child(i).Best.Cost
                
                child(i).Best.Drawing = child(i).Drawing;
                child(i).Best.Cost = child(i).Cost;
                % Update Global Best
                if child(i).Best.Cost < GlobalBest.Cost
                    GlobalBest = child(i).Best;
                    CP(k)= child(i);
                end
            end
        end
        % Store the Best Cost Value
        BestCosts(it) = GlobalBest.Cost;
        
        % Display Iteration Information
        if ShowIterInfo
            disp(['Iteration ' num2str(it) ': Best Cost = ' num2str(BestCosts(it))]);
        end
    end
    out.pop = child;
    out.BestSol = GlobalBest;
    out.BestCosts = BestCosts;
    semilogy(BestCosts, 'LineWidth', 2);
    xlabel('Iteration');
    ylabel('Best Cost');
    grid on;
    output = zeros(itt, 1);
    
    output1 (n) = GlobalBest.Cost; % added!
    
    output = output1;
end
end
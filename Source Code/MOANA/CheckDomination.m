

function Ants=CheckDomination(Ants)

    Number_Of_Ants=numel(Ants);
    
    for i=1:Number_Of_Ants
        Ants(i).IsDominated=false;
    end
    
    for i=1:Number_Of_Ants-1
        for j=i+1:Number_Of_Ants
            
            if Dominates(Ants(i),Ants(j))
               Ants(j).IsDominated=true;
            end
            
            if Dominates(Ants(j),Ants(i))
               Ants(i).IsDominated=true;
            end
            
        end
    end

end
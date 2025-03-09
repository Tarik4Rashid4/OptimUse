
function Ant=FindGridIndex(Ant,Delete_Factor)

    nObj=numel(Ant.Fitness);
    
    nGrid=numel(Delete_Factor(1).LB);
    
    Ant.GridSubIndex=zeros(1,nObj);
    
    for j=1:nObj
        
        Ant.GridSubIndex(j)=...
            find(Ant.Fitness(j)<Delete_Factor(j).UB,1,'first');
 

    end

    Ant.GridIndex=Ant.GridSubIndex(1);
    for j=2:nObj
        Ant.GridIndex=Ant.GridIndex-1;
        Ant.GridIndex=nGrid*Ant.GridIndex;
        Ant.GridIndex=Ant.GridIndex+Ant.GridSubIndex(j);
    end
    
end
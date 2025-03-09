

function Grid=GenerateGrid(Ants,Grid_Number,Inflation_rate)

    c=[Ants.Fitness];
    
    cmin=min(c,[],2);
    cmax=max(c,[],2);
    
    dc=cmax-cmin;
    cmin=cmin-Inflation_rate*dc;
    cmax=cmax+Inflation_rate*dc;
    
    nObj=size(c,1);
    
    empty_grid.LB=[];
    empty_grid.UB=[];
    Grid=repmat(empty_grid,nObj,1);
    
    for j=1:nObj
        
        cj=linspace(cmin(j),cmax(j),Grid_Number+1);
        
        Grid(j).LB=[-inf cj];
        Grid(j).UB=[cj +inf];
        
    end

end
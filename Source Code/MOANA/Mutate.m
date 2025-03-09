
function xnew=Mutate(x,pm,VarMin,VarMax)

    nVar=numel(x);
    j=randi([1 nVar]);

    dx=pm*(VarMax-VarMin);
    
    lb=x(j)-dx;
    if lb<VarMin
        lb=VarMin;
    end
    
    ub=x(j)+dx;
    if ub>VarMax
        ub=VarMax;
    end
    
    xnew=x;
    if numel(lb) == 1
        rrr  = unifrnd(lb,ub,[1 nVar]);
        xnew(j)= rrr(j);
    elseif numel(lb) == 2
        low = unifrnd(lb(1), lb(2));
        if isnan(low)
            low = unifrnd(VarMin(1), VarMin(2));
        end
        upp = unifrnd(ub(1), ub(2));
        rrr = [low upp];
        xnew(j)= rrr(j);
    end
end
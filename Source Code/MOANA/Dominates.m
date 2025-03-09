

function b=Dominates(x,y)
    b=all(x.Fitness<=y.Fitness) && any(x.Fitness<y.Fitness);
end
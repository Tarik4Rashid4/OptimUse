function x = getin(index , value)

switch index
    case 1
        if value < 0.125
            value =0.125;
        elseif value > 5
            value= 5;
        end
        
    case 2
        if value < 0.1
            value =0.1;
        elseif value > 10
            value= 10;
        end
    case 3
        if value < 0.125
            value =0.125;
        elseif value > 5
            value= 5;
        end
        
    case 4
        if value < 0.1
            value =0.1;
        elseif value > 10
            value= 10;
        end
end
x = value;

end

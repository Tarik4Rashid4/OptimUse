
function [ best_fitness_value, best_scout_bee ] = CFDO( fitness, max_iteration, upper_bound, lower_bound, dimensions,scout_bee_number, weightFactor )


% am random abet la naw forakada bet
%xy=chaos(8,rand,dimensions-1);
for i=1: scout_bee_number
    xy=chaos(8,rand,dimensions-1);
    %scouts(i).xs = lower_bound+rand(1,dimensions)*(upper_bound-lower_bound);
    scouts(i).xs = lower_bound+xy*(upper_bound-lower_bound);
    scouts(i).pace = 0.0;
end


for iterate = 1 : max_iteration
   % clc
    %iterate

    for s=1 :scout_bee_number
        current_bee = scouts(s);
        best_bee =  getBestScoutBee(scouts); % find global Best bee
        %find current bee fitness_weight fw
        if fitness(best_bee.xs) ~= 0
            fitness_weight = fitness(best_bee.xs)/fitness( current_bee.xs) - weightFactor;
        end
        %% addition
          xx=chaos(8,rand,max_iteration);
          %%
        for d=1 : dimensions
            x = current_bee.xs(d);
            pace = 0.0;
        % random = Levy(1);
        random= xx(d).*(1+1)-1;
            distance_from_best_bee = best_bee.xs(d)- x;
            if fitness_weight == 1
                pace = x * random;
            elseif fitness_weight ==0
                pace = distance_from_best_bee * random;
            else
                pace = (distance_from_best_bee * fitness_weight);
                if random < 0
                    pace = pace * -1;
                end
            end
            x = x +pace;
            x = getIntoBounderyLimit(x);
            tempBee.xs(d) = x;
            tempBee.pace(d) = pace;
        end
        if fitness(tempBee.xs) < fitness( current_bee.xs)
            current_bee = tempBee;
        elseif  size(current_bee.pace, 2) > 1
            for m=1 : dimensions
                x = current_bee.xs(m);
                distance_from_best_bee = best_bee.xs(m)- x;
                x = current_bee.xs(m) + (distance_from_best_bee*fitness_weight)+current_bee.pace(m);
                 x = getIntoBounderyLimit(x);
                tempBee.xs(m)= x;
            end
            if fitness(tempBee.xs) < fitness( current_bee.xs)
                current_bee = tempBee;
            end
        else
            for k=1 : dimensions
                x = current_bee.xs(k);
                random = Levy(1);
                x= x + x*random;
                 x = getIntoBounderyLimit(x);
                tempBee.xs(k)= x;
            end
            if fitness(tempBee.xs) < fitness( current_bee.xs)
                current_bee = tempBee;
            end
        end
          scouts(s)= current_bee;
    end
end

% for rr=1: scout_bee_number
%     fitness(scouts(rr).xs)
% end

best_scout_bee = getBestScoutBee(scouts);
best_fitness_value= fitness(best_scout_bee.xs);



    function max_bee =  getBestScoutBee(scouts)
        max_bee = scouts(1);
        for n=2: scout_bee_number
            if fitness(max_bee.xs) >  fitness(scouts(n).xs)
                max_bee =  scouts(n);
            end
        end
        
    end

    function x= getIntoBounderyLimit(x)
        if x > upper_bound
            x = upper_bound * Levy(1);
        elseif x < lower_bound
            x = lower_bound *Levy(1);
        end
    end
end


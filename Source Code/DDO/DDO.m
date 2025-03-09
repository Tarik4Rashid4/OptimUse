function [ best_fitness_value, best_fitness_posision ] = DDO( fitness, max_iteration, number_of_agents, upper_bound,  lower_bound, dimensions)
    
    best_fitness_value = Inf;
    best_fitness_posision = -1;
    search_range = upper_bound - lower_bound;

    for iteration = 0:max_iteration
        agents = zeros(dimensions, number_of_agents);
        agents_position = zeros(number_of_agents, 1);
        agents_fitness = zeros(number_of_agents, 1);

        for agent = 1:number_of_agents
            position = unifrnd(lower_bound, upper_bound);

            search_lower_bound = position - search_range * 0.1;
            search_upper_bound = position + search_range * 0.1;

            search_lower_bound = max(lower_bound, search_lower_bound);
            search_upper_bound = min(upper_bound, search_upper_bound);

            positions = unifrnd(search_lower_bound, search_upper_bound, dimensions, 1);
            agents(:, agent) = positions;
            agents_position(agent) = position;
            agent_fitness = fitness(position);

            if agent_fitness < best_fitness_value
                best_fitness_value = agent_fitness;
                best_fitness_posision = positions;
            end
            agents_fitness(agent) = fitness(position);
        end
        %scatter(agents_position, agents_fitness);
        %hold on;
        p = polyfit(agents_position, agents_fitness, 2);
        
        %xs = linspace(search_lower_bound, search_upper_bound, 100);
        %ys = polyval(p, xs);
        %plot(xs, ys)
        %hold off;

        a = p(1);
        b = p(2);
        c = p(3);

        optimum_solution = -b / (2 * a);

        distance_from_upper = upper_bound - optimum_solution;
        distance_from_lower = optimum_solution - lower_bound;
        actual_distance = min(distance_from_upper, distance_from_lower) / 2;

        upper_bound = optimum_solution + actual_distance;
        lower_bound = optimum_solution - actual_distance;
        search_range  = search_range / 2;
    end
end

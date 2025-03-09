
clear all
clc

scout_bee_number =50; % Number of search agents

function_name='F10'; % Name of the test function that can be from F1 to F19 and cec01 t0 cec10 (Table 1,2 in the paper)

max_iteration = 10;

weightFactor = 0.0;  %equation 2 in the above paper.

disp(function_name);



[best_fitness_value, best_scout_bee] = FDO(function_name, max_iteration, scout_bee_number, weightFactor);
best_fitness_value



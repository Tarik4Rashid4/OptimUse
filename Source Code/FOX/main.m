clear all 
clc
summ=0;
avg=0;
 for i=1:30
SearchAgents_no=30; % Number of search agents
%30, cec01, max it=100
Function_name='cec01'; % Name of the test function that can be from 1 to 10

Max_iteration=500; % Maximum numbef of iterations

% Load details of the selected benchmark function
[lb,ub,dim,fobj]=Get_Functions_details(Function_name);
[Best_score,Best_pos]=FOX(SearchAgents_no,Max_iteration,lb,ub,dim,fobj);


display( num2str(Best_score));
       

 summ=summ+Best_score;
 end
 avg=summ/30;
 [avg]

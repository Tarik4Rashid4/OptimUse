
function DrawObjectives(pop,rep, Functin_Name)

if size([pop.Fitness], 1) == 2
    fitness_function=[pop.Fitness];
    plot(fitness_function(1,:),fitness_function(2,:),'o');
    hold on;
    
    rep_costs=[rep.Fitness];
    plot(rep_costs(1,:),rep_costs(2,:),'r*');
    
    xlabel('1^{st} Objective');
    ylabel('2^{nd} Objective');
    title([' Benchmark  ' Functin_Name]);
    grid on;
    hold off;
elseif  size([pop.Fitness], 1) == 3
%     fitness_function=[pop.Fitness];
%     scatter3(fitness_function(1,:),fitness_function(2,:), fitness_function(3,:), 10,'ko');
    hold on;
    
    rep_costs=[rep.Fitness];
    scatter3(rep_costs(1,:),rep_costs(2,:),rep_costs(3,:),10, 'r*');
    title(['Benchmark  ' Functin_Name]);
    xlabel('1^{st} Objective');
    ylabel('2^{nd} Objective');
    zlabel('3^{rd} Objective');
    grid on;
    hold off;
% 
% hold on;
% 
% fitness_function=[pop.Fitness];
% 
% 
% [x, y] = meshgrid(fitness_function(1,:), fitness_function(2,:));
% z =meshgrid(fitness_function(3,:));
% figure;
% surf(x,y,z);
%     xlabel('1^{st} Objective');
%     ylabel('2^{nd} Objective');
%     zlabel('3^{rd} Objective');
%     shading intrep;
%   grid on;
%   hold off;
%   
end
set(gcf,'units','points','position',[10,10,720,550]);
set(gcf,'color','w');

end
% Cite this article
%Abdulhameed, S., Rashid, T.A. Child Drawing Development Optimization Algorithm Based on Child’s Cognitive Development. 
%Arab J Sci Eng (2021). https://doi.org/10.1007/s13369-021-05928-6
%
%
clc;
clear;
close all;

%% Call Function

[output] = CCD(30, "F1");

average = mean(output);

std_dev = std(output);

disp(['Average of Best Cost = ' num2str(average)]);

disp(['Standard Deviation of Best Cost = ' num2str(std_dev)]);
clc;
clear;
close all;

addpath("DXD\");




[a,b] = DXD(@test_f2, 20, 10, 100, -100, 10);
a
b
function [fitness] = test_f1(xs)
    fitness = sum((xs-30)^2);
end

function [fitness] = test_f2(xs)
    fitness = sum(xs.^2);
end
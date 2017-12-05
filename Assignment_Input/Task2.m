% MATLAB script for Assessment Item-1
% Task-2
clear; close all; clc;
I = imread('SC.png');
IPW = I;
ISize = size(IPW);
x = 0;
% defines piecewise transformation highlighting range 80-100 and maintaining every other value.
for i = 1:ISize(2)
	for j = 1:ISize(1)
        x = IPW(j,i);
        
        if (80<x)&&(x<100) % values are assigned to x based on x's value
            x = 220;
            IPW(j,i) = x;
        else
            IPW(j,i) = x;
        end
		 	
		 % assigns new value to 
	end
end	
syms g;
y = piecewise((80<g)&(g<100), 220, g>100, g, g<80, g);
fplot(y);
figure;
imshow(IPW);
title('Piecewise transformed image');




% MATLAB script for Assessment Item-1
% Task-2
clear; close all; clc;
I = imread('SC.png');
IPW = I;
ISize = size(IPW);
syms x
y = piecewise(100>x>80, 220, x<80, x, x>100, x);
% defines piecewise transformation highlighting range 80-100 and maintaining every other value.
for i = 1:ISize(2)
	for j = 1:ISize(1)
		x = IPW(j,i); 	
		IPW(j,i) = y; % assigns new value to 
	end
end	
fplot(y);
figure;
imshow(IPW);
title('Piecewise transformed image');




% MATLAB script for Assessment Item-1
% Task-2
clear; close all; clc;
%read and display original image
I = imread('SC.png');
figure;
imshow(I);
axis on;
title('original image');
IPW = I;
ISize = size(IPW);
x = 0;

%piecewise transformation in the form of a for loop
for i = 1:size(IPW(:))
        x = IPW(i);
        if (80<=x)&&(x<=100) % Values between the ranges of 80 and 100 are highlighted
            x = 220;
            IPW(i) = x;
        end
end
        
figure;
imshow(IPW);
axis on;
title('Piecewise transformed image');

%Graphical representation of transformation on image
syms g;
y = piecewise((80<g)&(g<100), 220, g>100, g, g<80, g);
figure
fplot(y, [0 255]);
title('graph of transformation');
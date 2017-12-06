% MATLAB script for Assessment Item-1
% Task-4
clear; close all; clc;
I = imread('Starfish.jpg');
figure;
imshow(I);
title('Starfish image');

Igray = rgb2gray(I);
figure;
imshow(Igray);
title('Starfish image greyscaled');

IFiltered = medfilt2(Igray, [3 3]);
figure;
imshow(IFiltered);
title('Starfish image with reduced noise');

figure;
imshow(IPW);
title('Starfish image Shapes defined');

IPW = IFiltered;
shapes = bwconncomp(IPW,4);
imtophat(IPW,Point);
figure;
imshow(IPW);
title('Starfish image Shapes defined');


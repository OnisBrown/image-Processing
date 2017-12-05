% MATLAB script for Assessment Item-1
% Task-3
clear; close all; clc;

axes;
I = imread('Noisy.png');
figure;
imshow(I);
title('Noisy image');

Igray = rgb2gray(I);




figure;
imshow(Igray);
title('Processed image');
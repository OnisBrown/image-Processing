% MATLAB script for Assessment Item-1
% Task-1
clear; close all; clc;

% Step-1: Load input image
I = imread('Zebra.jpg');
figure;
imshow(I);
title('Step-1: Load input image');

% Step-2: Conversion of input image to grey-scale image
Igray = rgb2gray(I);
figure;
imshow(Igray);
title('Step-2: Conversion of input image to greyscale');

% interpolation
newSize = [1668, 1836];
cSize = size(Igray);
ratioW = newSize(1)/cSize(1);
ratioH = newSize(2)/cSize(2);
newImage = zeros(1668,1836);

%nearest neighbour
for i = 1:ratioH
	for j = 1:ratioW
		mR = i/ratioH;
		mC = j/ratioW;
		newImage(i,j) = Igray(mR,mC);
	end
end	
			
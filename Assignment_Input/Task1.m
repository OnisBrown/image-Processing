% MATLAB script for Assessment Item-1
% Task-1
clear; close all; clc;

% Step-1: Load input image
axes;
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
IgrayNear = zeros(1668,1836);
IgrayBi = zeros(1668,1836);

% nearest neighbour
for i = 1:newSize(2)
	for j = 1:newSize(1)
		mR = i/ratioH;
		mC = j/ratioW;
		IgrayNear(i,j) = Igray(mC,mR);
	end
end	

figure;
imshow(IgrayNear);
title('nearest nieghbor interpolation');			
% bilinear 
for i = 1:newSize(2)
	for j = 1:newSize(1)
		temp1 = 0;
		temp2 = 0;
		temp3 = 0;
		mR = i/ratioH;
		mC = j/ratioW;
		temp1 = (Igray(mC,mR)+Igray(mC,mR+1))/2; % interpolation along y axis
		temp2 = (Igray(mC,mR)+Igray(mC+1,mR))/2; % interpolation along x axis
		temp3 = (temp1 + temp2)/2
		IgrayBi(i,j) = temp3/2;
		% new pixel is given by 
	end
end	
figure;
imshow(IgrayBi);
title('Bilinear interpolation');

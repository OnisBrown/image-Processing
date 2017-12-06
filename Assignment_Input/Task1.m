% MATLAB script for Assessment Item-1
% Task-1
clear; close all; clc;

% Step-1: Load input image
I = imread('Zebra.jpg');

% Step-2: Conversion of input image to grey-scale image
% If gray image isn't 16 bit integer white pixels aren't evaluated properly
% during bilinear interpolation
Igray = uint16(rgb2gray(I)); 

figure;
% 16 bit and processed images don't display correctly using imshow
imshow(uint8(Igray)); 

title('Step-2: Conversion of input image to greyscale');

% interpolation
newSize = [1668, 1836];
cSize = size(Igray);
ratioW = newSize(1)/cSize(1);
ratioH = newSize(2)/cSize(2);
IgrayNear = zeros(1668,1836);
IgrayBi = zeros(1668,1836); 

% nearest neighbour
for i = 1:newSize(2)
	for j = 1:newSize(1)
		mR = i/ratioH;
        mR = round(mR);
		mC = j/ratioW;
        mC = round(mC);
        if mC == 0
            mC = 1;
        end
        if mR == 0
            mR = 1;
        end
		IgrayNear(j,i) = Igray(mC,mR);
	end
end	

figure;
imshow(uint8(IgrayNear));

title('nearest nieghbor interpolation');			
% bilinear 

for i = 1:newSize(2)
	for j = 1:newSize(1)
		mR = i/ratioH;
        mR = round(mR)-1;
		mC = j/ratioW;
        mC = round(mC)-1;
        if mC < 1
            mC = 1;
        end
        if mR < 1
            mR = 1;
        end
        
		temp1 = (Igray(mC,mR)+Igray(mC,mR+1))/2; % interpolation along y axis
		temp2 = (Igray(mC,mR)+Igray(mC+1,mR))/2; % interpolation along x axis
		temp3 = (temp1 + temp2)/2;
		IgrayBi(j,i) = temp3;
		% new pixel is given by bilinear interpolation (temp3)
	end
end	
figure;
imshow(uint8(IgrayBi));
title('Bilinear interpolation');

% MATLAB script for Assessment Item-1
% Task-3
clear; close all; clc;

axes;
I = imread('Noisy.png');
figure;
imshow(I);
title('Noisy image');

Igray = rgb2gray(I);
IgrayPad = padarray(Igray,[2 2]);
IgrayMean = IgrayPad;
IgrayMedian = IgrayPad;
ISize = size(padarray(Igray , [2 2]); % rray for soring size of padded image
%padding the arrays that will hold the filtered images
mask = zeros(5,5); % creating mask for the images
for i = 1:5:Isize(2)-5

	for j= 1:5:Isize(1)-5
	
		for mi = 1:5
		
			for mj = 1:5
				mask(mj,mi) = IgrayPad((j+mj-1),(i+mi-1));
				% maps points in padded image to mask
			end
		end
		
		median = m(25);
		
		for m = 1:25
			mean = mean + mask(m);
		end
		mean =  mean/25;
		IgrayMean(j-2,i-2) = mean;
		IgrayMedian(j-2,i-2) = median;
	end
end

figure;
imshow(IgrayMean);
title('Processed image: mean filter');

figure;
imshow(IgrayMedian);
title('Processed image: median filter');
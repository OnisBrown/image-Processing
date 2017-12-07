% MATLAB script for Assessment Item-1
% Task-3
clear; close all; clc;

I = imread('Noisy.png');
figure;
imshow(I);
axis on;
title('Noisy image');

Igray = rgb2gray(I);
IgrayPad = padarray(Igray,[2 2]); %pads image with gray border
IgrayMean = IgrayPad;
IgrayMedian = IgrayPad;
ISize = size(padarray(Igray , [2 2])); % array for soring size of padded image
%padding the arrays that will hold the filtered images
mask = zeros(5,5); % creating mask for the images

for i = 1:ISize(2)-5
	for j= 1:ISize(1)-5
		for mi = 1:5
			for mj = 1:5
				mask(mj,mi) = IgrayPad((j+mj-1),(i+mi-1));
				% maps points in padded image to mask
			end
        end
        
        % mean and median are calculated using sort mean and median
        % functions
        Isort = mask(:);
        Isort = sort(Isort);
        Imedian = median(Isort);
		Imean =  mean(mask(:));
        % map mean and median values to respective images
		IgrayMean(j+2,i+2) = Imean;
        watch = IgrayMean(j,i);
		IgrayMedian(j+2,i+2) = Imedian;
	end
end

figure;
imshow(IgrayMean);
axis on;
title('Processed image: mean filter');

figure;
imshow(IgrayMedian);
axis on;
title('Processed image: median filter');
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

IFiltered = medfilt2(Igray);
figure;
imshow(IFiltered);
title('Starfish image with reduced noise');

ISize = imresize(IFiltered, 2, 'nearest');
figure;
imshow(ISize);
title('Starfish image resized');

Ibi = imcomplement(ISize);
Ibi = imbinarize(Ibi);
figure;
imshow(Ibi);
title('Starfish image Shapes defined');

Line = bwboundaries(Ibi);
ILine = Ibi;
for i = 1:size(Line)
    j = Line{i};
    plot(j(:,2),j(:,1),'w','LineWidth', 2);
end
figure;
imshow(ILine);
title('Starfish image with all shapes outlined');



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

IPW = IFiltered;
Imean = mean(IFiltered(:));
for i = 1:size(IFiltered(:))
        x = IPW(i);
        if ((Imean*0.95)<x)&&(x<(Imean*1.05)) 
            x = 0;
            IPW(i) = x; % Values within 10% of the  mean greyscale value are set to black
        end
end

for i = 1:numel(IPW)
    if IPW(i) > 220
        IPW(i) = 0;
    end
end
imclose(IPW,strel('disk',2));
figure;
imshow(IPW);
title('Starfish image piecewise transformed');





level = graythresh(IPW); % find threshold of image

Ibi = IPW;
Ibi = imbinarize(Ibi,level); % use threshold to creat binary image
Ibi = imfill(Ibi, 'holes'); % fill holes in binary image
figure;
imshow(Ibi);
title('Starfish image binarized and with holes filled');

ILabeled = bwconncomp(Ibi, 8); %find all objects in the image
Shape = regionprops(ILabeled, 'basic'); % find properties of every object
ShapeArea = [Shape.Area];
ShapeAMean = mean(ShapeArea); % find the mean area of all objects


% reduce number of objects in image based on the mean area of all objects
Ibi = bwareaopen(Ibi,round(ShapeAMean));

% update list of objects and their attributes
ShapeArea = [Shape.Area];
ShapeAMean = mean(ShapeArea); % find the new mean area of all objects

figure;
imshow(Ibi);
title('Starfish image with objects smaller than the average size removed');

% update list of objects and their attributes
ILabeled = bwconncomp(Ibi, 8);
ILMap = bwlabel(Ibi); %create labelled image
Shape = regionprops(ILabeled, 'basic');
ShapePixels = [ILabeled.PixelIdxList];
ShapeArea = [Shape.Area];

roundness = [];
keepers = [];
for i = 1:size(Shape)
    ShapePerim = sum(sum(bwperim(ShapePixels{i})));
    roundness = [roundness, 4*pi*ShapeArea(i)/ShapePerim^2]; % finds the roundness of every object
end

for i = 1:numel(roundness)
    if  roundness(i) > mean(roundness)*1.1 || roundness(i) < mean(roundness)*0.9
        keepers = [keepers,i];
    end
end

% keepers2 = [];
% for i = 1:numel(keepers)
%     if  ShapeArea(keepers(i)) > mean(ShapeArea) 
%         keepers2 = [keepers2, keepers(i)];
% 
%     end
% end

IFinal = ismember(ILMap,keepers);

figure;
imshow(IFinal);
title('Starfish image with starfish isolated');
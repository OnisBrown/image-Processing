% MATLAB script for Assessment Item-1
% Task-4
clear; close all; clc;
I = imread('Starfish.jpg');
figure;
imshow(I);
title('Starfish image');

% convert image to greyscale
Igray = rgb2gray(I);
figure;
imshow(Igray);
title('Starfish image greyscaled');

%filter out noise from image
IFiltered = medfilt2(Igray);
figure;
imshow(IFiltered);
title('Starfish image with reduced noise');

% standardising common values to make binarize function friendlier
IPW = IFiltered;
Imean = mean(IPW(:));
for i = 1:size(IPW(:))
        x = IPW(i);
        % Values within 5% of the  mean greyscale value are set to black
        if ((Imean*0.95)<x)&&(x<(Imean*1.05)) 
            x = 0;
            IPW(i) = x; 
        end
end
% values close to white are turned black
for i = 1:numel(IPW)
    if IPW(i) > 220
        IPW(i) = 0;
    end
end

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
Ibi = bwareaopen(Ibi,round(ShapeAMean*3));

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

% initialise empty vectors for storing roundness and locations of values to
% keep
roundness = [];
keepers = []; 
% finds the roundness of every object 
for i = 1:size(Shape)
    ShapePerim = sum(sum(bwperim(ShapePixels{i})));
    roundness = [roundness, 4*pi*ShapeArea(i)/ShapePerim^2];
end
% finds objects that have roundness within a small, low range 
for i = 1:numel(roundness)
    if  roundness(i) < 0.016 && roundness(i) > 0.012 
        keepers = [keepers,i]; % stores locations of qualifying objects
    end
end


% qualifying objects are singled out in the final image 
IFinal = ismember(ILMap,keepers);
% neaten up the starfish objects slightly
IFinal = imclose(IFinal, strel('disk',4));
figure;
imshow(IFinal);
title('Starfish image with starfish isolated');
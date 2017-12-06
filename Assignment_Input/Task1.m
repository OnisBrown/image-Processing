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
axis on;
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
axis on;
title('nearest nieghbor interpolation');			
% bilinear 

for i = 1:newSize(2)
	for j = 1:newSize(1)
		mR = i/ratioH;
        mRH = ceil(mR);
        mRL = floor(mR);
		mC = j/ratioW;
        mCH = ceil(mC);
        mCL = floor(mC);
        
        
        if mCL < 1
            mCL = 1;
        end
        
        if mRL < 1
            mRL = 1;
        end
        
        if mCL == mCH
           mCH = mCH + 1; 
        end
        
        if mC == cSize(1)
            IgrayBi(j,i) = (Igray(mCL,mRL)+Igray(mC,mRL))/2;
            break
        end
        
        if mR == cSize(2)
            IgrayBi(j,i) = (Igray(mCL,mRH)+Igray(mCH,mRH))/2;
            break
        end
        

        frac1 = (mCH-mC)/(mCH-mCL);
        frac2 = (mC-mCL)/(mCH-mCL);
        
        

        x1 = (frac1*Igray(mCL,mRL)) + (frac2*Igray(mCH,mRL));
        x2 = (frac1*Igray(mCL,mRH)) + (frac2*Igray(mCH,mRH));
        
        if mRL == mRH
           mRH = mRH + 1; 
        end
        
        frac3 = (mRH-mR)/(mRH-mRL);
        frac4 = (mR-mRL)/(mRH-mRL);
        y = (frac3*x1) + (frac4*x2); 
        IgrayBi(j,i) = y;

		% new pixel is given by bilinear interpolation (temp3)
	end
end	
figure;
imshow(uint8(IgrayBi));
axis on;
title('Bilinear interpolation');

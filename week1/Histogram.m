clear; clc;
O = imread('door.jpeg');
GR = rgb2gray(O);
figure,
subplot(1,2,1);imshow(GR);title('gray-scale image');
% Image Processing Toolbox is used
subplot(1,2,2);imhist(GR);title('Histogram');

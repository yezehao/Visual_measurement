clear;clc;
O = imread("door.jpeg");
GR = rgb2gray(O);
SE = strel('disk',5);
bwe = imerode(GR,SE);
bw = imdilate(GR,SE);
open = imopen(GR,SE);
close = imclose(GR,SE);
tophat = imtophat(O,SE);
bothat = imbothat(O,SE);


%% Figures of erode and dilate
figure,
subplot(1,3,1);imshow(GR);
subplot(1,3,2);imshow(bwe);
subplot(1,3,3);imshow(bw);
%% Figures of open and closed operation
figure,
subplot(1,3,1);imshow(GR);
subplot(1,3,2);imshow(open);
subplot(1,3,3);imshow(close);
%% Figures of hat operation
figure,
subplot(1,3,1);imshow(O);
subplot(1,3,2);imshow(tophat);
subplot(1,3,3);imshow(bothat);
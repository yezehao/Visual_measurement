clear;clc;
O=imread('door.jpeg');
GR = rgb2gray(O);

% canny edge detection
canny = edge(GR,"canny");

figure,
imshow(canny),title('prewitt edge detection');

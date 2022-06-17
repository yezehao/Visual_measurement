clear; clc;
O = imread('door.jpeg'); % Input Image
GR = rgb2gray(O); % Gray Scale
figure % Subplot for comparison
subplot(1,2,1); imshow(O); title('original image');
subplot(1,2,2); imshow(GR); title('gray-scale image');

%% Explain about the rgb2gray function
% R = O(:,:,1);
% G = O(:,:,2);
% B = O(:,:,3);
% GR = 0.29900 * R + 0.58700 * G + 0.11400 * B;
% figure
% subplot(1,4,1);imshow(R);
% subplot(1,4,2);imshow(G);
% subplot(1,4,3);imshow(B);
% subplot(1,4,4);imshow(GR);
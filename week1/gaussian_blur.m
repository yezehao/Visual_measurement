clear; clc;
O = imread('door.jpeg');
R = O(:,:,1);
G = O(:,:,2);
B = O(:,:,3);
%% 3x3 Average blur
% Average blur for three channel signal seperately
GR3 = filter2(fspecial("gaussian"),R)/255;
GG3 = filter2(fspecial("gaussian"),G)/255;
GB3 = filter2(fspecial("gaussian"),B)/255;
% Compound three blured images together
G3 = cat(3,GR3,GG3,GB3);


%% Plot figure
figure,
subplot(1,2,1);imshow(O);
subplot(1,2,2);imshow(G3);

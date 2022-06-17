clear; clc;
O = imread('door.jpeg');
R = O(:,:,1);
G = O(:,:,2);
B = O(:,:,3);
%% 3x3 Average blur
% Average blur for three channel signal seperately
MR3 = filter2(fspecial("average",3),R)/255;
MG3 = filter2(fspecial("average",3),G)/255;
MB3 = filter2(fspecial("average",3),B)/255;
% Compound three blured images together
M3 = cat(3,MR3,MG3,MB3);

%% 7x7 Average blur
% Average blur for three channel signal seperately
MR7 = filter2(fspecial("average",7),R)/255;
MG7 = filter2(fspecial("average",7),G)/255;
MB7 = filter2(fspecial("average",7),B)/255;
% Compound three blured images together
M7 = cat(3,MR7,MG7,MB7);

%% 15x15 Average blur
% Average blur for three channel signal seperately
MR15 = filter2(fspecial("average",15),R)/255;
MG15 = filter2(fspecial("average",15),G)/255;
MB15 = filter2(fspecial("average",15),B)/255;
% Compound three blured images together
M15 = cat(3,MR15,MG15,MB15);

%% Plot figure
figure,
subplot(1,4,1);imshow(O);
subplot(1,4,2);imshow(M3);
subplot(1,4,3);imshow(M7);
subplot(1,4,4);imshow(M15);
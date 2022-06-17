clear;clc;
O = imread("door.jpeg");
GR = rgb2gray(O);
%% Sobel edge detection
model=[-1,0,1;
       -2,0,2;
       -1,0,1];
[m,n]=size(GR);
GR_d=double(GR);

for i=2:m-1
    for j=2:n-1
        GR_d(i,j)=GR(i+1,j+1)+2*GR(i+1,j)+GR(i+1,j-1)-GR(i-1,j+1)-2*GR(i-1,j)-GR(i-1,j-1);
    end
end
figure,

%% point detection
point_matrix = [-1 -1 -1;
                -1  8 -1;
                -1 -1 -1];
PD = abs(imfilter(GR_d,point_matrix));
w = max(PD(:));
PD = PD>=w;
figure,
subplot(1,2,1);imshow(O);title('original');
subplot(1,2,2);imshow(PD);title('point detection')
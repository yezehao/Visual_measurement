clear;clc;
O=imread('door.jpeg'); %读取图像
GR=rgb2gray(O); %将彩色图变成灰色图
model=[0,-1;1,0];
[m,n]=size(GR);
GR_d=double(GR);
for i=2:m-1
    for j=2:n-1
        GR_d(i,j)=GR(i+1,j)-GR(i,j+1);
    end
end
figure,
subplot(1,2,1);imshow(GR_d),title('robert edge detection');
subplot(1,2,2);imshow(uint8(GR_d + double(GR))),title('sharpen');
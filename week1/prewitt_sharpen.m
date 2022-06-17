clear;clc;
O=imread('door.jpeg'); 
GR=rgb2gray(O); %将彩色图变成灰色图
PED = uint8(filter2(fspecial("prewitt"),GR));% perwitt edge detection
PS = GR + uint8(PED);
figure,
subplot(1,2,1);imshow(PED),title('prewitt edge detection');
subplot(1,2,2);imshow(PS),title('sharpen');


%% perwitt算子
% O=imread('door.jpeg'); 
% GR=rgb2gray(O); %将彩色图变成灰色图
% model=[-1,0,1;
%       -1,0,1;
%       -1,0,1];
% [m,n]=size(GR);
% GR_d=double(GR);
% for i=2:m-1
%     for j=2:n-1
%         tem=GR(i-1:i+1,j-1:j+1);
%         tem=double(tem).*double(model);      
%         GR_d(i,j)=sum(sum(tem));        
%      end
% end
% 
% figure,
% subplot(1,2,1);imshow(uint8(GR_d)),title('prewitt edge detection');
% subplot(1,2,2);imshow(uint8(GR_d + double(GR))),title('sharpen');
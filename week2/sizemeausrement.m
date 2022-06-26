clear;clc;
%% Set up
% The diameter of one pound coin is 23.43 mm
coin_width = 23.43;
coin_height = 23.43;
O = imread('D:\Visual_measurement\week2\sample.jpg');

%% Binarization
gr = rgb2gray(O);% gray scale;
SE = strel('square',9);
bw = imdilate(gr,SE);
binary = imbinarize(bw);

% figure,% plot figure
% subplot(1,3,1);imshow(gr);title('灰度图');
% subplot(1,3,2);imshow(bw);title('膨胀');
% subplot(1,3,3);imshow(binary);title('二值化');
%% Remove miscellaneous
edge1=bwperim(binary);% binary image edge detection
filling=imfill(edge1,'holes');% flood filling
edge2=bwperim(filling);% binary image edge detection
output=bwareaopen(edge2,150);% remove objects smaller than 150 px

% figure,% plot figure
% subplot(1,3,1);imshow(filling);title('孔洞填充');
% subplot(1,3,2);imshow(edge2); title('提取最外围边缘');
% subplot(1,3,3);imshow(output);title('去除杂物边缘');
%% Calculation about reference
[labelpic,num] = bwlabel(output,8);
[r, c]=find(labelpic==1);
[rectx,recty,area,perimeter] = minboundrect(c,r,'p');% 获取标记物体最小外接矩形坐标点
[length, width] = minboxing(rectx(1:end-1),recty(1:end-1));% 计算最小外接矩形长宽


% pixels per metric ratio
pixels_length_rate=length/coin_height;
pixels_width_rate=width/coin_width;
midpointx=zeros(2,2);
midpointy=zeros(2,2);
target_mat=zeros(1,num);
%% Plot figure with rectangles
figure,
imshow(O);
 for v=2:num
    [r, c]=find(labelpic==v);
    [rectx,recty,area,perimeter]=minboundrect(c,r,'p');
    [length, width] = minboxing(rectx(1:end-1),recty(1:end-1));
     % 绘制目标检测框
    line(rectx,recty,'color','y','linewidth',2);
             midpointx(1)=(rectx(1)+rectx(2))/2;
             midpointx(2)=(rectx(3)+rectx(4))/2;
             midpointx(3)=(rectx(2)+rectx(3))/2;
             midpointx(4)=(rectx(4)+rectx(1))/2;

             midpointy(1)=(recty(1)+recty(2))/2;
             midpointy(2)=(recty(3)+recty(4))/2;
             midpointy(3)=(recty(2)+recty(3))/2;
             midpointy(4)=(recty(4)+recty(1))/2;
      % 绘制目标长宽中点间连线
     % line(midpointx,midpointy,'color','m','linewidth',2);
     target_float_length=length/pixels_length_rate;
     target_length=num2str(target_float_length);
     target_float_width=width/pixels_width_rate;
     target_width=num2str(target_float_width);
     
     % 显示目标物体长宽信息
     if((rectx(2)-rectx(1))<=(recty(2)-recty(1)))
         text(midpointx(1),midpointy(1)-10,target_length,'Color','g');
         text(midpointx(3)+10,midpointy(3),target_width,'Color','g');
     else
         text(midpointx(1),midpointy(1)-10,target_width,'Color','g');
         text(midpointx(3)+10,midpointy(3),target_length,'Color','g');
     end
 end

%% Set Up
clear; clc;
obj = VideoReader('test.mp4'); % imread video

% The size of portabel hard disk is: 
% 110.49mm x 82.04mm x 15.24mm
real_area = 110.49 * 82.04; 

% initial distance
init_dis = 162; % unit is mm

%% Check the pixel of first frame
frame1 = read(obj,1);
% process first frame
gaussian = imfilter(rgb2gray(frame1), fspecial('gaussian',9), 'replicate');
canny=edge(imbinarize(gaussian),'Canny');
filling = bwperim(imfill(canny,'holes')); 
bw = imdilate(bwareaopen(filling,800),strel('disk',5));

% find rectangle
[labelpic,num] = bwlabel(bw,4);
[r, c]=find(labelpic==1);
[rectx,recty,area,perimeter]=minboundrect(c,r,'p');
[length, width] = minboxing(rectx(1:end-1),recty(1:end-1));

% Plot figure
figure,imshow(frame1);
line(rectx,recty,'color','y','linewidth',2);
text(360,200,num2str(init_dis),'Color','m','FontSize',18);
close;

%% Calculation
pixel_area1 = length * width;
rate = sqrt(real_area/pixel_area1);

%% Image Processing
% quarter the number of frames to increase processing speed
numframes = floor((obj.NumFrames/4));

for i = 1 : numframes 
    m = 4*i; frame = read(obj,m);

    % process frames
    gaussian = imfilter(rgb2gray(frame), fspecial('gaussian',9), 'replicate');
    canny=edge(imbinarize(gaussian),'Canny'); % canny edge detection
    filling = bwperim(imfill(canny,'holes')); % filling
    bw = imdilate(bwareaopen(filling,800),strel('disk',5)); 

    % find rectangle
    [labelpic,num] = bwlabel(bw,4);
    [r, c]=find(labelpic==1);
    [rectx,recty,area,perimeter]=minboundrect(c,r,'p');
    [length, width] = minboxing(rectx(1:end-1),recty(1:end-1));

    % Plot figure
    figure,imshow(frame);
    line(rectx,recty,'color','y','linewidth',2);

    % calculate distance
    pixel_area = length * width;
    rate_frame = sqrt(real_area/pixel_area);
    delta_d = init_dis*(rate_frame-rate)/rate;
    distance = init_dis + delta_d;
    text(360,200,num2str(distance),'Color','m','FontSize',18);

    % save images
    path = ['D:\Visual_measurement\week3\monocular\result\proimg' num2str(i) '.jpg'];
    saveas(gcf,path)
    close;
end

%% Video Maker
% write blank video
provideo=VideoWriter('process_result');
endFrame = 21; % The end frames
provideo.FrameRate = 6; % fps = 24
open(provideo); % Open file for writing video data
% imread image from result
for i= 1:endFrame
    frames=imread(['D:\Visual_measurement\week3\monocular\result\proimg',num2str(i),'.jpg']);
    writeVideo(provideo,frames);
end
close(provideo);
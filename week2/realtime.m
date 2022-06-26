%% Set Up
clear; clc;
obj = VideoReader('sample1.mp4'); % imread video
% quarter the number of frames to reduce processing speed
numframes = obj.NumFrames;

%% Image Processing
for i = 1 : numframes 
    frame = read(obj,i);
    % Edge Detection
    binary = imbinarize(imfilter(rgb2gray(frame), fspecial('gaussian',9), 'replicate'));
    canny=edge(binary,'Canny');
    % Remove miscellaneous
    filling = bwareaopen(bwperim(imfill(canny,'holes')),600);  
    %% Reference
    [labelpic,num] = bwlabel(filling,8);
    pixels_lr=24; % pixels per length ratio
    pixels_wr=24; % pixels per width ratio
    %% Plot
    figure,imshow(frame);
    for v=1:num
        [r, c]=find(labelpic==v);
        [rectx,recty,area,perimeter]=minboundrect(c,r,'p');
        [length, width] = minboxing(rectx(1:end-1),recty(1:end-1));
         % draw the rectangle
        line(rectx,recty,'color','y','linewidth',2);
        midpointx(1)=((rectx(1)+rectx(2))/2);
        midpointx(3)=(rectx(2)+rectx(3))/2;
        midpointy(1)=(recty(1)+recty(2))/2;
        midpointy(3)=(recty(2)+recty(3))/2;
        target_length=num2str(length/pixels_lr);
        target_width=num2str(width/pixels_wr);
     
        % show the information about the length and width
        if((rectx(2)-rectx(1))^2+(recty(2)-recty(1))^2)<=((rectx(3)-rectx(2))^2+(recty(3)-recty(2))^2)
            text(midpointx(1),midpointy(1)-10,target_length,'Color','g');
            text(midpointx(3)+10,midpointy(3),target_width,'Color','g');
        else
            text(midpointx(1),midpointy(1)-10,target_width,'Color','g');
            text(midpointx(3)+10,midpointy(3),target_length,'Color','g');
        end
    end
    path = ['D:\Visual_measurement\week2\process_result\proimg' num2str(i) '.jpg'];
    saveas(gcf,path)
    close;
end





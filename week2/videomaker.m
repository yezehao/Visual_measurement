% write blank video
provideo=VideoWriter('process_result');
endFrame = 81; % The end frames
provideo.FrameRate = 20; % fps = 30
open(provideo); % Open file for writing video data
% imread image from result
for i= 1:endFrame
    frames=imread(['D:\Visual_measurement\week2\process_result\proimg',num2str(i),'.jpg']);
    writeVideo(provideo,frames);
end
close(provideo);


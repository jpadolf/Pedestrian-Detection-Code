% %% Create Input Video
% fnames = dir('../Files/VideoImages/*.pgm');
% numfids = length(fnames);
% 
% outputVideo = VideoWriter(fullfile('../Files/Videos','input_video.avi'));
% outputVideo.FrameRate = 13;
% open(outputVideo);
% 
% for i = 1:numfids
%     img = imread(fullfile('../Files/VideoImages',fnames(i).name));
%     writeVideo(outputVideo,img);
% end
% 
% close(outputVideo);

%% Create Output Video(s)
fnames = dir('../Files/VideoImages/*.pgm');
numfids = length(fnames);

outputVideo1 = VideoWriter(fullfile('../Files/Videos','output_video1.avi'));
outputVideo1.FrameRate = 13;
open(outputVideo1);

outputVideo2 = VideoWriter(fullfile('../Files/Videos','output_video2.avi'));
outputVideo2.FrameRate = 13;
open(outputVideo2);

for i = 1:numfids
    tic
    i
    NMSwindows = detect_pedestrian(fullfile('../Files/VideoImages',fnames(i).name),mod2_csvm,0,10,.75,1);
    F1 = getframe(1);
    writeVideo(outputVideo1,F1);
    F2 = getframe(2);
    writeVideo(outputVideo2,F2);
    toc
end

close(outputVideo1);
close(outputVideo2);
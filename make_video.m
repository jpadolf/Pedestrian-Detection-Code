%% Create Input Video
fnames = dir('../Files/VideoImages/*.pgm');
numfids = length(fnames);

outputVideo = VideoWriter(fullfile('../Files/Videos','input_video.avi'));
outputVideo.FrameRate = 13;
open(outputVideo);

for i = 1:numfids
    img = imread(fullfile('../Files/VideoImages',fnames(i).name));
    writeVideo(outputVideo,img);
end

close(outputVideo);

%% Create Output Video
fnames = dir('../Files/VideoImages/*.pgm');
numfids = length(fnames);

outputVideo = VideoWriter(fullfile('../Files/Videos','output_video.avi'));
outputVideo.FrameRate = 13;
open(outputVideo);
for i = 1:numfids
    tic
    i
    NMSwindows = detect_pedestrian(fullfile('../Files/VideoImages',fnames(i).name),mod2_csvm,0,16,.75,0);
    frame = getframe;
    writeVideo(outputVideo,frame);
    toc
end

close(outputVideo);
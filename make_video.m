%% Create Input Video
fnames = dir('../VideoImages/*.pgm');
numfids = length(fnames);

outputVideo = VideoWriter(fullfile('../Videos','input_video.avi'));
outputVideo.FrameRate = 13;
open(outputVideo);

for i = 1:numfids
    img = imread(fullfile('../VideoImages',fnames(i).name));
    writeVideo(outputVideo,img);
end

close(outputVideo);

%% Create Output Video
fnames = dir('../VideoImages/*.pgm');
numfids = length(fnames);

outputVideo = VideoWriter(fullfile('../Videos','output_video.avi'));
outputVideo.FrameRate = 13;
open(outputVideo);
for i = 1:numfids
    tic
    i
    NMSwindows = detect_pedestrian(fullfile('../VideoImages',fnames(i).name),mod2_csvm,0,16,.75,0);
    frame = getframe;
    writeVideo(outputVideo,frame);
    toc
end

close(outputVideo);
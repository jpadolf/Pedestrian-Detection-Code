function make_video(inputDir, outputDir,model)
% 'makevideo' takes input video frames, detects the object in each frame, and collects all the output frames into one video, which is then saved.
% By default, it uses number_scales = 0, overlap_pixels=10, scaling_factor=.8, and toSRS=1.
% 
%     makevideo(inputDir, outputDir, model)
% 	a) inputDir is the path that contains the input video frames.
% 	b) outputDir is the path that the final output video is written into.
% 	c) model is the name of the classifier model: mod2 if loaded from startup.m
    
%% Setup
mkdir(outputDir);
fnames = dir(fullfile(inputDir,'/*.pgm'));
numframes = length(fnames);

%% Create Input Video
inputVideo = VideoWriter(fullfile(outputDir,'Input_Video.avi'));
inputVideo.FrameRate = 13;
open(inputVideo);

for i = 1:numframes
    img = imread(fullfile(inputDir,fnames(i).name));
    writeVideo(inputVideo,img);
end

close(inputVideo);
 
%% Create Output Video(s)
outputVideo1 = VideoWriter(fullfile(outputDir,'Initial_Detection.avi'));
outputVideo1.FrameRate = 13;
open(outputVideo1);

outputVideo2 = VideoWriter(fullfile(outputDir,'Final_Detection.avi'));
outputVideo2.FrameRate = 13;
open(outputVideo2);

OutputWindows = cell(1,numframes);

for i = 1:numframes
    tic
    i
    NMSwindows = detect_pedestrian(fullfile(inputDir,fnames(i).name),model,0,10,.8,1);
    F1 = getframe(1);
    writeVideo(outputVideo1,F1);
    F2 = getframe(2);
    writeVideo(outputVideo2,F2);
    toc
    OutputWindows{i} = NMSwindows;
end

close(outputVideo1);
close(outputVideo2);

%% Video Post Processing
threshold = 55;
FinalWindows = cell(1,numframes);
for i = 1:numframes
    FinalWindows{i} = [];
end

FinalWindows{1} = OutputWindows{1};

for i = 2:numframes
    %figure, plot_boxes_NMS(fullfile('../Files/VideoImages',fnames(i).name),OutputWindows{i});
    for j1=1:length(OutputWindows{i})
        for j0 = 1:length(OutputWindows{i-1})
            xdiff = OutputWindows{i}(j1).xstart-OutputWindows{i-1}(j0).xstart;
            ydiff = OutputWindows{i}(j1).ystart-OutputWindows{i-1}(j0).ystart;
            diff = hypot(xdiff,ydiff);
            if diff < threshold
                FinalWindows{i} = [FinalWindows{i} OutputWindows{i}(j1)];
            end
        end
    end
end

outputVideo = VideoWriter(fullfile(outputDir,'Processed_Video.avi'));
outputVideo.FrameRate = 13;
open(outputVideo);

for i = 1:numframes
    figure(1), plot_boxes_NMS(fullfile(inputDir,fnames(i).name),FinalWindows{i});
    F1 = getframe(1);
    writeVideo(outputVideo,F1);
end

close(outputVideo);
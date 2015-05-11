function plot_boxes_NMS(I,NMSwindows)
% plot_boxes takes an image and plots boxes around regions in which we've
% detected a human. 
% Inputs: 
% I - input image
% NMSwindows - array of length nx1 containing the 128x64 detection windows

imshow(I), hold on;


for index = 1:length(NMSwindows)
    scale = NMSwindows(index).scale;
    x = (NMSwindows(index).xstart-1)*scale+1;
    y = (NMSwindows(index).ystart-1)*scale+1;

    plot([x x x+64*scale-1 x+64*scale-1 x],...
        [y y+128*scale-1 y+128*scale-1 y y],'r');
end
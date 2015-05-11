function plot_boxes(I,windows,results)
% plot_boxes takes an image and plots boxes around regions in which we've
% detected a human. 
% Inputs: 
% I - input image
% windows - cell of length nx1 containing arrays of 128x64 detection windows
% results - cell of length nx1 containing arrays of binary results windows

imshow(I), hold on;


for index = 1:size(windows,1)
    [rows,cols] = find(results{index}>0);
    for finds = 1:length(rows)
        i = rows(finds);
        j = cols(finds);
        scale = windows{index}(i,j).scale;
        x = (windows{index}(i,j).xstart-1)*scale+1;
        y = (windows{index}(i,j).ystart-1)*scale+1;
        %x = windows{index}(i,j).xstart;
        %y = windows{index}(i,j).ystart;
        plot([x x x+64*scale-1 x+64*scale-1 x],...
            [y y+128*scale-1 y+128*scale-1 y y],'r');
    end
end
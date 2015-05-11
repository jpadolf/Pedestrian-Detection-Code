function windows = create_windows(input_image,overlap,scaling)
% create_windows constructs a pyramid of windows in different spatial and
% resolution levels. 
% overlap: the number of pixels between starting coordinates of two windows
% scaling: the size reduction between corresponding resolution levels

I = im2double(input_image);
[ysize, xsize,~] = size(I);
ylev = log(ysize/128)/log(1/scaling);
xlev = log(xsize/64)/log(1/scaling);
levels = floor(min(ylev,xlev))+1;

windows = cell(levels,1);
f = input_image;

for index = 1:levels
    scale = (1/scaling)^(index-1);
    windows{index} = slide_window(f,overlap,scale);
    f = imresize(f,scaling);
end
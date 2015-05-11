function NMSwindows = detect_pedestrian(image_path,model_name,number_scales,overlap_pixels,scaling_factor,toSRS)
% 'detect_pedestrian' runs the main algorithm to detect a pedestrian in the image
% 
% detect_pedestrian(image_path,model_name,number_scales,overlap_pixels,scaling_factor,toSRS)
% 	a) image_path gives the relative or absolute string location of the input image
% 	b) model_name is the name of the classifier model: mod2 if loaded from startup.m
% 	c) number_scales looks at the top 'n' scales. a value of 0 implies parsing all scales.
% 	d) overlap_pixels is the number of pixels between the current and the next window.
% 	e) scaling_factor indicates the amount of scaling done to the image. Best value is 0.8.
% 	f) toSRS is the option of computing the Single Response Suppression of each input image.


img = imread(image_path);
if length(size(img)) == 3 % if RGB
    f = single(rgb2gray(img));
else % if grayscale
    f = single(img);
end

windows = create_windows(f,overlap_pixels,scaling_factor);

if (number_scales > length(windows) || number_scales == 0)
    number_scales = length(windows);
end
  
%%
results = cell(size(windows));
for index = 1:size(windows,1)
    results{index,1} = -ones(size(windows{index}));
end

%%
count = 1;
for l = size(windows,1):-1:size(windows,1)-number_scales+1
  for i = 1:size(windows{l},1)
      for j = 1:size(windows{l},2)
          im_temp = windows{l}(i,j).pixels;
%           hog = vl_hog(im_temp,8,'variant','dalaltriggs');
%           imhog = vl_hog('render',hog,'variant','dalaltriggs');
%           featval = imhog(:)';
%           feat(count,:) = featval;
            imhog = extractHOGFeatures(im_temp);
            feat(count,:) = imhog;
          count = count+1;
      end
  end
end

res = predict(model_name,feat);
count = 1;
for l = size(windows,1):-1:size(windows,1)-number_scales+1
  for i = 1:size(windows{l},1)
      for j = 1:size(windows{l},2)
         results{l}(i,j) = res(count);
         count = count+1;
      end
  end
end

figure(1), plot_boxes(imread(image_path),windows,results);

NMSwindows = NMS(windows,results,toSRS);
figure(2),plot_boxes_NMS(imread(image_path),NMSwindows);

end
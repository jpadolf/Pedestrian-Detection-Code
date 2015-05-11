function NMSwindows = detect_pedestrian(image_path,model,numscales,overlap,scaling,sss)

img = imread(image_path);
if length(size(img)) == 3 % if RGB
    f = single(rgb2gray(img));
else % if grayscale
    f = single(img);
end

windows = create_windows(f,overlap,scaling);

if (numscales > length(windows) || numscales == 0)
    numscales = length(windows);
end
  
%%
results = cell(size(windows));
for index = 1:size(windows,1)
    results{index,1} = -ones(size(windows{index}));
end

%%
count = 1;
for l = size(windows,1):-1:size(windows,1)-numscales+1
  for i = 1:size(windows{l},1)
      for j = 1:size(windows{l},2)
          im_temp = windows{l}(i,j).pixels;
          hog = vl_hog(im_temp,8,'variant','dalaltriggs');
          imhog = vl_hog('render',hog,'variant','dalaltriggs');
          featval = imhog(:)';
          feat(count,:) = featval;
          count = count+1;
      end
  end
end

res = predict(model,feat);
count = 1;
for l = size(windows,1):-1:size(windows,1)-numscales+1
  for i = 1:size(windows{l},1)
      for j = 1:size(windows{l},2)
         results{l}(i,j) = res(count);
         count = count+1;
      end
  end
end

% figure, plot_boxes(imread(image_path),windows,results);

NMSwindows = NMS(windows,results,sss);
figure,plot_boxes_NMS(imread(image_path),NMSwindows);

end
% clc;clear;close all;
clearvars -except mod2_csvm;
% load 'newtrainmod2_laptop_csvm.mat';
clc;
  hh = strcat('test/pos/crop_000027.png');
  f = single(rgb2gray(imread(hh)));
  
%   f = histeq(rgb2gray(f));
%   f = single(f);
%   figure,imagesc(f);
%%
  windows = create_windows(f,16,0.75);
%%
  results = cell(size(windows));
  for index = 1:size(windows,1)
  results{index,1} = -ones(size(windows{index}));
  end
  %%
  count = 1;
  for l = size(windows,1):-1:size(windows,1)-1
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
  
  res = predict(mod2_csvm,feat);
  count = 1;
  for l = size(windows,1):-1:size(windows,1)-1
      for i = 1:size(windows{l},1)
          for j = 1:size(windows{l},2)
             results{l}(i,j) = res(count);
             count = count+1;
          end
      end
  end

figure, plot_boxes(imread(hh),windows,results);

NMSwindows = NMS(windows,results);
figure,plot_boxes_NMS(hh,NMSwindows);
  
% pos_tr = [ones(size(g,1),1) g];
% save('K:\computer_vision\ped_mit\pos_train','pos_tr');
% l = svmclassify(mod,g);
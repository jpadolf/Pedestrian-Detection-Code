clc;close all;
clearvars -except mod2_csvm pos_scores neg_scores;
load 'K:\newtrainmod2_laptop_csvm.mat';
% clearvars -except mod2_csvm;
% load 'K:\inria_model.mat';
% load K:\new_model.mat;
  
%   f = histeq(rgb2gray(f));
%   f = single(f);
%   figure,imagesc(f);
%%
dirData = dir('K:\computer_vision\INRIAPerson\70X134H96\test\pos\*.png');
fileNames = {dirData.name};
count = 1;
for iFile = 1:numel(fileNames)
  hh = strcat('K:\computer_vision\INRIAPerson\70X134H96\test\pos\',fileNames{iFile});
  f = single(rgb2gray(imread(hh)));
  
  windows = create_windows(f,16,0.75);
%    im = windows{7}(2,3).pixels;
%    figure,imagesc(im);
%    ihg = vl_hog(im,8,'variant','dalaltriggs');
% ihg1 = vl_hog('render',ihg,'variant','dalaltriggs');
% figure,imagesc(ihg1),colormap gray;

  %%
  results = cell(size(windows));
  for index = 1:size(windows,1)
  results{index,1} = zeros(size(windows{index}));
  end
  %%
  for l = size(windows,1)
      for i = 2
          for j = 2
              im_temp = windows{l}(i,j).pixels;
%               z = imresize(im_temp,[size(im_temp,1)*2 size(im_temp,2)*2]);
              hog = vl_hog(im_temp,8,'variant','dalaltriggs');
              imhog = vl_hog('render',hog,'variant','dalaltriggs');
              featval = imhog(:)';
              feat(count,:) = featval;
              count = count+1;
%              results{l}(i,j) = res;
          end
      end
  end
  clear windows;
end

[res,sco] = predict(mod2_csvm,feat);
pos_scores = sco(:,2);
% sco = calscores(feat,mod2);
% sco = calscores(feat,mod2);

% figure, plot_boxes(imread(hh),windows,results);
% 
% NMSwindows = NMS(windows,results);
% figure,plot_boxes_NMS(hh,NMSwindows);
  
% pos_tr = [ones(size(g,1),1) g];
% save('K:\computer_vision\ped_mit\pos_train','pos_tr');
% l = svmclassify(mod,g);
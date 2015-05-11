% startup.m loads the classification model and sets up the VLFeat library 
% 
% Change the current directory to the "Code" folder containing this file
% and all other MATLAB functions.
% 
% The parent folder of "Code" should also include the "Files" folder,
% which contains the model, the VLFeat library, and all testing images.

clear; clc;
load '../Files/model.mat';
run('../Files/vlfeat-0.9.20/toolbox/vl_setup');
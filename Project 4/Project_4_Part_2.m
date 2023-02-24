%% Project 4
%
% EE/CPE 428 - Computer Vision
% Winter 2023
%
% Group 6: Nathan Jaggers, Jay Sisodia, Jeffrey Wexler
%
% Description: See coresponding document <Can add description later>
%% Part 2
close all;
clear;
clc;

%%
% load image and extract its key points
bikes1 = imread("bikes1.ppm");

% create feature vector with 5x5 neighboring pixels as descriptor
features_a = my_extractFeatures_a(bikes1, 10);

% create feature vector with SIFT like descriptor
features_b = my_extractFeatures_b(bikes1, 100);

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
[features_a1, locs1] = my_extractFeatures_a(bikes1, 100);

% load image and extract its key points
bikes2 = imread("bikes2.ppm");

% create feature vector with 5x5 neighboring pixels as descriptor
[features_a2, locs2] = my_extractFeatures_a(bikes2, 100);

[output, mloc1, mloc2] = feature_matching(features_a1,features_a2,locs1,locs2);

showMatchedFeatures(bikes1,bikes2,mloc1,mloc2);

%%
% load image and extract its key points
bikes1 = imread("bikes1.ppm");

% create feature vector with SIFT
[features_b1, locs1] = my_extractFeatures_b(bikes1, 100);

% load image and extract its key points
bikes2 = imread("bikes2.ppm");

% create feature vector with SIFT
[features_b2, locs2] = my_extractFeatures_b(bikes2, 100);

[output, mloc1, mloc2] = feature_matching(features_a1,features_a2,locs1,locs2);

showMatchedFeatures(bikes1,bikes2,mloc1,mloc2);

%%
% The following is code from (I believe) Jeffrey
% example of what final is supposed to look like
im1 = imread('bikes1.ppm');
I1 = rgb2gray(im1);
imshow(I1)
im2 = imread('bikes2.ppm');
I2 = rgb2gray(im2);
imshow(I2)


points1 = detectSURFFeatures(I1);
points2 = detectSURFFeatures(I2);
[f1, vpts1] = extractFeatures(I1, points1);  
[f2, vpts2] = extractFeatures(I2, points2);
        
indexPairs = matchFeatures(f1, f2) ;
matchedPoints1 = vpts1(indexPairs(:, 1));
matchedPoints2 = vpts2(indexPairs(:, 2));


figure;
showMatchedFeatures(I1,I2,matchedPoints1,matchedPoints2);
title('Putative point matches');
legend('matchedPts1','matchedPts2');

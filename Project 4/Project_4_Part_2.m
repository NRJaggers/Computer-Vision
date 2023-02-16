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
%load image and extract its key points
bikes1 = imread("bikes1.ppm");

%eventually this
%my_extractFeatures_a(bikes1, 10);

%%
% check image passed into function and ensure it is grayscale
image = bikes1; detected_pts = 100;
gray = check_grayscale(image);

% use detectSURFFeatures(I) or detectFASTFeatures(I) to detect features 
% in an image. I must be a 2D grayscale image
keypoints = detectSURFFeatures(gray);

% keep only strongest amount of points desired
strongPoints = keypoints.selectStrongest(detected_pts);

% grab locations for strongets pixels
L = strongPoints.Location;
y = uint32(L(:, 1));
x = uint32(L(:, 2));

extracted_features = []
for i = 1 : detected_pts
    tempMat = gray(x(i)-2:x(i)+2, y(i)-2:y(i)+2);
    extracted_features = [extracted_features tempMat(:)];
end


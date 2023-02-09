%% Project 4
%
% EE/CPE 428 - Computer Vision
% Winter 2023
%
% Group 6: Nathan Jaggers, Jay Sisodia, Jeffrey Wexler
%
% Description: See coresponding document <Can add description later>
% Credit: This code was adapted from code given to the students of EE428 by
% Dr. Zhang
%% Part 1
close all;
clear;
clc;

%%
% read image and cast to double so negative values are allowed during computation 
checkers = double(imread("checkerboard-noisy1.tif"));
figure(1); imshow(checkers,[]);

%%
% apply Gaussian filter
figure(2);
sigma = 1;
I = imfilter(checkers, fspecial("gaussian", round(6*sigma+1), sigma));
imshow(I,[]);

%%
% compute the gradient
Sx = [-1 -2 -1 ; 0 0 0; 1 2 1]; Ix = imfilter(I,Sx);
Sy = Sx'; Iy = imfilter(I, Sy);

% compute M (the second moment matrix)
Ixx = Ix.*Ix;
Ixy = Ix.*Iy;
Iyy = Iy.*Iy;

% Sum the dertivatives over the window size using Gaussian window
sigma = 2;
W = fspecial('gaussian', round(6*sigma+1), sigma);
M11 = imfilter(Ixx, W);
M12 = imfilter(Ixy, W);
M22 = imfilter(Iyy, W);

% compute harris corner response
alpha = 0.06;
detM = M11.*M22 - M12.^2;
traceM = M11 + M22;
R = detM - alpha*traceM.^2;

% apply maximum suppression
% find local maxima
R_thresh = 2;
Lmax = (R == imdilate(R,strel('disk',13)) & R > R_thresh);
[rows, cols] = find(Lmax); %get a list of indicies of potential interest points

% draw a box around the detected corners
figure(3);
imshow(checkers,[]);
hold on 
for i = 1:length(rows)
    x = cols(i);
    y = rows(i);
    rectangle('Position',[x-2 y-2 10 10],'EdgeColor','r');
end

%%
% comparing to built-in matlab functions
checkers = imread("checkerboard-noisy1.tif");
corners = detectHarrisFeatures(checkers);
checkersNboxes = insertMarker(checkers, corners, "circle");
figure; imshow(checkersNboxes);
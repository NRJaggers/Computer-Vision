%% Project 3
%
% EE/CPE 428 - Computer Vision
% Winter 2023
%
% Group 1: Nathan Jaggers, Fadi Alzammar, Eitan Klass
%
% Description: See coresponding document <Can add description later>
%% Part A
close all;
clear;
clc;

%%
% load image
bg = imread("go1.jpg");
imshow(bg);

% grayscale image
gray = rgb2gray(bg);
imshow(gray);

%%
% crop pieces out of image
white = gray(28:55, 399:437);
black = gray(28:55, 649:687);

% show cropped images
figure('Name','Piece Templates')
subplot(121);
imshow(white);
subplot(122);
imshow(black);
figure;

%%
% Apply normalized correlation (matched filtering)
% and find other pieces on board
w_nc = normxcorr2(white,gray);
b_nc = normxcorr2(black,gray);

% figure, surf(ncw), shading flat;
% figure, surf(ncb), shading flat;

% correlation maps for white and black pieces
figure(2), imshow(w_nc,[]);
figure(3), imshow(b_nc,[]);

%%
% find location of maxes for pieces 
% (we expect max to be 1 and min to be -1)
% play with threshold for different results!
thresh = 0.62;
w_thresh = thresh*max(w_nc(:));
b_thresh = thresh*max(b_nc(:));

[w_ypeak, w_xpeak] = find(w_nc>=w_thresh);
[b_ypeak, b_xpeak] = find(b_nc>=b_thresh);

% find offsets for bounding boxes
w_yoffSet = w_ypeak-size(white,1);
w_xoffSet = w_xpeak-size(white,2);

b_yoffSet = b_ypeak-size(black,1);
b_xoffSet = b_xpeak-size(black,2);

%display image and boxes
figure(4);
hold on;
imshow(bg);
for i = 1:size(w_xoffSet)
rectangle('Position', ...
    [w_xoffSet(i)+1, w_yoffSet(i)+1, size(white,2), size(white,1)], ...
    'EdgeColor','r');
rectangle('Position', ...
    [b_xoffSet(i)+1, b_yoffSet(i)+1, size(black,2), size(black,1)], ...
    'EdgeColor','b');
end
hold off

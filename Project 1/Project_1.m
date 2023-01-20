%% Project 1
%
% EE/CPE 428 - Computer Vision
% Winter 2023
%
% Group <#>: Chris Miglio, Eitan Klass, Nathan Jaggers
%
% Description: See coresponding document
%% Part A

% read and display image
im1 = imread("Sunflower.png")
imshow(im1)

% convert to grayscale
imgray = rgb2gray(im1)
% there is an extra stray column in the sunflower image
% for some reason here we are getting rid of it
% imgray = imgray(:,2:801)
% imshow(imgray)

%%
% max and min values with coordinates
[M,I] = max(imgray,[],"all")
[Y,X] = find(imgray == M)
%[Y,X] = ind2sub(size(imgray),I)

[M,I] = min(imgray,[],"all")
[Y,X] = ind2sub(size(imgray),I)

%%
% find size of image in bytes
[rows, cols] = size(imgray)
class(imgray)

%each pixle is a byte so area is size
bytes = rows*cols

imshow(imgray)

fileinfo = dir('graygroupreduced.jpeg')
filesize = fileinfo(1).bytes

%%
%reduce resolution of image
[rows, cols] = size(imgray)
small = imgray(2:2:rows,2:2:cols)

imshow(small)
[rows, cols] = size(small)
bytes = rows*cols

%%
%keep reducing
[rows, cols] = size(small)
smaller = small(2:2:rows,2:2:cols)

imshow(smaller)
[rows, cols] = size(smaller)
bytes = rows*cols

small = smaller;

%%
% Eitans Reduce
% Reduced quality of image
reduced = imgray(1:20:end, 1:20:end);
figure;
imshow(reduced);

%% Part B

imbacteria = imread("bacteria.bmp")
imshow(imbacteria)

threshold = 100
imthresh = imbacteria<threshold
imshow(imthresh)

imlabled = bwlabel(imthresh)
max(max(imlabled))
imshow(imlabled,[0,21])
%% Project 1
%
% EE/CPE 428 - Computer Vision
% Winter 2023
%
% Group 4: Chris Miglio, Eitan Klass, Nathan Jaggers
%
% Description: See coresponding document
%% Part A

% read and display image
im1 = imread("Sunflower.png")
imshow(im1)

%%
% convert to grayscale
imgray = rgb2gray(im1)
imshow(imgray)

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
%%
imagename = 'grayflower.png'
imwrite(imgray,imagename)

fileinfo = dir(imagename)
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
imagename = 'grayflowerreduced.png'
imwrite(small,imagename)

fileinfo = dir(imagename)
filesize = fileinfo(1).bytes

%% Part B

imbacteria = imread("bacteria.bmp")
imshow(imbacteria)

%%
threshold = 100
imthresh = imbacteria<threshold
imshow(imthresh)

% Compute the total area
area = bwarea(imthresh)
disp(area)

%%
imlabled = bwlabel(imthresh)
max(max(imlabled))
imshow(imlabled,[])

%%
%find the center of bacteria and print number there
stats = regionprops(imthresh,'Centroid')
centers = stats.Centroid
imshow(imthresh)
hold on
for x = 1: numel(stats)
    text(stats(x).Centroid(1),stats(x).Centroid(2), num2str(x), ...
        'Color',[1 0 0], 'FontWeight','bold','HorizontalAlignment','center')
end 

hold off
%%
% Get the area of each bacterium
for i = 1 : max(imlabled(:))
   area = bwarea(imlabled == i)
end

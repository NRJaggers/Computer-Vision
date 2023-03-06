%% Project 5
%
% EE/CPE 428 - Computer Vision
% Winter 2023
%
% Group 12: Nathan Jaggers, Fadi Alzammar, Ryan Geisen
%
% Description: See coresponding document <Can add description later>
%% Part A
close all;
clear;
clc;

%%
% read in images form folder
dataDir = "Part A Data/";
filePattern = fullfile(dataDir, "s*");
theFiles = dir(filePattern);
im = cell(20,1);

for k = 1:length(theFiles)
    imname = theFiles(k).name;
    im{k} = imread(dataDir + imname);
end

% go through images and resize them to min length and width
% this ends up squishing some of the images, should ask if this is okay or
% not
for i = 1:size(im,1)
    im{i} = imresize(im{i}, [183 259]);
    % use the following to display images one by one
    %imshow(im{i});
    %input("Next");
end

%%
% use ROIpoly to crop out areas of interest in image
% save masks in folder
% if mask already exsits, skip it
dataDir = "Part A Masks/";
filePattern = fullfile(dataDir, "m*");
theMasks = dir(filePattern);
masks = cell(20,1);
maskNames(1:20) = "";

for i = 1:length(theMasks)
    maskNames(i) = theMasks(i).name;
end

for i = 1:size(im,1)
    mask = sprintf("m%s.jpg",int2str(i));
    if (find(maskNames == mask))
        masks{i} = imread(dataDir + mask);
        masks{i} = (masks{i})>200;
        imshow(masks{i});
        input("Next");
    else
        masks{i} = roipoly(im{i});
        imshow(masks{i});
        maskName = sprintf("Part A Masks/%s",mask);
        imwrite(masks{i},maskName);
        input("Next");
    end

end

%%
% go through images with masks and create histogram of strawberry pixels vs
% non strawberry pixels for R, G and B

% store results of separating pixels by color and strawberry-ness
rgb_s = cell(3,1);
rgb_b = cell(3,1);

% loop through channels to isolate r, g and b values
for color = 1:3
    % loop through each image and mask. pull out strawberry and background
    % pixels
    for i = 1:length(im)
        c = (im{i}(:,:,color));
        % store strawberry and background pixels in different vectors
        c_s = c(masks{1} == 1);
        c_b = c(masks{1} == 0);

        %concatonate information from single image to total dataset
        rgb_s{color} = [rgb_s{color}; c_s];
        rgb_b{color} = [rgb_b{color}; c_b];

    end 
end

%%
% create histograms for RGB
figure('Name','Red');
histogram(rgb_s{1});
hold on;
histogram(rgb_b{1});
title('Red Value Histogram');
legend('Strawberry','Background');
hold off

figure('Name','Green');
histogram(rgb_s{2});
hold on;
histogram(rgb_b{2});
title('Green Value Histogram');
legend('Strawberry','Background');
hold off

figure('Name','Blue');
histogram(rgb_s{3});
hold on;
histogram(rgb_b{3});
title('Blue Value Histogram');
legend('Strawberry','Background');
hold off

%%


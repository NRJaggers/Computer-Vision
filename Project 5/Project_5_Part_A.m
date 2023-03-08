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
% this ends up squishing some of the images,
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
rgb_s = cell(3,1); rgb_b = cell(3,1);
hsv_s = cell(3,1); hsv_b = cell(3,1);

% loop through channels to isolate rgb or hsv values
for channel = 1:3
    % loop through each image and mask. pull out strawberry and background
    % pixels
    for i = 1:length(im)
        color = (im{i}(:,:,channel));
        alt = rgb2hsv(im{i});
        vector = alt(:,:,channel);
        % store strawberry and background pixels in different vectors
        c_s = double(color(masks{1} == 1));
        c_b = double(color(masks{1} == 0));

        v_s = double(vector(masks{1} == 1));
        v_b = double(vector(masks{1} == 0));
        %concatonate information from single image to total dataset
        rgb_s{channel} = [rgb_s{channel}; c_s];
        rgb_b{channel} = [rgb_b{channel}; c_b];
        
        hsv_s{channel} = [hsv_s{channel}; v_s];
        hsv_b{channel} = [hsv_b{channel}; v_b];

    end 
end

%%
% create histograms for RGB
figure('Name','Red');
histogram(rgb_s{1});
hold on;
histogram(rgb_b{1});
title('Red Histogram');
legend('Strawberry','Background');
hold off

figure('Name','Green');
histogram(rgb_s{2});
hold on;
histogram(rgb_b{2});
title('Green Histogram');
legend('Strawberry','Background');
hold off

figure('Name','Blue');
histogram(rgb_s{3});
hold on;
histogram(rgb_b{3});
title('Blue Histogram');
legend('Strawberry','Background');
hold off

%%
% now create histograms for normalized rgb
n_rgb_s = cell(3,1);
n_rgb_b = cell(3,1);

n_rgb_s{1} = rgb_s{1}./(rgb_s{1} + rgb_s{2} + rgb_s{3});
n_rgb_s{2} = rgb_s{2}./(rgb_s{1} + rgb_s{2} + rgb_s{3});
n_rgb_s{3} = rgb_s{3}./(rgb_s{1} + rgb_s{2} + rgb_s{3});

n_rgb_b{1} = rgb_b{1}./(rgb_b{1} + rgb_b{2} + rgb_b{3});
n_rgb_b{2} = rgb_b{2}./(rgb_b{1} + rgb_b{2} + rgb_b{3});
n_rgb_b{3} = rgb_b{3}./(rgb_b{1} + rgb_b{2} + rgb_b{3});

%%
% create histograms for normalized RGB
figure('Name','Norm Red');
histogram(n_rgb_s{1});
hold on;
histogram(n_rgb_b{1});
title('Normalized Red Histogram');
legend('Strawberry','Background');
hold off

figure('Name','Norm Green');
histogram(n_rgb_s{2});
hold on;
histogram(n_rgb_b{2});
title('Normalized Green Histogram');
legend('Strawberry','Background');
hold off

figure('Name','Norm Blue');
histogram(n_rgb_s{3});
hold on;
histogram(n_rgb_b{3});
title('Normalized Blue Histogram');
legend('Strawberry','Background');
hold off

%%
% create offset Hue vector to see red values together on histogram
offset = 0.1;
offset_hue_s = size(hsv_s{1});
for counter = 1:length(hsv_s{1})
    if (hsv_s{1}(counter) + offset) <= 1
        offset_hue_s(counter) = hsv_s{1}(counter) + offset;
    else
        offset_hue_s(counter) = hsv_s{1}(counter) - (1-offset);
    end
end

offset_hue_b = size(hsv_b{1});
for counter = 1:length(hsv_b{1})
    if (hsv_b{1}(counter) + offset) <= 1
        offset_hue_b(counter) = hsv_b{1}(counter) + offset;
    else
        offset_hue_b(counter) = hsv_b{1}(counter) - (1-offset);
    end
end
%%
% create histograms for HSV
figure('Name','Hue');
histogram(hsv_s{1});
hold on;
histogram(hsv_b{1});
title('Hue Histogram');
legend('Strawberry','Background');
hold off

figure('Name','Offset Hue');
histogram(offset_hue_s);
hold on;
histogram(offset_hue_b);
title('Offset Hue Histogram');
legend('Strawberry','Background');
hold off

figure('Name','Saturation');
histogram(hsv_s{2});
hold on;
histogram(hsv_b{2});
title('Saturation Histogram');
legend('Strawberry','Background');
hold off

figure('Name','Value');
histogram(hsv_s{3});
hold on;
histogram(hsv_b{3});
title('Value Histogram');
legend('Strawberry','Background');
hold off

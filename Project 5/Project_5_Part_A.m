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
%figure('Name','Red');
figure('Name','Histograms');
subplot(3,1,1);
histogram(rgb_s{1},'FaceColor','#E33D61');
hold on;
histogram(rgb_b{1},'FaceColor',[0.4660 0.6740 0.1880]);
title('Red Histogram');
xlabel("Color Value");
ylabel("Pixels");
legend('Strawberry','Background');
hold off

%figure('Name','Green');
subplot(3,1,2);
histogram(rgb_s{2},'FaceColor','#E33D61');
hold on;
histogram(rgb_b{2},'FaceColor',[0.4660 0.6740 0.1880]);
title('Green Histogram');
xlabel("Color Value");
ylabel("Pixels");
legend('Strawberry','Background');
hold off

%figure('Name','Blue');
subplot(3,1,3);
histogram(rgb_s{3},'FaceColor','#E33D61');
hold on;
histogram(rgb_b{3},'FaceColor',[0.4660 0.6740 0.1880]);
title('Blue Histogram');
xlabel("Color Value");
ylabel("Pixels");
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
%figure('Name','Norm Red');
figure('Name','Normalized RGB');
subplot(3,1,1);
histogram(n_rgb_s{1},'FaceColor','#E33D61');
hold on;
histogram(n_rgb_b{1},'FaceColor',[0.4660 0.6740 0.1880]);
title('Normalized Red Histogram');
xlabel("Color Value");
ylabel("Pixels");
legend('Strawberry','Background');
hold off

%figure('Name','Norm Green');
subplot(3,1,2);
histogram(n_rgb_s{2},'FaceColor','#E33D61');
hold on;
histogram(n_rgb_b{2},'FaceColor',[0.4660 0.6740 0.1880]);
title('Normalized Green Histogram');
xlabel("Color Value");
ylabel("Pixels");
legend('Strawberry','Background');
hold off

%figure('Name','Norm Blue');
subplot(3,1,3);
histogram(n_rgb_s{3},'FaceColor','#E33D61');
hold on;
histogram(n_rgb_b{3},'FaceColor',[0.4660 0.6740 0.1880]);
title('Normalized Blue Histogram');
xlabel("Color Value");
ylabel("Pixels");
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
%figure('Name','Hue');
figure('Name','HSV Histogram');
subplot(2,2,1);
histogram(hsv_s{1},'FaceColor','#E33D61');
hold on;
histogram(hsv_b{1},'FaceColor',[0.4660 0.6740 0.1880]);
title('Hue Histogram');
xlabel("Hue Value");
ylabel("Pixels");
legend('Strawberry','Background');
hold off

%figure('Name','Offset Hue');
subplot(2,2,2);
histogram(offset_hue_s,'FaceColor','#E33D61');
hold on;
histogram(offset_hue_b,'FaceColor',[0.4660 0.6740 0.1880]);
title('Offset Hue Histogram');
xlabel("Hue Value");
ylabel("Pixels");
legend('Strawberry','Background');
hold off

%figure('Name','Saturation');
subplot(2,2,3);
histogram(hsv_s{2},'FaceColor','#E33D61');
hold on;
histogram(hsv_b{2},'FaceColor',[0.4660 0.6740 0.1880]);
title('Saturation Histogram');
xlabel("Saturation Value");
ylabel("Pixels");
legend('Strawberry','Background');
hold off

%figure('Name','Value');
subplot(2,2,4);
histogram(hsv_s{3},'FaceColor','#E33D61');
hold on;
histogram(hsv_b{3},'FaceColor',[0.4660 0.6740 0.1880]);
title('Value Histogram');
xlabel("Value");
ylabel("Pixels");
legend('Strawberry','Background');
hold off

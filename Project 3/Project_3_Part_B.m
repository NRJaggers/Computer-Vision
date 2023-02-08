%% Project 3
%
% EE/CPE 428 - Computer Vision
% Winter 2023
%
% Group 1: Nathan Jaggers, Fadi Alzammar, Eitan Klass
%
% Description: See coresponding document <Can add description later>
%% Part B
close all;
clear;
clc;

%%
% load images
figure(1)
all = imread("all_signs.jpg");
subplot(2,2,1);
imshow(all);
rock = imread("rock.jpg");
subplot(2,2,2);
imshow(rock);
paper = imread("paper.jpg");
subplot(2,2,3);
imshow(paper);
scissors = imread("scissors.jpg");
subplot(2,2,4);
imshow(scissors);

% grayscale image
figure(2)
gray_all = rgb2gray(all);
subplot(2,2,1);
imshow(gray_all);
gray_rock = rgb2gray(rock);
subplot(2,2,2);
imshow(gray_rock);
gray_paper = rgb2gray(paper);
subplot(2,2,3);
imshow(gray_paper);
gray_scissors = rgb2gray(scissors);
subplot(2,2,4);
imshow(gray_scissors);

%%
% create templates
figure(3)
template_rock = gray_all(1558:2193,236:882);
subplot(1,3,1);
imshow(template_rock);
template_paper = gray_all(1545:2656,1230:2169);
subplot(1,3,2);
imshow(template_paper);
template_scissors = gray_all(1665:2941,2890:3791);
subplot(1,3,3);
imshow(template_scissors);

%%
nc_rock = normxcorr2(template_rock,gray_rock);
nc_paper = normxcorr2(template_paper,gray_paper);
nc_scissors = normxcorr2(template_scissors,gray_scissors);

figure(4)
subplot(1,3,1);
imshow(nc_rock,[]);
subplot(1,3,2);
imshow(nc_paper,[]);
subplot(1,3,3);
imshow(nc_scissors,[]);

%%
thresh = 0.9;
r_thresh = thresh*max(nc_rock(:));
p_thresh = thresh*max(nc_paper(:));
s_thresh = thresh*max(nc_scissors(:));

[r_ypeak, r_xpeak] = find(nc_rock>=r_thresh);
[p_ypeak, p_xpeak] = find(nc_paper>=p_thresh);
[s_ypeak, s_xpeak] = find(nc_scissors>=s_thresh);

r_yoffSet = r_ypeak-size(template_rock,1);
r_xoffSet = r_xpeak-size(template_rock,2);

p_yoffSet = p_ypeak-size(template_paper,1);
p_xoffSet = p_xpeak-size(template_paper,2);

s_yoffSet = s_ypeak-size(template_scissors,1);
s_xoffSet = s_xpeak-size(template_scissors,2);

%%
%display rock image and boxes
figure(5);
hold on;
imshow(rock);
for i = 1:size(r_xoffSet)
rectangle('Position', ...
    [r_xoffSet(i)+1, r_yoffSet(i)+1, size(template_rock,2), size(template_rock,1)], ...
    'EdgeColor','r');
end
hold off

%%
%display rock paper and boxes
figure(6);
hold on;
imshow(paper);
for i = 1:size(p_xoffSet)
rectangle('Position', ...
    [p_xoffSet(i)+1, p_yoffSet(i)+1, size(template_paper,2), size(template_paper,1)], ...
    'EdgeColor','r');
end
hold off

%%
%display rock scissors and boxes
figure(7);
hold on;
imshow(scissors);
for i = 1:size(s_xoffSet)
rectangle('Position', ...
    [s_xoffSet(i)+1, s_yoffSet(i)+1, size(template_scissors,2), size(template_scissors,1)], ...
    'EdgeColor','r');
end
hold off
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
peak = match_template(gray_rock, template_rock, 0.75);
[ypeak, xpeak] = find(peak>=1);
yoffSet = ypeak-size(template_rock,1);
xoffSet = xpeak-size(template_rock,2);
%%
%display rock image and boxes
figure();
hold on;
imshow(rock);
for i = 1:size(xoffSet)
rectangle('Position', ...
    [xoffSet(i)+1, yoffSet(i)+1, size(template_rock,2), size(template_rock,1)], ...
    'EdgeColor','r');
end
hold off

%%
peak = match_template(gray_paper, template_paper, 0.85);
[ypeak, xpeak] = find(peak>=1);
yoffSet = ypeak-size(template_paper,1);
xoffSet = xpeak-size(template_paper,2);
%%
%display rock paper and boxes
figure();
hold on;
imshow(paper);
for i = 1:size(xoffSet)
rectangle('Position', ...
    [xoffSet(i)+1, yoffSet(i)+1, size(template_paper,2), size(template_paper,1)], ...
    'EdgeColor','r');
end
hold off

%%
peak = match_template(gray_scissors, template_scissors, 0.86);
[ypeak, xpeak] = find(peak>=1);
yoffSet = ypeak-size(template_scissors,1);
xoffSet = xpeak-size(template_scissors,2);
%%
%display rock scissors and boxes
figure();
hold on;
imshow(scissors);
for i = 1:size(xoffSet)
rectangle('Position', ...
    [xoffSet(i)+1, yoffSet(i)+1, size(template_scissors,2), size(template_scissors,1)], ...
    'EdgeColor','r');
end
hold off


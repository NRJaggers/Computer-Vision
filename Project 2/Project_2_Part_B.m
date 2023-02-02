%% Project 2
%
% EE/CPE 428 - Computer Vision
% Winter 2023
%
% Group 4: Nathan Jaggers, Addison Sandvik, Matthew Palma
%
% Description: See coresponding document <Can add description later>
% Cannot use imfilter, can use fspecial
%% Part B
close all
clear
clc

%% PB-1
% load image
image = imread("corner_window.jpg");
imshow(image)

%%
% grayscale image
gray = rgb2gray(image);
imshow(gray)

%%
% create Prewitt and sobel kernels

% Prewitt horizontal [1 1 1;0 0 0;-1 -1 -1]
Px = fspecial("prewitt");
Py = Px';

% Sobel horizontal [1 2 1;0 0 0;-1 -2 -1]
Sx = fspecial("sobel");
Sy = Sx';

%%
% filter horizontal and vertical edges 
% and combine results
Gx = linearfilter(gray,Px);
%imshow(Gx);
Gy = linearfilter(gray,Py);
%imshow(Gy);

G = abs(Gx) + abs(Gy);
imshow(G)

%%
% threshold final results
threshold = 50;
edges = G > threshold;
imshow(edges);

%%
% filter horizontal and vertical edges 
% and combine results
Gx = linearfilter(gray,Sx);
%imshow(Gx);
Gy = linearfilter(gray,Sy);
%imshow(Gy);

G = abs(Gx) + abs(Gy);
imshow(G)

%%
% threshold final results
threshold = 80;
edges = G > threshold;
imshow(edges);

%% PB-2
% load image
image = imread("New York City.jpg");
imshow(image)

%%
% grayscale image
gray = rgb2gray(image);
imshow(gray)

%%
% LoG kernel
s1 = fspecial("log",5,0.5)
s2 = fspecial("log",5,1.0)
s3 = fspecial("log",5,1.2)

%%
%filter image
G = linearfilter(gray,s1);
imshow(G)
%%
G = linearfilter(gray,s2);
imshow(G)
%%
G = linearfilter(gray,s3);
imshow(G)

%% PB-3
% load image
image = imread("bike-lane.jpg");
imshow(image)

%%
% grayscale image
gray = rgb2gray(image);
imshow(gray)

%%
G = edge(gray,'canny',0.5,2);
imshow(G)

%% PB-4

[H,T,R] = hough(G);
P  = houghpeaks(H,5,'threshold',ceil(0.3*max(H(:))));

% Find lines and plot them
lines = houghlines(G,T,R,P,'FillGap',5,'MinLength',7);
figure, imshow(gray), hold on

for k = 1:length(lines)
 xy = [lines(k).point1; lines(k).point2];
 plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');

 % plot beginnings and ends of lines
 plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
 plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');
end

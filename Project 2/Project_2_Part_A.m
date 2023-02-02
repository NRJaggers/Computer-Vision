%% Project 2
%
% EE/CPE 428 - Computer Vision
% Winter 2023
%
% Group 4: Nathan Jaggers, Addison Sandvik, Matthew Palma
%
% Description: See coresponding document <Can add description later>
% Cannot use imfilter, can use fspecial
%% Part A
close all
clear
clc

%%
% filter boat
figure("Name","Boat Comparison")
boat = imread("Boat2.tif")
subplot(3,4,1)
imshow(boat)
title('Original')

%%
% linear - averaging 3x3
H = fspecial("average")
faboat3x3 = linearfilter(boat,H)
subplot(3,4,3)
imshow(faboat3x3)
title('Avg 3x3')

%%
% linear - averaging 5x5
H = fspecial("average",5)
faboat5x5 = linearfilter(boat,H)
subplot(3,4,4)
imshow(faboat5x5)
title('Avg 5x5')

%%
% linear - gaussian 3x3
H = fspecial("gaussian")
fgboat3x3 = linearfilter(boat,H)
subplot(3,4,5)
imshow(fgboat3x3)
title('Gaussian 3x3')

%%
% linear - gaussian 5x5
H = fspecial("gaussian",5,1)
fgboat5x5 = linearfilter(boat,H)
subplot(3,4,6)
imshow(fgboat5x5)
title('Gaussian 5x5')

%%
% nonlinear - median 3x3
fmboat3x3 = nonlinearfilter("median",boat,3,3)
subplot(3,4,7)
imshow(fmboat3x3)
title('Median 3x3')

%%
% nonlinear - median 5x5
fmboat5x5 = nonlinearfilter("median",boat,3,3)
subplot(3,4,8)
imshow(fmboat5x5)
title('Median 5x5')

%%
% nonlinear - max and/or min?
fmaxboat3x3 = nonlinearfilter("max",boat,3,3)
subplot(3,4,9)
imshow(fmaxboat3x3)
title('Max 3x3')

%%
fmaxboat5x5 = nonlinearfilter("max",boat,5,5)
subplot(3,4,10)
imshow(fmaxboat5x5)
title('Max 5x5')

%%
fminboat3x3 = nonlinearfilter("min",boat,3,3)
subplot(3,4,11)
imshow(fminboat3x3)
title('Min 3x3')

%%
fminboat5x5 = nonlinearfilter("min",boat,5,5)
subplot(3,4,12)
imshow(fminboat5x5)
title('Min 5x5')

%%
% filter building
figure("Name","Building Comparison")
bldg = imread("building.gif")
subplot(3,4,1)
imshow(bldg)
title('Original')

%%
% linear - averaging 3x3
H = fspecial("average")
fabldg3x3 = linearfilter(bldg,H)
subplot(3,4,3)
imshow(fabldg3x3)
title('Avg 3x3')

%%
% linear - averaging 5x5
H = fspecial("average",5)
fabldg5x5 = linearfilter(bldg,H)
subplot(3,4,4)
imshow(fabldg5x5)
title('Avg 5x5')

%%
% linear - gaussian 3x3
H = fspecial("gaussian")
fgbldg3x3 = linearfilter(bldg,H)
subplot(3,4,5)
imshow(fgbldg3x3)
title('Gaussian 3x3')

%%
% linear - gaussian 5x5
H = fspecial("gaussian",5,1)
fgbldg5x5 = linearfilter(bldg,H)
subplot(3,4,6)
imshow(fgbldg5x5)
title('Gaussian 5x5')

%%
% nonlinear - median 3x3
fmbldg3x3 = nonlinearfilter("median",bldg,3,3)
subplot(3,4,7)
imshow(fmbldg3x3)
title('Median 3x3')

%%
% nonlinear - median 5x5
fmbldg5x5 = nonlinearfilter("median",bldg,3,3)
subplot(3,4,8)
imshow(fmbldg5x5)
title('Median 5x5')

%%
% nonlinear - max and/or min?
fmaxbldg3x3 = nonlinearfilter("max",bldg,3,3)
subplot(3,4,9)
imshow(fmaxbldg3x3)
title('Max 3x3')

%%
fmaxbldg5x5 = nonlinearfilter("max",bldg,5,5)
subplot(3,4,10)
imshow(fmaxbldg5x5)
title('Max 5x5')

%%
fminbldg3x3 = nonlinearfilter("min",bldg,3,3)
subplot(3,4,11)
imshow(fminbldg3x3)
title('Min 3x3')

%%
fminbldg5x5 = nonlinearfilter("min",bldg,5,5)
subplot(3,4,12)
imshow(fminbldg5x5)
title('Min 5x5')



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

% filter boat
boat = imread("Boat2.tif")
imshow(boat)

%%
% linear - averaging 3x3
H = fspecial("average")
faboat3x3 = linearfilter(boat,H)
imshow(faboat3x3)

%%
% linear - averaging 5x5
H = fspecial("average",5)
faboat5x5 = linearfilter(boat,H)
imshow(faboat5x5)

%%
% linear - gaussian 3x3
H = fspecial("gaussian")
fgboat3x3 = linearfilter(boat,H)
imshow(fgboat3x3)

%%
% linear - gaussian 5x5
H = fspecial("gaussian",5,1)
fgboat5x5 = linearfilter(boat,H)
imshow(fgboat5x5)

%%
% nonlinear - median 3x3
fmboat3x3 = medianfilter(boat,3,3)
imshow(fmboat3x3)

%%
% nonlinear - median 5x5
fmboat3x3 = medianfilter(boat,5,5)
imshow(fmboat3x3)

%%
% nonlinear - max and/or min?
fmaxboat3x3 = nonlinearfilter("max",boat,3,3)
imshow(fmaxboat3x3)

%%
fmaxboat3x3 = nonlinearfilter("max",boat,5,5)
imshow(fmaxboat3x3)

%%
fmaxboat3x3 = nonlinearfilter("min",boat,3,3)
imshow(fmaxboat3x3)

%%
fmaxboat3x3 = nonlinearfilter("min",boat,5,5)
imshow(fmaxboat3x3)

%%
% create comparison subplots

%%
% filter building
building = imread("building.gif")
imshow(building)


%% Part B






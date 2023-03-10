%% Project 5
%
% EE/CPE 428 - Computer Vision
% Winter 2023
%
% Group 12: Nathan Jaggers, Fadi Alzammar, Ryan Geisen
%
% Description: See coresponding document <Can add description later>
%% Part B
close all;
clear;
clc;

%%
% read in images from folder
dataDir = "Part B Data/";
filePattern = fullfile(dataDir, "t*");
theFiles = dir(filePattern);
im = cell(length(theFiles),1);

for k = 1:length(theFiles)
    imname = theFiles(k).name;
    im{k} = imread(dataDir + imname);
end

%%
% select size for K
K = 5;
im_segmented_k = cell(length(im),1);
k_centroid = cell(length(im),1);
im_segmented_em = cell(length(im),1);


%%
% run the k means and EM algorithms for each image
for i = 1:length(im)
    % grab row and columns to reshape image
    [m,n]=size(im{i}(:,:,1));
    X=reshape(im{i},m*n,3);

    
    % create kmeans results
    [X_clustered, k_centroid{i}] = kmeans(double(X),K);
    im_segmented_k{i}=reshape(X_clustered, m,n);

%     % create EM results
%     X_dist=fitgmdist(double(X),K);
%     X_clustered=cluster(X_dist,double(X)); 
%     
%     im_segmented_em{i}=reshape(X_clustered, m,n);

end

fprintf("Done");

%%
% show k means results
for i = 1:length(im_segmented_k)
    imshow(im_segmented_k{i},[]);
    input("Next");
end

%%
% show centroid colors and values
for i = 1:length(k_centroid)
    for segment = 1:length(k_centroid{i})
        show_color(k_centroid{i}(segment,:));
    end
    k_centroid{i}
    input("Next");
end

%% delete this test later
for segment = 1:length(k_centroid{1})
    show_color(k_centroid{1}(segment,:));
end
k_centroid{1}
%%
%row 1 in Km1 is red
%can use if statment later, for now hard code
redSegment = 0;

% go through all the segments and pick out the best red
% so far if there is no good red, redSeg stays 0
for segment = 1:length(k_centroid{1})
    if redSegment == 0
        %if r is above certain threshold and bg are below threshold
        if (k_centroid{1}(segment,1)>150)&&(k_centroid{1}(segment,2)<100)&&(k_centroid{1}(segment,3)<100)
            redSegment = segment;
        end
    else
        %if r is above certain threshold and bg are below threshold
        if (k_centroid{1}(segment,1)>k_centroid{1}(redSegment,1))&&(k_centroid{1}(segment,2)<k_centroid{1}(redSegment,2))&&(k_centroid{1}(segment,3)<k_centroid{1}(redSegment,3))
            redSegment = segment;
        end
    end 
    
end


%%
% select a segment from kmeans and use it to create a binary image
strawberryBW = im_segmented_k{1} == redSegment;
imshow(strawberryBW,[]);

%%
% use this binary image with bwconncomp to find strawberry bodies
% CC = bwconncomp(BW)
CC = bwconncomp(strawberryBW);
% use regionprops to find centers of bodies ...
% stats = regionprops(CC,'Centroid')
% centers = stats.Centroid
centers = regionprops(CC, 'Centroid');
stats = regionprops(CC, "Area", 'BoundingBox','Centroid');
bb = stats(find([stats.Area] > 80000));
%%
% Can then use centroid to bound strawberries
% or you can use technique described here maybe?:
% https://www.mathworks.com/matlabcentral/answers/87597-rectangle-around-the-object-bounding-box
imshow(im{1});
hold on
for k = 1 : length(bb)
  thisBB = bb(k).BoundingBox;
  rectangle('Position', [thisBB(1),thisBB(2),thisBB(3),thisBB(4)],...
  'EdgeColor','white','LineWidth',2 )
  text(bb(k).Centroid(1),bb(k).Centroid(2), num2str(k), ...
    'Color','white', 'FontWeight','bold','HorizontalAlignment','center');
end
%%
% run the k means and EM algorithms for each image
for i = 1:length(im)
    % grab row and columns to reshape image
    [m,n]=size(im{i}(:,:,1));
    X=reshape(im{i},m*n,3);
    
%     % create kmeans results
%     X_clustered=kmeans(double(X),K);
%     im_segmented_k{i}=reshape(X_clustered, m,n);

    % create EM results
    X_dist=fitgmdist(double(X),K);
    X_clustered=cluster(X_dist,double(X));
    
    im_segmented_em{i}=reshape(X_clustered, m,n);

end

fprintf("Done");
%%
% show EM results
for i = 1:length(im_segmented_em)
    imshow(im_segmented_em{i},[]);
    input("Next");
end

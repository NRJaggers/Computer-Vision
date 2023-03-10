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

%%
redSegment = zeros(6,1);

for i = 1:length(k_centroid)
    redSegment(i) = 0;
    % go through all the segments and pick out the best red
    % so far if there is no good red, redSeg stays 0
    for segment = 1:length(k_centroid{i})
        if (redSegment(i)) == 0
            %if r is above certain threshold and bg are below threshold
            if (k_centroid{i}(segment,1)>100)&&(k_centroid{i}(segment,2)<120)&&(k_centroid{i}(segment,3)<120)
                redSegment(i) = segment;
            end
        else
            %if r is above certain threshold and bg are below threshold
            if (k_centroid{i}(segment,1)>k_centroid{i}(redSegment(i),1))&&(k_centroid{i}(segment,2)<k_centroid{i}(redSegment(i),2))&&(k_centroid{i}(segment,3)<k_centroid{i}(redSegment(i),3))
                redSegment(i) = segment;
            end
        end     
    end
end


%%
% select a segment from kmeans and use it to create a binary image
strawberryBW = cell(length(redSegment),1);
for i = 1:length(redSegment)
    strawberryBW{i} = im_segmented_k{i} == (redSegment(i));
    figure();
    imshow(strawberryBW{i},[]);
    input("Next");
end

%%
minsize = [80000 500 8000 500 100 100];
for i = 1:length(strawberryBW)
    box_objectBW(im{i},strawberryBW{i},minsize(i));
end

%%
K = 3;
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

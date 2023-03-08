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
% read in images form folder
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
K = 4;
im_segmented_k = cell(length(im),1);
im_segmented_em = cell(length(im),1);

%%
% run the k means and EM algorithms for each image
for i = 1:length(im)
    % grab row and columns to reshape image
    [m,n]=size(im{i}(:,:,1));
    X=reshape(im{i},m*n,3);
    
    % create kmeans results
    X_clustered=kmeans(double(X),K);
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

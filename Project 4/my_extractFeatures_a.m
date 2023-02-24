function [extracted_features, Locations] = my_extractFeatures_a(image, detected_pts)
%  Function that extracts the feature vector from the detected keypoints
%  
% detected points are how many points you want detected in the image

%%
% check image passed into function and ensure it is grayscale
gray = check_grayscale(image);

% check that detected keypoints doesn't exceed 100
if detected_pts > 100
    fprintf("Max allowed detected points is 100\n");
    detected_pts = 100;
end

% use detectSURFFeatures(I) or detectFASTFeatures(I) to detect features 
% in an image. I must be a 2D grayscale image
keypoints = detectSURFFeatures(gray);

% keep only strongest amount of points desired
strongPoints = keypoints.selectStrongest(detected_pts);

% grab locations for strongets pixels
Locations = strongPoints.Location;
y = uint32(Locations(:, 1));
x = uint32(Locations(:, 2));

extracted_features = [];
for i = 1 : detected_pts
    tempMat = gray(x(i)-2:x(i)+2, y(i)-2:y(i)+2);
    extracted_features = [extracted_features tempMat(:)];
end
function extracted_features = my_extractFeatures_a(image, detected_pts)
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
L = strongPoints.Location;
y = uint32(L(:, 1));
x = uint32(L(:, 2));

extracted_features = [];
for i = 1 : detected_pts
    % make start and stop coord for 16x16 cell?
    start = [x(i)-7 y(i)-7];
    stop = [x(i)+8 y(i)+8];

    % loop through cells
    for cell = 0 : cell < 16
        

        % loop through rows
        for row = 1 : row <= 4

            % loop through columns
            for col = 1 : col <= 4


            % compute gradient magnitude and direction (and suppress weak edges)

            % accumulate results in bin 
            
            end
        end

    % when finished with a cell, concat to results for keypoint?

    % increment cell start position
    start 
    
    end

    % concat all key points?
    
end
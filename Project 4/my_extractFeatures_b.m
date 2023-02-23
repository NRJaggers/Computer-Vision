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

% Notes:
% can do sobel/prewit on whole image before loop and generate Gx & Gy
% then use Gx Gy with locations of key points to make descriptors
% can use built in functions to help get gradient info 
% (imgradient and imgradientxy)

% prepare Gx and Gy gradients of original image
[Gx, Gy] = imgradientxy(gray);

extracted_features = [];
for i = 1 : detected_pts
    % make start and stop coord for 16x16 cell?
    start = [x(i)-7 y(i)-7];
    stop = [x(i)+8 y(i)+8];

    % loop through cells
    for cell = 0 : cell < 16
        

        % loop through rows
        for row = row_start : row <= 4

            % loop through columns
            for col = col_start : col <= 4
                %get pixel and neighbors (3x3 matrix)
                M = gray(col-1:col+1, row-1:row+1);

                % compute gradient magnitude and direction 
                % (and suppress weak edges)
                % use prewit or sobel
                Gx = sum(M.*Sx,"all");
                Gy = sum(M.*Sy,"all");

                G = abs(Gx) + abs(Gy);
                theta = atan(Gy/Gx);

                % accumulate results in bin 
            
            end
        end

    % when finished with a cell, concat to results for keypoint?

    % increment cell start position
    start 
    
    end

    % concat all key points?
    
end
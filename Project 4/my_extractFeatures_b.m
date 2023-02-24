function [feature, Locations] = my_extractFeatures_a(image, detected_pts)
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

% Notes:
% can do sobel/prewit on whole image before loop and generate Gx & Gy
% then use Gx Gy with locations of key points to make descriptors
% can use built in functions to help get gradient info 
% (imgradient and imgradientxy)

% prepare Gx and Gy gradients of original image
[Gx, Gy] = imgradientxy(gray);

extracted_features = {};
feature = [];
for i = 1 : detected_pts  
    % pull out 16x16 from Gx and Gy
    subGx = Gx(x(i)-7:x(i)+8, y(i)-7:y(i)+8);
    subGy = Gy(x(i)-7:x(i)+8, y(i)-7:y(i)+8);

    % compute gradient magnitude and direction
    [subG, theta] = imgradient(subGx, subGx);

    % iterate through cells, rows and columns and sort results in bins
    descriptor = [];
    for cell_row = 0:3
        for cell_col = 0:3
            cellMag = subG((cell_row*4)+1:(cell_row*4)+4,(cell_col*4)+1:(cell_col*4)+4);
            celltheta = theta((cell_row*4)+1:(cell_row*4)+4,(cell_col*4)+1:(cell_col*4)+4);
            hist = zeros(8,1);
            for row = 1:4
                for col = 1:4
                    % converting from -180-180 to 0-360
                    celltheta(row,col)= celltheta(row,col) + 180; 
                    % base bin number of of data, div by 45 gives 8
                    % directions
                    bin = fix(celltheta(row,col)/45)+1;

                    %store results in vector
                    hist(bin) = hist(bin) + cellMag(row,col);
                end
            end
            descriptor = cat(2,descriptor, hist);

        end
    end
    extracted_features{i}=descriptor;
    feature = [feature descriptor(:)];
end
function [output, matchingLocation1, matchingLocation2] = feature_matching(keypoints1, keypoints2, locations1, locations2)
    % compare the keypoints of two images
    % inputs are keypoint vectors from two images
    points = [];
    matchingLocation1 = [];
    matchingLocation2 = [];
    for i=1:size(keypoints1,2) % keypoints of image 1
        match = 2000; % threshold
        bestLocation1 = [-1 -1];
        bestLocation2 = [-1 -1];
        for j=1:size(keypoints2,2)  % keypoints of image 2
            distance = feature_distance(keypoints1(:,i), keypoints2(:,j));
            if distance < match
                match = distance;
                bestLocation1 = locations1(i,:);
                bestLocation2 = locations1(j,:);

            end
        end
        points = [points match];
        matchingLocation1 = [matchingLocation1;bestLocation1];
        matchingLocation2 = [matchingLocation2;bestLocation2];

    end
    output = points;
end

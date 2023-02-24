function [output] = feature_matching(cell1, cell2)
    % compare the 100 keypoints of two images
    % inputs are cell vectors of length 100 containing the
    % feature descriptors
    points = zeros(1,100)
    for i=1:100 % keypoints of image 1
        match = 1000; % threshold
        for j=1:100  % keypoints of image 2
            distance = feature_distance(cell1{i}, cell2{j});
            if distance < match;
                match = distance;
                points(i) = j;
                % if index value is left a 0,
                % then no good match was found
            end              
        end
    end
    % index corresponds to location on image 1
    % stored value corresponds to location on image 2
    output = points;
end

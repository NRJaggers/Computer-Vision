function [output] = feature_distance(vect1, vect2)
    % find euclidean distance between two vectors
    % for vector of length 128
    sum = 0;
    for i=1:128
        sum = sum + ((vect1(i) - vect2(i))^2);
    end
    output = sqrt(sum);
end

function [output] = feature_distance(vect1, vect2)
    % find euclidean distance between two vectors
    
    if size(vect1) == size(vect2)        
        sum = 0;
        for i=1:numel(vect1)
            sum = sum + ((vect1(i) - vect2(i))^2);
        end
        output = sqrt(double(sum));
    else
        fprintf("Size of vectors are different");
        ouput = -1;
    end

end

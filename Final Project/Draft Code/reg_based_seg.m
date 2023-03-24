function object = reg_based_seg(gray_img, k)
    %% Region-based segmentation using K-means
    % Input: gray_img - grayscale image
    %        k - the k value for k-means
    % Output: object - binary image containing the extracted object

    % Apply k-means clustering
    kmeans_img = kmeans(gray_img(:), k, 'MaxIter', 100000, 'Replicates', 5);
    kmeans_img = reshape(kmeans_img, size(gray_img));
    imshow(kmeans_img)
    figure;
    
    % Convert the segmented image to a binary image
    bin_img = imbinarize(kmeans_img);
    imshow(bin_img)
    figure;
    
    % Clean up the binary image
    clean_img = bwareaopen(bin_img, 100);
    clean_img = imfill(clean_img, 'holes');
    
    % Extract the object of interest
    object = bwpropfilt(clean_img, 'Area', 1, 'Largest');
end


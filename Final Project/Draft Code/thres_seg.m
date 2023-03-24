function object = thres_seg(gray_img, threshold, background)
    %% Thresholding Segmentation
    % Input: gray_img - grayscale image
    %        threshold - the threshold
    %        background - 1 for white, 0 for black
    % Output: object - binary image containing the extracted object
    
    % Threshold image
    if background
        % White background
        t_img = gray_img < threshold;
    else
        % Black background
        t_img = gray_img > threshold;
    end

%     imshow(t_img)
%     figure;
    
    % Clean up the binary image
    clean_img = bwareaopen(t_img, 100);
%     imshow(clean_img)
%     figure;

    clean_img = imfill(clean_img, 'holes');
%     imshow(clean_img)
%     figure;
    
    % Extract the object of interest
    object = bwpropfilt(clean_img, 'Area', 1, 'Largest');
end


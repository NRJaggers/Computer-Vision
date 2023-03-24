function object = edge_based_seg(gray_img)
    %% Edge-based segmentation using the Sobel edge detector
    % Input: gray_img - grayscale image
    % Output: object - binary image containing the extracted object

    % Apply the Sobel edge detection filter
    edge_img = edge(gray_img, 'prewitt');

    % Clean up the edge image
    clean_img = bwareaopen(edge_img, 25);

    % Convert the edge image to a binary image (if it's not binary already)
    if ~islogical(clean_img)
        bin_img = imbinarize(clean_img);
    else
        bin_img = clean_img;
    end

    % Clean up the binary image
    %clean_img = bwareaopen(bin_img, 100);

    % Close the gaps between the lines
    closed_img = imclose(bin_img, strel('disk', 25));
%     imshow(closed_img)
%     figure;

    % Fill image in
    fill_img = imfill(closed_img, 'holes');
%     imshow(fill_img)
%     figure;

    % Extract the object of interest
    object = bwpropfilt(fill_img, 'Area', 1, 'Largest');
end

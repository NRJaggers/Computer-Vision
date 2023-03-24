impath = '../Images/easy1.jpg';
res1 = imread(impath);
res_gray = rgb2gray(res1);
res_gray = medfilt2(res_gray, [9 9]);
res_seg = edge_based_seg(res_gray);
subplot(611); imshow(res_seg); title('Resistor Gray Image');

% Mask of image
se = strel("rectangle", [40 25]);
eroded_img = imerode(res_seg, se);
eroded_img = bwpropfilt(eroded_img, 'Area', 1, 'Largest');
dilated_img = ~imdilate(eroded_img, se);
subplot(612); imshow(dilated_img); title('Dilated Image');

% Mask out resistor body from background
% res_body = bsxfun(@times, res1, cast(mask, 'like', res1));
res_body = imoverlay(res1, dilated_img, 'black');
subplot(613); imshow(res_body); title('Resistor Body Image');

% Get Bounding Box for resistor body
props = regionprops('table', ~dilated_img, 'BoundingBox');
box = props.BoundingBox(1,:);
subplot(613); rectangle('Position', [box(1), box(2), box(3), box(4)], 'EdgeColor', 'r', 'LineWidth', 2);

% crop to only look at resistor body
new_res = imcrop(res_body, [box(1), box(2), box(3), box(4)]);
% new_res = rgb2hsv(new_res);
subplot(614); imshow(new_res); title('RGB Resistor Body')

% slice of resistor for clustering again
slice = imcrop(res_body,[box(1) + box(3)*0.1, box(2) + box(4)/2, box(3) - box(3)*.2, box(4)/4]);
subplot(615); imshow(slice); title('Slice Resistor')

gray_slice = rgb2gray(slice);
mask2 = gray_slice < 160;
subplot(616); imshow(mask2); title(' Gray Slice Resistor')

% Set K-value RGB
K = 4;
[m,n]=size(slice(:,:,1));
X=reshape(slice, m*n, 3);

% Set K-value Gray
% K = 2;
% [m,n]=size(new_res);
% X=reshape(new_res, m*n, 1);

% Initialization parameters
% options = statset('MaxIter', 1000, 'Display', 'final');
% X_dist = fitgmdist(double(X), K, 'Options', options);
options = statset('Display','final','MaxIter',1000);
[X_clustered, C] = kmeans(double(X), K, 'Options', options, 'Start', 'plus', 'Replicates', 5);
% X_clustered = cluster(X_dist, double(X));

% Reshape for displaying
im_segmented=reshape(X_clustered, m,n);
% figure;
% subplot(616); imshow(im_segmented, []), title('EM Clustering Segmented Image')

feature_arr = zeros(5);

props2 = regionprops('table', mask2, 'BoundingBox','Area');
band_num = 1;
for i=1:size(props2, 1)
    box2 = props2.BoundingBox(i,:);
    box2_area = box2(3) * box2(4);
    if (props2.Area(i) > 100)
        subplot(616); rectangle('Position', [box2(1), box2(2), box2(3), box2(4)], 'EdgeColor', 'r', 'LineWidth', 2);
        feature_arr(3,band_num) = int32(box2(1));
        feature_arr(4,band_num) = int32(box2(1)+box2(3));
        band_num = band_num + 1;
    end
end

%%
%slice from rgb to hsv
slice_hsv = rgb2hsv(slice);
% look at bands one at a time and average hue and intensity values
for i = 1:length(feature_arr)

    band = slice_hsv(:,feature_arr(3):feature_arr(4),:);
    imshow(band,hsv);
end

%%

figure;
hsv_slice = rgb2hsv(slice);
h = hsv_slice(:,:,1);
s = hsv_slice(:,:,2);
v = hsv_slice(:,:,3);
subplot(311); histogram(h); title('H-value')
subplot(312); histogram(s); title('S-value')
subplot(313); histogram(v); title('V-value')

%%
function object = edge_based_seg(gray_img)
    %% Edge-based segmentation using the Sobel edge detector
    % Input: gray_img - grayscale image
    % Output: object - binary image containing the extracted object

    % Apply the Sobel edge detection filter
    edge_img = edge(gray_img, 'prewitt');

    % Clean up the edge image
    clean_img = bwareaopen(edge_img, 20);

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

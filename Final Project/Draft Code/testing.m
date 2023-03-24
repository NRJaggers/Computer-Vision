% Load the image
impath = '../Images/easy1.jpg';
img = imread(impath);

% Convert the image to grayscale
gray_img = rgb2gray(img);
% imshow(gray_img);
% figure;

% Apply median filter with 3x3 neighborhood
filtered_img = medfilt2(gray_img, [9 9]);
% imtool(filtered_img)
% imshow(filtered_img)
% figure;

%% STEP 1
% Using thresholding segmentation
thres_img = thres_seg(filtered_img, 254, 1);
%imshow(thres_img);

% Using edge-based segmentation
edge_based_img = edge_based_seg(filtered_img);
imshow(edge_based_img);

%% STEP 2
% Perform Morphological Operations to remove leads
% First erode image to get rid of leads, then dilate
% Adjust disk radius in strel object according to resistor size
se = strel("rectangle", [40 25]);
eroded_img = imerode(edge_based_img, se);
eroded_img = bwpropfilt(eroded_img, 'Area', 1, 'Largest');
dilated_img = ~imdilate(eroded_img, se);
dilated_img2 = ~dilated_img;
% imshow(dilated_img)
% figure;
% imshow(eroded_img)
% figure;

%% STEP 3
% Masking the resistor body out of the original image
res_img = imoverlay(gray_img, dilated_img);
imshow(img);
figure;
imshow(res_img);

% Display the results
% hold off
% subplot(1,3,1), imshow(img), title('original image')
% subplot(1,3,2), imshow(edge_based_img,[]), title("edge-based segmentation")
% subplot(1,3,3), imshow(thres_img,[]), title("thresholding segmenation")
%subplot(3,1,3), imshow(reg_based_img,[]), title("Region-based Segmentation")
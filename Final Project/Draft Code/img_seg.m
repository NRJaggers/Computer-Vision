% Final Project
% Read in image
impath = '../Images/easy1.jpg';
res1 = imread(impath);
res_gray = rgb2gray(res1);

% Preprocessing smoothing for illumination minimization
res_gray = medfilt2(res_gray, [9 9]);

% Perfrom Edge-Based Segmentation
res_seg = edge_based_seg(res_gray);
subplot(611); imshow(res_seg); title('Resistor Gray Image');

% Dilate and Erode leads of resistors
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

% Crop to only look at resistor body
new_res = imcrop(res_body, [box(1), box(2), box(3), box(4)]);
% new_res = rgb2hsv(new_res);
subplot(614); imshow(new_res); title('RGB Resistor Body')

% Get slice of resistor body for further processing
slice = imcrop(res_body,[box(1) + box(3)*0.1, box(2) + box(4)/2, box(3) - box(3)*.2, box(4)/4]);
subplot(615); imshow(slice); title('Slice Resistor')

% Segment the slice for getting bounding boxes around bands
gray_slice = rgb2gray(slice);
mask2 = gray_slice < 160;
subplot(616); imshow(mask2); title(' Gray Slice Resistor')

% Initialize Feature Array
feature_arr = zeros(5,4);
% Obtain BoundingBox objects from image
props2 = regionprops('table', mask2, 'BoundingBox');

% Iterate through objects and filter
band_num = 1;
for i=1:size(props2, 1)
    box2 = props2.BoundingBox(i,:);
    % Use box area as threshold for detecting bands
    box2_area = box2(3) * box2(4);
    if (box2_area > 100)
        subplot(616); rectangle('Position', [box2(1), box2(2), box2(3), box2(4)], 'EdgeColor', 'r', 'LineWidth', 2);
        % Assign the start & end x-axis values to feature array
        feature_arr(4,band_num) = round(box2(1));
        feature_arr(5,band_num) = round(box2(1)+box2(3));
        band_num = band_num + 1;
    end
end

% Setup histograms to analyze HSV color space along the x-axis of image
% HSV Channels
figure;
hsv_slice = rgb2hsv(slice);
x = linspace(1, size(slice,2), size(slice,2));
h = hsv_slice(:,:,1);
h = mean(h);
s = hsv_slice(:,:,2);
s = mean(s);
v = hsv_slice(:,:,3);
v = mean(v);
subplot(311); plot(x,h); title('H-value')
subplot(312); plot(x,s); title('S-value')
subplot(313); plot(x,v); title('V-value')

% Extract Colors from hsv vectors using start/end x-axis values from boxes
for i=1:4
    feature_arr(1,i) = mean(h(feature_arr(4,i):feature_arr(5,i)));
    feature_arr(2,i) = mean(s(feature_arr(4,i):feature_arr(5,i)));
    feature_arr(3,i) = mean(v(feature_arr(4,i):feature_arr(5,i)));
end

% HSV values for the colors of a resistor
blackHSV = [0 0 0];
brownHSV = [0.0472 0.8296 0.3554];
redHSV = [0.4067 0.8393 0.6278];
orangeHSV = [0.0690 0.8502 0.9385];
yellowHSV = [0.17 1 1];
greenHSV = [0.2604 0.7459 0.6522];
blueHSV = [0.5037 0.6880 0.6035];
violetHSV = [0.83 0.5 1];
greyHSV = [0 0 0.5];
whiteHSV = [0 0 1];
goldHSV = [0.0898 0.5608 0.8463];
silverHSV = [0 0.75 0.75];

% Index values
blackIdx = 1;
brownIdx = 2;
redIdx = 3;
orangeIdx = 4;
yellowIdx = 5;
greenIdx = 6;
blueIdx = 7;
violetIdx = 8;
greyIdx = 9;
whiteIdx = 10;
goldIdx = 11;
silverIdx = 12;
colorHSV = [blackHSV; brownHSV; redHSV; orangeHSV; yellowHSV; greenHSV; blueHSV; violetHSV; greyHSV; whiteHSV; goldHSV; silverHSV];

% Multiplier and Tolerance Matrices for determining resistor value
multiplier_matrix = [1, 10, 100, 1000, 10000, 100000, 1000000, 10000000, 100000000, 1000000000];
tol_matrix = [0, 1, 2, 0, 0, 0.5, 0.25, 0.1, 0.05, 0, 5, 10, 20];

% Vector containing the correct color index values
class_vector = hsvToIdx(feature_arr, colorHSV);

% Determines the ohm and tolerance value of the resistor based off class
% vector
[ohms, tolerance] = determine_res(class_vector, multiplier_matrix, tol_matrix);

% Displaying the resistor attributes and bounding box around resistor body
final_text = ohms + "," + tolerance;
figure;
imshow(res1), rectangle('Position', [box(1), box(2), box(3), box(4)], 'EdgeColor', 'r', 'LineWidth', 2);
text(box(1), box(2) + box(4) + 10, final_text, 'Color', 'g', 'FontSize', 20);

%% Function Appendix
function inRange = inrange(x, value, error)
   % Returns true if x is in range of value by error or false otherwise
   inRange = (x >= value - (value * error)) & (x <= value + (value * error));
end

function feat_arr = hsvToIdx(featVec, color)
   tmp_arr = zeros(1,4);
   errorRange = 0.25;
   numBands = size(featVec, 2);
   numColors = size(color, 1);
   for i = 1:numBands
       for j = 1:numColors
           thisColor = color(j,:);
           hueInRange = inrange(featVec(1, i), thisColor(1), errorRange);
           satInRange = inrange(featVec(2, i), thisColor(2), errorRange);
           valInRange = inrange(featVec(3, i), thisColor(3), errorRange);
           % disp(thisColor(1))
           if (hueInRange && satInRange || hueInRange && valInRange)
               disp(featVec(1, i))
               disp(featVec(2, i))
               disp(featVec(3, i))
               disp("Band: " + i)
               disp("Color index: " + j)
               tmp_arr(i) = j;
               break;
           end
       end
   end
   feat_arr = tmp_arr;
end

function [res_val, tol] = determine_res(feat_vector, multiplier_matrix, tol_matrix)
    ohms = feat_vector(1) * 10 + feat_vector(2);
    ohms = ohms * multiplier_matrix(feat_vector(3));
    res_val = int2str(ohms);
    res_val = res_val + "Ω";
    tol = int2str(tol_matrix(feat_vector(4)));
    tol = tol + "%";
end

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

    % Close the gaps between the lines
    closed_img = imclose(bin_img, strel('disk', 25));

    % Fill image in
    fill_img = imfill(closed_img, 'holes');

    % Extract the object of interest
    object = bwpropfilt(fill_img, 'Area', 1, 'Largest');
end

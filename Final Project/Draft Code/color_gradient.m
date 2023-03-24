% Define the size of the rectangle
width = 400;
height = 50;

% Create a matrix to store the HSV values
hsv_matrix = zeros(height, width, 3);

% Set the hue values to a linear gradient from 0 to 1
hsv_matrix(:,:,1) = repmat(linspace(0,1,width), height, 1);

% Set the saturation and value values to 1
hsv_matrix(:,:,2) = ones(height, width);
hsv_matrix(:,:,3) = ones(height, width);

% Convert the HSV values to RGB values
rgb_matrix = hsv2rgb(hsv_matrix);

% Display the color gradient rectangle
c = hsv;
imtool(rgb_matrix);
axis off;

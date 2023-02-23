function [grayImage] = check_grayscale(image)
%check_grayscale checks if the given image has multiple or a single channel

% Get the dimensions of the image.  
% numberOfColorBands should be = 1 if grayscale
[~, ~, numberOfColorChannels] = size(image); % tildes are to replace unused output arguments
if numberOfColorChannels > 1
  % It's not really gray scale like we expected - it's color.
  grayImage = rgb2gray(image);
else
    grayImage = image;
end

end

function peak = match_template(grayImage, template, threshold)
% Takes grayscale image, template, and threshold value to perform
% normalized correlation and narrow down on maxes with the threshold and
% regional maximum function and finally display the image.
%
% Returns the offset for drawing rectangles around matches.


% generate correlation map
nc_map= normxcorr2(template,grayImage);

% view normal correlation map if desired
% figure;
% imshow(nc_map,[]);

thresh = threshold*max(nc_map(:));

[m,n] = size(nc_map);
highs = zeros(m,n);
for i = 1:size(nc_map(:))
    if nc_map(i) >= thresh
        highs(i) = nc_map(i);
    end
end

% view restricted normal correlation map if desired
% figure();
% imshow(highs);

% nonmaximum suppression in regions
peak = imregionalmax(highs);

% view maxes if desired (and if you can)
% figure();
% imshow(peak);

[ypeak, xpeak] = find(peak>=1);
yoffSet = ypeak-size(template,1);
xoffSet = xpeak-size(template,2);

%display rock image and boxes
figure;
hold on;
imshow(grayImage);
for i = 1:size(xoffSet)
rectangle('Position', ...
    [xoffSet(i)+1, yoffSet(i)+1, size(template,2), size(template,1)], ...
    'EdgeColor','r');
end
hold off

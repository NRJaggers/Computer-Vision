function box_objectBW(image, imageBW,minSize)
%box_objectBW boxes an object from a black and white image
    % use this binary image with bwconncomp to find strawberry bodies
    % CC = bwconncomp(BW)
    CC = bwconncomp(imageBW);
    % use regionprops to find centers of bodies ...
    % stats = regionprops(CC,'Centroid')
    % centers = stats.Centroid
    stats = regionprops(CC, "Area", 'BoundingBox','Centroid');
    bb = stats(find([stats.Area] > minSize));

    % Can then use centroid to bound strawberries
    % or you can use technique described here maybe?:
    % https://www.mathworks.com/matlabcentral/answers/87597-rectangle-around-the-object-bounding-box
    figure();
    hold on;
    imshow(image);
    for k = 1 : length(bb)
      thisBB = bb(k).BoundingBox;
      rectangle('Position', [thisBB(1),thisBB(2),thisBB(3),thisBB(4)],...
      'EdgeColor','white','LineWidth',2 )
      text(bb(k).Centroid(1),bb(k).Centroid(2), num2str(k), ...
        'Color','white', 'FontWeight','bold','HorizontalAlignment','center');
    end
    hold off;
end
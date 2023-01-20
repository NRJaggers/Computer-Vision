function [filtered_image]=nonlinearfilter(mode, image, k_rows, k_cols)
% k_rows and k_cols must be ODD
% image must be larger than k_rows by k_cols
% mode must be max, min, or median


[i_rows, i_cols] = size(image);


% Edge pixels of image will be omitted from new image.
% _trim variables hold number of pixels from edge that are ignored.
tb_trim = (k_rows-1)/2; % Top/Bottom
lr_trim = (k_cols-1)/2; % Left/Right


% Start and end indicies of new image
col_start = lr_trim+1;
col_end = i_cols-lr_trim;
row_start = tb_trim+1;
row_end = i_rows-tb_trim;


image = double(image);
filtered_image = uint8(zeros(i_rows-2*tb_trim, i_cols-2*lr_trim));


f_col = 1;
for C=col_start:1:col_end
    f_row = 1;
    for R=row_start:1:row_end
        
        % Extract neighborhood from image
        neighbors = image(R-tb_trim:R+tb_trim,C-lr_trim:C+lr_trim);
        
        if mode == "max"
            pixel = max(neighbors, [], 'all');

        elseif mode == "min"
            pixel = min(neighbors, [], 'all');

        elseif mode == "median"
            pixel = median(neighbors, 'all');
        else
            pixel = 0;
        end
        
        filtered_image(f_row,f_col) = uint8(pixel);
        
        f_row = f_row+1;
    end
    f_col = f_col+1;
end

end

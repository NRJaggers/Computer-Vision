function show_color(rgb_mat)
%SHOW COLOR give RGB values, show the color
x = [0 1 1 0] ; y = [0 0 1 1] ;
figure;
fill(x,y,rgb_mat/255);
end
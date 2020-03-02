function mesh_col = assign_color_for_scalar_func(f,f_min,f_max,range_col)
color_min = [0.88,0.88,0.88];
color_min = [14,77,146]/255;
color_ave = [220,255,241]/255;
color_max = [213,94,0]/255;


if nargin < 2
    f_min = min(f);
    f_max = max(f);
end

if nargin > 3
    color_min = range_col(1,:);
    color_ave = range_col(2,:);
    color_max = range_col(3,:);
end

c_min = quantile(f,0.01); c_max= quantile(f,0.99);
c_ave = (f_min+f_max)/2;

if c_min ~= f_min
    c1 = interp1([f_min,c_min,c_ave,c_max,f_max],[color_min(1),color_min(1),color_ave(1),color_max(1),color_max(1)],f);
    c2 = interp1([f_min,c_min,c_ave,c_max,f_max],[color_min(2),color_min(2),color_ave(2),color_max(2),color_max(2)],f);
    c3 = interp1([f_min,c_min,c_ave,c_max,f_max],[color_min(3),color_min(3),color_ave(3),color_max(3),color_max(3)],f);
else
    c1 = interp1([f_min,c_ave,f_max],[color_min(1),color_ave(1),color_max(1)],f);
    c2 = interp1([f_min,c_ave,f_max],[color_min(2),color_ave(2),color_max(2)],f);
    c3 = interp1([f_min,c_ave,f_max],[color_min(3),color_ave(3),color_max(3)],f);
end
mesh_col = [c1, c2, c3];
end
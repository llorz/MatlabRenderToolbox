function [S_combined, col_combined] = merge_mesh_with_landmarks(S1, lmk_id, S1_col, lmk_col, radius)
if nargin < 4
    lmk_col = repmat([0.8,0.8,0.8], length(lmk_id), 1);
end
if nargin < 5
    edge = get_edge_list(S1);
    radius = mean(sum((S1.surface.VERT(edge(:,1),:) - S1.surface.VERT(edge(:,2),:)).^2,2));
end
sphere_base = MESH_IO.read_shape('sphere.obj'); 
lmk_spheres = cell(length(lmk_id),1);
col_combined = S1_col;

X1_new = S1.surface.VERT;

for i = 1:length(lmk_id)
    sphere1 = normalize_mesh_area(sphere_base, radius*4*pi^2);
    sphere1.surface.VERT = sphere1.surface.VERT + X1_new(lmk_id(i),:);
    lmk_spheres{i} = sphere1;
    col_combined = [col_combined; repmat(lmk_col(i,:), sphere_base.nv,1)];
end
%% combine the original mesh + landmark spheres to get nice shaddows for the lmks as well
S_combined = S1;
for i = 1:length(lmk_id)
    sphere1 = lmk_spheres{i};
    S_combined.surface.TRIV = [S_combined.surface.TRIV; sphere1.surface.TRIV + size(S_combined.surface.VERT,1)];
    S_combined.surface.VERT = [S_combined.surface.VERT; sphere1.surface.VERT];
end
S_combined.surface.X = S_combined.surface.VERT(:,1);
S_combined.surface.Y = S_combined.surface.VERT(:,2);
S_combined.surface.Z = S_combined.surface.VERT(:,3);
S_combined.nv = size(S_combined.surface.VERT,1);
S_combined.nf = size(S_combined.surface.TRIV,1);

end
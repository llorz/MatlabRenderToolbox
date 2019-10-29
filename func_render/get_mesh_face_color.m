function S2_col = get_mesh_face_color(S2, col_idx)
if nargin < 2, col_idx = [1,2,3]; end


X = S2.surface.VERT;
X_new = X*diag(sign(col_idx));
X_new = X_new(:,abs(col_idx));

g1 = X_new(:,1);
g2 = X_new(:,2);
g3 = X_new(:,3);


g1 = normalize_function(0,1,g1);
g2 = normalize_function(0,1,g2);
g3 = normalize_function(0,1,g3);

g1 = cos(g1);
g2 = cos(g2);
g3 = cos(g3);

g1 = normalize_function(0,1,g1);
g2 = normalize_function(0,1,g2);
g3 = normalize_function(0,1,g3);

S2_col = [g1,g2,g3];

end
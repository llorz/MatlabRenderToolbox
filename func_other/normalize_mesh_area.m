function S = normalize_mesh_area(S_,a)
if nargin < 2, a = 1; end
S = S_;
S.surface.TRIV = S_.surface.TRIV;
S.surface.VERT = S_.surface.VERT/sqrt(sum(calc_tri_areas(S_.surface)))*sqrt(a); % rescale such that the mesh_area = 0.5
S.surface.VERT = S.surface.VERT - mean(S.surface.VERT);
S.surface.X = S.surface.VERT(:,1);
S.surface.Y = S.surface.VERT(:,2);
S.surface.Z = S.surface.VERT(:,3);

end

function S_tri = calc_tri_areas(M)

getDiff  = @(a,b)M.VERT(M.TRIV(:,a),:) - M.VERT(M.TRIV(:,b),:);
getTriArea  = @(X,Y).5*sqrt(sum(cross(X,Y).^2,2));
S_tri = getTriArea(getDiff(1,2),getDiff(1,3));
end

function render_map(S1,S2,map,col_idx,samples,varargin)
default_param = load_MeshPlot_default_params(S1);
param = parse_MeshPlot_params(default_param, varargin{:});

xdiam = param.MeshSepDist(1)*(max(S2.surface.X)-min(S2.surface.X));
ydiam = param.MeshSepDist(2)*(max(S2.surface.Y)-min(S2.surface.Y));
zdiam = param.MeshSepDist(3)*(max(S2.surface.Z)-min(S2.surface.Z));
%%
[S1_col,S2_col]= get_mapped_face_color_withNaN(S1,S2,map,col_idx);


[~,new_X1] = render_mesh(S1,'MeshVtxCol',S1_col,varargin{:});
axis equal; axis off; hold on;

[~,new_X2] = render_mesh(S2,'MeshVtxCol',S2_col,...
    'VtxPos',S2.surface.VERT + repmat([xdiam,ydiam,zdiam],S2.nv,1),...
    varargin{:});
axis equal; axis off; hold on;

if (~isempty(samples))
    target_samples = map(samples);
    
    Xstart = new_X1(samples,1)'; Xend = new_X2(target_samples,1)';
    Ystart = new_X1(samples,2)'; Yend = new_X2(target_samples,2)';
    Zstart = new_X1(samples,3)'; Zend = new_X2(target_samples,3)';
    
    Colors = S1_col;
    ColorSet = Colors(samples,:);
    set(gca, 'ColorOrder', ColorSet);
    plot3([Xstart; Xend], [Ystart; Yend], [Zstart; Zend],'LineWidth',1.2); hold off;
end
end

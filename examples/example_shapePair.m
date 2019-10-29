clc; clear; close all;
addpath('../func_render/');
addpath('../func_other/');
mesh_dir = '../data/';
s1_name = 'tr_reg_000.off';
s2_name = 'tr_reg_001.off';
%% Given a pair of shapes, and a computed pair from S1 to S2
% we want to visualize the map by color transfer
S1 = MESH_IO.read_shape([mesh_dir, s1_name]);
S2 = MESH_IO.read_shape([mesh_dir, s2_name]);
T12 = 1:length(S1.surface.X);

% its fine that some correspondences are missing (with value NaN)
% T12(randi([1, S1.nv],500,1)) = NaN; 
%% get the color of the two shapes from the given map
% the last argument controls the color-scheme of the shape
% try any permutation of [1,2,3] with different signs, e.g., [1,2,3], [-3,-2,1]
[S1_col,S2_col]= get_mapped_face_color_withNaN(S1,S2,T12,[-2,-1,3]);
%% render the two shapes sperately to find the proper rotations
figure(1);
[~,~, S1_new] = render_mesh(S1,'MeshVtxColor',S1_col,...
    'RotationOps',{[-90,0,0],[0,0,30]},...
    'CameraPos',[-10,10],...
    'FaceAlpha',0.9); hold on;


translation = [1.2,-0.1,0]; % translate the second shape
[~,~, S2_new] = render_mesh(S2,'MeshVtxColor',S1_col,...
    'RotationOps',{[-90,0,0],[0,0,30]},...
    'VtxPos',S2.surface.VERT + repmat(translation,S2.nv,1),... % translate the second shape such that S1 and S2 are not overlapped
    'CameraPos',[-10,10],...
    'FaceAlpha',0.9);

%% add some landmarks
lmk1 = fps_euclidean(S1, 15); % sample some vtx on S1
lmk2 = T12(lmk1); % they are mapped to lmk2 by the given map

[S1_combined, S1_col_combined] = merge_mesh_with_landmarks(S1_new, lmk1, S1_col, S1_col(lmk1,:));
[S2_combined, S2_col_combined] = merge_mesh_with_landmarks(S2_new, lmk2, S2_col, S2_col(lmk1,:));

figure(2);
render_mesh(S1_combined,'MeshVtxColor',S1_col_combined,...
    'CameraPos',[-10,10],...
    'FaceAlpha',0.9); hold on;


render_mesh(S2_combined,'MeshVtxColor',S2_col_combined,...
    'CameraPos',[-10,10],...
    'FaceAlpha',0.9); hold off;

%% add some lines to connect the landmarks
figure(3);
render_mesh(S1_combined,'MeshVtxColor',S1_col_combined,...
    'CameraPos',[-10,10],...
    'FaceAlpha',0.9,...
     'BackgroundColor',[0.5, 0.5, 0.5]); hold on;

render_mesh(S2_combined,'MeshVtxColor',S2_col_combined,...
    'CameraPos',[-10,10],...
    'FaceAlpha',0.9,...
    'BackgroundColor',[0.5, 0.5, 0.5]); hold on;

X1 = S1_combined.surface.VERT;
X2 = S2_combined.surface.VERT;

Xstart = X1(lmk1,1)'; Xend = X2(lmk2,1)';
Ystart = X1(lmk1,2)'; Yend = X2(lmk2,2)';
Zstart = X1(lmk1,3)'; Zend = X2(lmk2,3)';

ColorSet = S1_col(lmk1,:);
set(gca, 'ColorOrder', ColorSet);
plot3([Xstart; Xend], [Ystart; Yend], [Zstart; Zend],'LineWidth',1.2); hold off;


set(gcf,'Position', [50 50 600 600]);
set(gcf,'Color', [0.5,0.5,0.5],'InvertHardcopy','off'); % to preserve the bgcolor when saving it
saveas(gcf,'../results/eg_shapePair.png')

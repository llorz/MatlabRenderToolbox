clc; clear; close all;
addpath('../func_render/');
addpath('../func_other/');
mesh_dir = '../data/';
%% 
% load the shape
S1 = MESH_IO.read_shape([mesh_dir, 'cat0.off']);
% specify the landmark ID
lmk_id = [1000,5500,10000];
% define the mesh color
S1_col = S1.surface.VERT;
% define the color for each landmark (can be different)
lmk_col = repmat([0.98,0.98,0.98], length(lmk_id), 1); 
% define the radius of the landmarks
radius = 10; % by default, the radius is average edge length :)

%% construct a new mesh with the shape and the landmark spheres
[S_combined, col_combined] = merge_mesh_with_landmarks(S1, lmk_id, S1_col, lmk_col, radius);

% rendering
figure(1); 
render_mesh(S_combined,...
    'MeshVtxColor',col_combined,...
    'RotationOps',{[0,0,-20]},...
    'CameraPos',[-15,10],...
    'FaceAlpha',0.98);
set(gcf,'Position', [50 50 600 600]);
saveas(gcf,'../results/eg_shapeWithLandmarks.png')
%% rendering: different transparancy for the shape and the landmarks
figure(2); clf;
render_mesh(S_combined,...
    'MeshVtxColor',col_combined,... % [R G B] for each of the vertex
    'CameraPos',[-40,3],...
    'FaceAlpha',0.99); hold on;

render_mesh(S1,...
    'MeshVtxColor',S1_col,... % [R G B] for each of the vertex
    'CameraPos',[-40,3],...
    'FaceAlpha',0.3); hold on;


% This script plots Mars surface. Data file Mars_topo.mat 
% has the topographical data. The axes are normalized by 1e6 m.

R = 3.3895e6 ;
load('Mars_topo.mat');
[x,y,z] = sphere(50);
s = surf(R*x/1e6,R*y/1e6,R*z/1e6); % create a sphere
colormap('hot'); view(3);
s.CData = Mars_topo;  % set color data to topographic data
s.FaceColor = 'texturemap';    % use texture mapping
s.EdgeColor = 'none';          % remove edges
s.FaceLighting = 'gouraud';    % preferred lighting for curved surfaces
s.SpecularStrength = 0.4;      % change the strength of the reflected light
grid on; box on; axis equal;
axis(4*[-1 1 -1 1 -1 1]);
xlabel('x (10^6 m)'); ylabel('y (10^6 m)'); zlabel('z (10^6 m)');
% title('Mars Topography');
set(gca,'LineWidth',1,'FontSize',10, ...
    'Xtick',[-4:2:4],'Ytick',[-4:2:2],'Ztick',[-4:2:2]);
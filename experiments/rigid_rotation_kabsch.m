% Kabsch algorithm to find rigid transformation & Least Root Mean Square
% distance between two paired sets of points

load('../bunny_meshes.mat');

Y.vertices = randRigid(X.vertices);

figure(1); 
patch(X, 'facecolor', 'g', 'facealpha', 0.2, 'linestyle','none');
hold on;
patch(Y, 'facecolor', 'b', 'facealpha', 0.2, 'linestyle','none');
axis equal; axis off;

% Bring centers to origin
XX = X.vertices - mean(X.vertices);
YY = Y.vertices - mean(Y.vertices);

% Covariance matrix
H = XX' * YY;

R = project_SO3(H);

Z.faces = X.faces;
Z.vertices = zeros(size(X.vertices));
for i=1:size(X.vertices,1)
    Z.vertices(i,:) = (R * X.vertices(i,:)')';
end

patch(Z, 'facecolor', 'r', 'facealpha', 0.2, 'linestyle','none');
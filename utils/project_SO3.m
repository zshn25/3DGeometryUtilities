function R = project_SO3(X)
% Projects on the rotation set given a 3x3 matrix

% Kabsch algorithm

[u,~,v] = svd(X);

identiti = eye(3);

% ensure a right-handed coordinate system
identiti(3,3) = det(v'*u');

R = v' * identiti * u';
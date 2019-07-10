function M = meshMatrix(X, vertices)
% Mesh matrix is #vertices x #faces incidence matrix.
% Reference: https://onlinelibrary.wiley.com/doi/full/10.1111/cgf.13144

% Inputs:
% X can be a struct with fields: faces and vertices or
% X can be faces

% Author: Zeeshan Khan Suri
% License: CC

if nargin < 2
    if isstruct(X)
        faces = X.faces;
        vertices = X.vertices;
    else
        error('Requires faces and vertices as input');
    end
else
    faces = X;
end

if size(faces,1) ~= 3
    faces = faces';
end
if size(vertices,1) ~= 3
    Nv = size(vertices,1);
else
    Nv = size(vertices,2);
end

N = size(faces,2);    % Number of faces (assumed to be same for X and Y)

M=sparse(faces, [1:N; 1:N; 1:N], 1, Nv, N); %mesh matrix

end
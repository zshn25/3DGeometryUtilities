function neighbors = triangleAdjacency(X, vertices)
% Neighbors of a mesh with inputs as faces and vertices using a mesh matrix

% Inputs
% 1. X can be a struct with fields: faces and vertices or

% 2. X can be faces with
%    vertices if X is faces otherwise (optional)

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

if size(faces,1) ~= 3 && size(vertices,1) ~= 3
    faces = faces';
    vertices = vertices';
end

% Get the mesh matrix
M = meshMatrix(faces, vertices);

M(M~=0) = 1;
neighbors = triu(M'*M == 2);

end
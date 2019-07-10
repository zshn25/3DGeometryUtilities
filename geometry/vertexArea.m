function area = vertexArea(X, vertices)
% vertexArea returns a vector of length #vertices with area of 
% corresponding faces of i^th vertex on it's i^th place

% Inputs:
    % X can be a struct with fields: faces and vertices or
    % X can be faces + vertices as second input
% Output: a vector of length #vertices with area of corresponding faces of
% i^th vertex on it's i^th place

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

transposed = false;
if size(vertices,2) == 3
    vertices = vertices';
    transposed = true;
end
if size(faces,2) == 3
    faces = faces';
    transposed = true;
end

normal = vertexnormal(faces, vertices, false);
area = 0.5*sqrt(sum(normal.^2));

if transposed
    area = area';
end

end

function test()
    X=cylinderMesh(0.1,5,5,5,false,false);
    area = vertexArea(X)
end
function N = facenormal(faces, vertices, normalized)
% Inputs:
    % point is 3xn matrix
    % triangle is 3xm matrix
    % normalized if true else non-normalized
% Outputs:
    % N is the face normals of size 3xm matrix
    % incenter is the incenter of each face triangle of size 3xm
% Author: Zeeshan Khan Suri
% License: CC

if nargin <3
    normalized = true;
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

edge1 = vertices(:,faces(1,:)) - vertices(:,faces(2,:));
edge2 = vertices(:,faces(2,:)) - vertices(:,faces(3,:));
edge3 = vertices(:,faces(3,:)) - vertices(:,faces(1,:));

N = cross(edge1, edge3);

if normalized
    N = normalize3D(N);
end

if transposed
    N = N';
end
% Plot
% incenter = trIncenter(face, vertice);
% quiver3(incenter(1,:),incenter(2,:),incenter(3,:),N(1,:),N(2,:),N(3,:), 1, 'color','r')
end

function test()
    X=cylinderMesh(0.1,5,10,1,0,false);
    incenter = trIncenter(X.faces, X.vertices);
    N=facenormal(X.faces, X.vertices, true);
    % Plot
    figure,patch(X, 'facealpha', 0.2, 'linestyle', ':');
    hold on; axis equal; axis off;
    quiver3(incenter(:,1),incenter(:,2),incenter(:,3),N(:,1),N(:,2),N(:,3),...
        1, 'color','r')
end
function N = vertexnormal(faces, vertices, normalize)
% Returns the vertex normals of a triangular mesh
% Inputs:
    % point is 3xn matrix
    % triangle is 3xm matrix
    % normalize if true else not
% Outputs:
    % N is the face normals of size 3xm matrix
    % incenter is the incenter of each face triangle of size 3xm
% Author: Zeeshan Khan Suri
% License: CC

    if nargin <3
        normalize=true;
    end
    
    transposed = false;
    if size(vertices,1) == 3
        vertices = vertices';
        transposed = true;
    end
    if size(faces,1) == 3
        faces = faces';
        transposed = true;
    end
    
    % Normals at each face
    faceNorm = facenormal(faces, vertices, false);
    
    % Incidence mesh matrix
    M = meshMatrix(faces, vertices);
    M(M~=0) = 1;
    numberFacesperVertex = sum(M,2);
    
    N = M * faceNorm;
    
    N = N./repmat(numberFacesperVertex,1,3);
    
    if normalize
        N = normalize3D(N);
    end
    
    if transposed
        N = N';
    end
    
end

function test()
    X=cylinderMesh(0.1,5,10,1,0,false);
    N=vertexnormal(X.faces, X.vertices, false);
    % Plot
    figure,patch(X, 'facealpha', 0.2, 'linestyle', ':');
    hold on; axis equal; axis off;
    quiver3(X.vertices(:,1),X.vertices(:,2),X.vertices(:,3),...
            N(:,1),N(:,2),N(:,3), 1, 'color','r');
end
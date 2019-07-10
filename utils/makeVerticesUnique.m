function [X, vertices] = makeVerticesUnique(X, vertices)
    % MAKEVERTICESUNIQUE makes the mesh's vertices unique
    % Sometimes the mesh has non-unique vertices with unique faces like 
    % this function https://mathworks.com/matlabcentral/fileexchange/22409-stl-file-reader.
    % This function makes the vertices unique and repeats the faces
    % Inputs:
    % X can be a struct with fields: faces and vertices or
    % X can be faces
    % if X is faces, vertices must be provided
    
    % Outputs:
    % Same as input
    
    % Author: Zeeshan Khan Suri
    % License: CC
    
    wasStruct = false;
    if nargin < 2
        if isstruct(X)
            faces = X.faces;
            vertices = X.vertices;
            wasStruct = true;
        else
            error('Requires faces and vertices as input');
        end
    else
        faces = X;
    end
    
    transposed = false;
    % Expects columns as each dimension
    if size(vertices,1) ~= 3
        vertices = vertices';
        faces = faces';
        transposed = true;
    end
    
    [vertices, ~, index] = unique(vertices, 'rows'); 
    faces = index(faces);
    
    if transposed
        vertices = vertices';
        faces = faces';
    end
    
    if wasStruct
        X.vertices = vertices;
        X.faces = faces;
    else
        X = faces;
    end
end


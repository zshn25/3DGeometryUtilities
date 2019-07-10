function neighbors = vertexAdjacency(f)
% Vertex neighbors of a mesh with faces f 
% Author: Zeeshan Khan Suri
% License: CC

if size(f,2) ~= 3
    f = f';
end

% A neighbor shares an edge
A = sparse(f(:,[1 2 3]), ...    % Half edge
           f(:,[2 3 1]), 1.0);

neighbors = logical(triu(A + A' > 0)); % Full edge

end
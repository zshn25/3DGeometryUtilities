function faces = cylinderFaces(density, length, torus)
% Triangulates the cylinder points by exploiting the structure
% Author: Zeeshan Khan Suri
% License: CC

if nargin <3
    torus = false;
end

faces = [];
for i = 1:length-1
    faces = [faces; [((i-1)*density)+(1:density)',...
        ((i-1)*density)+[(2:density)'; 1],...
        (i*density)+(1:density)']];
    
    faces = [faces; [(i*density)+[(2:density)'; 1],... % Interchnge 1st and second rows for normal direction consistency
        (i*density)+(1:density)',...
        ((i-1)*density)+[(2:density)'; 1]]];
end

if torus % Join the initial and final circumcircles
    faces = [faces; [((length-1)*density)+(1:density)',...
        ((length-1)*density)+[(2:density)'; 1],...
        (1:density)']];
    
    faces = [faces; [[(2:density)'; 1],...  % Interchnge 1st and second rows for normal direction consistency
        (1:density)',...
        ((length-1)*density)+[(2:density)'; 1]]];
end

faces = faces(:, [2,1,3]);   % Out facing normals

end
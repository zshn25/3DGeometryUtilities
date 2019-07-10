function incenter = trIncenter(faces, vertices)
% Returns the incenter of a triangle

transposed = false;
if size(faces,1) ~= 3 && size(vertices,1)~=3
    faces = faces';
    vertices = vertices';
    transposed = true;
end

incenter = vertices(:,faces(1,:)) + vertices(:,faces(2,:)) + vertices(:,faces(3,:));
incenter = incenter/3;

if transposed
    incenter = incenter';
end

end
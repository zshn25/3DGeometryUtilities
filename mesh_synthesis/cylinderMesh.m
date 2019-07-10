function cyl = cylinderMesh(radius, length, nTheta, nL, xShiftFactor, draw)
% Returns a cylinder mesh with axis along the Z axis
% Inputs:
%       radius
%       length
%       nTheta : Number of discrete points at each level along the length
%       nL     : Number of discrete points along the length
%       twisted: True / False: For a twisted (sine-like) cylinder
%       draw   : True / False: For plotting the mesh in a figure
% Output:
%       cyl.vertices: Cylinder vertices
%       cyl.faces   : Cylinder faces
% Author: Zeeshan Khan Suri
% License: CC

if nargin < 1
    radius=1;
end
if nargin < 2
    length=5;
end
if nargin < 3
    nTheta=25;
end
if nargin < 4
    nL=100;
end
if nargin < 5
    xShiftFactor = 0;
end
if nargin < 6
    draw = false;
end

%%

theta = 2*pi*(linspace(0,1,nTheta+1));
x = radius * cos(theta);
x(end) = [];    % Last element is same as first. So, just remove it
y = radius * sin(theta);
y(end) = [];
z = linspace(0,length,length*nL)';

nz = size(z,1);

% xshift = 0;
yshift = 0;
% if twisted
    xshift = xShiftFactor*repmat(sin(z), 1, nTheta);
%     yshift = repmat(cos(z), 1, nTheta);
% end

% Plot
% surf(repmat(x,l,1),repmat(y,l,1),repmat(z,1,nTheta))

X = repmat(x',nz,1) + vec(xshift');
Y = repmat(y',nz,1) + vec(yshift');
Z = vec(repmat(z, 1, nTheta)');

% Make faces
faces = cylinderFaces(nTheta, nz);

cyl.vertices = [X,Y,Z];
cyl.faces = faces;

if draw
    figure, patch(cyl, 'facealpha', 0.2, 'linestyle', ':')
    axis equal
end

end
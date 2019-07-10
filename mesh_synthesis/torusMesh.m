function torus = torusMesh(R, r, nTheta, nPhi, draw)
%TORUSMESH Returns a torus (cylinder with a circle as it's axis)
% Inputs:
%     R       : Outer radius
%     r       : inner radius
%     nTheta  : density of points along theta
%     nPhi    : density of points along phi
%     length  : 0 < length < 2*pi : For length of open torus
%     closed  : true for a closed mesh with genus 1
%     draw    : Plots if true
% Outputs:
%     torus.vertices: Cylinder vertices
%     torus.faces   : Cylinder faces
% Author: Zeeshan Khan Suri
% License: CC

% Parse inputs
% p = inputParser;
% 
% defaultNTheta = 8;
% defaultNPhi = 2;
% defaultLength = 2*pi;
% default
% addRequired(p, 'R', 1, @isnumeric);
% addRequired(p, 'r', 0.1, @isnumeric);
% addOptional(p, 'nTheta,

if nargin < 1
    R=1;
end
if nargin < 2
    r=0.1;
end
if nargin < 3
    nTheta=25;
end
if nargin < 4
    nPhi=25;
end
if nargin < 5
    draw = false;
end
%%
% nPhi = nL * length;
theta = 2*pi*(linspace(0,1,nTheta+1))';
phi = 2*pi*(linspace(0,1,nPhi+1));
theta = theta(1:end-1);
phi = phi(1:end-1);

x = (R + r*cos(theta))*cos(phi);
y = (R + r*cos(theta))*sin(phi);
z = (r*sin(theta)*ones(size(phi)));

% surf(x,y,z)
nz = size(z,2);

faces = cylinderFaces(nTheta, nz, true);

torus.vertices = [x(:),y(:),z(:)];
torus.faces = faces;

if draw
    figure, patch(torus, 'facealpha', 0.2, 'linestyle', ':')
    axis equal
    axis off
end
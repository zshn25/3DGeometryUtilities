function d = dist_matrix(vertices)
% DISTMATRIX returns the NxN eucledian distance matrix of N 3D points
% Author: Zeeshan Khan Suri
% License: CC
% Based on https://de.mathworks.com/matlabcentral/answers/154361-calculating-euclidean-distance-of-pairs-of-3d-points#answer_151348
d = squeeze(sqrt(sum(bsxfun(@minus,vertices,permute(vertices,[3,2,1])).^2,2)));
end


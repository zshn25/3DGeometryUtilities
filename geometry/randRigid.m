function [transformed, Tx, tx] = randRigid(vertices, seed)
% Returns a random rigid 3D transformation matrix of 3D points
    if nargin<2
        seed = 1;
    end
    transposed = false;
    if size(vertices,1) == 3
        vertices = vertices';
        transposed = true;
    end
	% Random rotation matrix
    rng(seed);
	[u,~,v] = svd(randn(size(vertices,2)));
	% Q = u*v'; % O(D) [abs(det(Q)) = 1]
	Tx = u*diag([ones(size(vertices,2)-1,1);det(u*v')])*v'; % SO(D) [det(Q) = 1]
	
    % Random translation
    rng(seed+1);
	tx = randn(1,3) * mean(mean(vertices));   % Scale a random translation
	for j = 1:size(vertices,1)
        
	    transformed(j,:) = vertices(j,:) * Tx + tx;
    end
	
    if transposed
        transformed = transformed';
    end
%         Tx = Tx';
%         tx = tx';
%     end
end
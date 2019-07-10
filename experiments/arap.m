load('bunny_meshes.mat')

figure(1); 
patch(X, 'facecolor', 'g', 'facealpha', 0.2, 'lineStyle',misc.lineStyle);
hold on;
patch(Y, 'facecolor', 'b', 'facealpha', 0.2, 'lineStyle',misc.lineStyle);
axis equal; axis off;

% Non-rigid procrustes based on as-rigid-as-possible
vertexNeighborhood = vertexAdjacency(X.faces);
vertexNeighborhood = vertexNeighborhood | vertexNeighborhood';
% Edge between i and j th vertices
[edge_i, edge_j] = find(vertexNeighborhood);

n = size(X.vertices,1); 
m = size(Y.vertices,1);
% k=6;

P = binvar(n,m,'full');
% assign(P,eye(n,m));

Constraints = [];
Constraints = [Constraints; P * ones(m,1) == ones(n,1)];
Constraints = [Constraints; ones(1,n) * P == ones(1,m)];

% YY = P * Y.vertices;
YY = Y.vertices;

% J = sampleJpoints(X, Y, 'uniform', k);

for i = 1:n%J(:,1)
    % For each vertex,
%     P_i = (X.vertices(edge_i(edge_i==i),:) - X.vertices(edge_j(edge_i==i),:))';
    P_i = X.vertices(vertexNeighborhood(i,:),:) - X.vertices(i,:);
    
    Q_i = YY(vertexNeighborhood(i,:),:) - repmat(YY(i,:), nnz(vertexNeighborhood(i,:)), 1);
%     Q_i = (Y.vertices(edge_i(edge_i==i),:) - Y.vertices(edge_j(edge_i==i),:))';
    
    S = P_i' * Q_i;
    
    [u,~,v] = svd(S);
    % Q = u*v'; % O(D) [abs(det(Q)) = 1]
%     Tx(:,:,i) = u*diag([ones(size(S,1)-1,1);det(u*v')])*v'; % SO(D) [det(Q) = 1]
    Tx(:,:,i) = eye(3);
%     tx(:,i) = P_i' - Q_i';
    tx(i,:) = Y.vertices(i,:) - X.vertices(i,:) * Tx(:,:,i);
end


%% Objective
% % tic;
% 
% % triangleNeighbours = triangleAdjacency(X);
% % [edge_i, edge_j] = find(triangleNeighbours);
% 
% % 
% % m_block = [sparse(eye(3)), sparse(3,1);...
% %             sparse(1,3), 0];
% % m = kron(sparse(eye(3)), m_block);
% % 
% % M_block = sparse([1:size(edge_i,1), 1:size(edge_j,1)], [edge_i, edge_j],...
% %     [ones(size(edge_i,1),1), -ones(size(edge_i,1),1)],...
% %     size(edge_i,1), size(X.faces,1));
% % 
% % M = kron(M_block, m);
% % % assert(all(size(M) == [12*size(edge_i,1), 12*size(X.faces,1)]));
% % 
% % % L = M'*M;
% % 
% % z = sdpvar(size(M,1),1);
% % Constraints = [Constraints; z == M*x_var(:)];
% % Obj = z'*z;
% tmp = Tx(:,:,edge_i) - Tx(:,:,edge_j);
% Obj = tmp(:)'*tmp(:);
% 
% opts = sdpsettings('solver', 'mosek');
% objVal = optimize(Constraints, Obj, opts);
% disp(value(Obj));
% 
% P_sol = value(P);

%% Result
X_new = zeros(size(X.vertices));
for i = 1:size(X.vertices,1)
    X_new(i,:) = X.vertices(i,:) * Tx(:,:,i) + tx(i,:);
end

patch('vertices', X_new, 'faces', X.faces,'facecolor', 'r', 'facealpha', 0.2)


function normalized = normalize3D(X)
% Normalizes the 3D vector

    transposed=false;
    if size(X,1) ~= 3
        X = X';
        transposed=true;
    end

    lenX = sqrt(sum(X.*X,1)); % Length of the vector
    normalized = X ./ repmat(lenX,3,1);

    if transposed
        normalized = normalized';
    end
end
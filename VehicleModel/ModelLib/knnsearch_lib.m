
function [k_idx, D] = knnsearch_lib(queryPoint, data, k)
    % Check if the Toolbox knnsearch function is available
    if exist('knnsearch', 'file') == 2
        [k_idx, D] = knnsearch(queryPoint, data, 'K', k);
    else
        % If not available, use custom implementation
        [k_idx, D] = knn_custom(queryPoint, data, k);
    end
end


function [k_idx, D] = knn_custom(P, PQ, k)
% KNNSEARCH - Finds the k nearest neighbors
%   [k_idx, D] = knnsearch(P, PQ, k) finds the k nearest neighbors in P
%   for each point in PQ
%
% Inputs:
%   P - Reference points matrix (MxD, M points in D dimensions)
%   PQ - Query points matrix (NxD, N points in D dimensions)
%   k - Number of nearest neighbors to find
%
% Outputs:
%   k_idx - Indices of the k nearest neighbors in P for each point in PQ (Nxk)
%   D - Distances to the k nearest neighbors (Nxk)

% Input validation
if nargin < 3
    k = 1;
end

[M, D1] = size(P);
[N, D2] = size(PQ);

if D1 ~= D2
    error('The dimensions of P and PQ must match');
end

if k > M
    warning('k is greater than the number of reference points, it fits M');
    k = M;
end

% Preallocation of output arrays
k_idx = int32(zeros(N, k));
D = zeros(N, k);

% For each consultation point
for i = 1:N
    % Calculate squared Euclidean distances (more efficient than calculating the square root)
    diff = P - repmat(PQ(i,:), M, 1);
    dist_sq = sum(diff.^2, 2);
    
    % Order distances and obtain indices
    [sorted_dist, sorted_idx] = sort(dist_sq);
    
    % Store the nearest k
    k_idx(i,:) = sorted_idx(1:k)';
    D(i,:) = sqrt(sorted_dist(1:k))'; % Calculate square root only for the top k
end
end






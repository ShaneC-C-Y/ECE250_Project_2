function xp = interleaver( dn, L, N)

% Input(dn):    row vector, length N*L
% Output:       row vector, size the same

dn_matrix = reshape(dn, N*L, []);
xp_matrix = zeros(size(dn_matrix));

% for i = 1:L
%     for j = 1:N
%         xp_matrix((i-1)*N+j, :) = dn_matrix(i+ (j-1)*L, :);
%     end
% end
%%%%%%%%%%%
%change new way
%%%%%%%%%%%%%%

for i = 1:L
    xp_matrix(1+(i-1)*N:i*N, :) = dn_matrix(i:L:end, :);
end

xp = xp_matrix(:)';
end


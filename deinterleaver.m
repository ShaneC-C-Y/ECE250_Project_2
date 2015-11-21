function dnhat = deinterleaver( yp, L, N )

% Input(yp):    row vector, length N*L???
% Output:       row vector, size the same

yp_matrix = reshape(yp, N*L, []);
dnhat_matrix = zeros(size(yp_matrix));

for i = 1:L
    for j = 1:N
        dnhat_matrix(i+ (j-1)*L, :) = yp_matrix((i-1)*N+j, :);
    end
end

dnhat = dnhat_matrix(:)';

end


function dn = repetition_encoder(bn, n)
%Input:     row vector, length N*L
%Output:    row vector, length N*L*n

G = ones(n, 1);
z = G*bn;
dn = z(:)';
end


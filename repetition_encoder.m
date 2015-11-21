function dn = repetition_encoder(bn, n)

%Input:     row vector, length N*L
%Output:    row vector, length N*L*n

% z = [ -----bn-----
%       -----bn-----
%             .
%             .
%       -----bn------]
% z have n rows

z = repmat(bn,n,1);
dn = z(:)';

end


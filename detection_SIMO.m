function bit_error_count = detection_SIMO(dnhat, dnhat2, n, bn)
% detection here should consider about bit error
% the number of total bit is Num*(n/k)
% only work when k = 1, repetition coding

% so we need to know bn here
% Input(dnhat):     row vector, 1 by Num*(n/1)
% Input(bn):        row vector, 1 by Num

% make dnhat to be L by Num matrix
% dnhat = [dn~[1] ...    ...
%          dn~[2] ...    ...
%            .     .      .
%          dn~[n] ... dn~[Num*(n/1)] ]
% bn =    [bn[1]  ...   bn[Num]  ]
% dnhat = length_handle(dnhat, n);
dnhat = reshape(dnhat,n,[]);
dnhat2 = reshape(dnhat2, n, []);

% check the length, make it comparable
assert(length(dnhat) == length(bn));

% bn_matrix = [ -----bn-----
%               -----bn-----
%                     .
%               -----bn-----]
bn_matrix = repmat(bn,n*2,1);

err = bn_matrix ~= [dnhat;dnhat2];
bit_error_count = sum(sum(err));
end


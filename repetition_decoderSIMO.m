function [ bnhat ] = repetition_decoderSIMO( dnhat, dnhat2, n )

% majority logic decoding
% dhnat2 = [ dn~[1] ...   ...
%            dn~[2] ...   ...
%              .     .     .
%            dn~[L] ... dn~[Num*(n/k)] ]  
%
% m =      [ bn~[1] ...  bn~[Num]  ]
dnhat_a = reshape(dnhat, n, []);
dnhat_b = reshape(dnhat2, n, []);

m = sum([dnhat_a; dnhat_b], 1);

% check value n/2
% it works only when n = 2t + 1
% otherwise there will be detection error
c = n;
bnhat = m>c;

end


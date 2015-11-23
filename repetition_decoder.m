function [ bnhat, retransmit_case ] = repetition_decoder( dnhat, n )

% majority logic decoding
% dhnat2 = [ dn~[1] ...   ...
%            dn~[2] ...   ...
%              .     .     .
%            dn~[L] ... dn~[Num*(n/k)] ]  
%
% m =      [ bn~[1] ...  bn~[Num]  ]
    
dnhat2 = reshape(dnhat, n, []);

c = n/2;
m = sum(dnhat2,1);
bnhat = m>c;

% if there is the case we need to flip coin, do retransmit
retransmit_case =  find(m == c, 2);
end


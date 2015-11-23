function [bnhat] = Hamming74_decoder(dnhat)

n = 7;

% cut off extra bit making vector can be a 7 by N~ matrix
% dnhat = [ dh[1] ...   ...
%            .     .     .
%           dh[7] ... dh[7*N~] ]
len = length(dnhat);
mo = mod(len,n);
if mo ~=0
    dnhat = dnhat(1:len-mo);
end
dnhat_matrix = reshape(dnhat,n,[]);

% parity check matrix
% very inportant to check the version of coding matrix
%https://en.wikipedia.org/wiki/Hamming(7,4)#Decoding
H = [ 1 0 1 0 1 0 1;
      0 1 1 0 0 1 1;
      0 0 0 1 1 1 1];
  
% err_matrix is 3 by N~ matrix
err_matrix = mod(H*dnhat_matrix,2);

% e_pos tell us which bit is wrong (if only 1 bit error)
% it is a 1 by N~ vector
e_pos = err_matrix(1,:) + 2.*err_matrix(2,:) + 4.*err_matrix(3,:);

% find which bit error
r_correct = dnhat_matrix;
for i = 1:length(e_pos)    % length(e_pos) = N~
    if e_pos(i) > 0
        r_correct(e_pos(i),i) = 1 - dnhat_matrix(e_pos(i),i);
    end
end

% dnhat_correct here is a 4 by N~ matrix
R = [ 0 0 1 0 0 0 0;
      0 0 0 0 1 0 0;
      0 0 0 0 0 1 0;
      0 0 0 0 0 0 1];
dnhat_correct = R*r_correct;

% output the result of decoder
bnhat = dnhat_correct(:)';
end
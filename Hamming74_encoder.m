function [ dn ] = Hamming74_encoder(bn)

% Input:  row vector, length N*L
% Output: row vector, length (7/4)*N*L
%                            this should be an even number
%                            so N*L should be dividable by 8
% n = 7;
k = 4;

% every 4 bits in a column vector
% p = [ bn[1] ...   ...
%         .    .     .
%       bn[4] ... bn[4*N~] ]
p = reshape(bn, k, []);

% very inportant to check the version of coding matrix
%https://en.wikipedia.org/wiki/Hamming(7,4)#Decoding
G = [ 1 1 0 1;
      1 0 1 1;
      1 0 0 0;
      0 1 1 1;
      0 1 0 0;
      0 0 1 0;
      0 0 0 1];

% x here is a 7 by N*L/4 matrix
% reshape to a row vector
x = mod(G*p,2);
dn = x(:)';

end


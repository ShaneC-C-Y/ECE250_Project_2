function [ rv ] = torowvector( cv )
% reshpae a matrix with mutiple colume vector to one row vector
% for example, cv = [a1 a2 ...
%                    b1 b2 ...
%                    c1 c2 ...]
%              rv = [a1 a2 ... b1 b2 ... c1 c2 ...]
t = cv.';
rv = t(:).';

end


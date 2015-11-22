function [ a1, a2 ] = Alamouti(u)
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here

u_temp = reshape(u,2,[]);

% a1 = zeros(size(u));
% a2 = zeros(size(u));

% use for two total block
% for i = 1:2
% a1_odd = u_temp(i,1:2:end);
% a2_odd = u_temp(i,2:2:end);
% a1_even = -conj(a2_odd);
% a2_even = conj(a1_odd);
% n_len = length(u)/2;
% a1((i-1)*n_len+1:i*n_len) = reshape([a1_odd;a1_even],1,[]);
% a2((i-1)*n_len+1:i*n_len) = reshape([a2_odd;a2_even],1,[]);
% end

% for one block
a1_odd = u_temp(1,:);
a2_odd = u_temp(2,:);
a1_even = -conj(a2_odd);
a2_even = conj(a1_odd);
a1 = reshape([a1_odd;a1_even],1,[]);
a2 = reshape([a2_odd;a2_even],1,[]);

end


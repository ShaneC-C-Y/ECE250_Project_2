function [ a1, a2 ] = Alamouti( u, N )
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here

u_temp = reshape(u,N,[]).';

a1 = zeros(size(u));
a2 = zeros(size(u));

for i = 1:2
a1_odd = u_temp(i,1:2:end);
a2_odd = u_temp(i,2:2:end);
a1_even = -conj(a2_odd);
a2_even = conj(a1_odd);

n_len = length(u)/2;

a1((i-1)*n_len+1:i*n_len) = reshape([a1_odd;a1_even],1,[]);
a2((i-1)*n_len+1:i*n_len) = reshape([a2_odd;a2_even],1,[]);
end

end


function [ y_afterfilter ] = matched_filter(y, h, N)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% implement matched filter  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Input(y):         row vector, 1 by N*L, complex
% Input(N):         parameter
% Input(h):         row vector, 1 bu L, complex
% OUtput:           row vector, 1 by N*L, complex

L = length(h);
assert( length(y) == N*L, 'lenght in matched filter is %d, not %d',...
    length(y), N*L );

% y = [y[1] y[1+N] ...        h_star = [h_1*  0   0 ...
%      y[2] y[2+N] ...                   0   h_2* 0 ...
%       .      .    .                    .    .   .  .
%      y[N] y[N+N] ...]                  0    0   0 h_L*]

% define h_norm as sqrt(|h_1|^2   + ... + |h_L|^2)
% and h_factor is h_star time a scalar (1/h_norm)
y = reshape(y, N, []);
h_norm = sqrt(sum(abs(h)));

h_factor = diag(conj(h)./h_norm);

% y -> (h*/|h|)y
y_afterfilter = y*h_factor;

% make a row vector to be output
y_afterfilter = y_afterfilter(:).';
end


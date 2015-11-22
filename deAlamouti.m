function [ y_afterfilter ] = deAlamouti(y, h1, h2, N)
%UNTITLED9 Summary of this function goes here
%   Detailed explanation goes here

% we need to creat y_
% so first seperate two tc
% Lt = 2 here, so there is y_1, y_2
y_1 = y(:,1:N);
y_2 = y(:,N+1:2*N);

% specify y[1,odd], y[1, even]*, y[2,odd], y[2,even]*
y_1_odd  = y_1(1:2:end);
y_1_even = y_1(2:2:end);
y_2_odd  = y_2(1:2:end);
y_2_even = y_2(2:2:end);

y_ = [y_1_odd;
      conj(y_1_even);
      y_2_odd;
      conj(y_2_even)];
  
% (U*)y_ have very useful property
% here h1 and h2 both should have 2 value inside h[1] and h[2]
%|h[1]| = h1(1)^2 + h2(1)^2
h_norm_1 = sqrt(abs(h1(1))^2+abs(h2(1))^2);
h_norm_2 = sqrt(abs(h1(2))^2+abs(h2(2))^2);
HA_1 = [h1(1) h2(1); h2(1)' -h1(1)'];
HA_2 = [h1(2) h2(2); h2(2)' -h1(2)'];
U = [HA_1./h_norm_1 zeros(2); zeros(2) HA_2./h_norm_2];

% y_bar = (R)x_ + w, 4 by xx matrix
y_bar = U'*y_;

% we need to rearrange y_bar to original format
y_bar_1 = y_bar(1:2,:);
y_bar_2 = y_bar(3:4,:);
y_afterfilter = [y_bar_1(:).', y_bar_2(:).'];

end


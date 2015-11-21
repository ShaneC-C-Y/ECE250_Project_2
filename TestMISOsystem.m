%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Test for antenna diversity system                         %
% create:       11/21/2015                                  %
% last modify:  11/--/2015                                  %
%                                                           %
% several tests can be done here                            %
%   (1) Hamming(7,4) encoding                               %
%       (a) verify prpbability of error on different SNR    %
%   (2) Repetition(n,1) encoding                            %
%       (a) verify probability of error on different SNR    %
%           under fixed n and L                             %
%       (b) compare probability of error on different time  %
%           diversity under fixed n                         %
%       (c) compare probability of error on different       %
%           repetition coding n under fixed L               %
%                                                           %
% Note:                                                     %
%   the input variables to System are for the tests above   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SNR simulation point                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
n_simulation = 200;
SNRrange = [10 100];
SNR = linspace(SNRrange(1),SNRrange(2),n_simulation);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% L should satsify                      %
%   L >= n, when using length n codeword%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Hamming74:        n = 7
% L = 7;
% n = 7;
% k = 4;

% Repetition(n):    n = n
L = 2;
n = 2;
k = 1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% initialize                            %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
pe_symbol = zeros(1,n_simulation);
pe_theoretical_symbol = zeros(1, n_simulation);
pe_bit = zeros(1,n_simulation);
pe_theoretical_bit = zeros(1,n_simulation);
n_total_bit = zeros(1, n_simulation);

pe_bit_3 = zeros(1,n_simulation);

    for i = 1 : n_simulation
%         type = 'hamming74';
        type = 'repetition';

        [~, pe_bit(i), n_total_bit(i)] = MISOsystem(SNR(i), L, n, k, type);
%         [~, pe_bit_3(i), ~] = System(SNR(i), 3, 3, k, type);

        %         pe_theoretical_symbol(i) = ?
        % for hamming74 at high SNR region
%         pe_theoretical_symbol(i) = (2^4-1)/SNR(i)^3;
        % for repetition n=2
%         pe_theoretical_symbol(i) = 4/SNR(i)^L;
        pe_theoretical_symbol(i) = 2*(4/SNR(i)^L)-(4/SNR(i)^L)^2;

    end
    

% h1 = plot(SNR,pe_bit, SNR, pe_bit_3, SNR,pe_theoretical_symbol);
% % h1 = plot(SNR,pe_bit,SNR,pe_theoretical_bit);
% legend('simulation, L = 2', 'simulation, L = 3', 'theoritical');
% % legend('simulation', 'theoritical');
% 
% set(h1, 'linewidth', 2);
% % legend('L=3', 'L=5', 'L=7', 'L=9', 'L=11');
% xlabel('SNR');
% ylabel('probability of error');
% 
% title(sprintf('Pe using repetition coding n = %d, L = 2, Num = %d',...
%     n, n_total_bit(n_simulation)));

% figure(2);
% h2 = plot(SNR,pe_theoretical);
% legend('L=3', 'L=5', 'L=7', 'L=9', 'L=11');
% 




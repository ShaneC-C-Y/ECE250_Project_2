function [pe_symbol, pe_bit, n_total_bit] = SIMOsystem(snr, L, n, k, type)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Antenna diversity system, SIMO                                %
% create:       11/22/2015                                      %
% last modify:  11/--/2015                                      %
%                                                               %
% note:                                                         %
%   Real and Imag part on the same path, so there will be only  %
%   one channel in this system                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% amount of symbol in one Tc
% set a number dividable by 2 and 7, choosing 42
% because QPSK need to deal with even number and hamming74 code
% with divide sequence by 7
N = 42;      

error_count_symbol = 0;
error_count_bit = 0;
n_run = 0;

% put here because the error rate caculator outside while loop need
Num = N*L*k/n*2;
assert(mod(Num,1)==0, 'Generated number not a integer');

while error_count_symbol <= 300
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % genertor                                          %
    % everytime we need a 2*N*L bit in interleaver, so  %
    % we should generate N*L / (n/k)*2 bits             %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    bn = bit_generator(Num);

    % the Transmitter here is the same as Project I
    [xR, xI] = Transmitter(bn, L, N, n, type);

    % SIMO will go through different channel with the same sequence
    [y1, h1] = channel(xR +1i*xI, snr, N);
    [y2, h2] = channel(xR +1i*xI, snr, N);

    % each antenna has one
    y_afterfilter_1 = matched_filter(y1, h1, N);
    y_afterfilter_2 = matched_filter(y2, h2, N);
    
    % the Receiver here is no matched filter
    dnhat = ReceiverSIMO( y_afterfilter_1, L, N);
    dnhat2 = ReceiverSIMO( y_afterfilter_2, L, N);
    
    bnhat = repetition_decoderSIMO(dnhat, dnhat2, n);

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    assert(length(bn) == length(bnhat),...
        'length bn: %d, is different with length bnhat: %d',...
        length(bn), length(bnhat));
    error_count_symbol = error_count_symbol + length(find(bnhat ~= bn));
    n_run = n_run + 1;
    
    % detection in bit error
    error_count_bit = error_count_bit + detection_SIMO(dnhat, dnhat2, n, bn);
end
% who can see both original bit and receiver can tell the probabilty of
% error (symbol error)
n_total_bit = n_run*Num;
pe_symbol = error_count_symbol / n_total_bit;

% because there are two sequences
% if n = 2, 1 bit will compare to 4 bits
pe_bit = error_count_bit / (n_total_bit*n*2);
end

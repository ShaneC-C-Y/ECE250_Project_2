function [pe_symbol, pe_bit, n_total_bit] = MISOsystem(snr, L, n, k, type)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Antenna diversity system                                      %
% create:       11/21/2015                                      %
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% genertor                          %
% everytime generate one set of bit %
% enough for N*L and should be even %
% because QPSK need even            %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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
       
    % extra part in Tranmitter in MISO
    % should Alamouti know N?
    [a1, a2] = Alamouti(xR + 1i*xI);

    [y1, h1] = channel(a1, snr, N);
    [y2, h2] = channel(a2, snr, N);

    % extra part in Receiver in MISO
    y_out =  deAlamouti(y1 + y2, h1, h2, N);
    
    % the Receiver here is no matched filter
    [bnhat, dnhat] = Receiver( y_out, L, N, n, type);

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    assert(length(bn) == length(bnhat),...
        'length bn: %d, is different with length bnhat: %d',...
        length(bn), length(bnhat));
    error_count_symbol = error_count_symbol + length(find(bnhat ~= bn));
    n_run = n_run + 1;
    
    % detection in bit error
    error_count_bit = error_count_bit + detection(dnhat, n, bn);
end
% who can see both original bit and receiver can tell the probabilty of
% error (symbol error)
n_total_bit = n_run*Num;
pe_symbol = error_count_symbol / n_total_bit;
pe_bit = error_count_bit / (n_total_bit*n);
end

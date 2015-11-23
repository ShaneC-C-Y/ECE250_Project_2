function [xR, xI] = Transmitter(bn, L, N, n, type)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% take input sequence bn        %
% and output signal xR xI       %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
dn = Encoder(bn, n, type);

% if use interleaver before QPSK, you should but 2N 
% due to QPSK will shrink 2 bits to 1 bit
xp = interleaver(dn, L, N*2);

% xR, xI are real
[xR, xI] = QPSK_constellation_mapper(xp);
end


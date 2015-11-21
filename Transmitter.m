function [xR, xI] = Transmitter(bn, L, N, n, type)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% take input sequence bn        %
% and output signal xR xI       %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
dn = Encoder(bn, n, type);

xp = interleaver(dn, L, N);

% xR, xI are real
[xR, xI] = QPSK_constellation_mapper(xp);

Alamouti(xR, xI);
end


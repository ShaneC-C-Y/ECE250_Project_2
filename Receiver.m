function [bnhat, dnhat] = Receiver( y_out, L, N, n, type)
%%%%%%%%%%%%%%%%%
% receiver      %
% for 
%%%%%%%%%%%%%%%%%

% from series to parallels, and back to series
yp = QPSK_constellation_demapper(real(y_out), imag(y_out));
    
dnhat = deinterleaver(yp, L, N*2);

bnhat = Decoder(dnhat, n, type);
end
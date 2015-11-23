function dnhat = ReceiverSIMO( y_afterfilter, L, N)
%%%%%%%%%%%%%%%%%
% receiver      %
% for 
%%%%%%%%%%%%%%%%%

% from series to parallels, and back to series
yp = QPSK_constellation_demapper(real(y_afterfilter), imag(y_afterfilter));
    
dnhat = deinterleaver(yp, L, N*2);

end
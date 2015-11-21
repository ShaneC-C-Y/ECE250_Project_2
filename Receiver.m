function [bnhat, dnhat] = Receiver( y_R, y_I, h_R, h_I, L, N, n, type)
%%%%%%%%%%%%%%
% re
%%%%%%%%%%%%%%%

% yR, yI here is real(with noise)
y_afterfilterR = matched_filter(y_R, h_R, N);
y_afterfilterI = matched_filter(y_I, h_I, N);

yp = QPSK_constellation_demapper(y_afterfilterR, y_afterfilterI);

dnhat = deinterleaver(yp, L, N);

bnhat = Decoder(dnhat, n, type);
end


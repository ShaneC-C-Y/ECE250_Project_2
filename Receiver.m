function [bnhat, retransmit_case] = Receiver(y1, y2, h1, h2,...
                                        L, N, n, type, type_antenna)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% receiver for MISO or SIMO     %     
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

switch type_antenna
    case 'MISO'
        % extra part in Receiver in MISO
        % here is no matched filter
        y_out =  deAlamouti(y1 + y2, h1, h2, N);

        % from series to parallels, and back to series
        yp = QPSK_constellation_demapper(real(y_out), imag(y_out));

        dnhat = deinterleaver(yp, L, N*2);

        [bnhat, retransmit_case] = Decoder(dnhat, n, type);
    case 'SIMO'
        % each antenna has one
        y_afterfilter1 = matched_filter(y1, h1, N);
        y_afterfilter2 = matched_filter(y2, h2, N);
        
        yp1 = QPSK_constellation_demapper(real(y_afterfilter1),...
                                            imag(y_afterfilter1));
        yp2 = QPSK_constellation_demapper(real(y_afterfilter2),...
                                            imag(y_afterfilter2));
        dnhat1 = deinterleaver(yp1, L, N*2);
        dnhat2 = deinterleaver(yp2, L, N*2);
        
        switch type
            case 'repetition'
                [bnhat, retransmit_case] = ...
                    repetition_decoderSIMO(dnhat1, dnhat2);
            case 'hamming74'
                ;
        end
end
end
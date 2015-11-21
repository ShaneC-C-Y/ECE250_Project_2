function [ bnhat ] = Decoder(dnhat, n, type )
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% need type
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

switch type
    case 'hamming74'
        bnhat = Hamming74_decoder(dnhat);
    case 'repetition'
        bnhat = repetition_decoder(dnhat, n);
    otherwise
        warning('Unexpected type')
end
end


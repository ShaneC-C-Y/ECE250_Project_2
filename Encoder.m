function [ dn ] = Encoder(bn, n, type)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% need type
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

switch type
    case 'hamming74'
        dn = Hamming74_encoder(bn);
    case 'repetition'
        dn = repetition_encoder(bn, n);
    otherwise
        error('Unexpected type');
end
end


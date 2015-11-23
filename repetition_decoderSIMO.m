function [bnhat, retransmit_case]...
                    = repetition_decoderSIMO( dnhat1, dnhat2)

% compare the sequence from different channel
% if there is any bit not the same in one time slot
% call to retransmit
dnhat1_matrix = reshape(dnhat1, 2, []);
dnhat2_matrix = reshape(dnhat2, 2, []);

[~, retransmit_case] = find(dnhat1_matrix ~= dnhat2_matrix);

% dnhat_m(2,:), dnhat_m(1or2,:) are the same if just 
% need to consider non-retransmit_case
bnhat = dnhat1_matrix(1,:);
end


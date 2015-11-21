function [xR, xI] = QPSK_constellation_mapper( xp )

% Input:            row vector, length 2*N*L
% Output(xR, xI):   row vector, length N*L

% change row vector input   [ xp[1] xp[2] xp[3] ... xp[2*N*L] ]
%
% to                        [ xp[1] xp[2];
%                             xp[3] xp[4];
%                               .     .
%                              ...  xp[2*N*L]]
% two length N*L column
assert(mod(length(xp),2) == 0);

dn_matrix = reshape(xp,2,[])';

x = zeros(size(dn_matrix));

% because QPSK send two bit in a time slot
% we normalize the energy in every time to one
% so the amptitude in each dimension is 1/sqrt(2)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% another problem
% should amptitude normalize with L?
% total energy in one transmission to be the same
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
s = 1/sqrt(2);

for i = 1:size(dn_matrix,1)
    if isequal(dn_matrix(i,:),[1,1])
        x(i,1) = s;
        x(i,2) = s;

    elseif isequal(dn_matrix(i,:),[0,1])
        x(i,1) = -s;
        x(i,2) = s;

    elseif isequal(dn_matrix(i,:),[1,0])
        x(i,1) = s;
        x(i,2) = -s;

    else
        x(i,1) = -s;
        x(i,2) = -s;
    end
end

xR = x(:,1)';
xI = x(:,2)';

end


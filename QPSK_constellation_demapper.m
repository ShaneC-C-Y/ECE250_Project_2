function yp = QPSK_constellation_demapper(y_afterfilterR, y_afterfilterI )

% Input:  row vector, both real !!!!!!
% Output: row vector, same size!!!!!

% because only positive or negetive

% odd position is R part, following even position is its I part
y_afterfilter2 = [y_afterfilterR; y_afterfilterI];
y_afterfilter = y_afterfilter2(:)';
yp = y_afterfilter>0;

end


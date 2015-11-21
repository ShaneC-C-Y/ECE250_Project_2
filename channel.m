 function [ y,h ] = channel(x, snr, N)

% Input(x):         row vector, length N*L
% Input(sigma, N):  parameter
% Output(y):        row vector, length N*L, complex
% OUtput(h):        row vector, length L

% change x to N by L matrix
% N bit in one column, in one Tc
% [ x[1] x[1+N] ...
%   x[2] x[2+N] ...
%   x[3] x[3+N] ...
%     .     .    .
%     .     .    .
%   x[N] x[N+N] ...]
%
x_matrix = reshape(x, N, []);
L = length(x)/N;

% generate H~CN(0,1)
% total Ns columns, so there are L channel response h in H
% each column will get the same h
%   the function in Matlab is different from the note we define 
%   with a scale sqrt(2)
mag = raylrnd(1/sqrt(2),L,1);   
h = mag.*exp(1j*2*pi*rand(L,1));    % H = |H|e^j*unif(0~2pi)

% use diagonal matrix to multiple
% so each column just multiple a scale 
h_matrix = diag(h);

% signal without noise;
y_no_noise = x_matrix*h_matrix;

% generate AWGN
% SNR = a^2 / sigma_w^2 
%   (1) a^2 here will normalize to 1 in QPSK mapper
%       sent amptitude 1/sqrt(2) singal in I and Q every time slot
%       total energy in every time slot is 1
% w = sigma_w.*exp(1j*2*pi*rand(N,L));% complex
% but here we can use Matlab function awgn with input snr(dB)
y = awgn(y_no_noise, 10*log10(snr), 'measured');

% make y and h to a row vector to be output
y = y(:).';
h = torowvector(h);

end


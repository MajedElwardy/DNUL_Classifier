function [ X, y, pos] = Oddball_Synthetic_Data( n, m, R, s, f )
% Input
% n - use 6 for simulating P300 speller
% m - number of row/column rounds
% R - number of repetitions 
% s - standard deviation of the two Gaussians (one centered at 0,0 the other
%     at 1,1) use 0.1 for an easy problem, higher for harder problem
% f - dimension of the feature vector

% Output 
% X   - Oddball Synthetic Dats [X1,X2, ..., Xf]
% Y   - Labels (used to verify you classifier accuracy)
% pos - The position of the target (used rarely)
%% Generate Oddball Synthetic Data
X = [];
y = [];
pos = [];
for i = 1:m
    k = ceil(n*rand()); 
    for r = 1:R
        temp = s*randn(n,f);
        temp2 = zeros(n,1); 
        temp (k,:) = temp (k,:) + ones(1,size(f,2));
        temp2 (k) = 1;
        X = [X;temp];
        y = [y;temp2];
        pos = [pos;k];
    end
end


end
 
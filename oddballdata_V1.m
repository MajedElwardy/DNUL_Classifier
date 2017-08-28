function [ X, y ] = oddballdata_V1( n, m, s, f )
% Input
% M - use 6 for simulating P300 speller
% N - number of experiments
% s - standard deviation of the two Gaussians (one centered at 0,0 the other
% at 1,1) use 0.1 for an easy problem, higher for harder problem

% Output 
% x - Oddballdata [x,y]
% l - True labels

%% Generate oddballdata 
X = [];
y = [];
for i = 1:m
   temp = s*randn(n,f);
   temp2 = zeros(n,1);
   k = ceil(n*rand()); 
   temp (k,:) = temp (k,:) + ones(1,size(f,2));
   temp2 (k) = 1;
   X = [X;temp];
   y = [y;temp2];
end


end
 
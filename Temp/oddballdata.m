function [ x, label ] = oddballdata( M, N, s, f )
% Input
% M - use 6 for simulating P300 speller
% N - number of experiments
% s - standard deviation of the two Gaussians (one centered at 0,0 the other
% at 1,1) use 0.1 for an easy problem, higher for harder problem

% Output 
% x - Oddballdata [x,y]
% l - True labels

%% Generate oddballdata 
x = [];
l = [];
for i = 1:N
   temp = s*randn(M,f);
   temp2 = zeros(M,1);
   k = ceil(M*rand()); 
   temp (k,:) = temp (k,:) + ones(1,size(f,2));
   temp2 (k) = 1;
   x = [x;temp];
   l = [l;temp2];
end
label = l';

end
 
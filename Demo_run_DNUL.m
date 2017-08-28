close all; clear all; clc

%% A Demo run for (DNUL) with synthetic data

% initial parameter for 6X6 character matrix
n = 6;                % n = 6 (6X6 character matrix)
f = 2;                % synthetic data dimention
ch = 20;              % Simulated char. no.
r = 1;                % Repetitions (trial groups) 
m = 2*ch*r;           % each char. have n rows & n colms
s = 0.2;              % synthetic data S.D.

beta = 1;             % senstivity parameter
max_epoch = 500;      % Iterat?ons
stepsize = 0.2;       % stepsize

% generate the synthetic data
% X: synthetic data
% y: Labels are 1 & 0
[ X, y] = oddballdata_V1(n, m, s, f);

%% Run the DNUL Classifier
rng(1);
% Initialize random weights
w_init = randn(f+1,1);
tic
[w_V1,Engy_start_V1, Engy_V1] = DNUL(X,w_init,n,max_epoch,stepsize,beta);
toc
tic
[w_V2,Engy_start_V2, Engy_V2] = DNUL_V2(X,w_init,n,max_epoch,stepsize,beta);
toc
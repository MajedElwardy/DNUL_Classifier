close all; clear all; clc

%% A Demo run for (DNUL) with Oddball synthetic data
%% initial parameter for (6X6 character matrix) simulation

n = 6;                % n = 6 (6X6 character matrix)
ch = 1;              % Simulated char. no.
m = 2*ch;             % Number of row/column rounds
r = 1;                % Number of repetitions (trial groups)
s = 0.2;              % Standard deviation of the two Gaussians
f = 2;                % Dimension of the feature vector

beta = 1;             % The Senstivity Parameter
max_epoch = 500;      % Number of epochs/iterations
stepsize = 0.2;       % stepsize/learning rate

%rng(2);               % Seed points

%% generate the synthetic data
% X: Oddball Synthetic Data
% y: Labels are 1 & 0
[X, y, pos] = Oddball_Synthetic_Data(n, m, r, s, f);

%% Run the DNUL Classifier

% Initialize random weights
w_init = randn(f+1,1);

% Rund different versions
[w_V1, E_start_V1, E_end_V1] = DNUL_V1(X,w_init,n,max_epoch,stepsize,beta);

[w_V2, E_start_V2, E_end_V2] = DNUL_V2(X,w_init,n,max_epoch,stepsize,beta);

[w_V3, E_start_V3, E_end_V3] = DNUL_V3(X,w_init,n,r,max_epoch,stepsize,beta);

% r=7 ---> beta=5

%% Predicting labels from the learned Weights
[y_pred_V1] = Classifiy_Prediction(X,w_V1,beta);
[y_pred_V2] = Classifiy_Prediction(X,w_V2,beta);
[y_pred_V3] = Classifiy_Prediction(X,w_V3,beta);

%% Calculating the Accuracies and FScore
[Resuts_V1, con_Mat_V1] = Confusion_Matrix(y, y_pred_V1);
[Resuts_V2, con_Mat_V2] = Confusion_Matrix(y, y_pred_V2);
[Resuts_V3, con_Mat_V3] = Confusion_Matrix(y, y_pred_V3);

%% Plot Energy Function and the data (if needed)
% Do not forget to get the energy vectors from the DNUL energy function
% [w, E_start,E_end,A,B] = DNUL(X,w,n,max_epoch,stepsize,beta);
plotData(X, y, w_V3)
%PlotEnergyFunction(A,B)

%% Synthetic data
close all; clear; clc

%% Set Data and classifier Parameter
M = 6;          % => No of flashes
N = 52;         % => 100X6 instances
s = 0.268;        % => STD of random samples
f = 320;          % => feature vector

max_epoch = 500;
stepsize = 0.2;
alpha = 1;

no_opt = 10;

%% set.seeds
% set_seed = rng;

load('set_seed_simulate_case.mat');
rng(set_seed);
%% Genereting synthetic data (Toy example)
[ x_toy_data, toy_label] ...
    = oddballdata( M, N, s, f );

%% Classifying the data ( Toy example )
for i = 1:no_opt
    w_init = [ randn(f, 1) ; 1 ];
    % w_init = randn(f + 1, 1);

    [w(:,i),Engy_start(:,i), Engy_end(:,i)] ...
        = OddBallLearnULDA (x_toy_data,w_init,M,max_epoch,stepsize,alpha);
end

%% Geting the Synthetic data "Classifier" Accuracies
for i = 1:no_opt
    [s_confusionMatrix, s_predicted_L, s_Classifier_Accuracy(i,:), s_Classifier_Error] ...
        = ConfusionMatrix_toy_example(x_toy_data, w(:,i), toy_label);
    TP_rate(i,:) = s_confusionMatrix(1,1)/ N;
    TN_rate(i,:) = s_confusionMatrix(2,2)/ ((N*M)-N);
end

%% Draw-LDA

if (f == 2)
    for i = 1:no_opt
        figure;
        X = x_toy_data(:,1);
        Y = x_toy_data(:,2);
        h1 = gscatter(X,Y,toy_label,'kr','ov',[],'off');
        h1(1).LineWidth = 2;
        h1(2).LineWidth = 2;
        legend('Not P300','P300','Location','best')
        hold on;

        K = w(3,i);
        L = [w(1,i);w(2,i)];
        f = @(x1,x2) K + L(1)*x1 + L(2)*x2;
        h2 = ezplot(f,[-3 3 -2 2]);
        h2.Color = 'r';
        h2.LineWidth = 2;
        title('Synthetic data example')
        str1 = sprintf('Classifier Accuracy: %0.2f %%', s_Classifier_Accuracy(i,:)*100);
        str2 = sprintf('True positive rate: %0.2f %%', TP_rate(i,:)*100);
        str3 = sprintf('True negative rate: %0.2f %%', TN_rate(i,:)*100);
        text(-0.8,-1.17,str1)
        text(-0.8,-1.35,str3)
        text(-0.8,-1.53,str2)
    end
    
elseif (f == 3)
    % Draw in 3D
    [~,~,id] = unique(toy_label);
    colors = 'rgb';
    markers = 'osd';
    
    for idx = 1:2
        data = x_toy_data(id == idx, :);
        plot3(data(:,1), data(:,2), data(:,3), [colors(idx) markers(idx)]);
        hold on;
    end
    grid; % Show a grid
    legend('Not P300','P300','Location','best')
    
else
    disp('Sorry, I can not draw a high dimentional dataset')
    
end

%% Saving section
% save('set_seed_simulate_case.mat','set_seed');
% save('old_version_simulate_case');
function [Labels_predicted, f] = Classifiy_Prediction(X,w,beta)
%CLASSIFIY_PREDICTION if a function to predict the labels with the learned
%weights from the DNUL classifier

N = size(X,1);
Labels_predicted = zeros(N,1);
X = [X ones(N,1)];

%% Predicting labels from the learned Weights
f = 1./(1+ exp( beta.*(-X*w) ));
Labels_predicted(f>=0.5) = 1;
    
end


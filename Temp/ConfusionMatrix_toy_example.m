function [confusionMatrix, predicted_L, Accuracy, Error] = ConfusionMatrix_toy_example(x,w,x_Label )

predicted_L = [];
N = size(x,1);
Error = 0;
x = [x ones(size(x,1),1)];
confusionMatrix = zeros(2,2);

%% Getting labels from updated Weights
for i=1:N
    f = 1./(1+ exp(-x(i,:)*w));
    if ge(f,0.5)
        Label(i) = 1;
        predicted_L = [predicted_L, Label(i)];
    else
        Label(i) = 0;
        predicted_L = [predicted_L, Label(i)];
    end
end

%% Claculate Error and ConfusionMatrix
for c = 1:N
    if (x_Label(1,c) ~= predicted_L(1,c))
        err =1;
        Error = Error +err;
        % Confusion Matrix
        if x_Label(1,c) == 1
            confusionMatrix(1,2) = confusionMatrix(1,2) + 1; %FT
        else
            confusionMatrix(2,1) = confusionMatrix(2,1) + 1; %TF
        end
    else
        % Confusion Matrix
        if x_Label(1,c) == 1
            confusionMatrix(1,1) = confusionMatrix(1,1) + 1; %TT
        else
            confusionMatrix(2,2) = confusionMatrix(2,2) + 1; %FF
        end
    end
end
    Error = (Error/N);
    Accuracy = 1 - Error;
    
end


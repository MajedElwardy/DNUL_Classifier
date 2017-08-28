function [Resuts, con_Mat] = Confusion_Matrix(t,t_gt)

N = size(t,1);
%Error = 0;
con_Mat = zeros(2,2);

%% Claculate Error and ConfusionMatrix
for c = 1:N
    if (t_gt(c,1) ~= t(c,1))
        %err =1;
        %Error = Error +err;
        % Confusion Matrix
        if t_gt(c,1) == 1    %+ve
            con_Mat(1,2) = con_Mat(1,2) + 1; %FN
        else
            con_Mat(2,1) = con_Mat(2,1) + 1; %FP
        end
    else
        % Confusion Matrix
        if t_gt(c,1) == -1   %-ve
            con_Mat(2,2) = con_Mat(2,2) + 1; %TN
        else
            con_Mat(1,1) = con_Mat(1,1) + 1; %TP
        end
    end
end
%% Results
% Accuracy
    Accuracy    = ((con_Mat(1,1) + con_Mat(2,2))/ N)*100;
% Sensitivity = (TPR)
    Sensitivity = con_Mat(1,1)/ (con_Mat(1,1) + con_Mat(1,2));
    TPR = Sensitivity*100;
% Precision
    Precision   = (con_Mat(1,1)/ (con_Mat(1,1) + con_Mat(2,1)))*100;
% Specifity = (1-FPR)
    Specifity   = con_Mat(2,2)/ (con_Mat(2,2) + con_Mat(2,1));
    FPR = (1- Specifity)*100;
% Total results
    Resuts = [ Accuracy; Precision; TPR; FPR];
end

